Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E938C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:00:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF65720679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxojqvKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF65720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47A9-0005m2-5Y
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:00:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j477U-0002Ss-2b
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j477R-00029s-Od
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:57:16 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j477R-00029B-Fs; Tue, 18 Feb 2020 12:57:13 -0500
Received: by mail-ot1-x344.google.com with SMTP id j16so20413680otl.1;
 Tue, 18 Feb 2020 09:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=5kN+uhA6Emf9q1UYbgvpnrUYwCpU0Y3MRA6H0hvKtBg=;
 b=DxojqvKNW6Wk5lEOS7KOhngkPUI5pfUyibHFZxKos3kf1ob2Bh8tGm62OyJ3jIxgJW
 LfMMTWTih5g/e8HSTOmKcS6DPXM+P4/AYerE4f93+Og9jRd55hZG67Lj1fCppg5XeHpG
 YLgU40m8jq9lSbfppVRSwhqOxPOV7xFB68r2V59r669f7KWLJLIlMPS2BCzdenmsTRCG
 nOBOoRTTRMg9D/AeLLk1Pmv6o4eSEt8mQolRE6iLtR1Bm789IL3+uGyHBF6o8MveDMGR
 7hoQ1xS/QB+wQPvS59YbrOD7yKlmaH0cKus0Cb5VrgyficiUyA/CcNobjM5nFVtTr7wn
 +jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=5kN+uhA6Emf9q1UYbgvpnrUYwCpU0Y3MRA6H0hvKtBg=;
 b=bYX0DS8kngDIl2nC6+/gAgJMBhSuSHHydpeItbTvRtpjONx9DnBNwbVfUMviCRbKtd
 0Z6g10cTWPkeQaV+Oea8EWMK16e0Z/WaaqxFSx5No9ZSYLYN8rA8DmjzfrHmrt/NQRiN
 7QohkLWCB2SR1g/SZopnrkH/nt9aUJu+qiFt49j1gpP92jPZT+n1hoNpKMWlY+JpMXUX
 +Ym9q8dUjtmtgz1E591fS7dZ6L2qogavJdWejJlOWx5T2QUdc41UKjaaVJYkHcNUytOF
 DFbNQan5n9ZNvN7h9UF17qdTIrFOPdn6uO7f6XxMof/D6JBuuFHtOWHpqgCs/q0xSLWr
 pXPQ==
X-Gm-Message-State: APjAAAVvOB3ug1Zzq6/9ApYxZUN3TIU+wU8K9LnRClVuAUGwNZI2e2YI
 nCBCHWHS33eGqdQ/d+EW5bY4aXN0kVf2O8FUT0c=
X-Google-Smtp-Source: APXvYqy3SxsCaIGAN0km14Gu+1qK1q1QvFGEKgLiT4Yp11oIdt/VnIJmbgqWhMYecQDHAsehR4TxSQnVIxOiKIHhSHc=
X-Received: by 2002:a9d:2184:: with SMTP id s4mr15681056otb.121.1582048632580; 
 Tue, 18 Feb 2020 09:57:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 09:57:12 -0800 (PST)
In-Reply-To: <20200217223558.863199-21-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-21-laurent@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 18:57:12 +0100
Message-ID: <CAL1e-=iG39+6=ojRvKod1-nTK2bJMpm81jiLFHLzs+t1OeiGVA@mail.gmail.com>
Subject: Re: [PATCH 20/22] linux-user: update syscall.tbl from linux
 0bf999f9c5e7
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="000000000000c32ef0059edd66db"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c32ef0059edd66db
Content-Type: text/plain; charset="UTF-8"

On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Run scripts/update-syscalltbl.sh with linux commit 0bf999f9c5e7
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---


Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


>  linux-user/arm/syscall.tbl        | 2 ++
>  linux-user/hppa/syscall.tbl       | 2 ++
>  linux-user/i386/syscall_32.tbl    | 2 ++
>  linux-user/m68k/syscall.tbl       | 4 +++-
>  linux-user/microblaze/syscall.tbl | 2 ++
>  linux-user/mips/syscall_o32.tbl   | 2 ++
>  linux-user/mips64/syscall_n32.tbl | 2 ++
>  linux-user/mips64/syscall_n64.tbl | 2 ++
>  linux-user/ppc/syscall.tbl        | 2 ++
>  linux-user/s390x/syscall.tbl      | 2 ++
>  linux-user/sh4/syscall.tbl        | 2 ++
>  linux-user/sparc/syscall.tbl      | 2 ++
>  linux-user/sparc64/syscall.tbl    | 2 ++
>  linux-user/x86_64/syscall_64.tbl  | 2 ++
>  linux-user/xtensa/syscall.tbl     | 2 ++
>  15 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/linux-user/arm/syscall.tbl b/linux-user/arm/syscall.tbl
> index 6da7dc4d79cc..4d1cf74a2caa 100644
> --- a/linux-user/arm/syscall.tbl
> +++ b/linux-user/arm/syscall.tbl
> @@ -449,3 +449,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  435    common  clone3                          sys_clone3
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/hppa/syscall.tbl b/linux-user/hppa/syscall.tbl
> index 285ff516150c..52a15f5cd130 100644
> --- a/linux-user/hppa/syscall.tbl
> +++ b/linux-user/hppa/syscall.tbl
> @@ -433,3 +433,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  435    common  clone3                          sys_clone3_wrapper
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/i386/syscall_32.tbl b/linux-user/i386/syscall_32.
> tbl
> index a2728f45906e..4fea592676c2 100644
> --- a/linux-user/i386/syscall_32.tbl
> +++ b/linux-user/i386/syscall_32.tbl
> @@ -440,3 +440,5 @@
>  433    i386    fspick                  sys_fspick
> __ia32_sys_fspick
>  434    i386    pidfd_open              sys_pidfd_open
> __ia32_sys_pidfd_open
>  435    i386    clone3                  sys_clone3
> __ia32_sys_clone3
> +437    i386    openat2                 sys_openat2
>  __ia32_sys_openat2
> +438    i386    pidfd_getfd             sys_pidfd_getfd
>  __ia32_sys_pidfd_getfd
> diff --git a/linux-user/m68k/syscall.tbl b/linux-user/m68k/syscall.tbl
> index a88a285a0e5f..f4f49fcb76d0 100644
> --- a/linux-user/m68k/syscall.tbl
> +++ b/linux-user/m68k/syscall.tbl
> @@ -434,4 +434,6 @@
>  432    common  fsmount                         sys_fsmount
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
> -# 435 reserved for clone3
> +435    common  clone3                          __sys_clone3
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/microblaze/syscall.tbl b/linux-user/microblaze/
> syscall.tbl
> index 09b0cd7dab0a..4c67b11f9c9e 100644
> --- a/linux-user/microblaze/syscall.tbl
> +++ b/linux-user/microblaze/syscall.tbl
> @@ -441,3 +441,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  435    common  clone3                          sys_clone3
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/mips/syscall_o32.tbl
> b/linux-user/mips/syscall_o32.tbl
> index 353539ea4140..ac586774c980 100644
> --- a/linux-user/mips/syscall_o32.tbl
> +++ b/linux-user/mips/syscall_o32.tbl
> @@ -423,3 +423,5 @@
>  433    o32     fspick                          sys_fspick
>  434    o32     pidfd_open                      sys_pidfd_open
>  435    o32     clone3                          __sys_clone3
> +437    o32     openat2                         sys_openat2
> +438    o32     pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/mips64/syscall_n32.tbl
> b/linux-user/mips64/syscall_n32.tbl
> index e7c5ab38e403..1f9e8ad636cc 100644
> --- a/linux-user/mips64/syscall_n32.tbl
> +++ b/linux-user/mips64/syscall_n32.tbl
> @@ -374,3 +374,5 @@
>  433    n32     fspick                          sys_fspick
>  434    n32     pidfd_open                      sys_pidfd_open
>  435    n32     clone3                          __sys_clone3
> +437    n32     openat2                         sys_openat2
> +438    n32     pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/mips64/syscall_n64.tbl
> b/linux-user/mips64/syscall_n64.tbl
> index 13cd66581f3b..c0b9d802dbf6 100644
> --- a/linux-user/mips64/syscall_n64.tbl
> +++ b/linux-user/mips64/syscall_n64.tbl
> @@ -350,3 +350,5 @@
>  433    n64     fspick                          sys_fspick
>  434    n64     pidfd_open                      sys_pidfd_open
>  435    n64     clone3                          __sys_clone3
> +437    n64     openat2                         sys_openat2
> +438    n64     pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/ppc/syscall.tbl b/linux-user/ppc/syscall.tbl
> index 43f736ed47f2..35b61bfc1b1a 100644
> --- a/linux-user/ppc/syscall.tbl
> +++ b/linux-user/ppc/syscall.tbl
> @@ -517,3 +517,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  435    nospu   clone3                          ppc_clone3
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/s390x/syscall.tbl b/linux-user/s390x/syscall.tbl
> index 3054e9c035a3..bd7bd3581a0f 100644
> --- a/linux-user/s390x/syscall.tbl
> +++ b/linux-user/s390x/syscall.tbl
> @@ -438,3 +438,5 @@
>  433  common    fspick                  sys_fspick
> sys_fspick
>  434  common    pidfd_open              sys_pidfd_open
> sys_pidfd_open
>  435  common    clone3                  sys_clone3
> sys_clone3
> +437  common    openat2                 sys_openat2
>  sys_openat2
> +438  common    pidfd_getfd             sys_pidfd_getfd
>  sys_pidfd_getfd
> diff --git a/linux-user/sh4/syscall.tbl b/linux-user/sh4/syscall.tbl
> index b5ed26c4c005..c7a30fcd135f 100644
> --- a/linux-user/sh4/syscall.tbl
> +++ b/linux-user/sh4/syscall.tbl
> @@ -438,3 +438,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  # 435 reserved for clone3
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/sparc/syscall.tbl b/linux-user/sparc/syscall.tbl
> index 8c8cc7537fb2..f13615ecdecc 100644
> --- a/linux-user/sparc/syscall.tbl
> +++ b/linux-user/sparc/syscall.tbl
> @@ -481,3 +481,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  # 435 reserved for clone3
> +437    common  openat2                 sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/sparc64/syscall.tbl b/linux-user/sparc64/syscall.
> tbl
> index 8c8cc7537fb2..f13615ecdecc 100644
> --- a/linux-user/sparc64/syscall.tbl
> +++ b/linux-user/sparc64/syscall.tbl
> @@ -481,3 +481,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  # 435 reserved for clone3
> +437    common  openat2                 sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> diff --git a/linux-user/x86_64/syscall_64.tbl b/linux-user/x86_64/syscall_
> 64.tbl
> index c29976eca4a8..44d510bc9b78 100644
> --- a/linux-user/x86_64/syscall_64.tbl
> +++ b/linux-user/x86_64/syscall_64.tbl
> @@ -357,6 +357,8 @@
>  433    common  fspick                  __x64_sys_fspick
>  434    common  pidfd_open              __x64_sys_pidfd_open
>  435    common  clone3                  __x64_sys_clone3/ptregs
> +437    common  openat2                 __x64_sys_openat2
> +438    common  pidfd_getfd             __x64_sys_pidfd_getfd
>
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/linux-user/xtensa/syscall.tbl b/linux-user/xtensa/syscall.tbl
> index 25f4de729a6d..85a9ab1bc04d 100644
> --- a/linux-user/xtensa/syscall.tbl
> +++ b/linux-user/xtensa/syscall.tbl
> @@ -406,3 +406,5 @@
>  433    common  fspick                          sys_fspick
>  434    common  pidfd_open                      sys_pidfd_open
>  435    common  clone3                          sys_clone3
> +437    common  openat2                         sys_openat2
> +438    common  pidfd_getfd                     sys_pidfd_getfd
> --
> 2.24.1
>
>
>

--000000000000c32ef0059edd66db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBNb25kYXksIEZlYnJ1YXJ5IDE3LCAyMDIwLCBMYXVyZW50IFZpdmllciAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmxhdXJlbnRAdml2aWVyLmV1Ij5sYXVyZW50QHZpdmllci5ldTwvYT4m
Z3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij5SdW4gc2NyaXB0cy91cGRhdGUtc3lzY2FsbHRibC5zaCB3aXRoIGxpbnV4IGNvbW1pdCAwYmY5
OTlmOWM1ZTc8YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBMYXVyZW50IFZpdmllciAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmxhdXJlbnRAdml2aWVyLmV1Ij5sYXVyZW50QHZpdmllci5ldTwvYT4mZ3Q7
PGJyPg0KLS0tPC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImNv
bG9yOnJnYigzNCwzNCwzNCk7Zm9udC1zaXplOjE0cHg7bGluZS1oZWlnaHQ6MjIuMTIwMDAwODM5
MjMzNHB4Ij5SZXZpZXdlZC1ieTogQWxla3NhbmRhciBNYXJrb3ZpYyAmbHQ7PC9zcGFuPjxhIGhy
ZWY9Im1haWx0bzphbWFya292aWNAd2F2ZWNvbXAuY29tIiBzdHlsZT0iZm9udC1zaXplOjE0cHg7
bGluZS1oZWlnaHQ6MjIuMTIwMDAwODM5MjMzNHB4Ij5hbWFya292aWNAd2F2ZWNvbXAuY29tPC9h
PjxzcGFuIHN0eWxlPSJjb2xvcjpyZ2IoMzQsMzQsMzQpO2ZvbnQtc2l6ZToxNHB4O2xpbmUtaGVp
Z2h0OjIyLjEyMDAwMDgzOTIzMzRweCI+Jmd0Ozwvc3Bhbj48YnI+PC9kaXY+PGRpdj7CoDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KwqBsaW51eC11
c2VyL2FybS9zeXNjYWxsLnRibMKgIMKgIMKgIMKgIHwgMiArKzxicj4NCsKgbGludXgtdXNlci9o
cHBhL3N5c2NhbGwudGJswqAgwqAgwqAgwqB8IDIgKys8YnI+DQrCoGxpbnV4LXVzZXIvaTM4Ni9z
eXNjYWxsXzMyLnRibMKgIMKgIHwgMiArKzxicj4NCsKgbGludXgtdXNlci9tNjhrL3N5c2NhbGwu
dGJswqAgwqAgwqAgwqB8IDQgKysrLTxicj4NCsKgbGludXgtdXNlci9taWNyb2JsYXplL3N5c2Nh
bGwuPHdicj50YmwgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL21pcHMvc3lzY2FsbF9vMzIuPHdi
cj50YmzCoCDCoHwgMiArKzxicj4NCsKgbGludXgtdXNlci9taXBzNjQvc3lzY2FsbF9uMzIuPHdi
cj50YmwgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL21pcHM2NC9zeXNjYWxsX242NC48d2JyPnRi
bCB8IDIgKys8YnI+DQrCoGxpbnV4LXVzZXIvcHBjL3N5c2NhbGwudGJswqAgwqAgwqAgwqAgfCAy
ICsrPGJyPg0KwqBsaW51eC11c2VyL3MzOTB4L3N5c2NhbGwudGJswqAgwqAgwqAgfCAyICsrPGJy
Pg0KwqBsaW51eC11c2VyL3NoNC9zeXNjYWxsLnRibMKgIMKgIMKgIMKgIHwgMiArKzxicj4NCsKg
bGludXgtdXNlci9zcGFyYy9zeXNjYWxsLnRibMKgIMKgIMKgIHwgMiArKzxicj4NCsKgbGludXgt
dXNlci9zcGFyYzY0L3N5c2NhbGwudGJswqAgwqAgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL3g4
Nl82NC9zeXNjYWxsXzY0Ljx3YnI+dGJswqAgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL3h0ZW5z
YS9zeXNjYWxsLnRibMKgIMKgIMKgfCAyICsrPGJyPg0KwqAxNSBmaWxlcyBjaGFuZ2VkLCAzMSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2xpbnV4
LXVzZXIvYXJtL3N5c2NhbGwudGJsIGIvbGludXgtdXNlci9hcm0vc3lzY2FsbC50Ymw8YnI+DQpp
bmRleCA2ZGE3ZGM0ZDc5Y2MuLjRkMWNmNzRhMmNhYSAxMDA2NDQ8YnI+DQotLS0gYS9saW51eC11
c2VyL2FybS9zeXNjYWxsLnRibDxicj4NCisrKyBiL2xpbnV4LXVzZXIvYXJtL3N5c2NhbGwudGJs
PGJyPg0KQEAgLTQ0OSwzICs0NDksNSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKg
NDM0wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBjb21tb27CoCBjbG9uZTPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzPGJyPg0KKzQzN8KgIMKg
IGNvbW1vbsKgIG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5
c19vcGVuYXQyPGJyPg0KKzQzOMKgIMKgIGNvbW1vbsKgIHBpZGZkX2dldGZkwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGlu
dXgtdXNlci9ocHBhL3N5c2NhbGwudGJsIGIvbGludXgtdXNlci9ocHBhL3N5c2NhbGwudGJsPGJy
Pg0KaW5kZXggMjg1ZmY1MTYxNTBjLi41MmExNWY1Y2QxMzAgMTAwNjQ0PGJyPg0KLS0tIGEvbGlu
dXgtdXNlci9ocHBhL3N5c2NhbGwudGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9ocHBhL3N5c2Nh
bGwudGJsPGJyPg0KQEAgLTQzMywzICs0MzMsNSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAg
ZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxi
cj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBjb21tb27CoCBjbG9uZTPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzX3dyYXBwZXI8
YnI+DQorNDM3wqAgwqAgY29tbW9uwqAgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgc3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgY29tbW9uwqAgcGlkZmRfZ2V0
ZmTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4NCmRp
ZmYgLS1naXQgYS9saW51eC11c2VyL2kzODYvc3lzY2FsbF8zMi48d2JyPnRibCBiL2xpbnV4LXVz
ZXIvaTM4Ni9zeXNjYWxsXzMyLjx3YnI+dGJsPGJyPg0KaW5kZXggYTI3MjhmNDU5MDZlLi40ZmVh
NTkyNjc2YzIgMTAwNjQ0PGJyPg0KLS0tIGEvbGludXgtdXNlci9pMzg2L3N5c2NhbGxfMzIuPHdi
cj50Ymw8YnI+DQorKysgYi9saW51eC11c2VyL2kzODYvc3lzY2FsbF8zMi48d2JyPnRibDxicj4N
CkBAIC00NDAsMyArNDQwLDUgQEA8YnI+DQrCoDQzM8KgIMKgIGkzODbCoCDCoCBmc3BpY2vCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgX19pYTMyX3N5c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIGkzODbCoCDCoCBwaWRm
ZF9vcGVuwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX3BpZGZkX29wZW7CoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBfX2lhMzJfc3lzX3BpZGZkX29wZW48YnI+DQrCoDQzNcKgIMKgIGkzODbCoCDC
oCBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgX19pYTMyX3N5c19jbG9uZTM8YnI+DQorNDM3wqAgwqAgaTM4
NsKgIMKgIG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19vcGVuYXQywqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX2lhMzJfc3lzX29wZW5hdDI8YnI+DQorNDM4wqAg
wqAgaTM4NsKgIMKgIHBpZGZkX2dldGZkwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0
ZmTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoF9faWEzMl9zeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpk
aWZmIC0tZ2l0IGEvbGludXgtdXNlci9tNjhrL3N5c2NhbGwudGJsIGIvbGludXgtdXNlci9tNjhr
L3N5c2NhbGwudGJsPGJyPg0KaW5kZXggYTg4YTI4NWEwZTVmLi5mNGY0OWZjYjc2ZDAgMTAwNjQ0
PGJyPg0KLS0tIGEvbGludXgtdXNlci9tNjhrL3N5c2NhbGwudGJsPGJyPg0KKysrIGIvbGludXgt
dXNlci9tNjhrL3N5c2NhbGwudGJsPGJyPg0KQEAgLTQzNCw0ICs0MzQsNiBAQDxicj4NCsKgNDMy
wqAgwqAgY29tbW9uwqAgZnNtb3VudMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgc3lzX2ZzbW91bnQ8YnI+DQrCoDQzM8KgIMKgIGNvbW1vbsKgIGZzcGlja8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIGNv
bW1vbsKgIHBpZGZkX29wZW7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfcGlk
ZmRfb3Blbjxicj4NCi0jIDQzNSByZXNlcnZlZCBmb3IgY2xvbmUzPGJyPg0KKzQzNcKgIMKgIGNv
bW1vbsKgIGNsb25lM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fc3lz
X2Nsb25lMzxicj4NCis0MzfCoCDCoCBjb21tb27CoCBvcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBjb21tb27CoCBw
aWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dldGZk
PGJyPg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvbWljcm9ibGF6ZS88d2JyPnN5c2NhbGwudGJs
IGIvbGludXgtdXNlci9taWNyb2JsYXplLzx3YnI+c3lzY2FsbC50Ymw8YnI+DQppbmRleCAwOWIw
Y2Q3ZGFiMGEuLjRjNjdiMTFmOWM5ZSAxMDA2NDQ8YnI+DQotLS0gYS9saW51eC11c2VyL21pY3Jv
YmxhemUvPHdicj5zeXNjYWxsLnRibDxicj4NCisrKyBiL2xpbnV4LXVzZXIvbWljcm9ibGF6ZS88
d2JyPnN5c2NhbGwudGJsPGJyPg0KQEAgLTQ0MSwzICs0NDEsNSBAQDxicj4NCsKgNDMzwqAgwqAg
Y29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lz
X2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBjb21tb27C
oCBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUz
PGJyPg0KKzQzN8KgIMKgIGNvbW1vbsKgIG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN5c19vcGVuYXQyPGJyPg0KKzQzOMKgIMKgIGNvbW1vbsKgIHBpZGZkX2dl
dGZkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpk
aWZmIC0tZ2l0IGEvbGludXgtdXNlci9taXBzL3N5c2NhbGxfbzMyLjx3YnI+dGJsIGIvbGludXgt
dXNlci9taXBzL3N5c2NhbGxfbzMyLjx3YnI+dGJsPGJyPg0KaW5kZXggMzUzNTM5ZWE0MTQwLi5h
YzU4Njc3NGM5ODAgMTAwNjQ0PGJyPg0KLS0tIGEvbGludXgtdXNlci9taXBzL3N5c2NhbGxfbzMy
Ljx3YnI+dGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9taXBzL3N5c2NhbGxfbzMyLjx3YnI+dGJs
PGJyPg0KQEAgLTQyMywzICs0MjMsNSBAQDxicj4NCsKgNDMzwqAgwqAgbzMywqAgwqAgwqBmc3Bp
Y2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfZnNwaWNrPGJyPg0K
wqA0MzTCoCDCoCBvMzLCoCDCoCDCoHBpZGZkX29wZW7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBzeXNfcGlkZmRfb3Blbjxicj4NCsKgNDM1wqAgwqAgbzMywqAgwqAgwqBjbG9uZTPC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3N5c19jbG9uZTM8YnI+DQor
NDM3wqAgwqAgbzMywqAgwqAgwqBvcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBvMzLCoCDCoCDCoHBpZGZkX2dldGZk
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZm
IC0tZ2l0IGEvbGludXgtdXNlci9taXBzNjQvc3lzY2FsbF88d2JyPm4zMi50YmwgYi9saW51eC11
c2VyL21pcHM2NC9zeXNjYWxsXzx3YnI+bjMyLnRibDxicj4NCmluZGV4IGU3YzVhYjM4ZTQwMy4u
MWY5ZThhZDYzNmNjIDEwMDY0NDxicj4NCi0tLSBhL2xpbnV4LXVzZXIvbWlwczY0L3N5c2NhbGxf
PHdicj5uMzIudGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9taXBzNjQvc3lzY2FsbF88d2JyPm4z
Mi50Ymw8YnI+DQpAQCAtMzc0LDMgKzM3NCw1IEBAPGJyPg0KwqA0MzPCoCDCoCBuMzLCoCDCoCDC
oGZzcGlja8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19mc3BpY2s8
YnI+DQrCoDQzNMKgIMKgIG4zMsKgIMKgIMKgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBuMzLCoCDCoCDCoGNs
b25lM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fc3lzX2Nsb25lMzxi
cj4NCis0MzfCoCDCoCBuMzLCoCDCoCDCoG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN5c19vcGVuYXQyPGJyPg0KKzQzOMKgIMKgIG4zMsKgIMKgIMKgcGlkZmRf
Z2V0ZmTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4N
CmRpZmYgLS1naXQgYS9saW51eC11c2VyL21pcHM2NC9zeXNjYWxsXzx3YnI+bjY0LnRibCBiL2xp
bnV4LXVzZXIvbWlwczY0L3N5c2NhbGxfPHdicj5uNjQudGJsPGJyPg0KaW5kZXggMTNjZDY2NTgx
ZjNiLi5jMGI5ZDgwMmRiZjYgMTAwNjQ0PGJyPg0KLS0tIGEvbGludXgtdXNlci9taXBzNjQvc3lz
Y2FsbF88d2JyPm42NC50Ymw8YnI+DQorKysgYi9saW51eC11c2VyL21pcHM2NC9zeXNjYWxsXzx3
YnI+bjY0LnRibDxicj4NCkBAIC0zNTAsMyArMzUwLDUgQEA8YnI+DQrCoDQzM8KgIMKgIG42NMKg
IMKgIMKgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2Zz
cGljazxicj4NCsKgNDM0wqAgwqAgbjY0wqAgwqAgwqBwaWRmZF9vcGVuwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc3lzX3BpZGZkX29wZW48YnI+DQrCoDQzNcKgIMKgIG42NMKgIMKg
IMKgY2xvbmUzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19zeXNfY2xv
bmUzPGJyPg0KKzQzN8KgIMKgIG42NMKgIMKgIMKgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgc3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgbjY0wqAgwqAgwqBw
aWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dldGZk
PGJyPg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvcHBjL3N5c2NhbGwudGJsIGIvbGludXgtdXNl
ci9wcGMvc3lzY2FsbC50Ymw8YnI+DQppbmRleCA0M2Y3MzZlZDQ3ZjIuLjM1YjYxYmZjMWIxYSAx
MDA2NDQ8YnI+DQotLS0gYS9saW51eC11c2VyL3BwYy9zeXNjYWxsLnRibDxicj4NCisrKyBiL2xp
bnV4LXVzZXIvcHBjL3N5c2NhbGwudGJsPGJyPg0KQEAgLTUxNywzICs1MTcsNSBAQDxicj4NCsKg
NDMzwqAgwqAgY29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDC
oCBub3NwdcKgIMKgY2xvbmUzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
cHBjX2Nsb25lMzxicj4NCis0MzfCoCDCoCBjb21tb27CoCBvcGVuYXQywqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBjb21tb27C
oCBwaWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dl
dGZkPGJyPg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvczM5MHgvc3lzY2FsbC50YmwgYi9saW51
eC11c2VyL3MzOTB4L3N5c2NhbGwudGJsPGJyPg0KaW5kZXggMzA1NGU5YzAzNWEzLi5iZDdiZDM1
ODFhMGYgMTAwNjQ0PGJyPg0KLS0tIGEvbGludXgtdXNlci9zMzkweC9zeXNjYWxsLnRibDxicj4N
CisrKyBiL2xpbnV4LXVzZXIvczM5MHgvc3lzY2FsbC50Ymw8YnI+DQpAQCAtNDM4LDMgKzQzOCw1
IEBAPGJyPg0KwqA0MzPCoCBjb21tb27CoCDCoCBmc3BpY2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBzeXNfZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGlj
azxicj4NCsKgNDM0wqAgY29tbW9uwqAgwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKg
IHN5c19waWRmZF9vcGVuwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX3BpZGZkX29wZW48
YnI+DQrCoDQzNcKgIGNvbW1vbsKgIMKgIGNsb25lM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHN5c19jbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzPGJy
Pg0KKzQzN8KgIGNvbW1vbsKgIMKgIG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5
c19vcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0Mjxicj4N
Cis0MzjCoCBjb21tb27CoCDCoCBwaWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3Bp
ZGZkX2dldGZkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpk
aWZmIC0tZ2l0IGEvbGludXgtdXNlci9zaDQvc3lzY2FsbC50YmwgYi9saW51eC11c2VyL3NoNC9z
eXNjYWxsLnRibDxicj4NCmluZGV4IGI1ZWQyNmM0YzAwNS4uYzdhMzBmY2QxMzVmIDEwMDY0NDxi
cj4NCi0tLSBhL2xpbnV4LXVzZXIvc2g0L3N5c2NhbGwudGJsPGJyPg0KKysrIGIvbGludXgtdXNl
ci9zaDQvc3lzY2FsbC50Ymw8YnI+DQpAQCAtNDM4LDMgKzQzOCw1IEBAPGJyPg0KwqA0MzPCoCDC
oCBjb21tb27CoCBmc3BpY2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBz
eXNfZnNwaWNrPGJyPg0KwqA0MzTCoCDCoCBjb21tb27CoCBwaWRmZF9vcGVuwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX3BpZGZkX29wZW48YnI+DQrCoCMgNDM1IHJlc2VydmVk
IGZvciBjbG9uZTM8YnI+DQorNDM3wqAgwqAgY29tbW9uwqAgb3BlbmF0MsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgY29tbW9u
wqAgcGlkZmRfZ2V0ZmTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9n
ZXRmZDxicj4NCmRpZmYgLS1naXQgYS9saW51eC11c2VyL3NwYXJjL3N5c2NhbGwudGJsIGIvbGlu
dXgtdXNlci9zcGFyYy9zeXNjYWxsLnRibDxicj4NCmluZGV4IDhjOGNjNzUzN2ZiMi4uZjEzNjE1
ZWNkZWNjIDEwMDY0NDxicj4NCi0tLSBhL2xpbnV4LXVzZXIvc3BhcmMvc3lzY2FsbC50Ymw8YnI+
DQorKysgYi9saW51eC11c2VyL3NwYXJjL3N5c2NhbGwudGJsPGJyPg0KQEAgLTQ4MSwzICs0ODEs
NSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlk
ZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJy
Pg0KwqAjIDQzNSByZXNlcnZlZCBmb3IgY2xvbmUzPGJyPg0KKzQzN8KgIMKgIGNvbW1vbsKgIG9w
ZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19vcGVuYXQyPGJyPg0KKzQzOMKgIMKg
IGNvbW1vbsKgIHBpZGZkX2dldGZkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNf
cGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9zcGFyYzY0L3N5c2NhbGwu
PHdicj50YmwgYi9saW51eC11c2VyL3NwYXJjNjQvc3lzY2FsbC48d2JyPnRibDxicj4NCmluZGV4
IDhjOGNjNzUzN2ZiMi4uZjEzNjE1ZWNkZWNjIDEwMDY0NDxicj4NCi0tLSBhL2xpbnV4LXVzZXIv
c3BhcmM2NC9zeXNjYWxsLjx3YnI+dGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9zcGFyYzY0L3N5
c2NhbGwuPHdicj50Ymw8YnI+DQpAQCAtNDgxLDMgKzQ4MSw1IEBAPGJyPg0KwqA0MzPCoCDCoCBj
b21tb27CoCBmc3BpY2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNf
ZnNwaWNrPGJyPg0KwqA0MzTCoCDCoCBjb21tb27CoCBwaWRmZF9vcGVuwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgc3lzX3BpZGZkX29wZW48YnI+DQrCoCMgNDM1IHJlc2VydmVkIGZv
ciBjbG9uZTM8YnI+DQorNDM3wqAgwqAgY29tbW9uwqAgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgY29tbW9uwqAgcGlkZmRfZ2V0ZmTC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4NCmRpZmYg
LS1naXQgYS9saW51eC11c2VyL3g4Nl82NC9zeXNjYWxsXzx3YnI+NjQudGJsIGIvbGludXgtdXNl
ci94ODZfNjQvc3lzY2FsbF88d2JyPjY0LnRibDxicj4NCmluZGV4IGMyOTk3NmVjYTRhOC4uNDRk
NTEwYmM5Yjc4IDEwMDY0NDxicj4NCi0tLSBhL2xpbnV4LXVzZXIveDg2XzY0L3N5c2NhbGxfPHdi
cj42NC50Ymw8YnI+DQorKysgYi9saW51eC11c2VyL3g4Nl82NC9zeXNjYWxsXzx3YnI+NjQudGJs
PGJyPg0KQEAgLTM1Nyw2ICszNTcsOCBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNr
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX194NjRfc3lzX2ZzcGljazxicj4NCsKgNDM0wqAg
wqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIF9feDY0X3N5c19waWRm
ZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBjb21tb27CoCBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBfX3g2NF9zeXNfY2xvbmUzL3B0cmVnczxicj4NCis0MzfCoCDCoCBjb21tb27CoCBv
cGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBfX3g2NF9zeXNfb3BlbmF0Mjxicj4NCis0
MzjCoCDCoCBjb21tb27CoCBwaWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgX194NjRfc3lz
X3BpZGZkX2dldGZkPGJyPg0KPGJyPg0KwqAjPGJyPg0KwqAjIHgzMi1zcGVjaWZpYyBzeXN0ZW0g
Y2FsbCBudW1iZXJzIHN0YXJ0IGF0IDUxMiB0byBhdm9pZCBjYWNoZSBpbXBhY3Q8YnI+DQpkaWZm
IC0tZ2l0IGEvbGludXgtdXNlci94dGVuc2Evc3lzY2FsbC48d2JyPnRibCBiL2xpbnV4LXVzZXIv
eHRlbnNhL3N5c2NhbGwuPHdicj50Ymw8YnI+DQppbmRleCAyNWY0ZGU3MjlhNmQuLjg1YTlhYjFi
YzA0ZCAxMDA2NDQ8YnI+DQotLS0gYS9saW51eC11c2VyL3h0ZW5zYS9zeXNjYWxsLjx3YnI+dGJs
PGJyPg0KKysrIGIvbGludXgtdXNlci94dGVuc2Evc3lzY2FsbC48d2JyPnRibDxicj4NCkBAIC00
MDYsMyArNDA2LDUgQEA8YnI+DQrCoDQzM8KgIMKgIGNvbW1vbsKgIGZzcGlja8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIGNv
bW1vbsKgIHBpZGZkX29wZW7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfcGlk
ZmRfb3Blbjxicj4NCsKgNDM1wqAgwqAgY29tbW9uwqAgY2xvbmUzwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2Nsb25lMzxicj4NCis0MzfCoCDCoCBjb21tb27CoCBv
cGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0Mjxi
cj4NCis0MzjCoCDCoCBjb21tb27CoCBwaWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgc3lzX3BpZGZkX2dldGZkPGJyPg0KLS0gPGJyPg0KMi4yNC4xPGJyPg0KPGJyPg0K
PGJyPg0KPC9ibG9ja3F1b3RlPg0K
--000000000000c32ef0059edd66db--

