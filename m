Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25479C04AA6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:24:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC2F21743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm4YaqrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC2F21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53739 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLaEv-0005fD-Nt
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:24:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLaE2-0005Gt-DL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLaE0-0005Y2-Pp
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:23:42 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLaDw-0005W6-9Q; Tue, 30 Apr 2019 17:23:36 -0400
Received: by mail-lf1-x144.google.com with SMTP id d8so335452lfb.8;
	Tue, 30 Apr 2019 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=e215SwCSmUw76xWKrmLcwkUlw9QN962bzsqcLOHTNNA=;
	b=mm4YaqrYM7iIEOBMh6MT5+Mw0xFbjLeca2RT0VRo052AZYmMQht5GE01dbTiPp6zSC
	ZpVbsstRKrsHAyW1+b0NK2aI/xWjPYeHoI44giE6IGLb+ed7aH/JEWrpyveYupC+DpU/
	MmZDkBu9VLJy0EigkD44dw+DuiKyl9jVdaZI/C9VF04TBQsnAnwF7jBXHzLr/AjSNV8V
	ChQCtsM0aBjOhkRriO73vqDZDLA2bB/+yXdV8F6DPITGQltjhmmuvjJdEVRov8P25QDs
	nr0cPUAGVcD4gMhRA53fJUjUn6JAYmP98i8gNKRDc1W5R4p0fk6foWlrbKrzRJ9Ophau
	WK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=e215SwCSmUw76xWKrmLcwkUlw9QN962bzsqcLOHTNNA=;
	b=UAn3Ftfu0EQNiQPnidvqyv/JB5elL2zXG2CfpVCSj9tGY4szeVdLv0de+4ST8sv0gx
	LoE5z4fHsM5y6IJa8pklV/dzeIJ1DU73iPY1Q63AHpG0FCsTDe94k9FJlKMO2SO7YsjG
	kpNuYcdwUhyoTjgLTsn+W01/+6OP9aptQgmynuk5HOwCi2pQerVOBJQMJe6PvwdOBCmM
	hYSP1eKkTSkxE7YAVypzlDAbQ36hVYpc6ixgGnd7+qui/cF3rdLMn0bKNLN1YSTgW0Lb
	M56G6eLbE3B5D1qUPM9aIulvIhj59CsptvFjj+QtHoXiw6uGdL0BNsEcuntzq0rPWr+w
	6yEg==
X-Gm-Message-State: APjAAAXg19Ch16Lb4+xH+EYAoovGrUvm8+2AlazRwxsyBKt1FTREgkOS
	SrHlK3jBYCpD7DcVs3mxyFAUmB+Egag89J5kn9c=
X-Google-Smtp-Source: APXvYqzLw2urcVCUucgqcORdJRo5MqGUMgWJcwZhZP2yzDClyLMZqC1YeuR0PyzhwiW13PTIjKg8nOPjDUOMrjjuTSM=
X-Received: by 2002:a19:4a04:: with SMTP id x4mr424485lfa.124.1556659413548;
	Tue, 30 Apr 2019 14:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
	<d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
	<CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
	<5f6212e0-6bc4-8e84-c522-e80d36c67257@redhat.com>
In-Reply-To: <5f6212e0-6bc4-8e84-c522-e80d36c67257@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:21:40 -0700
Message-ID:
 <CAKmqyKOqaY+36uAZeYS23O7aZu4cnnx3oiJrGjrRys6iPzEv6g@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
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
	Laurent Vivier <laurent@vivier.eu>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430212140.O2D2uyJk4R48_Jb27BuV83JkwAj8pgJd7H_Ld4za3Fo@z>

On Tue, Apr 30, 2019 at 2:10 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 4:01 PM, Alistair Francis wrote:
> > On Tue, Apr 30, 2019 at 1:36 PM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
> >>> Fix this warning when building with GCC9 on Fedora 30:
> >>> In function =E2=80=98strncpy=E2=80=99,
> >>>     inlined from =E2=80=98fill_psinfo=E2=80=99 at /home/alistair/qemu=
/linux-user/elfload.c:3208:12,
> >>>     inlined from =E2=80=98fill_note_info=E2=80=99 at /home/alistair/q=
emu/linux-user/elfload.c:3390:5,
> >>>     inlined from =E2=80=98elf_core_dump=E2=80=99 at /home/alistair/qe=
mu/linux-user/elfload.c:3539:9:
> >>> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builti=
n_strncpy=E2=80=99 specified bound 16 equals destination size [-Werror=3Dst=
ringop-truncation]
> >>>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos=
 (__dest));
> >>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> >>>
>
> >>        /*
> >>         * Using strncpy here is fine: at max-length,
> >>>       * this field is not NUL-terminated.
> >>>       */>      (void) strncpy(psinfo->pr_fname, base_filename,
> >>> -                   sizeof(psinfo->pr_fname));
> >>> +                   sizeof(psinfo->pr_fname) - 1);
> >>
> >> Read the comment above :)
> >
> > GCC can't read the comment though. The only other option I can think
> > of is using a pragma, which I avoided using unless I had to. Would you
> > prefer a pragma here? Or do you have a better solution?
>
> psinfo is struct target_elf_prpsinfo, which we declare.  Why not just
> use the QEMU_NONSTRING attribute in the declaration, to tell the
> compiler our exact intents (untested, but something like this):
>
> diff --git i/linux-user/elfload.c w/linux-user/elfload.c
> index c1a26021f8d..6ebb2eeb957 100644
> --- i/linux-user/elfload.c
> +++ w/linux-user/elfload.c
> @@ -2872,7 +2872,7 @@ struct target_elf_prpsinfo {
>      target_gid_t pr_gid;
>      target_pid_t pr_pid, pr_ppid, pr_pgrp, pr_sid;
>      /* Lots missing */
> -    char    pr_fname[16];           /* filename of executable */
> +    char    pr_fname[16] QEMU_NONSTRING;           /* filename of
> executable */
>      char    pr_psargs[ELF_PRARGSZ]; /* initial part of arg list */
>  };

I didn't know about that property, that fixes it.

Alistair

>
>
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

