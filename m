Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652F3C28CC3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 03:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C24F20684
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 03:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLpZyfNp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ5vp-0004MY-TU
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 23:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hsp.cat7@gmail.com>) id 1hZ5v0-0003vr-UR
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 23:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1hZ5uz-0001hC-29
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 23:51:54 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1hZ5uy-0001bG-Q8
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 23:51:53 -0400
Received: by mail-oi1-x244.google.com with SMTP id u64so532168oib.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=Vqha7UHe1gywWApwtOU2vhANaW9Z2sPRiGR1Kz361r0=;
 b=oLpZyfNp9GOw8fwgMUB45CJ0s3voLDN1LS9RKgZ7ji/Z4NYJTnqL5W1cA9H8JEWR6P
 AjKZ8YDd9KwGYyWGYggIodWPhjU8vrcZVlIgqRCIc5riYXPpLqyN0kEUk+GYor1wlFSj
 JGH8rhiEo2TQzpNFdViteLKRyEK0JLq3ZoS/4rHJ8grC/MYfjQzbX52x22eBIpc8mRV7
 7bRRpuqtcWVBi9vGsXiv8x8JUG7/taNSPG0leGnpIpNoebOV+bfok95r46Tvv7SqtgCN
 nqb2YTjsTE91X0Ew1QEFMFc/PgHy4OCq14R5GaJ3n476guVRZBPlZI7Qkw2KYNGKMtSs
 I1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=Vqha7UHe1gywWApwtOU2vhANaW9Z2sPRiGR1Kz361r0=;
 b=dyvVK7U7y2WrvkQBD1+u2HZmBv2/jnbf+JW8Mv2WkfkYsuUcYyiFvniMVAjAMWFVbV
 o86YrHQEb8BwdoHTOENQcPhIgy99VA2X0lWVoqbRZ5UR1JUkSvzdfxWneort/A6aXbZI
 doJDDD8i3jCuNhNxQ3MMctKoxcsMJcoebW1aCpb+mVT3gkccXRlqFglqZkRwDU5C2UBs
 PyWZkizfnC6EOslwvH9lR0nsm+QwjKkOJmZE51wHyzIDtUGHLsdgfREjMzmUY6ZUxHgi
 G3rvyiKaQFEIJ8QKrcjO7bKpmvPnP23O06LIkui5rxPLYhxCsPg4OjYaSzvLSJ01H9NI
 gaag==
X-Gm-Message-State: APjAAAXXM+6nUMF3jI/6s1PRON56iW4CU1fqVXB9NvSFRM7lpqoPV4sL
 UgWuCiQAoY9C6AJXNq5AejwBCybDs2s3qmE0sz6aI8GJ
X-Google-Smtp-Source: APXvYqzEt3wKR80TaFyQ9DIhSb8aWf87YrgRUvpDSleqM1z1+prS1QXgqW6fyCbwBCgDlNxKXyak2tfZmRolT4Cgr4o=
X-Received: by 2002:a54:4686:: with SMTP id k6mr2518066oic.112.1559879510680; 
 Thu, 06 Jun 2019 20:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Fri, 7 Jun 2019 05:51:39 +0200
Message-ID: <CABLmASH-AD8hf9u6LLJPyH8huaH+KX+opPqYh1K9yxu+xc2PCA@mail.gmail.com>
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/8] Optimize emulation of ten Altivec
 instructions: lvsl, 
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series gives me several compilation errors.
When compiled with --disable-werror, OSX 10.3 guest on qemu-system-ppc
shows corrupted desktop graphics.

Compiled with:
./configure --target-list=3D"ppc-softmmu" --enable-sdl --enable-gtk  && mak=
e
-j8

gcc is:
[hsp@fedora30 qemu-master]$ gcc -v
Using built-in specs.
COLLECT_GCC=3Dgcc
COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/9/lto-wrapper
OFFLOAD_TARGET_NAMES=3Dnvptx-none
OFFLOAD_TARGET_DEFAULT=3D1
Target: x86_64-redhat-linux
Configured with: ../configure --enable-bootstrap
--enable-languages=3Dc,c++,fortran,objc,obj-c++,ada,go,d,lto --prefix=3D/us=
r
--mandir=3D/usr/share/man --infodir=3D/usr/share/info --with-bugurl=3D
http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=3Dposi=
x
--enable-checking=3Drelease --enable-multilib --with-system-zlib
--enable-__cxa_atexit --disable-libunwind-exceptions
--enable-gnu-unique-object --enable-linker-build-id
--with-gcc-major-version-only --with-linker-hash-style=3Dgnu --enable-plugi=
n
--enable-initfini-array --with-isl --enable-offload-targets=3Dnvptx-none
--without-cuda-driver --enable-gnu-indirect-function --enable-cet
--with-tune=3Dgeneric --with-arch_32=3Di686 --build=3Dx86_64-redhat-linux
Thread model: posix
gcc version 9.1.1 20190503 (Red Hat 9.1.1-1) (GCC)

Errors are:

/home/hsp/src/qemu-master/tcg/tcg-op.h:837:24: error: initialization of
=E2=80=98TCGv_i64=E2=80=99 {aka =E2=80=98struct TCGv_i64_d *=E2=80=99} from=
 incompatible pointer type
=E2=80=98TCGv_i32=E2=80=99 {aka =E2=80=98struct TCGv_i32_d *=E2=80=99} [-We=
rror=3Dincompatible-pointer-types]
  837 | #define tcg_temp_new() tcg_temp_new_i32()
      |                        ^~~~~~~~~~~~~~~~
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c:513:19: note:
in expansion of macro =E2=80=98tcg_temp_new=E2=80=99
  513 |     TCGv_i64 EA =3D tcg_temp_new();
      |                   ^~~~~~~~~~~~
In file included from /home/hsp/src/qemu-master/target/ppc/translate.c:6826=
:
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c:517:29:
error: passing argument 2 of =E2=80=98gen_addr_reg_index=E2=80=99 from inco=
mpatible pointer
type [-Werror=3Dincompatible-pointer-types]
  517 |     gen_addr_reg_index(ctx, EA);
      |                             ^~
      |                             |
      |                             TCGv_i64 {aka struct TCGv_i64_d *}
/home/hsp/src/qemu-master/target/ppc/translate.c:2398:63: note: expected
=E2=80=98TCGv_i32=E2=80=99 {aka =E2=80=98struct TCGv_i32_d *=E2=80=99} but =
argument is of type =E2=80=98TCGv_i64=E2=80=99
{aka =E2=80=98struct TCGv_i64_d *=E2=80=99}
 2398 | static inline void gen_addr_reg_index(DisasContext *ctx, TCGv EA)
In file included from /home/hsp/src/qemu-master/target/ppc/translate.c:6826=
:
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c:545:19:
error: passing argument 1 of =E2=80=98tcg_temp_free_i32=E2=80=99 from incom=
patible pointer
type [-Werror=3Dincompatible-pointer-types]
  545 |     tcg_temp_free(EA);
      |                   ^~
      |                   |
      |                   TCGv_i64 {aka struct TCGv_i64_d *}
In file included from /home/hsp/src/qemu-master/tcg/tcg-op.h:28,
                 from /home/hsp/src/qemu-master/target/ppc/translate.c:26:
/home/hsp/src/qemu-master/tcg/tcg.h:933:47: note: expected =E2=80=98TCGv_i3=
2=E2=80=99 {aka
=E2=80=98struct TCGv_i32_d *=E2=80=99} but argument is of type =E2=80=98TCG=
v_i64=E2=80=99 {aka =E2=80=98struct
TCGv_i64_d *=E2=80=99}
  933 | static inline void tcg_temp_free_i32(TCGv_i32 arg)
      |                                      ~~~~~~~~~^~~
In file included from /home/hsp/src/qemu-master/target/ppc/translate.c:26:
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c: In function
=E2=80=98trans_lvsr=E2=80=99:
/home/hsp/src/qemu-master/tcg/tcg-op.h:837:24: error: initialization of
=E2=80=98TCGv_i64=E2=80=99 {aka =E2=80=98struct TCGv_i64_d *=E2=80=99} from=
 incompatible pointer type
=E2=80=98TCGv_i32=E2=80=99 {aka =E2=80=98struct TCGv_i32_d *=E2=80=99} [-We=
rror=3Dincompatible-pointer-types]
  837 | #define tcg_temp_new() tcg_temp_new_i32()
      |                        ^~~~~~~~~~~~~~~~
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c:561:19: note:
in expansion of macro =E2=80=98tcg_temp_new=E2=80=99
  561 |     TCGv_i64 EA =3D tcg_temp_new();
      |                   ^~~~~~~~~~~~
In file included from /home/hsp/src/qemu-master/target/ppc/translate.c:6826=
:
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c:565:29:
error: passing argument 2 of =E2=80=98gen_addr_reg_index=E2=80=99 from inco=
mpatible pointer
type [-Werror=3Dincompatible-pointer-types]
  565 |     gen_addr_reg_index(ctx, EA);
      |                             ^~
      |                             |
      |                             TCGv_i64 {aka struct TCGv_i64_d *}
/home/hsp/src/qemu-master/target/ppc/translate.c:2398:63: note: expected
=E2=80=98TCGv_i32=E2=80=99 {aka =E2=80=98struct TCGv_i32_d *=E2=80=99} but =
argument is of type =E2=80=98TCGv_i64=E2=80=99
{aka =E2=80=98struct TCGv_i64_d *=E2=80=99}
 2398 | static inline void gen_addr_reg_index(DisasContext *ctx, TCGv EA)
In file included from /home/hsp/src/qemu-master/target/ppc/translate.c:6826=
:
/home/hsp/src/qemu-master/target/ppc/translate/vmx-impl.inc.c:596:19:
error: passing argument 1 of =E2=80=98tcg_temp_free_i32=E2=80=99 from incom=
patible pointer
type [-Werror=3Dincompatible-pointer-types]
  596 |     tcg_temp_free(EA);
      |                   ^~
      |                   |
      |                   TCGv_i64 {aka struct TCGv_i64_d *}
In file included from /home/hsp/src/qemu-master/tcg/tcg-op.h:28,
                 from /home/hsp/src/qemu-master/target/ppc/translate.c:26:
/home/hsp/src/qemu-master/tcg/tcg.h:933:47: note: expected =E2=80=98TCGv_i3=
2=E2=80=99 {aka
=E2=80=98struct TCGv_i32_d *=E2=80=99} but argument is of type =E2=80=98TCG=
v_i64=E2=80=99 {aka =E2=80=98struct
TCGv_i64_d *=E2=80=99}
  933 | static inline void tcg_temp_free_i32(TCGv_i32 arg)
      |                                      ~~~~~~~~~^~~


Best,
Howard
