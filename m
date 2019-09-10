Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7170C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69EAA21019
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 19:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cghwc/Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69EAA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ldU-0003yW-7K
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 15:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7lbh-0003S9-H0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i7lbg-0006EF-4O
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:15:17 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i7lbf-0006Ds-Ve
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 15:15:16 -0400
Received: by mail-ot1-x341.google.com with SMTP id t6so6868821otp.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=76HFADLdTGqwKYwl6lDFIFIcEZkGH+7F21Yt5pkIutY=;
 b=cghwc/GlytwMTs/ScETfMDSXFZvDjwow9PCOyik2lSxC0cvYR+YRSJ5KP6kKTEJ1Cm
 +8n/KoTPHdvgwx/QCG7S0Hp/c9Mg9ZfHsUnl8B4ExQySGOaaLms5TLxBDsgS6kCvSowO
 fP9kxvUxYNVPfgqlrjhr/+UQ9swGsGURgwtiVNqLrPXcWnWSEEvG8bY9znRdH0bCtxsY
 EbSq6NSaDRPR6pBr/aY5uYLzGdTmLvxitYQeDR+UzOzZqGy7p1b2FYnrxN/wA5Xr2VUX
 T3e8JYrd8fqxaEEYQ314QHiSC0nwaxyx4MsfuT9I1gaCDjcNargtPoscbtepLtc8oM24
 lx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=76HFADLdTGqwKYwl6lDFIFIcEZkGH+7F21Yt5pkIutY=;
 b=sX971uqCmzc46JvjL4Ko8B4INdglBBGvBdm+UDRGfzJ33+Z9COeSiOoAN3hFxdONsZ
 8MaVYSYv7AdGpmuQdLxCKRZfDc/i/KVqaapDSGIFA1sIHtmZcmPi1h8EIXNtTkvvqHha
 ubmclp2P9rIGxpq/vPvciejW3XCVISxsDuid8+Ug5BjLFDWw4kHpws3X7ECDbfcco/z6
 TRT8wtupE4po3h0YBnjkLIMUgcKKXP2IcSECPaiTn6kw1a4sftyLsUbQBqcSoYA2zyJj
 TFefut/VNK8pfCSH7fmeT8qViU3g4cKAmPkOxEIXL5+k+UQao+dV1olMxwM6Ux5JILiv
 jQ9w==
X-Gm-Message-State: APjAAAVJeErHtU+IAJfw+V9nLbhpdWz6KS1KzK46ncqwVOAeg+rNcFey
 rkdanQvuIWELI5TQUyChuZiGWEqdg3Nvhn31ESw=
X-Google-Smtp-Source: APXvYqxAR6yPCqTc/wK5j7ap5AMdvPXGPDSftv6a8zj3H9Y2q3AxYwjs4hpGMVUIqsTrTUIjD95VUGcS57eS7rNrG5A=
X-Received: by 2002:a9d:7989:: with SMTP id h9mr3300781otm.295.1568142915127; 
 Tue, 10 Sep 2019 12:15:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 12:15:14
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 10 Sep 2019 12:15:14
 -0700 (PDT)
In-Reply-To: <CAL1e-=id9tL4-6eLgkd2SQ2W-5yU6Zp7WgVj0YFJ83wdG1qG6w@mail.gmail.com>
References: <1567601968-26946-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1567601968-26946-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <2d5e7f28-7fa4-7637-c512-b443848eb61b@vivier.eu>
 <CAL1e-=id9tL4-6eLgkd2SQ2W-5yU6Zp7WgVj0YFJ83wdG1qG6w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 10 Sep 2019 21:15:14 +0200
Message-ID: <CAL1e-=hT6_gDa1U5jC=0HCRo37PR44zBxXH3OU8=XF6pEE=ofA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 8/8] linux-user: Add support for
 FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, riku.voipio@iki.fi,
 qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

10.09.2019. 20.58, aleksandar.m.mail@gmail.com =D1=98=D0=B5 =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
> 06.09.2019. 12.47, "Laurent Vivier" <laurent@vivier.eu> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > Le 04/09/2019 =C3=A0 14:59, Aleksandar Markovic a =C3=A9crit :
> > > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> > >
> > > FDSETEMSGTRESH, FDSETMAXERRS, and FDGETMAXERRS ioctls are commands
> > > for controlling error reporting of a floppy drive.
> > >
> > > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > > ---
> > >  linux-user/ioctls.h        |  2 ++
> > >  linux-user/syscall_defs.h  | 19 +++++++++++++++++++
> > >  linux-user/syscall_types.h |  7 +++++++
> > >  3 files changed, 28 insertions(+)
> > >
> > > diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> > > index 622874b..0c75d03 100644
> > > --- a/linux-user/ioctls.h
> > > +++ b/linux-user/ioctls.h
> > > @@ -118,6 +118,8 @@
> > >       IOCTL(FDFMTTRK, IOC_W, MK_PTR(MK_STRUCT(STRUCT_format_descr)))
> > >       IOCTL(FDFMTEND, 0, TYPE_NULL)
> > >       IOCTL(FDFLUSH, 0, TYPE_NULL)
> > > +     IOCTL(FDSETMAXERRS, IOC_W,
MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
> > > +     IOCTL(FDGETMAXERRS, IOC_R,
MK_PTR(MK_STRUCT(STRUCT_floppy_max_errors)))
> >
> > where is FDSETEMSGTRESH?
> >
> > >       IOCTL(FDRESET, 0, TYPE_NULL)
> > >       IOCTL(FDRAWCMD, 0, TYPE_NULL)
> > >       IOCTL(FDTWADDLE, 0, TYPE_NULL)
> > > diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> > > index 834a085..7c5b614 100644
> > > --- a/linux-user/syscall_defs.h
> > > +++ b/linux-user/syscall_defs.h
> > > @@ -890,12 +890,31 @@ struct target_pollfd {
> > >
> > >  /* From <linux/fd.h> */
> > >
> > > +struct target_floppy_max_errors {
> > > +    abi_uint        abort;
> > > +    abi_uint        read_track;
> > > +    abi_uint        reset;
> > > +    abi_uint        recal;
> > > +    abi_uint        reporting;
> > > +};
> >
> > You don't need this, you can use floppy_max_errors from <linux/fd.h>.
> >
> > But you can define it if you want because it is used to know the size o=
f
> > the target structure (and if alignment or data types differ it can
> > mismatch. With "int" it's not the case).
> >
>
> Laurent, thanks for the review, I'll correct this in the next version.
>
> Just a follow-up question:
>
> If the structure of related to a (not-yet-supported in QEMU) ioctl was:
>
> struct hd_geometry {
>       unsigned char heads;
>       unsigned char sectors;
>       unsigned short cylinders;
>       unsigned long start;
> };
>
> ... would "target_hd_geometry" be needed, or not?
>

Actually, that ioctl is already implemented in QEMU (HDIO_GETGEO), without
defining target_hd_geometry. Is this fine?

> Regards,
>
> Aleksandar
>
> > > +struct target_format_descr {
> > > +    abi_uint        device;
> > > +    abi_uint        head;
> > > +    abi_uint        track;
> > > +};
> > > +
> >
> > This one is for the previous patch. Same comment as above.
> >
> > Thanks,
> > Laurent
> >
