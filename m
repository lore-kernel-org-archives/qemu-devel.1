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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8618C3403A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71AC2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URwhQfaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71AC2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j41Sx-0001E2-Ty
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 06:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j41SJ-0000lx-Sg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j41SH-0001D0-LH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 06:54:23 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j41SH-0001Cg-Dz; Tue, 18 Feb 2020 06:54:21 -0500
Received: by mail-oi1-x244.google.com with SMTP id p125so19787625oif.10;
 Tue, 18 Feb 2020 03:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jUXY1SgU9XEvFK3NRDKazrdMIYPpketa0p5vjjDs5R0=;
 b=URwhQfawgvs8KkwWht5nwycAG3zGhZBg2phHQcxyZBulzmS5GlKIa+C76b6Eo3VqHO
 7nSJpT0ap9zwjMqd9vcAnm0YQ8Auarzq6PEdTJIVsSErHIWhp71nZpTHgnYzPLlspUIB
 mfmMFwfeTU4D3WErQEMKJ+6tHOyRmWc/3DfbhkBojsuXD6x55zmK6zuQ+pA/NeVcdzf5
 PwS3ScVXnH0JY7XaCIESsjBKwSS28SPueaT6VhNyLeumwB87L747cK3eQERIop02z+Gi
 qtfv+38ed4eaQiaphgzvBKRBFvv4ragnn8Rtdn0xVjGubuROmS9Yppj5PEEPn7Gpsbt6
 XWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jUXY1SgU9XEvFK3NRDKazrdMIYPpketa0p5vjjDs5R0=;
 b=UiszU7KvFwJMXQlItzO91m/MfDcLSJrxugZcw2ihPku/DWt6+Ehtqq3aM2IWBCkAna
 jMS9m2bYTCzrBYjqUqLZ5tziHPlvf8pJOYUwO2IRTKPtPlVpa5WMtVP0Qr5mya7NoRlG
 kVXM5DzmYCfN9e/Dft17Thpxqfa66Qarw0aP84zUYeNLGlJezCBMV5iyS/JLA4sGrKVZ
 kyy2wJJFkalsl+EpKQ0aoiZZFMfAF1CsusGiyFLGFLTbpIti7i0ECut1p3ZghEUGiUEj
 PjLFIWHdj6o53U3TXzJhFZtN7Q91mmrfDNFJnq+4mraTeKNy0MQFYglEXa4+3pJSrwc2
 Hd4w==
X-Gm-Message-State: APjAAAWDWnRY4OAYgwGmGwGAPsJ9fqpOqN4LB/Laxi1oh+GQ693lY0pn
 TQ4EeuKi6vtcyJE0v+8hjAwVyZ/LnbhCZ14MqXs=
X-Google-Smtp-Source: APXvYqwPt9kwbAAYV/ySlTb97zgxa+KDqrXnEow9FuebqiP35ellMlp7Lmd6WpD9Z4Nj1ZvUU0Rm8W0VAQpt7orhtws=
X-Received: by 2002:aca:5248:: with SMTP id g69mr939269oib.106.1582026860512; 
 Tue, 18 Feb 2020 03:54:20 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Tue, 18 Feb 2020 03:54:20 -0800 (PST)
In-Reply-To: <20200217223558.863199-21-laurent@vivier.eu>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-21-laurent@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 18 Feb 2020 12:54:20 +0100
Message-ID: <CAL1e-=jypqDYT3Q5s_Kjieqc9zTPbSLFhNLiT4ipaam0j6yX2g@mail.gmail.com>
Subject: Re: [PATCH 20/22] linux-user: update syscall.tbl from linux
 0bf999f9c5e7
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/alternative; boundary="0000000000000bcd2b059ed855ec"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

--0000000000000bcd2b059ed855ec
Content-Type: text/plain; charset="UTF-8"

On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu> wrote:

> Run scripts/update-syscalltbl.sh with linux commit 0bf999f9c5e7
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---


Wow, new syscalls keep coming in....


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

--0000000000000bcd2b059ed855ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBNb25kYXksIEZlYnJ1YXJ5IDE3LCAyMDIwLCBMYXVyZW50IFZpdmllciAmbHQ7
PGEgaHJlZj0ibWFpbHRvOmxhdXJlbnRAdml2aWVyLmV1Ij5sYXVyZW50QHZpdmllci5ldTwvYT4m
Z3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij5SdW4gc2NyaXB0cy91cGRhdGUtc3lzY2FsbHRibC5zaCB3aXRoIGxpbnV4IGNvbW1pdCAwYmY5
OTlmOWM1ZTc8YnI+DQo8YnI+DQpTaWduZWQtb2ZmLWJ5OiBMYXVyZW50IFZpdmllciAmbHQ7PGEg
aHJlZj0ibWFpbHRvOmxhdXJlbnRAdml2aWVyLmV1Ij5sYXVyZW50QHZpdmllci5ldTwvYT4mZ3Q7
PGJyPg0KLS0tPC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+V293LCBuZXcgc3lzY2Fs
bHMga2VlcCBjb21pbmcgaW4uLi4uPC9kaXY+PGRpdj7CoDwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAj
Y2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPg0KwqBsaW51eC11c2VyL2FybS9zeXNjYWxsLnRi
bMKgIMKgIMKgIMKgIHwgMiArKzxicj4NCsKgbGludXgtdXNlci9ocHBhL3N5c2NhbGwudGJswqAg
wqAgwqAgwqB8IDIgKys8YnI+DQrCoGxpbnV4LXVzZXIvaTM4Ni9zeXNjYWxsXzMyLnRibMKgIMKg
IHwgMiArKzxicj4NCsKgbGludXgtdXNlci9tNjhrL3N5c2NhbGwudGJswqAgwqAgwqAgwqB8IDQg
KysrLTxicj4NCsKgbGludXgtdXNlci9taWNyb2JsYXplL3N5c2NhbGwuPHdicj50YmwgfCAyICsr
PGJyPg0KwqBsaW51eC11c2VyL21pcHMvc3lzY2FsbF9vMzIuPHdicj50YmzCoCDCoHwgMiArKzxi
cj4NCsKgbGludXgtdXNlci9taXBzNjQvc3lzY2FsbF9uMzIuPHdicj50YmwgfCAyICsrPGJyPg0K
wqBsaW51eC11c2VyL21pcHM2NC9zeXNjYWxsX242NC48d2JyPnRibCB8IDIgKys8YnI+DQrCoGxp
bnV4LXVzZXIvcHBjL3N5c2NhbGwudGJswqAgwqAgwqAgwqAgfCAyICsrPGJyPg0KwqBsaW51eC11
c2VyL3MzOTB4L3N5c2NhbGwudGJswqAgwqAgwqAgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL3No
NC9zeXNjYWxsLnRibMKgIMKgIMKgIMKgIHwgMiArKzxicj4NCsKgbGludXgtdXNlci9zcGFyYy9z
eXNjYWxsLnRibMKgIMKgIMKgIHwgMiArKzxicj4NCsKgbGludXgtdXNlci9zcGFyYzY0L3N5c2Nh
bGwudGJswqAgwqAgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL3g4Nl82NC9zeXNjYWxsXzY0Ljx3
YnI+dGJswqAgfCAyICsrPGJyPg0KwqBsaW51eC11c2VyL3h0ZW5zYS9zeXNjYWxsLnRibMKgIMKg
IMKgfCAyICsrPGJyPg0KwqAxNSBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pPGJyPg0KPGJyPg0KZGlmZiAtLWdpdCBhL2xpbnV4LXVzZXIvYXJtL3N5c2NhbGwu
dGJsIGIvbGludXgtdXNlci9hcm0vc3lzY2FsbC50Ymw8YnI+DQppbmRleCA2ZGE3ZGM0ZDc5Y2Mu
LjRkMWNmNzRhMmNhYSAxMDA2NDQ8YnI+DQotLS0gYS9saW51eC11c2VyL2FybS9zeXNjYWxsLnRi
bDxicj4NCisrKyBiL2xpbnV4LXVzZXIvYXJtL3N5c2NhbGwudGJsPGJyPg0KQEAgLTQ0OSwzICs0
NDksNSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29tbW9uwqAg
cGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVu
PGJyPg0KwqA0MzXCoCDCoCBjb21tb27CoCBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzPGJyPg0KKzQzN8KgIMKgIGNvbW1vbsKgIG9wZW5hdDLC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19vcGVuYXQyPGJyPg0KKzQz
OMKgIMKgIGNvbW1vbsKgIHBpZGZkX2dldGZkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9ocHBhL3N5c2Nh
bGwudGJsIGIvbGludXgtdXNlci9ocHBhL3N5c2NhbGwudGJsPGJyPg0KaW5kZXggMjg1ZmY1MTYx
NTBjLi41MmExNWY1Y2QxMzAgMTAwNjQ0PGJyPg0KLS0tIGEvbGludXgtdXNlci9ocHBhL3N5c2Nh
bGwudGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9ocHBhL3N5c2NhbGwudGJsPGJyPg0KQEAgLTQz
MywzICs0MzMsNSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29t
bW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRm
ZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBjb21tb27CoCBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzX3dyYXBwZXI8YnI+DQorNDM3wqAgwqAgY29t
bW9uwqAgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX29w
ZW5hdDI8YnI+DQorNDM4wqAgwqAgY29tbW9uwqAgcGlkZmRfZ2V0ZmTCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4NCmRpZmYgLS1naXQgYS9saW51eC11
c2VyL2kzODYvc3lzY2FsbF8zMi48d2JyPnRibCBiL2xpbnV4LXVzZXIvaTM4Ni9zeXNjYWxsXzMy
Ljx3YnI+dGJsPGJyPg0KaW5kZXggYTI3MjhmNDU5MDZlLi40ZmVhNTkyNjc2YzIgMTAwNjQ0PGJy
Pg0KLS0tIGEvbGludXgtdXNlci9pMzg2L3N5c2NhbGxfMzIuPHdicj50Ymw8YnI+DQorKysgYi9s
aW51eC11c2VyL2kzODYvc3lzY2FsbF8zMi48d2JyPnRibDxicj4NCkBAIC00NDAsMyArNDQwLDUg
QEA8YnI+DQrCoDQzM8KgIMKgIGkzODbCoCDCoCBmc3BpY2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCBzeXNfZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19pYTMyX3N5
c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIGkzODbCoCDCoCBwaWRmZF9vcGVuwqAgwqAgwqAgwqAg
wqAgwqAgwqAgc3lzX3BpZGZkX29wZW7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX2lhMzJf
c3lzX3BpZGZkX29wZW48YnI+DQrCoDQzNcKgIMKgIGkzODbCoCDCoCBjbG9uZTPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgX19pYTMyX3N5c19jbG9uZTM8YnI+DQorNDM3wqAgwqAgaTM4NsKgIMKgIG9wZW5hdDLCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19vcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBfX2lhMzJfc3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgaTM4NsKgIMKgIHBpZGZk
X2dldGZkwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmTCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoF9faWEzMl9zeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgt
dXNlci9tNjhrL3N5c2NhbGwudGJsIGIvbGludXgtdXNlci9tNjhrL3N5c2NhbGwudGJsPGJyPg0K
aW5kZXggYTg4YTI4NWEwZTVmLi5mNGY0OWZjYjc2ZDAgMTAwNjQ0PGJyPg0KLS0tIGEvbGludXgt
dXNlci9tNjhrL3N5c2NhbGwudGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9tNjhrL3N5c2NhbGwu
dGJsPGJyPg0KQEAgLTQzNCw0ICs0MzQsNiBAQDxicj4NCsKgNDMywqAgwqAgY29tbW9uwqAgZnNt
b3VudMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX2ZzbW91bnQ8YnI+
DQrCoDQzM8KgIMKgIGNvbW1vbsKgIGZzcGlja8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN5c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIGNvbW1vbsKgIHBpZGZkX29wZW7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfcGlkZmRfb3Blbjxicj4NCi0jIDQz
NSByZXNlcnZlZCBmb3IgY2xvbmUzPGJyPg0KKzQzNcKgIMKgIGNvbW1vbsKgIGNsb25lM8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fc3lzX2Nsb25lMzxicj4NCis0MzfC
oCDCoCBjb21tb27CoCBvcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBjb21tb27CoCBwaWRmZF9nZXRmZMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dldGZkPGJyPg0KZGlmZiAtLWdpdCBh
L2xpbnV4LXVzZXIvbWljcm9ibGF6ZS88d2JyPnN5c2NhbGwudGJsIGIvbGludXgtdXNlci9taWNy
b2JsYXplLzx3YnI+c3lzY2FsbC50Ymw8YnI+DQppbmRleCAwOWIwY2Q3ZGFiMGEuLjRjNjdiMTFm
OWM5ZSAxMDA2NDQ8YnI+DQotLS0gYS9saW51eC11c2VyL21pY3JvYmxhemUvPHdicj5zeXNjYWxs
LnRibDxicj4NCisrKyBiL2xpbnV4LXVzZXIvbWljcm9ibGF6ZS88d2JyPnN5c2NhbGwudGJsPGJy
Pg0KQEAgLTQ0MSwzICs0NDEsNSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNrwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0
wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBjb21tb27CoCBjbG9uZTPCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzPGJyPg0KKzQzN8KgIMKgIGNv
bW1vbsKgIG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19v
cGVuYXQyPGJyPg0KKzQzOMKgIMKgIGNvbW1vbsKgIHBpZGZkX2dldGZkwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgt
dXNlci9taXBzL3N5c2NhbGxfbzMyLjx3YnI+dGJsIGIvbGludXgtdXNlci9taXBzL3N5c2NhbGxf
bzMyLjx3YnI+dGJsPGJyPg0KaW5kZXggMzUzNTM5ZWE0MTQwLi5hYzU4Njc3NGM5ODAgMTAwNjQ0
PGJyPg0KLS0tIGEvbGludXgtdXNlci9taXBzL3N5c2NhbGxfbzMyLjx3YnI+dGJsPGJyPg0KKysr
IGIvbGludXgtdXNlci9taXBzL3N5c2NhbGxfbzMyLjx3YnI+dGJsPGJyPg0KQEAgLTQyMywzICs0
MjMsNSBAQDxicj4NCsKgNDMzwqAgwqAgbzMywqAgwqAgwqBmc3BpY2vCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfZnNwaWNrPGJyPg0KwqA0MzTCoCDCoCBvMzLCoCDC
oCDCoHBpZGZkX29wZW7CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfcGlkZmRf
b3Blbjxicj4NCsKgNDM1wqAgwqAgbzMywqAgwqAgwqBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBfX3N5c19jbG9uZTM8YnI+DQorNDM3wqAgwqAgbzMywqAgwqAg
wqBvcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0
Mjxicj4NCis0MzjCoCDCoCBvMzLCoCDCoCDCoHBpZGZkX2dldGZkwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgtdXNl
ci9taXBzNjQvc3lzY2FsbF88d2JyPm4zMi50YmwgYi9saW51eC11c2VyL21pcHM2NC9zeXNjYWxs
Xzx3YnI+bjMyLnRibDxicj4NCmluZGV4IGU3YzVhYjM4ZTQwMy4uMWY5ZThhZDYzNmNjIDEwMDY0
NDxicj4NCi0tLSBhL2xpbnV4LXVzZXIvbWlwczY0L3N5c2NhbGxfPHdicj5uMzIudGJsPGJyPg0K
KysrIGIvbGludXgtdXNlci9taXBzNjQvc3lzY2FsbF88d2JyPm4zMi50Ymw8YnI+DQpAQCAtMzc0
LDMgKzM3NCw1IEBAPGJyPg0KwqA0MzPCoCDCoCBuMzLCoCDCoCDCoGZzcGlja8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIG4z
MsKgIMKgIMKgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19w
aWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBuMzLCoCDCoCDCoGNsb25lM8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIF9fc3lzX2Nsb25lMzxicj4NCis0MzfCoCDCoCBuMzLC
oCDCoCDCoG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19v
cGVuYXQyPGJyPg0KKzQzOMKgIMKgIG4zMsKgIMKgIMKgcGlkZmRfZ2V0ZmTCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4NCmRpZmYgLS1naXQgYS9saW51
eC11c2VyL21pcHM2NC9zeXNjYWxsXzx3YnI+bjY0LnRibCBiL2xpbnV4LXVzZXIvbWlwczY0L3N5
c2NhbGxfPHdicj5uNjQudGJsPGJyPg0KaW5kZXggMTNjZDY2NTgxZjNiLi5jMGI5ZDgwMmRiZjYg
MTAwNjQ0PGJyPg0KLS0tIGEvbGludXgtdXNlci9taXBzNjQvc3lzY2FsbF88d2JyPm42NC50Ymw8
YnI+DQorKysgYi9saW51eC11c2VyL21pcHM2NC9zeXNjYWxsXzx3YnI+bjY0LnRibDxicj4NCkBA
IC0zNTAsMyArMzUwLDUgQEA8YnI+DQrCoDQzM8KgIMKgIG42NMKgIMKgIMKgZnNwaWNrwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0wqAg
wqAgbjY0wqAgwqAgwqBwaWRmZF9vcGVuwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c3lzX3BpZGZkX29wZW48YnI+DQrCoDQzNcKgIMKgIG42NMKgIMKgIMKgY2xvbmUzwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgX19zeXNfY2xvbmUzPGJyPg0KKzQzN8KgIMKg
IG42NMKgIMKgIMKgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
c3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgbjY0wqAgwqAgwqBwaWRmZF9nZXRmZMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dldGZkPGJyPg0KZGlmZiAtLWdpdCBh
L2xpbnV4LXVzZXIvcHBjL3N5c2NhbGwudGJsIGIvbGludXgtdXNlci9wcGMvc3lzY2FsbC50Ymw8
YnI+DQppbmRleCA0M2Y3MzZlZDQ3ZjIuLjM1YjYxYmZjMWIxYSAxMDA2NDQ8YnI+DQotLS0gYS9s
aW51eC11c2VyL3BwYy9zeXNjYWxsLnRibDxicj4NCisrKyBiL2xpbnV4LXVzZXIvcHBjL3N5c2Nh
bGwudGJsPGJyPg0KQEAgLTUxNywzICs1MTcsNSBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAg
ZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxi
cj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXCoCDCoCBub3NwdcKgIMKgY2xvbmUz
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcHBjX2Nsb25lMzxicj4NCis0
MzfCoCDCoCBjb21tb27CoCBvcGVuYXQywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBjb21tb27CoCBwaWRmZF9nZXRmZMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dldGZkPGJyPg0KZGlmZiAtLWdp
dCBhL2xpbnV4LXVzZXIvczM5MHgvc3lzY2FsbC50YmwgYi9saW51eC11c2VyL3MzOTB4L3N5c2Nh
bGwudGJsPGJyPg0KaW5kZXggMzA1NGU5YzAzNWEzLi5iZDdiZDM1ODFhMGYgMTAwNjQ0PGJyPg0K
LS0tIGEvbGludXgtdXNlci9zMzkweC9zeXNjYWxsLnRibDxicj4NCisrKyBiL2xpbnV4LXVzZXIv
czM5MHgvc3lzY2FsbC50Ymw8YnI+DQpAQCAtNDM4LDMgKzQzOCw1IEBAPGJyPg0KwqA0MzPCoCBj
b21tb27CoCDCoCBmc3BpY2vCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfZnNwaWNrwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX2ZzcGljazxicj4NCsKgNDM0wqAgY29t
bW9uwqAgwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVuwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgc3lzX3BpZGZkX29wZW48YnI+DQrCoDQzNcKgIGNvbW1v
bsKgIMKgIGNsb25lM8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19jbG9uZTPCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfY2xvbmUzPGJyPg0KKzQzN8KgIGNvbW1vbsKg
IMKgIG9wZW5hdDLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19vcGVuYXQywqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCBjb21tb27CoCDC
oCBwaWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZkX2dldGZkwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgt
dXNlci9zaDQvc3lzY2FsbC50YmwgYi9saW51eC11c2VyL3NoNC9zeXNjYWxsLnRibDxicj4NCmlu
ZGV4IGI1ZWQyNmM0YzAwNS4uYzdhMzBmY2QxMzVmIDEwMDY0NDxicj4NCi0tLSBhL2xpbnV4LXVz
ZXIvc2g0L3N5c2NhbGwudGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9zaDQvc3lzY2FsbC50Ymw8
YnI+DQpAQCAtNDM4LDMgKzQzOCw1IEBAPGJyPg0KwqA0MzPCoCDCoCBjb21tb27CoCBmc3BpY2vC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfZnNwaWNrPGJyPg0KwqA0
MzTCoCDCoCBjb21tb27CoCBwaWRmZF9vcGVuwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgc3lzX3BpZGZkX29wZW48YnI+DQrCoCMgNDM1IHJlc2VydmVkIGZvciBjbG9uZTM8YnI+DQor
NDM3wqAgwqAgY29tbW9uwqAgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgc3lzX29wZW5hdDI8YnI+DQorNDM4wqAgwqAgY29tbW9uwqAgcGlkZmRfZ2V0ZmTCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4NCmRpZmYgLS1n
aXQgYS9saW51eC11c2VyL3NwYXJjL3N5c2NhbGwudGJsIGIvbGludXgtdXNlci9zcGFyYy9zeXNj
YWxsLnRibDxicj4NCmluZGV4IDhjOGNjNzUzN2ZiMi4uZjEzNjE1ZWNkZWNjIDEwMDY0NDxicj4N
Ci0tLSBhL2xpbnV4LXVzZXIvc3BhcmMvc3lzY2FsbC50Ymw8YnI+DQorKysgYi9saW51eC11c2Vy
L3NwYXJjL3N5c2NhbGwudGJsPGJyPg0KQEAgLTQ4MSwzICs0ODEsNSBAQDxicj4NCsKgNDMzwqAg
wqAgY29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c3lzX2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlkZmRfb3BlbsKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHN5c19waWRmZF9vcGVuPGJyPg0KwqAjIDQzNSByZXNlcnZl
ZCBmb3IgY2xvbmUzPGJyPg0KKzQzN8KgIMKgIGNvbW1vbsKgIG9wZW5hdDLCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN5c19vcGVuYXQyPGJyPg0KKzQzOMKgIMKgIGNvbW1vbsKgIHBpZGZkX2dl
dGZkwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfcGlkZmRfZ2V0ZmQ8YnI+DQpk
aWZmIC0tZ2l0IGEvbGludXgtdXNlci9zcGFyYzY0L3N5c2NhbGwuPHdicj50YmwgYi9saW51eC11
c2VyL3NwYXJjNjQvc3lzY2FsbC48d2JyPnRibDxicj4NCmluZGV4IDhjOGNjNzUzN2ZiMi4uZjEz
NjE1ZWNkZWNjIDEwMDY0NDxicj4NCi0tLSBhL2xpbnV4LXVzZXIvc3BhcmM2NC9zeXNjYWxsLjx3
YnI+dGJsPGJyPg0KKysrIGIvbGludXgtdXNlci9zcGFyYzY0L3N5c2NhbGwuPHdicj50Ymw8YnI+
DQpAQCAtNDgxLDMgKzQ4MSw1IEBAPGJyPg0KwqA0MzPCoCDCoCBjb21tb27CoCBmc3BpY2vCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfZnNwaWNrPGJyPg0KwqA0MzTC
oCDCoCBjb21tb27CoCBwaWRmZF9vcGVuwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
c3lzX3BpZGZkX29wZW48YnI+DQrCoCMgNDM1IHJlc2VydmVkIGZvciBjbG9uZTM8YnI+DQorNDM3
wqAgwqAgY29tbW9uwqAgb3BlbmF0MsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX29wZW5h
dDI8YnI+DQorNDM4wqAgwqAgY29tbW9uwqAgcGlkZmRfZ2V0ZmTCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHN5c19waWRmZF9nZXRmZDxicj4NCmRpZmYgLS1naXQgYS9saW51eC11c2Vy
L3g4Nl82NC9zeXNjYWxsXzx3YnI+NjQudGJsIGIvbGludXgtdXNlci94ODZfNjQvc3lzY2FsbF88
d2JyPjY0LnRibDxicj4NCmluZGV4IGMyOTk3NmVjYTRhOC4uNDRkNTEwYmM5Yjc4IDEwMDY0NDxi
cj4NCi0tLSBhL2xpbnV4LXVzZXIveDg2XzY0L3N5c2NhbGxfPHdicj42NC50Ymw8YnI+DQorKysg
Yi9saW51eC11c2VyL3g4Nl82NC9zeXNjYWxsXzx3YnI+NjQudGJsPGJyPg0KQEAgLTM1Nyw2ICsz
NTcsOCBAQDxicj4NCsKgNDMzwqAgwqAgY29tbW9uwqAgZnNwaWNrwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgX194NjRfc3lzX2ZzcGljazxicj4NCsKgNDM0wqAgwqAgY29tbW9uwqAgcGlkZmRf
b3BlbsKgIMKgIMKgIMKgIMKgIMKgIMKgIF9feDY0X3N5c19waWRmZF9vcGVuPGJyPg0KwqA0MzXC
oCDCoCBjb21tb27CoCBjbG9uZTPCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBfX3g2NF9zeXNf
Y2xvbmUzL3B0cmVnczxicj4NCis0MzfCoCDCoCBjb21tb27CoCBvcGVuYXQywqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBfX3g2NF9zeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBjb21tb27CoCBw
aWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgX194NjRfc3lzX3BpZGZkX2dldGZkPGJyPg0K
PGJyPg0KwqAjPGJyPg0KwqAjIHgzMi1zcGVjaWZpYyBzeXN0ZW0gY2FsbCBudW1iZXJzIHN0YXJ0
IGF0IDUxMiB0byBhdm9pZCBjYWNoZSBpbXBhY3Q8YnI+DQpkaWZmIC0tZ2l0IGEvbGludXgtdXNl
ci94dGVuc2Evc3lzY2FsbC48d2JyPnRibCBiL2xpbnV4LXVzZXIveHRlbnNhL3N5c2NhbGwuPHdi
cj50Ymw8YnI+DQppbmRleCAyNWY0ZGU3MjlhNmQuLjg1YTlhYjFiYzA0ZCAxMDA2NDQ8YnI+DQot
LS0gYS9saW51eC11c2VyL3h0ZW5zYS9zeXNjYWxsLjx3YnI+dGJsPGJyPg0KKysrIGIvbGludXgt
dXNlci94dGVuc2Evc3lzY2FsbC48d2JyPnRibDxicj4NCkBAIC00MDYsMyArNDA2LDUgQEA8YnI+
DQrCoDQzM8KgIMKgIGNvbW1vbsKgIGZzcGlja8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIHN5c19mc3BpY2s8YnI+DQrCoDQzNMKgIMKgIGNvbW1vbsKgIHBpZGZkX29wZW7C
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBzeXNfcGlkZmRfb3Blbjxicj4NCsKgNDM1
wqAgwqAgY29tbW9uwqAgY2xvbmUzwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgc3lzX2Nsb25lMzxicj4NCis0MzfCoCDCoCBjb21tb27CoCBvcGVuYXQywqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzeXNfb3BlbmF0Mjxicj4NCis0MzjCoCDCoCBjb21t
b27CoCBwaWRmZF9nZXRmZMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgc3lzX3BpZGZk
X2dldGZkPGJyPg0KLS0gPGJyPg0KMi4yNC4xPGJyPg0KPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3Rl
Pg0K
--0000000000000bcd2b059ed855ec--

