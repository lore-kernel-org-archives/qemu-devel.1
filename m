Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEE0C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAA9207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 13:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWwUhRxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAA9207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioopX-00058y-Vz
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 08:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ion96-0002kR-K0
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:35:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ion95-0004ef-Ae
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:35:36 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:56251)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ion95-0004eG-28
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:35:35 -0500
Received: by mail-wm1-x344.google.com with SMTP id q9so18581028wmj.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eoBlPvsd0rTKa1qTN01JbAs2DLpTIQMI0Q11/oqNUIM=;
 b=ZWwUhRxVEE4YfjwNcpqqDIlLpw3UvCvXhO1zyH5i5Y+oXB1NoxJ6T9WsvfbQe6J2+j
 fBhKW9uz/0j/MtRcxTM8ynRW7gpyOIMSj1F+Tuqhy7luWFaHhBMBLqFfmtcrVNK321ZR
 N7Hv0cTUEnhqfGcH1E3VBu5FYfaMyqPJHHtQ+TBJ6uT9s2gJr1xGBdpSsLRSWuLwVP+3
 Rzb128uoYQchJyX/71oaGkzyjpMFKhNgvr8cHsKjdlKl6RzRygMGcGgN0fYRgt95yNrq
 nIG3Hw+oQOede1w9edkYdxaxpowDUDcW9hk60Dqegly4FTxAFWGAyK0sgBHgqaApB+xA
 74zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eoBlPvsd0rTKa1qTN01JbAs2DLpTIQMI0Q11/oqNUIM=;
 b=H++ZoclAQPtpmqPQRj8gyM3UBbldNe//XX1jXzWzLhSXU9oTmzJ1obLAk+M88rypWo
 PjV2SJoJt5Evc25JXfN+KC6zqoM2PWyK2tAIzR+rcgsZLIs4t2tlcmxLCyEwgzreHRMH
 TFSojZ0fhHJrALzcOKYHon+u155C2Igw+inl2fphW51Tl9rCnxVmraluFzmxWP27T43N
 D596eKlWM3OAERt+V8oaGod6hy84fGbUUJgJN+XOUb9NWj77LAjUEMtVT6Bg0ftzLqQJ
 is8oLEUUSC9MjAYYRQ3FiMRGVcZpwe0EzLISv6q82NYA6Uey/q7b9nNsUcZskg6w+srx
 6+1g==
X-Gm-Message-State: APjAAAWKQP6XPV+MtNWeZkNxMkwmYiahzP/zvAZ47ahajTRjuIn+DzfG
 dyVRjXBEoIUdzi8vIyrVH1/Gc8/OCXQ=
X-Google-Smtp-Source: APXvYqw46PNENcHBXafHav4JK2z1DNCY/nBVVC7+V1jvD6rYygVP9XFCNB71jLBXzRx05v2pXUD9SQ==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr40490132wmo.13.1578396933621; 
 Tue, 07 Jan 2020 03:35:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u16sm26689217wmj.41.2020.01.07.03.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 03:35:32 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB1191FF87;
 Tue,  7 Jan 2020 11:35:31 +0000 (GMT)
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/7] tcg: Remove softmmu code_gen_buffer fixed address
In-reply-to: <20191218223441.23852-3-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 11:35:31 +0000
Message-ID: <87tv574hz0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: berrange@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The commentary talks about "in concert with the addresses
> assigned in the relevant linker script", except there is no
> linker script for softmmu, nor has there been for some time.
>
> (Do not confuse the user-only linker script editing that was
> removed in the previous patch, because user-only does not
> use this code_gen_buffer allocation method.)
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  accel/tcg/translate-all.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 9f48da9472..88468a1c08 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1032,47 +1032,20 @@ static inline void *alloc_code_gen_buffer(void)
>  {
>      int prot =3D PROT_WRITE | PROT_READ | PROT_EXEC;
>      int flags =3D MAP_PRIVATE | MAP_ANONYMOUS;
> -    uintptr_t start =3D 0;
>      size_t size =3D tcg_ctx->code_gen_buffer_size;
>      void *buf;
>=20=20
> -    /* Constrain the position of the buffer based on the host cpu.
> -       Note that these addresses are chosen in concert with the
> -       addresses assigned in the relevant linker script file.  */
> -# if defined(__PIE__) || defined(__PIC__)
> -    /* Don't bother setting a preferred location if we're building
> -       a position-independent executable.  We're more likely to get
> -       an address near the main executable if we let the kernel
> -       choose the address.  */
> -# elif defined(__x86_64__) && defined(MAP_32BIT)
> -    /* Force the memory down into low memory with the executable.
> -       Leave the choice of exact location with the kernel.  */
> -    flags |=3D MAP_32BIT;
> -    /* Cannot expect to map more than 800MB in low memory.  */
> -    if (size > 800u * 1024 * 1024) {
> -        tcg_ctx->code_gen_buffer_size =3D size =3D 800u * 1024 * 1024;
> -    }
> -# elif defined(__sparc__)
> -    start =3D 0x40000000ul;
> -# elif defined(__s390x__)
> -    start =3D 0x90000000ul;
> -# elif defined(__mips__)
> -#  if _MIPS_SIM =3D=3D _ABI64
> -    start =3D 0x128000000ul;
> -#  else
> -    start =3D 0x08000000ul;
> -#  endif
> -# endif
> -
> -    buf =3D mmap((void *)start, size, prot, flags, -1, 0);
> +    buf =3D mmap(NULL, size, prot, flags, -1, 0);
>      if (buf =3D=3D MAP_FAILED) {
>          return NULL;
>      }
>=20=20
>  #ifdef __mips__
>      if (cross_256mb(buf, size)) {
> -        /* Try again, with the original still mapped, to avoid re-acquir=
ing
> -           that 256mb crossing.  This time don't specify an address.  */
> +        /*
> +         * Try again, with the original still mapped, to avoid re-acquir=
ing
> +         * the same 256mb crossing.
> +         */
>          size_t size2;
>          void *buf2 =3D mmap(NULL, size, prot, flags, -1, 0);
>          switch ((int)(buf2 !=3D MAP_FAILED)) {


--=20
Alex Benn=C3=A9e

