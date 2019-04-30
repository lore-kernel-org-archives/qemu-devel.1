Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABE5C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:08:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E394D21744
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXnqPgxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E394D21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZz8-0006ja-5i
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:08:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZwr-0004rd-3R
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZwp-0003WC-VG
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:05:57 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:33887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLZwp-0003VN-Nf; Tue, 30 Apr 2019 17:05:55 -0400
Received: by mail-lf1-x143.google.com with SMTP id r30so1027855lfn.1;
	Tue, 30 Apr 2019 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=dUTOJPS4OpQpyaEqcU3Da4Y+g7zsjN0KyP824IHLh6s=;
	b=KXnqPgxZGp0MFkCoqhF7m1AluBv3xxei17YBQvcOJRIcbtPOHwOWsGJaoKsvJUmpBN
	LE2njobFTSHIIBfmupSJW2Ec5RgPksZ91yZrKJCd/lvvVoaUx45vO0sKDVef9XgYKAMT
	pdYdBFIBNtifHJtVvCkMI3xJ3ZnVZoocDXZ0F/ufGQTrfZqnzPf0X8hSlSaHs9M94Tob
	QCP7ZG5hBY94+HAG+hkFLLetu7Xfg/BcMc2rub6a6Qa9sZFfPO6bhjPdj2yXozMEowJ1
	T2UBgNtszSqloM1ATmiFbTgsSyF/9kp3MDjMinGrOrxra733iufxJvN3z1G10o+O3lq/
	C/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=dUTOJPS4OpQpyaEqcU3Da4Y+g7zsjN0KyP824IHLh6s=;
	b=QXI5n+phcELI30+O1KASyrguBRYBS7yfqCxynZZcPEzWimirlzyOh/nVxFxRHZCiyt
	U1QJro3FrVkQ00r3qfzaaEdQRMSEWRZc3PjMf0oEOFITuadYxnI/9YrmtfxBUILMJGyg
	kJWbz87G9wbEi578KVcIq5g9ptS70XlGV4G5cFPC0jhIgDjKOu/Hx4f3lEpedgnmRcpz
	h3F/4PX22zPiug2TGkI6Y6SVnYOkmsZUL3Ny0zgPKTh0NRZob8Z9WGswRHN+V22lRpBQ
	imzDlkK2ne/tjl9sSeZ07+yIu8RljxMnRM3PdLs6EkEqgw+C18NafqY9c3c5J6aVFnHP
	NgVw==
X-Gm-Message-State: APjAAAXEl3NhfZNfomMVQOmaxj7FPf6d2CnrIUVfA0RfakEbfBYsbm45
	nsrCbAFi2kTbaL+BVDinL47HhVQ3Bb9HLDNQezo=
X-Google-Smtp-Source: APXvYqygpmQKnSVR/lfuuZ3uzKmOg34Cy2dH+Y9S0PylBY0Dqdxd16kFPaOs22/faOhVYzFLQmvhxqg2SygvyqKhFZY=
X-Received: by 2002:a19:750e:: with SMTP id y14mr36038286lfe.74.1556658354369; 
	Tue, 30 Apr 2019 14:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<66295a3d9e21f52d777e6354d6c0f98b0bcb0c26.1556650594.git.alistair.francis@wdc.com>
	<8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
In-Reply-To: <8a53bfff-9b16-7dcf-1626-5b93a44e8dfc@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:04:00 -0700
Message-ID:
 <CAKmqyKNOmjxJqqi9rvL=8zH6ePfTpHGiurBeq8Q2Q9A-fk2qFA@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v1 4/5] linux-user/uname: Fix GCC 9 build
 warnings
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
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430210400.zcOEvdPKBxLBhsg1HjPGvCCeRU4v8_BXjg8ewDCpf6A@z>

On Tue, Apr 30, 2019 at 1:40 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 3:09 PM, Alistair Francis wrote:
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/lin=
ux-user/uname.c:94:3:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 output may be truncated copying 64 bytes from a string of =
length 64 [-Werror=3Dstringop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/uname.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/linux-user/uname.c b/linux-user/uname.c
> > index 313b79dbad..293b2238f2 100644
> > --- a/linux-user/uname.c
> > +++ b/linux-user/uname.c
> > @@ -90,6 +90,11 @@ int sys_uname(struct new_utsname *buf)
> >     * struct linux kernel uses).
> >     */
> >
> > +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Wstringop-truncation"
> > +#endif
>
> Why do we need the pragma?
>
> > +
> >    memset(buf, 0, sizeof(*buf));
>
> We are prezeroing the entire field, at which point...
>
> >    COPY_UTSNAME_FIELD(buf->sysname, uts_buf.sysname);
> >    COPY_UTSNAME_FIELD(buf->nodename, uts_buf.nodename);
>
> ...using strncpy() for a shorter string is wasteful (we're writing the
> tail end twice), and for a long string is warning-prone.  Why not
> rewrite COPY_UTSNAME_FIELD() to use memcpy() for the MIN(strlen(src),
> __NEW_UTS_LEN) and drop the write of the trailing NUL, since it will
> already be NUL from your memset()?

I'm happy to do that, I'll change it to memcpy().

Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

