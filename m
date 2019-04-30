Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF1C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB1D2081C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEh3qQNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB1D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53437 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZwt-0004TK-6g
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:05:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZuX-0002hi-JU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZs6-0000RJ-Sy
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:01:03 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:35238)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLZs6-0000Pw-Lp; Tue, 30 Apr 2019 17:01:02 -0400
Received: by mail-lf1-x141.google.com with SMTP id j20so11959749lfh.2;
	Tue, 30 Apr 2019 14:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=05LJbDiyXnwkAcbMIJxpRQIyxurjkjMdMF29cuB89K8=;
	b=tEh3qQNPRvO3PW+wMD0zZhtCeCXWUQN8rhxkT/sIBUb9/lt10IEQ6Rro0EIeKi7gY3
	VoQEBW63qfWqKcTNYYooO/8pGExppWAd6zQEzf//+XP/hpy5LVS+HZORFSramMN6arI0
	JGOJVsmgr77igqWfB+exh8YUCu9wIinH11j512T4+3P/2yU/Y7WydI2Sa4rhNkChWKcL
	nJa6dgDD9qnOppnlx7L/0FraQb481J8jKkvZNoFHO7ZOrIEKlDzfi+GLgyPDFFikW0w4
	YhwHH7SwMdyjc7Oszee6NAchQohNdMd/VWQTDuXct5kqgu0UBGt+1xLScftclU4oKNxf
	pP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=05LJbDiyXnwkAcbMIJxpRQIyxurjkjMdMF29cuB89K8=;
	b=UZXpTSLMgNOmp+8kcoSO6seHXZh1qB6yJMvenmzz6kLZmAWl9OCCJgV2CSlBbpGJy6
	5Cl9EePyjYuyfXy59c2OLnevExrPf9m5i/ypsjwdV57m1t+g7m9Gs2HIyZvCDedB/QYV
	KgoML7iUQUnXhE0l4MiUd472em/KKXqv4PccXgY/b+6lXEKq8XBavurC5/qL1rTBi3nk
	cSS8gIIGzp8ZKcLWBx3/IbnfISdnu/SqSevpUfG9qfRraFrNUsQzeo2w4WIBLOMLbQA1
	1jObcPh28pwnPsvkDoN4GL5hToKX/qve6Row19EdlNbBgzFn1KkmqoYhiMhv1GrkxsFv
	v3VA==
X-Gm-Message-State: APjAAAWeVWd9j7IPyRsSftSsqmEbLkKgrlIS55l8P1cZTQBOy++hnpBA
	MDTREVR/LI5qnbg5s7zrh21cqxq9xp3zahhNgNc=
X-Google-Smtp-Source: APXvYqzmnlnPHMIP048CAjD0sDZKNE/a9CApOcdMrGHS5BOIia7EP7V40BAY+buhKM4kHtgdWJs0YFST+QzNNMHtrJ8=
X-Received: by 2002:a19:1949:: with SMTP id 70mr28585768lfz.103.1556658059595; 
	Tue, 30 Apr 2019 14:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<c4768a18309b3918715f96a1f5b2a9a264a5a9e4.1556650594.git.alistair.francis@wdc.com>
	<8ca522c7-d1dd-fe05-f8ab-031b72a9fbef@vivier.eu>
In-Reply-To: <8ca522c7-d1dd-fe05-f8ab-031b72a9fbef@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 13:59:06 -0700
Message-ID:
 <CAKmqyKNRO7ESNmngtV3b8EjZfiuuu9QQm6avfwUuGe=NtpS46A@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v1 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430205906.RQ-nQNDAOV0aHUlB8jYxSFWAzVaVry97yRRX-MtmOB0@z>

On Tue, Apr 30, 2019 at 1:24 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
> > Fix this build warning with GCC 9 on Fedora 30:
> > hw/usb/hcd-xhci.c:3339:66: error: =E2=80=98%d=E2=80=99 directive output=
 may be truncated writing between 1 and 10 bytes into a region of size 5 [-=
Werror=3Dformat-truncation=3D]
> >  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
> >       |                                                                =
  ^~
> > hw/usb/hcd-xhci.c:3339:54: note: directive argument in the range [1, 21=
47483647]
> >  3339 |             snprintf(port->name, sizeof(port->name), "usb2 port=
 #%d", i+1);
>
> "i" cannot be greater than 15.
>
> perhaps an "assert(i <=3D MAX(MAXPORTS_2, MAXPORTS_3))" can fix the warni=
ng ?

It does seem to stop the warnings, I'll change this patch to use a g_assert=
().

Alistair

>
> Thanks,
> Laurent
>
> >       |                                                      ^~~~~~~~~~=
~~~~~
> > In file included from /usr/include/stdio.h:867,
> >                  from /home/alistair/qemu/include/qemu/osdep.h:99,
> >                  from hw/usb/hcd-xhci.c:21:
> > /usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_c=
hk=E2=80=99 output between 13 and 22 bytes into a destination of size 16
> >    67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVE=
L - 1,
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
> >    68 |        __bos (__s), __fmt, __va_arg_pack ());
> >       |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/usb/hcd-xhci.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> > index 240caa4e51..9e4988abb6 100644
> > --- a/hw/usb/hcd-xhci.h
> > +++ b/hw/usb/hcd-xhci.h
> > @@ -133,7 +133,7 @@ typedef struct XHCIPort {
> >      uint32_t portnr;
> >      USBPort  *uport;
> >      uint32_t speedmask;
> > -    char name[16];
> > +    char name[24];
> >      MemoryRegion mem;
> >  } XHCIPort;
> >
> >
>

