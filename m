Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7918DC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:42:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436832075C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 16:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKxPvSgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436832075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMbG6-0002ph-JV
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 12:42:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMbEy-0001wm-8J
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMbEx-0000sc-3M
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:40:52 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hMbEw-0000ox-S0; Fri, 03 May 2019 12:40:51 -0400
Received: by mail-lf1-x141.google.com with SMTP id u27so4584547lfg.10;
	Fri, 03 May 2019 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ripvz1kd5CwIb/AtX0NS4Ufbgm5ZvRnjen61yerimug=;
	b=bKxPvSgyzDlmPwPjaiGatqqq0ygnikxQtk5qweFA7p4uihXx4JWqSElJviBfhQXh8n
	jbidI3fVjgqeVM2+p1Fmvvavgtho1pMcl0ZWmLSCLYoPpg8pnrs7YrBFLi2w/Fa6Mo7G
	DxhUSU/to4Vdmlwodypseg28O+EnJWeylD5HfnLzCYSw29HV12wL1QEZTCb9yUvcS9cH
	kpd2p7936P3JCHuc3vrM7pyKE6VtRhC/W89B7K9lSZXUlWkv3Zn1YnoIaKvTt1v1+umw
	00FldOhaHTPgvW+NbsIFht0X3gDgBF2bOX849tqodyIZkSjCS6nRurn8hdWrGoBxIe10
	TCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=ripvz1kd5CwIb/AtX0NS4Ufbgm5ZvRnjen61yerimug=;
	b=LqRHRCX1/pcDBHwBaIgEYS9qw+ZH57T2hmGnm+C7Y/x4j0dy6Q0LPah+yK+HTV1umv
	5OLBhS3oDt0QlJ/JaIQU8WxyoDrX9/12pCtsy1CuapAPFVUu9gLgcZKsM3PcFE6/nvle
	qKkdi31APnLenIYyPtnL46ktls8MVKZSeeXiXxzw5Dmi7HUtrFHPSSOdZfunIrX/e+YS
	gj6Xs+QldGddEtekiI9c6VkgWqWhp3osiuR6bXyHgffII5EC0PlWdwpjvBRJY2X2D6q6
	JhCAd9hopPfp9q9kRE5JLtdLVN8sSxgGNa53zxvhhtN3HSYpYn9aSN15qxkRz83FqXID
	yfJg==
X-Gm-Message-State: APjAAAVHUAE+NkxRxHT9yr5T+mCr0BXe3B46LI39VljkHyXphlrtsSgV
	yskNMCZ8azCEqAMdgQsFuWPd0GQYtQjmp26mKr0=
X-Google-Smtp-Source: APXvYqy8K1jfrzBRYYG2lRAxsSabCM+VK3sfeUO+SIMSc7Yrt7BEzUjeu4B0q3ucZa0JF1NDyCw0GhfUrmyjwyNxZE0=
X-Received: by 2002:a19:a40f:: with SMTP id q15mr5132312lfc.121.1556901648564; 
	Fri, 03 May 2019 09:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190503004021.13814-1-alistair.francis@wdc.com>
	<20190503092424.GB17905@redhat.com>
In-Reply-To: <20190503092424.GB17905@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 May 2019 09:38:50 -0700
Message-ID:
 <CAKmqyKO5Mhb5RyA13isjMJY2a6uUOLCmPtcK_HRt3uyWgm9XGw@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v3] hw/usb/hcd-xhci: Fix GCC 9 build warning
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
	"laurent@vivier.eu" <laurent@vivier.eu>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503163850.ZjIl5KW7Q3vgHj7NNvdjVS4TAyLx-Wp538zwJ8SzIeI@z>

On Fri, May 3, 2019 at 2:24 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Fri, May 03, 2019 at 12:42:04AM +0000, Alistair Francis wrote:
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
> > Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> > This is the onl patch left if my original series "Fix some GCC 9 build
> > warnings" that hasn't either been accepeted into a maintainers tree or
> > fixed by someone else.
> >
> >  hw/usb/hcd-xhci.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> > index ec28bee319..a15b103b65 100644
> > --- a/hw/usb/hcd-xhci.c
> > +++ b/hw/usb/hcd-xhci.c
> > @@ -3321,6 +3321,8 @@ static void usb_xhci_init(XHCIState *xhci)
> >
> >      usb_bus_new(&xhci->bus, sizeof(xhci->bus), &xhci_bus_ops, dev);
> >
> > +    g_assert(usbports <=3D MAX(MAXPORTS_2, MAXPORTS_3));
> > +
> >      for (i =3D 0; i < usbports; i++) {
> >          speedmask =3D 0;
> >          if (i < xhci->numports_2) {
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> but it looks like Gerd already sent a pull request with my patch for
> this from a few weeks back
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00543.html

No worries, I'm just glad it's fixed.

Alistair

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

