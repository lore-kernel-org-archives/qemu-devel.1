Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C418C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3614121744
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 20:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWbylTdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3614121744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53327 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZoY-0001Bu-HQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 16:57:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZeu-0002jO-Ar
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZes-00005G-Db
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:47:24 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLZeq-0008Ox-9I; Tue, 30 Apr 2019 16:47:21 -0400
Received: by mail-lf1-x144.google.com with SMTP id d12so11886568lfk.6;
	Tue, 30 Apr 2019 13:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=y7xfoofEm4PAoHQaMXpXigT2S2f6wMz1mt7eVkQs2Sw=;
	b=hWbylTdKEQ9a861h6nsAFe7S7u7+cfpXDZHcAMySg4gVg9AZIXhsxtyeHpQlSQ24HD
	0WKY5m5rW4/Lm9/QYvgGB9nGNySx/kB9KbSMHebNcik9Z8fF6B4lExipTt2LUfelZToZ
	nBKT+oVNmq+Ki0VAL5tqjfhzyULDq0XOoAXjqkRUPa3d23fEav2aYXieeXWzBsB50MRb
	wJ5UkbQet2I2Qj2CmG+SImTZqFR0HRRTqhdS37huNhvcX7tlpLGfFjDkBVJt2ztvVNp1
	psoT3s06bmZhj38JardeplnuyW8p9xY08oWbvUXeWBvZfBtxhx/HarPgpMTsW9hpu8hS
	i4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=y7xfoofEm4PAoHQaMXpXigT2S2f6wMz1mt7eVkQs2Sw=;
	b=fZl5w1D0LfsgxTcSUMSH0A7avV5RX5XtRN4IdGlOUUcq89JjPJoJsS0efT+RVD5gr5
	ElHTmNmWh/9KlgEyUIryPM81O+HCn8F9pRT0qcTLV1+CyGTZQzE5aSs5Ev2QEYpkee2o
	kr+iX9U2+2DMHFEfAierh9gyRhh0nrTZUS5O/cSPJqAZarvYy+HoVgqVjSqxHFIKekib
	0zzs2ntBmrIYdIPFvVP/UC44g/RV6q7BXHXcCELgrCIlGZmHHOdKQAMcxGrW5/85J9C+
	QLXhRGkhwea6HeOCCI4PTIdWoxFRKlSFohf3XLRwHJZwxbN9x6uD3oUwApwjvgxEQoN8
	RpGQ==
X-Gm-Message-State: APjAAAXDSBuD3Sk7TH5wYzx4ocznuM2aJ3F4xI6Qaw41G1/5jfaKsMQA
	CTjnKGZnTzXdG67mj0kHeZJJaxVbaApnDkpeqmc=
X-Google-Smtp-Source: APXvYqz9iXkzAzZmiA95VuA9Ydg4ZqCGyVXCiIq8qGHtVXRhEnc0GlMOmqUpe6A9mL/cOPFntcKWqp/cwa2yb8pNQsQ=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr355974lfa.124.1556657236454;
	Tue, 30 Apr 2019 13:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
	<6650d0b8-1c5c-a8ea-ef92-a69ad50f7d8b@redhat.com>
In-Reply-To: <6650d0b8-1c5c-a8ea-ef92-a69ad50f7d8b@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 13:45:23 -0700
Message-ID:
 <CAKmqyKP0-Aikd3+fF-u=be_2ZaRtfa6Sx-Cxu49uFtXgN9C_Ew@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build
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
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430204523.pzUCGsoltq9Q6dpWPHaHa5dwfVs6Wq7_ZpfI8zN_ZPc@z>

On Tue, Apr 30, 2019 at 1:37 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 3:09 PM, Alistair Francis wrote:
> > Fix this warning with GCC 9 on Fedora 30:
> > hw/usb/dev-mtp.c:1715:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer value =
[-Werror=3Daddress-of-packed-member]
> >  1715 |                             dataset->filename);
> >       |                             ~~~~~~~^~~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/usb/dev-mtp.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> > index 99548b012d..6de85d99e6 100644
> > --- a/hw/usb/dev-mtp.c
> > +++ b/hw/usb/dev-mtp.c
> > @@ -1711,9 +1711,22 @@ static void usb_mtp_write_metadata(MTPState *s, =
uint64_t dlen)
> >      assert(!s->write_pending);
> >      assert(p !=3D NULL);
> >
> > +/*
> > + * We are about to access a packed struct. We are confident that the p=
ointer
> > + * address won't be unalligned, so we ignore GCC warnings.
>
> unaligned

Fixed.

>
> Aren't there other potential proposed patches floating around for this
> issue that do not involve messing with pragmas?

I'm not sure, I haven't seen anything. I'm more then open to a better
fix, this is the best option I could think of.

Alistair

>
> > + */
> > +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> > +#pragma GCC diagnostic push
> > +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> > +#endif
> > +
> >      filename =3D utf16_to_str(MIN(dataset->length, filename_chars),
> >                              dataset->filename);
> >
> > +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> > +#pragma GCC diagnostic pop
> > +#endif
> > +
> >      if (strchr(filename, '/')) {
> >          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
> >                               0, 0, 0, 0);
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

