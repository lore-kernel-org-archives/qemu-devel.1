Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58991C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659FE20EDD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC5/ErZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659FE20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJzFT-0008NV-Ad
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 09:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJz9s-0004KE-0D
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:13:36 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kJz9i-0001ml-Q3
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 09:13:35 -0400
Received: by mail-lj1-x243.google.com with SMTP id u4so8832910ljd.10
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=iPFJ5H1yzDM0tHv3gazt7TismFHgAa2Xr2/xnfZeE7k=;
 b=UC5/ErZDscOAsTSNkKhdda92mrEWZoBt1G9/fcFd6bpoGWgImL34v0Pv7j3VoYUgaX
 HQ3o7CxOjv0Ag0Bs68dAt7cG+B/vVfksmUiIdRtMDlrI/wQyrEMrDtyzxy4btDjnjhuG
 Q61M/Kv3WVIryKugVVaJLBPvBcXesSPeFPPUG0/LTFBMUHjA6VwfrOgpH/nsFBYVLWb2
 jy2ww5M7yqaqlW6QzVuxjlnfnYRRwU0w7yZYOhntEkaGnkLwEA042y6FpJdYMtEzxJM5
 9nDXGZS2/lYtAyr+0R71ExncJLT1HNag5/PV6DfjdUtL33RS/Qb4ADOXUuaekOVr2a59
 SFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=iPFJ5H1yzDM0tHv3gazt7TismFHgAa2Xr2/xnfZeE7k=;
 b=oWs3rJ0DEZvl8GdHljWSJ249qMHQcVaxKjwXHQs69CU441tsEJ6BQngYvtsmGI/xrd
 eh/lX4RRseK1xwQnaUHwUgcVSayVQGBzXJ+TfQKuoKnBYJpNM+e3fFwRK0XrjPESbW6r
 N8kJDMn6zuYGLv92sQoq01dGRGSSMi3rsVSf7xvRA3Sfk7E8ZyVQu9OiB/p8kM14oUGv
 535/zMi+zggFIXxJRuZhhgpOoxrhKrn2CTf5ZckkPt8zdNmjPQ9n0egjRp4PAvCiPmfW
 R+ogDnV52YfG4AdlWntnH+doCzL7InU77BWrSkUMTrpVkVifnkjiIhodhNJ6T4NfThmo
 cKCw==
X-Gm-Message-State: AOAM533dgM1eF9j2zf5NbnJlMyndmdqBrXuE3GA15tZA6wbXIq/dJ6e8
 gWGHQjo6e+q0x5NgHgGuNCp1H9AsrwEnl6sS00c=
X-Google-Smtp-Source: ABdhPJwhCdl2YCSlVPt3S6p1Ou2E9xMcEw1jg2TpME2/Rq7azjFCG9iE7C7uxQ/X8j1ldjNJsvlF24XfdgNsblkE0+w=
X-Received: by 2002:a05:651c:151:: with SMTP id
 c17mr15669588ljd.467.1600607604175; 
 Sun, 20 Sep 2020 06:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200920130708.1156310-1-pbonzini@redhat.com>
 <20200920130708.1156310-8-pbonzini@redhat.com>
In-Reply-To: <20200920130708.1156310-8-pbonzini@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 20 Sep 2020 21:13:12 +0800
Message-ID: <CAE2XoE8=igq7emJNFkPJ61TdnU1eigT6GFJPb5WHywtKQzZWSQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] configure: remove target configuration
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000abf8d405afbe7f2c"
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: luoyonggang@gmail.com
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000abf8d405afbe7f2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can these be generated from meson directly?
as makefile finally need to be removed

On Sun, Sep 20, 2020 at 9:09 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The config-target.mak files are small constant, we can therefore just
> write them down explicitly.
>
> This removes about 10% of the configure script, including the
> whole logic to detect which accelerators are supported by each
> target.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                                     | 407 +-----------------
>  .../targets/aarch64-linux-user.mak            |   5 +
>  default-configs/targets/aarch64-softmmu.mak   |   5 +
>  .../targets/aarch64_be-linux-user.mak         |   6 +
>  default-configs/targets/alpha-linux-user.mak  |   6 +
>  default-configs/targets/alpha-softmmu.mak     |   7 +
>  default-configs/targets/arm-linux-user.mak    |   7 +
>  default-configs/targets/arm-softmmu.mak       |   7 +
>  default-configs/targets/armeb-linux-user.mak  |   8 +
>  default-configs/targets/avr-softmmu.mak       |   4 +
>  default-configs/targets/cris-linux-user.mak   |   3 +
>  default-configs/targets/cris-softmmu.mak      |   3 +
>  default-configs/targets/hppa-linux-user.mak   |   7 +
>  default-configs/targets/hppa-softmmu.mak      |   8 +
>  default-configs/targets/i386-bsd-user.mak     |   6 +
>  default-configs/targets/i386-linux-user.mak   |   6 +
>  default-configs/targets/i386-softmmu.mak      |   7 +
>  default-configs/targets/lm32-softmmu.mak      |   4 +
>  default-configs/targets/m68k-linux-user.mak   |   8 +
>  default-configs/targets/m68k-softmmu.mak      |   7 +
>  .../targets/microblaze-linux-user.mak         |   7 +
>  .../targets/microblaze-softmmu.mak            |   7 +
>  .../targets/microblazeel-linux-user.mak       |   6 +
>  .../targets/microblazeel-softmmu.mak          |   6 +
>  default-configs/targets/mips-linux-user.mak   |   8 +
>  default-configs/targets/mips-softmmu.mak      |   9 +
>  default-configs/targets/mips64-linux-user.mak |   8 +
>  default-configs/targets/mips64-softmmu.mak    |   8 +
>  .../targets/mips64el-linux-user.mak           |   7 +
>  default-configs/targets/mips64el-softmmu.mak  |   7 +
>  default-configs/targets/mipsel-linux-user.mak |   7 +
>  default-configs/targets/mipsel-softmmu.mak    |   8 +
>  .../targets/mipsn32-linux-user.mak            |   9 +
>  .../targets/mipsn32el-linux-user.mak          |   8 +
>  default-configs/targets/moxie-softmmu.mak     |   4 +
>  default-configs/targets/nios2-linux-user.mak  |   3 +
>  default-configs/targets/nios2-softmmu.mak     |   3 +
>  default-configs/targets/or1k-linux-user.mak   |   4 +
>  default-configs/targets/or1k-softmmu.mak      |   4 +
>  default-configs/targets/ppc-linux-user.mak    |   7 +
>  default-configs/targets/ppc-softmmu.mak       |   7 +
>  default-configs/targets/ppc64-linux-user.mak  |   7 +
>  default-configs/targets/ppc64-softmmu.mak     |   8 +
>  .../targets/ppc64abi32-linux-user.mak         |   8 +
>  .../targets/ppc64le-linux-user.mak            |   6 +
>  .../targets/riscv32-linux-user.mak            |   4 +
>  default-configs/targets/riscv32-softmmu.mak   |   5 +
>  .../targets/riscv64-linux-user.mak            |   4 +
>  default-configs/targets/riscv64-softmmu.mak   |   5 +
>  default-configs/targets/rx-softmmu.mak        |   4 +
>  default-configs/targets/s390x-linux-user.mak  |   7 +
>  default-configs/targets/s390x-softmmu.mak     |   8 +
>  default-configs/targets/sh4-linux-user.mak    |   7 +
>  default-configs/targets/sh4-softmmu.mak       |   6 +
>  default-configs/targets/sh4eb-linux-user.mak  |   8 +
>  default-configs/targets/sh4eb-softmmu.mak     |   7 +
>  default-configs/targets/sparc-bsd-user.mak    |   7 +
>  default-configs/targets/sparc-linux-user.mak  |   7 +
>  default-configs/targets/sparc-softmmu.mak     |   7 +
>  .../targets/sparc32plus-linux-user.mak        |   8 +
>  default-configs/targets/sparc64-bsd-user.mak  |   7 +
>  .../targets/sparc64-linux-user.mak            |   7 +
>  default-configs/targets/sparc64-softmmu.mak   |   7 +
>  default-configs/targets/tilegx-linux-user.mak |   3 +
>  default-configs/targets/tricore-softmmu.mak   |   3 +
>  default-configs/targets/unicore32-softmmu.mak |   3 +
>  default-configs/targets/x86_64-bsd-user.mak   |   6 +
>  default-configs/targets/x86_64-linux-user.mak |   6 +
>  default-configs/targets/x86_64-softmmu.mak    |   7 +
>  default-configs/targets/xtensa-linux-user.mak |   7 +
>  default-configs/targets/xtensa-softmmu.mak    |   7 +
>  .../targets/xtensaeb-linux-user.mak           |   8 +
>  default-configs/targets/xtensaeb-softmmu.mak  |   8 +
>  meson.build                                   |  27 +-
>  74 files changed, 482 insertions(+), 405 deletions(-)
>  create mode 100644 default-configs/targets/aarch64-linux-user.mak
>  create mode 100644 default-configs/targets/aarch64-softmmu.mak
>  create mode 100644 default-configs/targets/aarch64_be-linux-user.mak
>  create mode 100644 default-configs/targets/alpha-linux-user.mak
>  create mode 100644 default-configs/targets/alpha-softmmu.mak
>  create mode 100644 default-configs/targets/arm-linux-user.mak
>  create mode 100644 default-configs/targets/arm-softmmu.mak
>  create mode 100644 default-configs/targets/armeb-linux-user.mak
>  create mode 100644 default-configs/targets/avr-softmmu.mak
>  create mode 100644 default-configs/targets/cris-linux-user.mak
>  create mode 100644 default-configs/targets/cris-softmmu.mak
>  create mode 100644 default-configs/targets/hppa-linux-user.mak
>  create mode 100644 default-configs/targets/hppa-softmmu.mak
>  create mode 100644 default-configs/targets/i386-bsd-user.mak
>  create mode 100644 default-configs/targets/i386-linux-user.mak
>  create mode 100644 default-configs/targets/i386-softmmu.mak
>  create mode 100644 default-configs/targets/lm32-softmmu.mak
>  create mode 100644 default-configs/targets/m68k-linux-user.mak
>  create mode 100644 default-configs/targets/m68k-softmmu.mak
>  create mode 100644 default-configs/targets/microblaze-linux-user.mak
>  create mode 100644 default-configs/targets/microblaze-softmmu.mak
>  create mode 100644 default-configs/targets/microblazeel-linux-user.mak
>  create mode 100644 default-configs/targets/microblazeel-softmmu.mak
>  create mode 100644 default-configs/targets/mips-linux-user.mak
>  create mode 100644 default-configs/targets/mips-softmmu.mak
>  create mode 100644 default-configs/targets/mips64-linux-user.mak
>  create mode 100644 default-configs/targets/mips64-softmmu.mak
>  create mode 100644 default-configs/targets/mips64el-linux-user.mak
>  create mode 100644 default-configs/targets/mips64el-softmmu.mak
>  create mode 100644 default-configs/targets/mipsel-linux-user.mak
>  create mode 100644 default-configs/targets/mipsel-softmmu.mak
>  create mode 100644 default-configs/targets/mipsn32-linux-user.mak
>  create mode 100644 default-configs/targets/mipsn32el-linux-user.mak
>  create mode 100644 default-configs/targets/moxie-softmmu.mak
>  create mode 100644 default-configs/targets/nios2-linux-user.mak
>  create mode 100644 default-configs/targets/nios2-softmmu.mak
>  create mode 100644 default-configs/targets/or1k-linux-user.mak
>  create mode 100644 default-configs/targets/or1k-softmmu.mak
>  create mode 100644 default-configs/targets/ppc-linux-user.mak
>  create mode 100644 default-configs/targets/ppc-softmmu.mak
>  create mode 100644 default-configs/targets/ppc64-linux-user.mak
>  create mode 100644 default-configs/targets/ppc64-softmmu.mak
>  create mode 100644 default-configs/targets/ppc64abi32-linux-user.mak
>  create mode 100644 default-configs/targets/ppc64le-linux-user.mak
>  create mode 100644 default-configs/targets/riscv32-linux-user.mak
>  create mode 100644 default-configs/targets/riscv32-softmmu.mak
>  create mode 100644 default-configs/targets/riscv64-linux-user.mak
>  create mode 100644 default-configs/targets/riscv64-softmmu.mak
>  create mode 100644 default-configs/targets/rx-softmmu.mak
>  create mode 100644 default-configs/targets/s390x-linux-user.mak
>  create mode 100644 default-configs/targets/s390x-softmmu.mak
>  create mode 100644 default-configs/targets/sh4-linux-user.mak
>  create mode 100644 default-configs/targets/sh4-softmmu.mak
>  create mode 100644 default-configs/targets/sh4eb-linux-user.mak
>  create mode 100644 default-configs/targets/sh4eb-softmmu.mak
>  create mode 100644 default-configs/targets/sparc-bsd-user.mak
>  create mode 100644 default-configs/targets/sparc-linux-user.mak
>  create mode 100644 default-configs/targets/sparc-softmmu.mak
>  create mode 100644 default-configs/targets/sparc32plus-linux-user.mak
>  create mode 100644 default-configs/targets/sparc64-bsd-user.mak
>  create mode 100644 default-configs/targets/sparc64-linux-user.mak
>  create mode 100644 default-configs/targets/sparc64-softmmu.mak
>  create mode 100644 default-configs/targets/tilegx-linux-user.mak
>  create mode 100644 default-configs/targets/tricore-softmmu.mak
>  create mode 100644 default-configs/targets/unicore32-softmmu.mak
>  create mode 100644 default-configs/targets/x86_64-bsd-user.mak
>  create mode 100644 default-configs/targets/x86_64-linux-user.mak
>  create mode 100644 default-configs/targets/x86_64-softmmu.mak
>  create mode 100644 default-configs/targets/xtensa-linux-user.mak
>  create mode 100644 default-configs/targets/xtensa-softmmu.mak
>  create mode 100644 default-configs/targets/xtensaeb-linux-user.mak
>  create mode 100644 default-configs/targets/xtensaeb-softmmu.mak
>
> diff --git a/configure b/configure
> index e64327e0f8..f6275d95fc 100755
> --- a/configure
> +++ b/configure
> @@ -220,99 +220,6 @@ glob() {
>      eval test -z '"${1#'"$2"'}"'
>  }
>
> -supported_hax_target() {
> -    test "$hax" =3D "enabled" || return 1
> -    glob "$1" "*-softmmu" || return 1
> -    case "${1%-softmmu}" in
> -        i386|x86_64)
> -            return 0
> -        ;;
> -    esac
> -    return 1
> -}
> -
> -supported_kvm_target() {
> -    test "$kvm" =3D "enabled" || return 1
> -    glob "$1" "*-softmmu" || return 1
> -    case "${1%-softmmu}:$cpu" in
> -        aarch64:aarch64 | \
> -        i386:i386 | i386:x86_64 | i386:x32 | \
> -        x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
> -        mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
> -        ppc:ppc | ppc64:ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | =
\
> -        s390x:s390x)
> -            return 0
> -        ;;
> -    esac
> -    return 1
> -}
> -
> -supported_xen_target() {
> -    test "$xen" =3D "enabled" || return 1
> -    glob "$1" "*-softmmu" || return 1
> -    # Only i386 and x86_64 provide the xenpv machine.
> -    case "${1%-softmmu}" in
> -        i386|x86_64)
> -            return 0
> -        ;;
> -    esac
> -    return 1
> -}
> -
> -supported_hvf_target() {
> -    test "$hvf" =3D "enabled" || return 1
> -    glob "$1" "*-softmmu" || return 1
> -    case "${1%-softmmu}" in
> -        x86_64)
> -            return 0
> -        ;;
> -    esac
> -    return 1
> -}
> -
> -supported_whpx_target() {
> -    test "$whpx" =3D "enabled" || return 1
> -    glob "$1" "*-softmmu" || return 1
> -    case "${1%-softmmu}" in
> -        i386|x86_64)
> -            return 0
> -        ;;
> -    esac
> -    return 1
> -}
> -
> -supported_target() {
> -    case "$1" in
> -        *-softmmu)
> -            ;;
> -        *-linux-user)
> -            if test "$linux" !=3D "yes"; then
> -                print_error "Target '$target' is only available on a
Linux host"
> -                return 1
> -            fi
> -            ;;
> -        *-bsd-user)
> -            if test "$bsd" !=3D "yes"; then
> -                print_error "Target '$target' is only available on a BSD
host"
> -                return 1
> -            fi
> -            ;;
> -        *)
> -            print_error "Invalid target name '$target'"
> -            return 1
> -            ;;
> -    esac
> -    test "$tcg" =3D "enabled" && return 0
> -    supported_kvm_target "$1" && return 0
> -    supported_xen_target "$1" && return 0
> -    supported_hax_target "$1" && return 0
> -    supported_hvf_target "$1" && return 0
> -    supported_whpx_target "$1" && return 0
> -    print_error "TCG disabled, but hardware accelerator not available
for '$target'"
> -    return 1
> -}
> -
> -
>  ld_has() {
>      $ld --help 2>/dev/null | grep ".$1" >/dev/null 2>&1
>  }
> @@ -2292,12 +2199,13 @@ if test "$solaris" =3D "yes" ; then
>  fi
>
>  if test -z "${target_list+xxx}" ; then
> +    default_targets=3Dyes
>      for target in $default_target_list; do
> -        supported_target $target 2>/dev/null && \
> -            target_list=3D"$target_list $target"
> +        target_list=3D"$target_list $target"
>      done
>      target_list=3D"${target_list# }"
>  else
> +    default_targets=3Dno
>      target_list=3D$(echo "$target_list" | sed -e 's/,/ /g')
>      for target in $target_list; do
>          # Check that we recognised the target name; this allows a more
> @@ -2309,7 +2217,6 @@ else
>                  error_exit "Unknown target name '$target'"
>                  ;;
>          esac
> -        supported_target $target || exit 1
>      done
>  fi
>
> @@ -2653,27 +2560,6 @@ if test "$seccomp" !=3D "no" ; then
>      fi
>  fi
>
> -##########################################
> -# simple accelerator probes
> -
> -if test "$kvm" =3D "auto" ; then
> -  if test "$linux" =3D yes ; then
> -    kvm=3Denabled
> -  else
> -    if test "$kvm" =3D "enabled" ; then
> -      feature_not_found "kvm" "KVM is only available on Linux"
> -    fi
> -  fi
> -fi
> -
> -if test "$hax" =3D "auto" ; then
> -  if test "$mingw" =3D yes || test "$darwin" =3D yes || test "$targetos"=
 =3D
NetBSD; then
> -    hax=3Denabled
> -  else
> -    hax=3Ddisabled
> -  fi
> -fi
> -
>  ##########################################
>  # xen probe
>
> @@ -2992,22 +2878,6 @@ if test "$xen_pci_passthrough" !=3D "disabled"; th=
en
>    fi
>  fi
>
> -##########################################
> -# Windows Hypervisor Platform accelerator (WHPX) check
> -if test "$whpx" =3D "enabled" && test "$ARCH" !=3D "x86_64"; then
> -  error_exit "WHPX requires 64-bit host"
> -fi
> -if test "$whpx" !=3D "disabled" && test "$ARCH" =3D "x86_64"; then
> -    if check_include "WinHvPlatform.h" && check_include
"WinHvEmulation.h"; then
> -        whpx=3D"yes"
> -    else
> -        if test "$whpx" =3D "auto"; then
> -            feature_not_found "WinHvPlatform" "WinHvEmulation is not
installed"
> -        fi
> -        whpx=3D"disabled"
> -    fi
> -fi
> -
>  ##########################################
>  # gettext probe
>  if test "$gettext" !=3D "false" ; then
> @@ -7375,281 +7245,13 @@ fi
>
>  for target in $target_list; do
>  target_dir=3D"$target"
> -config_target_mak=3D$target_dir/config-target.mak
>  target_name=3D$(echo $target | cut -d '-' -f 1)
> -target_aligned_only=3D"no"
> -case "$target_name" in
> -
 alpha|hppa|mips64el|mips64|mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|s=
parc64|sparc32plus|xtensa|xtensaeb)
> -  target_aligned_only=3D"yes"
> -  ;;
> -esac
> -target_bigendian=3D"no"
> -case "$target_name" in
> -
 armeb|aarch64_be|hppa|lm32|m68k|microblaze|mips|mipsn32|mips64|moxie|or1k|=
ppc|ppc64|ppc64abi32|s390x|sh4eb|sparc|sparc64|sparc32plus|xtensaeb)
> -  target_bigendian=3D"yes"
> -  ;;
> -esac
> -target_softmmu=3D"no"
> -target_user_only=3D"no"
> -target_linux_user=3D"no"
> -target_bsd_user=3D"no"
> -case "$target" in
> -  ${target_name}-softmmu)
> -    target_softmmu=3D"yes"
> -    ;;
> -  ${target_name}-linux-user)
> -    target_user_only=3D"yes"
> -    target_linux_user=3D"yes"
> -    ;;
> -  ${target_name}-bsd-user)
> -    target_user_only=3D"yes"
> -    target_bsd_user=3D"yes"
> -    ;;
> -  *)
> -    error_exit "Target '$target' not recognised"
> -    exit 1
> -    ;;
> -esac
> -
>  mkdir -p $target_dir
> -echo "# Automatically generated by configure - do not modify" >
$config_target_mak
> -
> -bflt=3D"no"
> -mttcg=3D"no"
> -interp_prefix1=3D$(echo "$interp_prefix" | sed "s/%M/$target_name/g")
> -gdb_xml_files=3D""
> -
> -TARGET_ARCH=3D"$target_name"
> -TARGET_BASE_ARCH=3D""
> -TARGET_ABI_DIR=3D""
> -TARGET_SYSTBL_ABI=3D""
> -TARGET_SYSTBL=3D""
> -
> -case "$target_name" in
> -  i386)
> -    mttcg=3D"yes"
> -    gdb_xml_files=3D"i386-32bit.xml"
> -    TARGET_SYSTBL_ABI=3Di386
> -    TARGET_SYSTBL=3Dsyscall_32.tbl
> -  ;;
> -  x86_64)
> -    TARGET_BASE_ARCH=3Di386
> -    TARGET_SYSTBL_ABI=3Dcommon,64
> -    TARGET_SYSTBL=3Dsyscall_64.tbl
> -    mttcg=3D"yes"
> -    gdb_xml_files=3D"i386-64bit.xml"
> -  ;;
> -  alpha)
> -    mttcg=3D"yes"
> -    TARGET_SYSTBL_ABI=3Dcommon
> -  ;;
> -  arm|armeb)
> -    TARGET_ARCH=3Darm
> -    TARGET_SYSTBL_ABI=3Dcommon,oabi
> -    bflt=3D"yes"
> -    mttcg=3D"yes"
> -    gdb_xml_files=3D"arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml
arm-m-profile.xml"
> -  ;;
> -  aarch64|aarch64_be)
> -    TARGET_ARCH=3Daarch64
> -    TARGET_BASE_ARCH=3Darm
> -    bflt=3D"yes"
> -    mttcg=3D"yes"
> -    gdb_xml_files=3D"aarch64-core.xml aarch64-fpu.xml arm-core.xml
arm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml"
> -  ;;
> -  avr)
> -    gdb_xml_files=3D"avr-cpu.xml"
> -    target_compiler=3D$cross_cc_avr
> -  ;;
> -  cris)
> -  ;;
> -  hppa)
> -    mttcg=3D"yes"
> -    TARGET_SYSTBL_ABI=3Dcommon,32
> -  ;;
> -  lm32)
> -  ;;
> -  m68k)
> -    bflt=3D"yes"
> -    gdb_xml_files=3D"cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
> -    TARGET_SYSTBL_ABI=3Dcommon
> -  ;;
> -  microblaze|microblazeel)
> -    TARGET_ARCH=3Dmicroblaze
> -    TARGET_SYSTBL_ABI=3Dcommon
> -    mttcg=3D"yes"
> -    bflt=3D"yes"
> -  ;;
> -  mips|mipsel)
> -    mttcg=3D"yes"
> -    TARGET_ARCH=3Dmips
> -    echo "TARGET_ABI_MIPSO32=3Dy" >> $config_target_mak
> -    TARGET_SYSTBL_ABI=3Do32
> -    TARGET_SYSTBL=3Dsyscall_o32.tbl
> -  ;;
> -  mipsn32|mipsn32el)
> -    mttcg=3D"yes"
> -    TARGET_ARCH=3Dmips64
> -    TARGET_BASE_ARCH=3Dmips
> -    echo "TARGET_ABI_MIPSN32=3Dy" >> $config_target_mak
> -    echo "TARGET_ABI32=3Dy" >> $config_target_mak
> -    TARGET_SYSTBL_ABI=3Dn32
> -    TARGET_SYSTBL=3Dsyscall_n32.tbl
> -  ;;
> -  mips64|mips64el)
> -    mttcg=3D"no"
> -    TARGET_ARCH=3Dmips64
> -    TARGET_BASE_ARCH=3Dmips
> -    echo "TARGET_ABI_MIPSN64=3Dy" >> $config_target_mak
> -    TARGET_SYSTBL_ABI=3Dn64
> -    TARGET_SYSTBL=3Dsyscall_n64.tbl
> -  ;;
> -  moxie)
> -  ;;
> -  nios2)
> -  ;;
> -  or1k)
> -    TARGET_ARCH=3Dopenrisc
> -    TARGET_BASE_ARCH=3Dopenrisc
> -  ;;
> -  ppc)
> -    gdb_xml_files=3D"power-core.xml power-fpu.xml power-altivec.xml
power-spe.xml"
> -    TARGET_SYSTBL_ABI=3Dcommon,nospu,32
> -  ;;
> -  ppc64)
> -    TARGET_BASE_ARCH=3Dppc
> -    TARGET_ABI_DIR=3Dppc
> -    TARGET_SYSTBL_ABI=3Dcommon,nospu,64
> -    mttcg=3Dyes
> -    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml
power-spe.xml power-vsx.xml"
> -  ;;
> -  ppc64le)
> -    TARGET_ARCH=3Dppc64
> -    TARGET_BASE_ARCH=3Dppc
> -    TARGET_ABI_DIR=3Dppc
> -    TARGET_SYSTBL_ABI=3Dcommon,nospu,64
> -    mttcg=3Dyes
> -    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml
power-spe.xml power-vsx.xml"
> -  ;;
> -  ppc64abi32)
> -    TARGET_ARCH=3Dppc64
> -    TARGET_BASE_ARCH=3Dppc
> -    TARGET_ABI_DIR=3Dppc
> -    TARGET_SYSTBL_ABI=3Dcommon,nospu,32
> -    echo "TARGET_ABI32=3Dy" >> $config_target_mak
> -    gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml
power-spe.xml power-vsx.xml"
> -    deprecated_features=3D"ppc64abi32 ${deprecated_features}"
> -  ;;
> -  riscv32)
> -    TARGET_BASE_ARCH=3Driscv
> -    TARGET_ABI_DIR=3Driscv
> -    mttcg=3Dyes
> -    gdb_xml_files=3D"riscv-32bit-cpu.xml riscv-32bit-fpu.xml
riscv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml"
> -  ;;
> -  riscv64)
> -    TARGET_BASE_ARCH=3Driscv
> -    TARGET_ABI_DIR=3Driscv
> -    mttcg=3Dyes
> -    gdb_xml_files=3D"riscv-64bit-cpu.xml riscv-32bit-fpu.xml
riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
> -  ;;
> -  rx)
> -    TARGET_ARCH=3Drx
> -    bflt=3D"yes"
> -    target_compiler=3D$cross_cc_rx
> -    gdb_xml_files=3D"rx-core.xml"
> -  ;;
> -  sh4|sh4eb)
> -    TARGET_ARCH=3Dsh4
> -    TARGET_SYSTBL_ABI=3Dcommon
> -    bflt=3D"yes"
> -  ;;
> -  sparc)
> -    TARGET_SYSTBL_ABI=3Dcommon,32
> -  ;;
> -  sparc64)
> -    TARGET_BASE_ARCH=3Dsparc
> -    TARGET_SYSTBL_ABI=3Dcommon,64
> -  ;;
> -  sparc32plus)
> -    TARGET_ARCH=3Dsparc64
> -    TARGET_BASE_ARCH=3Dsparc
> -    TARGET_ABI_DIR=3Dsparc
> -    TARGET_SYSTBL_ABI=3Dcommon,32
> -    echo "TARGET_ABI32=3Dy" >> $config_target_mak
> -  ;;
> -  s390x)
> -    TARGET_SYSTBL_ABI=3Dcommon,64
> -    mttcg=3Dyes
> -    gdb_xml_files=3D"s390x-core64.xml s390-acr.xml s390-fpr.xml
s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
> -  ;;
> -  tilegx)
> -  ;;
> -  tricore)
> -  ;;
> -  unicore32)
> -  ;;
> -  xtensa|xtensaeb)
> -    TARGET_ARCH=3Dxtensa
> -    TARGET_SYSTBL_ABI=3Dcommon
> -    bflt=3D"yes"
> -    mttcg=3D"yes"
> -  ;;
> -  *)
> -    error_exit "Unsupported target CPU"
> -  ;;
> -esac
> -# TARGET_BASE_ARCH needs to be defined after TARGET_ARCH
> -if [ "$TARGET_BASE_ARCH" =3D "" ]; then
> -  TARGET_BASE_ARCH=3D$TARGET_ARCH
> -fi
> -if [ "$TARGET_SYSTBL_ABI" !=3D "" ] && [ "$TARGET_SYSTBL" =3D "" ]; then
> -  TARGET_SYSTBL=3Dsyscall.tbl
> -fi
> -
> -upper() {
> -    echo "$@"| LC_ALL=3DC tr '[a-z]' '[A-Z]'
> -}
> -
> -target_arch_name=3D"$(upper $TARGET_ARCH)"
> -echo "TARGET_$target_arch_name=3Dy" >> $config_target_mak
> -echo "TARGET_BASE_ARCH=3D$TARGET_BASE_ARCH" >> $config_target_mak
> -if [ "$TARGET_ABI_DIR" =3D "" ]; then
> -  TARGET_ABI_DIR=3D$TARGET_ARCH
> -fi
> -echo "TARGET_ABI_DIR=3D$TARGET_ABI_DIR" >> $config_target_mak
> -if [ "$TARGET_SYSTBL_ABI" !=3D "" ]; then
> -    echo "TARGET_SYSTBL_ABI=3D$TARGET_SYSTBL_ABI" >> $config_target_mak
> -    echo "TARGET_SYSTBL=3D$TARGET_SYSTBL" >> $config_target_mak
> -fi
> -
> -if test "$target_aligned_only" =3D "yes" ; then
> -  echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
> -fi
> -if test "$target_bigendian" =3D "yes" ; then
> -  echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
> -fi
> -if test "$target_softmmu" =3D "yes" ; then
> -  if test "$mttcg" =3D "yes" ; then
> -    echo "TARGET_SUPPORTS_MTTCG=3Dy" >> $config_target_mak
> -  fi
> -fi
>  if test "$target_user_only" =3D "yes" ; then
>    symlink "../qemu-$target_name" "$target_dir/qemu-$target_name"
>  else
>    symlink "../qemu-system-$target_name"
"$target_dir/qemu-system-$target_name"
>  fi
> -list=3D""
> -if test ! -z "$gdb_xml_files" ; then
> -  for x in $gdb_xml_files; do
> -    list=3D"$list gdb-xml/$x"
> -  done
> -  echo "TARGET_XML_FILES=3D$list" >> $config_target_mak
> -fi
> -
> -if test "$target_user_only" =3D "yes" && test "$bflt" =3D "yes"; then
> -  echo "TARGET_HAS_BFLT=3Dy" >> $config_target_mak
> -fi
> -
>  done # for target in $targets
>
>  if [ "$fdt" =3D "git" ]; then
> @@ -7659,6 +7261,9 @@ if [ "$capstone" =3D "git" -o "$capstone" =3D
"internal" ]; then
>    subdirs=3D"$subdirs capstone"
>  fi
>  echo "CONFIG_QEMU_INTERP_PREFIX=3D$interp_prefix" | sed 's/%M/@0@/' >>
$config_host_mak
> +if test "$default_targets" =3D "yes"; then
> +  echo "CONFIG_DEFAULT_TARGETS=3Dy" >> $config_host_mak
> +fi
>  echo "SUBDIRS=3D$subdirs" >> $config_host_mak
>  if test -n "$LIBCAPSTONE"; then
>    echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
> diff --git a/default-configs/targets/aarch64-linux-user.mak
b/default-configs/targets/aarch64-linux-user.mak
> new file mode 100644
> index 0000000000..4495e86509
> --- /dev/null
> +++ b/default-configs/targets/aarch64-linux-user.mak
> @@ -0,0 +1,5 @@
> +TARGET_AARCH64=3Dy
> +TARGET_BASE_ARCH=3Darm
> +TARGET_ABI_DIR=3Daarch64
> +TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml
gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/aarch64-softmmu.mak
b/default-configs/targets/aarch64-softmmu.mak
> new file mode 100644
> index 0000000000..53f83ea81f
> --- /dev/null
> +++ b/default-configs/targets/aarch64-softmmu.mak
> @@ -0,0 +1,5 @@
> +TARGET_AARCH64=3Dy
> +TARGET_BASE_ARCH=3Darm
> +TARGET_ABI_DIR=3Daarch64
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml
gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
> diff --git a/default-configs/targets/aarch64_be-linux-user.mak
b/default-configs/targets/aarch64_be-linux-user.mak
> new file mode 100644
> index 0000000000..da13693d3d
> --- /dev/null
> +++ b/default-configs/targets/aarch64_be-linux-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_AARCH64=3Dy
> +TARGET_BASE_ARCH=3Darm
> +TARGET_ABI_DIR=3Daarch64
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml
gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/alpha-linux-user.mak
b/default-configs/targets/alpha-linux-user.mak
> new file mode 100644
> index 0000000000..5ff89f5d48
> --- /dev/null
> +++ b/default-configs/targets/alpha-linux-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_ALPHA=3Dy
> +TARGET_BASE_ARCH=3Dalpha
> +TARGET_ABI_DIR=3Dalpha
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> diff --git a/default-configs/targets/alpha-softmmu.mak
b/default-configs/targets/alpha-softmmu.mak
> new file mode 100644
> index 0000000000..b78114b028
> --- /dev/null
> +++ b/default-configs/targets/alpha-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_ALPHA=3Dy
> +TARGET_BASE_ARCH=3Dalpha
> +TARGET_ABI_DIR=3Dalpha
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/arm-linux-user.mak
b/default-configs/targets/arm-linux-user.mak
> new file mode 100644
> index 0000000000..7c54c3c2a2
> --- /dev/null
> +++ b/default-configs/targets/arm-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_ARM=3Dy
> +TARGET_BASE_ARCH=3Darm
> +TARGET_ABI_DIR=3Darm
> +TARGET_SYSTBL_ABI=3Dcommon,oabi
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml
gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/arm-softmmu.mak
b/default-configs/targets/arm-softmmu.mak
> new file mode 100644
> index 0000000000..d40b995f25
> --- /dev/null
> +++ b/default-configs/targets/arm-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_ARM=3Dy
> +TARGET_BASE_ARCH=3Darm
> +TARGET_ABI_DIR=3Darm
> +TARGET_SYSTBL_ABI=3Dcommon,oabi
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml
gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
> diff --git a/default-configs/targets/armeb-linux-user.mak
b/default-configs/targets/armeb-linux-user.mak
> new file mode 100644
> index 0000000000..1882aa472d
> --- /dev/null
> +++ b/default-configs/targets/armeb-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_ARM=3Dy
> +TARGET_BASE_ARCH=3Darm
> +TARGET_ABI_DIR=3Darm
> +TARGET_SYSTBL_ABI=3Dcommon,oabi
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml
gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/avr-softmmu.mak
b/default-configs/targets/avr-softmmu.mak
> new file mode 100644
> index 0000000000..ecd292b2f7
> --- /dev/null
> +++ b/default-configs/targets/avr-softmmu.mak
> @@ -0,0 +1,4 @@
> +TARGET_AVR=3Dy
> +TARGET_BASE_ARCH=3Davr
> +TARGET_ABI_DIR=3Davr
> +TARGET_XML_FILES=3D gdb-xml/avr-cpu.xml
> diff --git a/default-configs/targets/cris-linux-user.mak
b/default-configs/targets/cris-linux-user.mak
> new file mode 100644
> index 0000000000..ba61135172
> --- /dev/null
> +++ b/default-configs/targets/cris-linux-user.mak
> @@ -0,0 +1,3 @@
> +TARGET_CRIS=3Dy
> +TARGET_BASE_ARCH=3Dcris
> +TARGET_ABI_DIR=3Dcris
> diff --git a/default-configs/targets/cris-softmmu.mak
b/default-configs/targets/cris-softmmu.mak
> new file mode 100644
> index 0000000000..ba61135172
> --- /dev/null
> +++ b/default-configs/targets/cris-softmmu.mak
> @@ -0,0 +1,3 @@
> +TARGET_CRIS=3Dy
> +TARGET_BASE_ARCH=3Dcris
> +TARGET_ABI_DIR=3Dcris
> diff --git a/default-configs/targets/hppa-linux-user.mak
b/default-configs/targets/hppa-linux-user.mak
> new file mode 100644
> index 0000000000..94222e8fc6
> --- /dev/null
> +++ b/default-configs/targets/hppa-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_HPPA=3Dy
> +TARGET_BASE_ARCH=3Dhppa
> +TARGET_ABI_DIR=3Dhppa
> +TARGET_SYSTBL_ABI=3Dcommon,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/hppa-softmmu.mak
b/default-configs/targets/hppa-softmmu.mak
> new file mode 100644
> index 0000000000..617c6483c0
> --- /dev/null
> +++ b/default-configs/targets/hppa-softmmu.mak
> @@ -0,0 +1,8 @@
> +TARGET_HPPA=3Dy
> +TARGET_BASE_ARCH=3Dhppa
> +TARGET_ABI_DIR=3Dhppa
> +TARGET_SYSTBL_ABI=3Dcommon,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/i386-bsd-user.mak
b/default-configs/targets/i386-bsd-user.mak
> new file mode 100644
> index 0000000000..34b52e9ee2
> --- /dev/null
> +++ b/default-configs/targets/i386-bsd-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_I386=3Dy
> +TARGET_BASE_ARCH=3Di386
> +TARGET_ABI_DIR=3Di386
> +TARGET_SYSTBL_ABI=3Di386
> +TARGET_SYSTBL=3Dsyscall_32.tbl
> +TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml
> diff --git a/default-configs/targets/i386-linux-user.mak
b/default-configs/targets/i386-linux-user.mak
> new file mode 100644
> index 0000000000..34b52e9ee2
> --- /dev/null
> +++ b/default-configs/targets/i386-linux-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_I386=3Dy
> +TARGET_BASE_ARCH=3Di386
> +TARGET_ABI_DIR=3Di386
> +TARGET_SYSTBL_ABI=3Di386
> +TARGET_SYSTBL=3Dsyscall_32.tbl
> +TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml
> diff --git a/default-configs/targets/i386-softmmu.mak
b/default-configs/targets/i386-softmmu.mak
> new file mode 100644
> index 0000000000..be9198bb84
> --- /dev/null
> +++ b/default-configs/targets/i386-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_I386=3Dy
> +TARGET_BASE_ARCH=3Di386
> +TARGET_ABI_DIR=3Di386
> +TARGET_SYSTBL_ABI=3Di386
> +TARGET_SYSTBL=3Dsyscall_32.tbl
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml
> diff --git a/default-configs/targets/lm32-softmmu.mak
b/default-configs/targets/lm32-softmmu.mak
> new file mode 100644
> index 0000000000..c327d27d5f
> --- /dev/null
> +++ b/default-configs/targets/lm32-softmmu.mak
> @@ -0,0 +1,4 @@
> +TARGET_LM32=3Dy
> +TARGET_BASE_ARCH=3Dlm32
> +TARGET_ABI_DIR=3Dlm32
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/m68k-linux-user.mak
b/default-configs/targets/m68k-linux-user.mak
> new file mode 100644
> index 0000000000..e7c0af5881
> --- /dev/null
> +++ b/default-configs/targets/m68k-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_M68K=3Dy
> +TARGET_BASE_ARCH=3Dm68k
> +TARGET_ABI_DIR=3Dm68k
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/cf-core.xml gdb-xml/cf-fp.xml
gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/m68k-softmmu.mak
b/default-configs/targets/m68k-softmmu.mak
> new file mode 100644
> index 0000000000..f8bf4fc5ac
> --- /dev/null
> +++ b/default-configs/targets/m68k-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_M68K=3Dy
> +TARGET_BASE_ARCH=3Dm68k
> +TARGET_ABI_DIR=3Dm68k
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/cf-core.xml gdb-xml/cf-fp.xml
gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
> diff --git a/default-configs/targets/microblaze-linux-user.mak
b/default-configs/targets/microblaze-linux-user.mak
> new file mode 100644
> index 0000000000..809819424d
> --- /dev/null
> +++ b/default-configs/targets/microblaze-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_MICROBLAZE=3Dy
> +TARGET_BASE_ARCH=3Dmicroblaze
> +TARGET_ABI_DIR=3Dmicroblaze
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/microblaze-softmmu.mak
b/default-configs/targets/microblaze-softmmu.mak
> new file mode 100644
> index 0000000000..1b0a76a61f
> --- /dev/null
> +++ b/default-configs/targets/microblaze-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_MICROBLAZE=3Dy
> +TARGET_BASE_ARCH=3Dmicroblaze
> +TARGET_ABI_DIR=3Dmicroblaze
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/microblazeel-linux-user.mak
b/default-configs/targets/microblazeel-linux-user.mak
> new file mode 100644
> index 0000000000..416b42eeb6
> --- /dev/null
> +++ b/default-configs/targets/microblazeel-linux-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_MICROBLAZE=3Dy
> +TARGET_BASE_ARCH=3Dmicroblaze
> +TARGET_ABI_DIR=3Dmicroblaze
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/microblazeel-softmmu.mak
b/default-configs/targets/microblazeel-softmmu.mak
> new file mode 100644
> index 0000000000..3a2cf8be0f
> --- /dev/null
> +++ b/default-configs/targets/microblazeel-softmmu.mak
> @@ -0,0 +1,6 @@
> +TARGET_MICROBLAZE=3Dy
> +TARGET_BASE_ARCH=3Dmicroblaze
> +TARGET_ABI_DIR=3Dmicroblaze
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/mips-linux-user.mak
b/default-configs/targets/mips-linux-user.mak
> new file mode 100644
> index 0000000000..bcfff16a7b
> --- /dev/null
> +++ b/default-configs/targets/mips-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI_MIPSO32=3Dy
> +TARGET_MIPS=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips
> +TARGET_SYSTBL_ABI=3Do32
> +TARGET_SYSTBL=3Dsyscall_o32.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/mips-softmmu.mak
b/default-configs/targets/mips-softmmu.mak
> new file mode 100644
> index 0000000000..8ab9ff2ac9
> --- /dev/null
> +++ b/default-configs/targets/mips-softmmu.mak
> @@ -0,0 +1,9 @@
> +TARGET_ABI_MIPSO32=3Dy
> +TARGET_MIPS=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips
> +TARGET_SYSTBL_ABI=3Do32
> +TARGET_SYSTBL=3Dsyscall_o32.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/mips64-linux-user.mak
b/default-configs/targets/mips64-linux-user.mak
> new file mode 100644
> index 0000000000..c02c5460a7
> --- /dev/null
> +++ b/default-configs/targets/mips64-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI_MIPSN64=3Dy
> +TARGET_MIPS64=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips64
> +TARGET_SYSTBL_ABI=3Dn64
> +TARGET_SYSTBL=3Dsyscall_n64.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/mips64-softmmu.mak
b/default-configs/targets/mips64-softmmu.mak
> new file mode 100644
> index 0000000000..c02c5460a7
> --- /dev/null
> +++ b/default-configs/targets/mips64-softmmu.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI_MIPSN64=3Dy
> +TARGET_MIPS64=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips64
> +TARGET_SYSTBL_ABI=3Dn64
> +TARGET_SYSTBL=3Dsyscall_n64.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/mips64el-linux-user.mak
b/default-configs/targets/mips64el-linux-user.mak
> new file mode 100644
> index 0000000000..8cbbc38e78
> --- /dev/null
> +++ b/default-configs/targets/mips64el-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_ABI_MIPSN64=3Dy
> +TARGET_MIPS64=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips64
> +TARGET_SYSTBL_ABI=3Dn64
> +TARGET_SYSTBL=3Dsyscall_n64.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> diff --git a/default-configs/targets/mips64el-softmmu.mak
b/default-configs/targets/mips64el-softmmu.mak
> new file mode 100644
> index 0000000000..8cbbc38e78
> --- /dev/null
> +++ b/default-configs/targets/mips64el-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_ABI_MIPSN64=3Dy
> +TARGET_MIPS64=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips64
> +TARGET_SYSTBL_ABI=3Dn64
> +TARGET_SYSTBL=3Dsyscall_n64.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> diff --git a/default-configs/targets/mipsel-linux-user.mak
b/default-configs/targets/mipsel-linux-user.mak
> new file mode 100644
> index 0000000000..26aa9c8279
> --- /dev/null
> +++ b/default-configs/targets/mipsel-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_ABI_MIPSO32=3Dy
> +TARGET_MIPS=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips
> +TARGET_SYSTBL_ABI=3Do32
> +TARGET_SYSTBL=3Dsyscall_o32.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> diff --git a/default-configs/targets/mipsel-softmmu.mak
b/default-configs/targets/mipsel-softmmu.mak
> new file mode 100644
> index 0000000000..afa0851887
> --- /dev/null
> +++ b/default-configs/targets/mipsel-softmmu.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI_MIPSO32=3Dy
> +TARGET_MIPS=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips
> +TARGET_SYSTBL_ABI=3Do32
> +TARGET_SYSTBL=3Dsyscall_o32.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/mipsn32-linux-user.mak
b/default-configs/targets/mipsn32-linux-user.mak
> new file mode 100644
> index 0000000000..81d548e699
> --- /dev/null
> +++ b/default-configs/targets/mipsn32-linux-user.mak
> @@ -0,0 +1,9 @@
> +TARGET_ABI_MIPSN32=3Dy
> +TARGET_ABI32=3Dy
> +TARGET_MIPS64=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips64
> +TARGET_SYSTBL_ABI=3Dn32
> +TARGET_SYSTBL=3Dsyscall_n32.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/mipsn32el-linux-user.mak
b/default-configs/targets/mipsn32el-linux-user.mak
> new file mode 100644
> index 0000000000..6de47f2a79
> --- /dev/null
> +++ b/default-configs/targets/mipsn32el-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI_MIPSN32=3Dy
> +TARGET_ABI32=3Dy
> +TARGET_MIPS64=3Dy
> +TARGET_BASE_ARCH=3Dmips
> +TARGET_ABI_DIR=3Dmips64
> +TARGET_SYSTBL_ABI=3Dn32
> +TARGET_SYSTBL=3Dsyscall_n32.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> diff --git a/default-configs/targets/moxie-softmmu.mak
b/default-configs/targets/moxie-softmmu.mak
> new file mode 100644
> index 0000000000..da093f5b36
> --- /dev/null
> +++ b/default-configs/targets/moxie-softmmu.mak
> @@ -0,0 +1,4 @@
> +TARGET_MOXIE=3Dy
> +TARGET_BASE_ARCH=3Dmoxie
> +TARGET_ABI_DIR=3Dmoxie
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/nios2-linux-user.mak
b/default-configs/targets/nios2-linux-user.mak
> new file mode 100644
> index 0000000000..a2308a16aa
> --- /dev/null
> +++ b/default-configs/targets/nios2-linux-user.mak
> @@ -0,0 +1,3 @@
> +TARGET_NIOS2=3Dy
> +TARGET_BASE_ARCH=3Dnios2
> +TARGET_ABI_DIR=3Dnios2
> diff --git a/default-configs/targets/nios2-softmmu.mak
b/default-configs/targets/nios2-softmmu.mak
> new file mode 100644
> index 0000000000..a2308a16aa
> --- /dev/null
> +++ b/default-configs/targets/nios2-softmmu.mak
> @@ -0,0 +1,3 @@
> +TARGET_NIOS2=3Dy
> +TARGET_BASE_ARCH=3Dnios2
> +TARGET_ABI_DIR=3Dnios2
> diff --git a/default-configs/targets/or1k-linux-user.mak
b/default-configs/targets/or1k-linux-user.mak
> new file mode 100644
> index 0000000000..2f5ff844df
> --- /dev/null
> +++ b/default-configs/targets/or1k-linux-user.mak
> @@ -0,0 +1,4 @@
> +TARGET_OPENRISC=3Dy
> +TARGET_BASE_ARCH=3Dopenrisc
> +TARGET_ABI_DIR=3Dopenrisc
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/or1k-softmmu.mak
b/default-configs/targets/or1k-softmmu.mak
> new file mode 100644
> index 0000000000..2f5ff844df
> --- /dev/null
> +++ b/default-configs/targets/or1k-softmmu.mak
> @@ -0,0 +1,4 @@
> +TARGET_OPENRISC=3Dy
> +TARGET_BASE_ARCH=3Dopenrisc
> +TARGET_ABI_DIR=3Dopenrisc
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/ppc-linux-user.mak
b/default-configs/targets/ppc-linux-user.mak
> new file mode 100644
> index 0000000000..c4d912bfb1
> --- /dev/null
> +++ b/default-configs/targets/ppc-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_PPC=3Dy
> +TARGET_BASE_ARCH=3Dppc
> +TARGET_ABI_DIR=3Dppc
> +TARGET_SYSTBL_ABI=3Dcommon,nospu,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/power-core.xml gdb-xml/power-fpu.xml
gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
> diff --git a/default-configs/targets/ppc-softmmu.mak
b/default-configs/targets/ppc-softmmu.mak
> new file mode 100644
> index 0000000000..c4d912bfb1
> --- /dev/null
> +++ b/default-configs/targets/ppc-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_PPC=3Dy
> +TARGET_BASE_ARCH=3Dppc
> +TARGET_ABI_DIR=3Dppc
> +TARGET_SYSTBL_ABI=3Dcommon,nospu,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/power-core.xml gdb-xml/power-fpu.xml
gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
> diff --git a/default-configs/targets/ppc64-linux-user.mak
b/default-configs/targets/ppc64-linux-user.mak
> new file mode 100644
> index 0000000000..7f96ab7e9d
> --- /dev/null
> +++ b/default-configs/targets/ppc64-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_PPC64=3Dy
> +TARGET_BASE_ARCH=3Dppc
> +TARGET_ABI_DIR=3Dppc
> +TARGET_SYSTBL_ABI=3Dcommon,nospu,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml
gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> diff --git a/default-configs/targets/ppc64-softmmu.mak
b/default-configs/targets/ppc64-softmmu.mak
> new file mode 100644
> index 0000000000..a73211918a
> --- /dev/null
> +++ b/default-configs/targets/ppc64-softmmu.mak
> @@ -0,0 +1,8 @@
> +TARGET_PPC64=3Dy
> +TARGET_BASE_ARCH=3Dppc
> +TARGET_ABI_DIR=3Dppc
> +TARGET_SYSTBL_ABI=3Dcommon,nospu,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml
gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> diff --git a/default-configs/targets/ppc64abi32-linux-user.mak
b/default-configs/targets/ppc64abi32-linux-user.mak
> new file mode 100644
> index 0000000000..13a02700aa
> --- /dev/null
> +++ b/default-configs/targets/ppc64abi32-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI32=3Dy
> +TARGET_PPC64=3Dy
> +TARGET_BASE_ARCH=3Dppc
> +TARGET_ABI_DIR=3Dppc
> +TARGET_SYSTBL_ABI=3Dcommon,nospu,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml
gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> diff --git a/default-configs/targets/ppc64le-linux-user.mak
b/default-configs/targets/ppc64le-linux-user.mak
> new file mode 100644
> index 0000000000..3dd54b894c
> --- /dev/null
> +++ b/default-configs/targets/ppc64le-linux-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_PPC64=3Dy
> +TARGET_BASE_ARCH=3Dppc
> +TARGET_ABI_DIR=3Dppc
> +TARGET_SYSTBL_ABI=3Dcommon,nospu,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml
gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
> diff --git a/default-configs/targets/riscv32-linux-user.mak
b/default-configs/targets/riscv32-linux-user.mak
> new file mode 100644
> index 0000000000..91d72a46b0
> --- /dev/null
> +++ b/default-configs/targets/riscv32-linux-user.mak
> @@ -0,0 +1,4 @@
> +TARGET_RISCV32=3Dy
> +TARGET_BASE_ARCH=3Driscv
> +TARGET_ABI_DIR=3Driscv
> +TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml
gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml
gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
> diff --git a/default-configs/targets/riscv32-softmmu.mak
b/default-configs/targets/riscv32-softmmu.mak
> new file mode 100644
> index 0000000000..35e5b2fb85
> --- /dev/null
> +++ b/default-configs/targets/riscv32-softmmu.mak
> @@ -0,0 +1,5 @@
> +TARGET_RISCV32=3Dy
> +TARGET_BASE_ARCH=3Driscv
> +TARGET_ABI_DIR=3Driscv
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml
gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml
gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32bit-virtual.xml
> diff --git a/default-configs/targets/riscv64-linux-user.mak
b/default-configs/targets/riscv64-linux-user.mak
> new file mode 100644
> index 0000000000..9e53193cdb
> --- /dev/null
> +++ b/default-configs/targets/riscv64-linux-user.mak
> @@ -0,0 +1,4 @@
> +TARGET_RISCV64=3Dy
> +TARGET_BASE_ARCH=3Driscv
> +TARGET_ABI_DIR=3Driscv
> +TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml
gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml
gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
> diff --git a/default-configs/targets/riscv64-softmmu.mak
b/default-configs/targets/riscv64-softmmu.mak
> new file mode 100644
> index 0000000000..4b9a61cd8f
> --- /dev/null
> +++ b/default-configs/targets/riscv64-softmmu.mak
> @@ -0,0 +1,5 @@
> +TARGET_RISCV64=3Dy
> +TARGET_BASE_ARCH=3Driscv
> +TARGET_ABI_DIR=3Driscv
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml
gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml
gdb-xml/riscv-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml
> diff --git a/default-configs/targets/rx-softmmu.mak
b/default-configs/targets/rx-softmmu.mak
> new file mode 100644
> index 0000000000..52a8c0df10
> --- /dev/null
> +++ b/default-configs/targets/rx-softmmu.mak
> @@ -0,0 +1,4 @@
> +TARGET_RX=3Dy
> +TARGET_BASE_ARCH=3Drx
> +TARGET_ABI_DIR=3Drx
> +TARGET_XML_FILES=3D gdb-xml/rx-core.xml
> diff --git a/default-configs/targets/s390x-linux-user.mak
b/default-configs/targets/s390x-linux-user.mak
> new file mode 100644
> index 0000000000..77ebec769f
> --- /dev/null
> +++ b/default-configs/targets/s390x-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_S390X=3Dy
> +TARGET_BASE_ARCH=3Ds390x
> +TARGET_ABI_DIR=3Ds390x
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml
gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml
gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
> diff --git a/default-configs/targets/s390x-softmmu.mak
b/default-configs/targets/s390x-softmmu.mak
> new file mode 100644
> index 0000000000..f2a80d3208
> --- /dev/null
> +++ b/default-configs/targets/s390x-softmmu.mak
> @@ -0,0 +1,8 @@
> +TARGET_S390X=3Dy
> +TARGET_BASE_ARCH=3Ds390x
> +TARGET_ABI_DIR=3Ds390x
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml
gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml
gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml
> diff --git a/default-configs/targets/sh4-linux-user.mak
b/default-configs/targets/sh4-linux-user.mak
> new file mode 100644
> index 0000000000..4292dd6128
> --- /dev/null
> +++ b/default-configs/targets/sh4-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_SH4=3Dy
> +TARGET_BASE_ARCH=3Dsh4
> +TARGET_ABI_DIR=3Dsh4
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/sh4-softmmu.mak
b/default-configs/targets/sh4-softmmu.mak
> new file mode 100644
> index 0000000000..e46bf0e278
> --- /dev/null
> +++ b/default-configs/targets/sh4-softmmu.mak
> @@ -0,0 +1,6 @@
> +TARGET_SH4=3Dy
> +TARGET_BASE_ARCH=3Dsh4
> +TARGET_ABI_DIR=3Dsh4
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> diff --git a/default-configs/targets/sh4eb-linux-user.mak
b/default-configs/targets/sh4eb-linux-user.mak
> new file mode 100644
> index 0000000000..cf9178f4ea
> --- /dev/null
> +++ b/default-configs/targets/sh4eb-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_SH4=3Dy
> +TARGET_BASE_ARCH=3Dsh4
> +TARGET_ABI_DIR=3Dsh4
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/sh4eb-softmmu.mak
b/default-configs/targets/sh4eb-softmmu.mak
> new file mode 100644
> index 0000000000..db4140ec32
> --- /dev/null
> +++ b/default-configs/targets/sh4eb-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_SH4=3Dy
> +TARGET_BASE_ARCH=3Dsh4
> +TARGET_ABI_DIR=3Dsh4
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc-bsd-user.mak
b/default-configs/targets/sparc-bsd-user.mak
> new file mode 100644
> index 0000000000..7f2fcba978
> --- /dev/null
> +++ b/default-configs/targets/sparc-bsd-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_SPARC=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc
> +TARGET_SYSTBL_ABI=3Dcommon,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc-linux-user.mak
b/default-configs/targets/sparc-linux-user.mak
> new file mode 100644
> index 0000000000..7f2fcba978
> --- /dev/null
> +++ b/default-configs/targets/sparc-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_SPARC=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc
> +TARGET_SYSTBL_ABI=3Dcommon,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc-softmmu.mak
b/default-configs/targets/sparc-softmmu.mak
> new file mode 100644
> index 0000000000..7f2fcba978
> --- /dev/null
> +++ b/default-configs/targets/sparc-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_SPARC=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc
> +TARGET_SYSTBL_ABI=3Dcommon,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc32plus-linux-user.mak
b/default-configs/targets/sparc32plus-linux-user.mak
> new file mode 100644
> index 0000000000..f5fcb7879e
> --- /dev/null
> +++ b/default-configs/targets/sparc32plus-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_ABI32=3Dy
> +TARGET_SPARC64=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc
> +TARGET_SYSTBL_ABI=3Dcommon,32
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc64-bsd-user.mak
b/default-configs/targets/sparc64-bsd-user.mak
> new file mode 100644
> index 0000000000..817529e587
> --- /dev/null
> +++ b/default-configs/targets/sparc64-bsd-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_SPARC64=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc64
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc64-linux-user.mak
b/default-configs/targets/sparc64-linux-user.mak
> new file mode 100644
> index 0000000000..817529e587
> --- /dev/null
> +++ b/default-configs/targets/sparc64-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_SPARC64=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc64
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/sparc64-softmmu.mak
b/default-configs/targets/sparc64-softmmu.mak
> new file mode 100644
> index 0000000000..817529e587
> --- /dev/null
> +++ b/default-configs/targets/sparc64-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_SPARC64=3Dy
> +TARGET_BASE_ARCH=3Dsparc
> +TARGET_ABI_DIR=3Dsparc64
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> diff --git a/default-configs/targets/tilegx-linux-user.mak
b/default-configs/targets/tilegx-linux-user.mak
> new file mode 100644
> index 0000000000..064d3320d7
> --- /dev/null
> +++ b/default-configs/targets/tilegx-linux-user.mak
> @@ -0,0 +1,3 @@
> +TARGET_TILEGX=3Dy
> +TARGET_BASE_ARCH=3Dtilegx
> +TARGET_ABI_DIR=3Dtilegx
> diff --git a/default-configs/targets/tricore-softmmu.mak
b/default-configs/targets/tricore-softmmu.mak
> new file mode 100644
> index 0000000000..356e5d8669
> --- /dev/null
> +++ b/default-configs/targets/tricore-softmmu.mak
> @@ -0,0 +1,3 @@
> +TARGET_TRICORE=3Dy
> +TARGET_BASE_ARCH=3Dtricore
> +TARGET_ABI_DIR=3Dtricore
> diff --git a/default-configs/targets/unicore32-softmmu.mak
b/default-configs/targets/unicore32-softmmu.mak
> new file mode 100644
> index 0000000000..d8c7860ac1
> --- /dev/null
> +++ b/default-configs/targets/unicore32-softmmu.mak
> @@ -0,0 +1,3 @@
> +TARGET_UNICORE32=3Dy
> +TARGET_BASE_ARCH=3Dunicore32
> +TARGET_ABI_DIR=3Dunicore32
> diff --git a/default-configs/targets/x86_64-bsd-user.mak
b/default-configs/targets/x86_64-bsd-user.mak
> new file mode 100644
> index 0000000000..6a9418f9ff
> --- /dev/null
> +++ b/default-configs/targets/x86_64-bsd-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_X86_64=3Dy
> +TARGET_BASE_ARCH=3Di386
> +TARGET_ABI_DIR=3Dx86_64
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall_64.tbl
> +TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml
> diff --git a/default-configs/targets/x86_64-linux-user.mak
b/default-configs/targets/x86_64-linux-user.mak
> new file mode 100644
> index 0000000000..6a9418f9ff
> --- /dev/null
> +++ b/default-configs/targets/x86_64-linux-user.mak
> @@ -0,0 +1,6 @@
> +TARGET_X86_64=3Dy
> +TARGET_BASE_ARCH=3Di386
> +TARGET_ABI_DIR=3Dx86_64
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall_64.tbl
> +TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml
> diff --git a/default-configs/targets/x86_64-softmmu.mak
b/default-configs/targets/x86_64-softmmu.mak
> new file mode 100644
> index 0000000000..8b56e6e6da
> --- /dev/null
> +++ b/default-configs/targets/x86_64-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_X86_64=3Dy
> +TARGET_BASE_ARCH=3Di386
> +TARGET_ABI_DIR=3Dx86_64
> +TARGET_SYSTBL_ABI=3Dcommon,64
> +TARGET_SYSTBL=3Dsyscall_64.tbl
> +TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml
> diff --git a/default-configs/targets/xtensa-linux-user.mak
b/default-configs/targets/xtensa-linux-user.mak
> new file mode 100644
> index 0000000000..63d9cff69f
> --- /dev/null
> +++ b/default-configs/targets/xtensa-linux-user.mak
> @@ -0,0 +1,7 @@
> +TARGET_XTENSA=3Dy
> +TARGET_BASE_ARCH=3Dxtensa
> +TARGET_ABI_DIR=3Dxtensa
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/xtensa-softmmu.mak
b/default-configs/targets/xtensa-softmmu.mak
> new file mode 100644
> index 0000000000..2166f97738
> --- /dev/null
> +++ b/default-configs/targets/xtensa-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_XTENSA=3Dy
> +TARGET_BASE_ARCH=3Dxtensa
> +TARGET_ABI_DIR=3Dxtensa
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/default-configs/targets/xtensaeb-linux-user.mak
b/default-configs/targets/xtensaeb-linux-user.mak
> new file mode 100644
> index 0000000000..e66b7dd0e3
> --- /dev/null
> +++ b/default-configs/targets/xtensaeb-linux-user.mak
> @@ -0,0 +1,8 @@
> +TARGET_XTENSA=3Dy
> +TARGET_BASE_ARCH=3Dxtensa
> +TARGET_ABI_DIR=3Dxtensa
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_HAS_BFLT=3Dy
> diff --git a/default-configs/targets/xtensaeb-softmmu.mak
b/default-configs/targets/xtensaeb-softmmu.mak
> new file mode 100644
> index 0000000000..2372d22492
> --- /dev/null
> +++ b/default-configs/targets/xtensaeb-softmmu.mak
> @@ -0,0 +1,8 @@
> +TARGET_XTENSA=3Dy
> +TARGET_BASE_ARCH=3Dxtensa
> +TARGET_ABI_DIR=3Dxtensa
> +TARGET_SYSTBL_ABI=3Dcommon
> +TARGET_SYSTBL=3Dsyscall.tbl
> +TARGET_ALIGNED_ONLY=3Dy
> +TARGET_WORDS_BIGENDIAN=3Dy
> +TARGET_SUPPORTS_MTTCG=3Dy
> diff --git a/meson.build b/meson.build
> index 6863b9febf..5ddaf16b88 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -722,13 +722,25 @@ kconfig_external_symbols =3D [
>  ]
>  ignored =3D ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
>
> +default_targets =3D 'CONFIG_DEFAULT_TARGETS' in config_host
> +actual_target_dirs =3D []
>  foreach target : target_dirs
>    config_target =3D { 'TARGET_NAME': target.split('-')[0] }
>    if target.endswith('linux-user')
> -    assert(targetos =3D=3D 'linux')
> +    if targetos !=3D 'linux'
> +      if default_targets
> +        continue
> +      endif
> +      error('Target @0@ is only available on a Linux
host'.format(target))
> +    endif
>      config_target +=3D { 'CONFIG_LINUX_USER': 'y' }
>    elif target.endswith('bsd-user')
> -    assert('CONFIG_BSD' in config_host)
> +    if not 'CONFIG_BSD' in config_host
> +      if default_targets
> +        continue
> +      endif
> +      error('Target @0@ is only available on a BSD host'.format(target))
> +    endif
>      config_target +=3D { 'CONFIG_BSD_USER': 'y' }
>    elif target.endswith('softmmu')
>      config_target +=3D { 'CONFIG_SOFTMMU': 'y' }
> @@ -752,8 +764,14 @@ foreach target : target_dirs
>      endif
>      have_accel =3D true
>    endforeach
> -  assert(have_accel)
> +  if not have_accel
> +    if default_targets
> +      continue
> +    endif
> +    error('No accelerator available for target @0@'.format(target))
> +  endif
>
> +  actual_target_dirs +=3D target
>    config_target +=3D keyval.load('default-configs/targets' / target +
'.mak')
>
>    foreach k, v: disassemblers
> @@ -815,6 +833,7 @@ foreach target : target_dirs
>    endif
>    config_target_mak +=3D {target: config_target}
>  endforeach
> +target_dirs =3D actual_target_dirs
>
>  # This configuration is used to build files that are shared by
>  # multiple binaries, and then extracted out of the "common"
> @@ -1600,7 +1619,7 @@ if config_host.has_key('CONFIG_MODULES')
>  endif
>  summary_info +=3D {'host CPU':          cpu}
>  summary_info +=3D {'host endianness':   build_machine.endian()}
> -summary_info +=3D {'target list':       config_host['TARGET_DIRS']}
> +summary_info +=3D {'target list':       ' '.join(target_dirs)}
>  summary_info +=3D {'gprof enabled':
config_host.has_key('CONFIG_GPROF')}
>  summary_info +=3D {'sparse enabled':
 meson.get_compiler('c').cmd_array().contains('cgcc')}
>  summary_info +=3D {'strip binaries':    get_option('strip')}
> --
> 2.26.2
>
>
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000abf8d405afbe7f2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Can these be generated from meson directly?<div>as makefil=
e finally need to be removed<br><br>On Sun, Sep 20, 2020 at 9:09 PM Paolo B=
onzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&g=
t; wrote:<br>&gt;<br>&gt; The config-target.mak files are small constant, w=
e can therefore just<br>&gt; write them down explicitly.<br>&gt;<br>&gt; Th=
is removes about 10% of the configure script, including the<br>&gt; whole l=
ogic to detect which accelerators are supported by each<br>&gt; target.<br>=
&gt;<br>&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@re=
dhat.com">pbonzini@redhat.com</a>&gt;<br>&gt; ---<br>&gt; =C2=A0configure =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 407 +---------------=
--<br>&gt; =C2=A0.../targets/aarch64-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 5 +<br>&gt; =C2=A0default-configs/targets/aarc=
h64-softmmu.mak =C2=A0 | =C2=A0 5 +<br>&gt; =C2=A0.../targets/aarch64_be-li=
nux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 6 +<br>&gt; =C2=A0default=
-configs/targets/alpha-linux-user.mak =C2=A0| =C2=A0 6 +<br>&gt; =C2=A0defa=
ult-configs/targets/alpha-softmmu.mak =C2=A0 =C2=A0 | =C2=A0 7 +<br>&gt; =
=C2=A0default-configs/targets/arm-linux-user.mak =C2=A0 =C2=A0| =C2=A0 7 +<=
br>&gt; =C2=A0default-configs/targets/arm-softmmu.mak =C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/armeb-linux-user.mak =C2=
=A0| =C2=A0 8 +<br>&gt; =C2=A0default-configs/targets/avr-softmmu.mak =C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 4 +<br>&gt; =C2=A0default-configs/targets/cris-l=
inux-user.mak =C2=A0 | =C2=A0 3 +<br>&gt; =C2=A0default-configs/targets/cri=
s-softmmu.mak =C2=A0 =C2=A0 =C2=A0| =C2=A0 3 +<br>&gt; =C2=A0default-config=
s/targets/hppa-linux-user.mak =C2=A0 | =C2=A0 7 +<br>&gt; =C2=A0default-con=
figs/targets/hppa-softmmu.mak =C2=A0 =C2=A0 =C2=A0| =C2=A0 8 +<br>&gt; =C2=
=A0default-configs/targets/i386-bsd-user.mak =C2=A0 =C2=A0 | =C2=A0 6 +<br>=
&gt; =C2=A0default-configs/targets/i386-linux-user.mak =C2=A0 | =C2=A0 6 +<=
br>&gt; =C2=A0default-configs/targets/i386-softmmu.mak =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/lm32-softmmu.mak =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 4 +<br>&gt; =C2=A0default-configs/targets/m68k-linux-=
user.mak =C2=A0 | =C2=A0 8 +<br>&gt; =C2=A0default-configs/targets/m68k-sof=
tmmu.mak =C2=A0 =C2=A0 =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0.../targets/microbl=
aze-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 7 +<br>&gt; =C2=A0.=
../targets/microblaze-softmmu.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 7 +<br>&gt; =C2=A0.../targets/microblazeel-linux-user.mak =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 6 +<br>&gt; =C2=A0.../targets/microblazeel-softmmu.m=
ak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 6 +<br>&gt; =C2=A0default-con=
figs/targets/mips-linux-user.mak =C2=A0 | =C2=A0 8 +<br>&gt; =C2=A0default-=
configs/targets/mips-softmmu.mak =C2=A0 =C2=A0 =C2=A0| =C2=A0 9 +<br>&gt; =
=C2=A0default-configs/targets/mips64-linux-user.mak | =C2=A0 8 +<br>&gt; =
=C2=A0default-configs/targets/mips64-softmmu.mak =C2=A0 =C2=A0| =C2=A0 8 +<=
br>&gt; =C2=A0.../targets/mips64el-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/mips64el-soft=
mmu.mak =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/mipsel-lin=
ux-user.mak | =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/mipsel-softm=
mu.mak =C2=A0 =C2=A0| =C2=A0 8 +<br>&gt; =C2=A0.../targets/mipsn32-linux-us=
er.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 9 +<br>&gt; =C2=A0=
.../targets/mipsn32el-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
=C2=A0 8 +<br>&gt; =C2=A0default-configs/targets/moxie-softmmu.mak =C2=A0 =
=C2=A0 | =C2=A0 4 +<br>&gt; =C2=A0default-configs/targets/nios2-linux-user.=
mak =C2=A0| =C2=A0 3 +<br>&gt; =C2=A0default-configs/targets/nios2-softmmu.=
mak =C2=A0 =C2=A0 | =C2=A0 3 +<br>&gt; =C2=A0default-configs/targets/or1k-l=
inux-user.mak =C2=A0 | =C2=A0 4 +<br>&gt; =C2=A0default-configs/targets/or1=
k-softmmu.mak =C2=A0 =C2=A0 =C2=A0| =C2=A0 4 +<br>&gt; =C2=A0default-config=
s/targets/ppc-linux-user.mak =C2=A0 =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0defaul=
t-configs/targets/ppc-softmmu.mak =C2=A0 =C2=A0 =C2=A0 | =C2=A0 7 +<br>&gt;=
 =C2=A0default-configs/targets/ppc64-linux-user.mak =C2=A0| =C2=A0 7 +<br>&=
gt; =C2=A0default-configs/targets/ppc64-softmmu.mak =C2=A0 =C2=A0 | =C2=A0 =
8 +<br>&gt; =C2=A0.../targets/ppc64abi32-linux-user.mak =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 8 +<br>&gt; =C2=A0.../targets/ppc64le-linux-user.mak =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 6 +<br>&gt; =C2=A0.../tar=
gets/riscv32-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 4 +<br>&gt; =C2=A0default-configs/targets/riscv32-softmmu.mak =C2=A0 | =
=C2=A0 5 +<br>&gt; =C2=A0.../targets/riscv64-linux-user.mak =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 4 +<br>&gt; =C2=A0default-configs/targe=
ts/riscv64-softmmu.mak =C2=A0 | =C2=A0 5 +<br>&gt; =C2=A0default-configs/ta=
rgets/rx-softmmu.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 4 +<br>&gt; =C2=A0=
default-configs/targets/s390x-linux-user.mak =C2=A0| =C2=A0 7 +<br>&gt; =C2=
=A0default-configs/targets/s390x-softmmu.mak =C2=A0 =C2=A0 | =C2=A0 8 +<br>=
&gt; =C2=A0default-configs/targets/sh4-linux-user.mak =C2=A0 =C2=A0| =C2=A0=
 7 +<br>&gt; =C2=A0default-configs/targets/sh4-softmmu.mak =C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 6 +<br>&gt; =C2=A0default-configs/targets/sh4eb-linux-user.=
mak =C2=A0| =C2=A0 8 +<br>&gt; =C2=A0default-configs/targets/sh4eb-softmmu.=
mak =C2=A0 =C2=A0 | =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/sparc-=
bsd-user.mak =C2=A0 =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0default-configs/target=
s/sparc-linux-user.mak =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0default-configs/tar=
gets/sparc-softmmu.mak =C2=A0 =C2=A0 | =C2=A0 7 +<br>&gt; =C2=A0.../targets=
/sparc32plus-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 8 +<br>&gt;=
 =C2=A0default-configs/targets/sparc64-bsd-user.mak =C2=A0| =C2=A0 7 +<br>&=
gt; =C2=A0.../targets/sparc64-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/sparc64-sof=
tmmu.mak =C2=A0 | =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/tilegx-l=
inux-user.mak | =C2=A0 3 +<br>&gt; =C2=A0default-configs/targets/tricore-so=
ftmmu.mak =C2=A0 | =C2=A0 3 +<br>&gt; =C2=A0default-configs/targets/unicore=
32-softmmu.mak | =C2=A0 3 +<br>&gt; =C2=A0default-configs/targets/x86_64-bs=
d-user.mak =C2=A0 | =C2=A0 6 +<br>&gt; =C2=A0default-configs/targets/x86_64=
-linux-user.mak | =C2=A0 6 +<br>&gt; =C2=A0default-configs/targets/x86_64-s=
oftmmu.mak =C2=A0 =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/=
xtensa-linux-user.mak | =C2=A0 7 +<br>&gt; =C2=A0default-configs/targets/xt=
ensa-softmmu.mak =C2=A0 =C2=A0| =C2=A0 7 +<br>&gt; =C2=A0.../targets/xtensa=
eb-linux-user.mak =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 8 +<br>&gt; =
=C2=A0default-configs/targets/xtensaeb-softmmu.mak =C2=A0| =C2=A0 8 +<br>&g=
t; =C2=A0meson.build =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
27 +-<br>&gt; =C2=A074 files changed, 482 insertions(+), 405 deletions(-)<b=
r>&gt; =C2=A0create mode 100644 default-configs/targets/aarch64-linux-user.=
mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/aarch64-softmm=
u.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/aarch64_be-l=
inux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/alph=
a-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/a=
lpha-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/a=
rm-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/=
arm-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/ar=
meb-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets=
/avr-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/c=
ris-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets=
/cris-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/=
hppa-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/target=
s/hppa-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets=
/i386-bsd-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets=
/i386-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targe=
ts/i386-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/target=
s/lm32-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets=
/m68k-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targe=
ts/m68k-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/target=
s/microblaze-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-config=
s/targets/microblaze-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-c=
onfigs/targets/microblazeel-linux-user.mak<br>&gt; =C2=A0create mode 100644=
 default-configs/targets/microblazeel-softmmu.mak<br>&gt; =C2=A0create mode=
 100644 default-configs/targets/mips-linux-user.mak<br>&gt; =C2=A0create mo=
de 100644 default-configs/targets/mips-softmmu.mak<br>&gt; =C2=A0create mod=
e 100644 default-configs/targets/mips64-linux-user.mak<br>&gt; =C2=A0create=
 mode 100644 default-configs/targets/mips64-softmmu.mak<br>&gt; =C2=A0creat=
e mode 100644 default-configs/targets/mips64el-linux-user.mak<br>&gt; =C2=
=A0create mode 100644 default-configs/targets/mips64el-softmmu.mak<br>&gt; =
=C2=A0create mode 100644 default-configs/targets/mipsel-linux-user.mak<br>&=
gt; =C2=A0create mode 100644 default-configs/targets/mipsel-softmmu.mak<br>=
&gt; =C2=A0create mode 100644 default-configs/targets/mipsn32-linux-user.ma=
k<br>&gt; =C2=A0create mode 100644 default-configs/targets/mipsn32el-linux-=
user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/moxie-sof=
tmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/nios2-lin=
ux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/nios2-=
softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/or1k-l=
inux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/or1k=
-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/ppc-l=
inux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/ppc-=
softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/ppc64-=
linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/ppc=
64-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/ppc=
64abi32-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/tar=
gets/ppc64le-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-config=
s/targets/riscv32-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-c=
onfigs/targets/riscv32-softmmu.mak<br>&gt; =C2=A0create mode 100644 default=
-configs/targets/riscv64-linux-user.mak<br>&gt; =C2=A0create mode 100644 de=
fault-configs/targets/riscv64-softmmu.mak<br>&gt; =C2=A0create mode 100644 =
default-configs/targets/rx-softmmu.mak<br>&gt; =C2=A0create mode 100644 def=
ault-configs/targets/s390x-linux-user.mak<br>&gt; =C2=A0create mode 100644 =
default-configs/targets/s390x-softmmu.mak<br>&gt; =C2=A0create mode 100644 =
default-configs/targets/sh4-linux-user.mak<br>&gt; =C2=A0create mode 100644=
 default-configs/targets/sh4-softmmu.mak<br>&gt; =C2=A0create mode 100644 d=
efault-configs/targets/sh4eb-linux-user.mak<br>&gt; =C2=A0create mode 10064=
4 default-configs/targets/sh4eb-softmmu.mak<br>&gt; =C2=A0create mode 10064=
4 default-configs/targets/sparc-bsd-user.mak<br>&gt; =C2=A0create mode 1006=
44 default-configs/targets/sparc-linux-user.mak<br>&gt; =C2=A0create mode 1=
00644 default-configs/targets/sparc-softmmu.mak<br>&gt; =C2=A0create mode 1=
00644 default-configs/targets/sparc32plus-linux-user.mak<br>&gt; =C2=A0crea=
te mode 100644 default-configs/targets/sparc64-bsd-user.mak<br>&gt; =C2=A0c=
reate mode 100644 default-configs/targets/sparc64-linux-user.mak<br>&gt; =
=C2=A0create mode 100644 default-configs/targets/sparc64-softmmu.mak<br>&gt=
; =C2=A0create mode 100644 default-configs/targets/tilegx-linux-user.mak<br=
>&gt; =C2=A0create mode 100644 default-configs/targets/tricore-softmmu.mak<=
br>&gt; =C2=A0create mode 100644 default-configs/targets/unicore32-softmmu.=
mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/x86_64-bsd-use=
r.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/x86_64-linux=
-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/x86_64-s=
oftmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/xtensa-=
linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/xte=
nsa-softmmu.mak<br>&gt; =C2=A0create mode 100644 default-configs/targets/xt=
ensaeb-linux-user.mak<br>&gt; =C2=A0create mode 100644 default-configs/targ=
ets/xtensaeb-softmmu.mak<br>&gt;<br>&gt; diff --git a/configure b/configure=
<br>&gt; index e64327e0f8..f6275d95fc 100755<br>&gt; --- a/configure<br>&gt=
; +++ b/configure<br>&gt; @@ -220,99 +220,6 @@ glob() {<br>&gt; =C2=A0 =C2=
=A0 =C2=A0eval test -z &#39;&quot;${1#&#39;&quot;$2&quot;&#39;}&quot;&#39;<=
br>&gt; =C2=A0}<br>&gt;<br>&gt; -supported_hax_target() {<br>&gt; - =C2=A0 =
=C2=A0test &quot;$hax&quot; =3D &quot;enabled&quot; || return 1<br>&gt; - =
=C2=A0 =C2=A0glob &quot;$1&quot; &quot;*-softmmu&quot; || return 1<br>&gt; =
- =C2=A0 =C2=A0case &quot;${1%-softmmu}&quot; in<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0i386|x86_64)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; - =C2=A0 =C2=A0=
esac<br>&gt; - =C2=A0 =C2=A0return 1<br>&gt; -}<br>&gt; -<br>&gt; -supporte=
d_kvm_target() {<br>&gt; - =C2=A0 =C2=A0test &quot;$kvm&quot; =3D &quot;ena=
bled&quot; || return 1<br>&gt; - =C2=A0 =C2=A0glob &quot;$1&quot; &quot;*-s=
oftmmu&quot; || return 1<br>&gt; - =C2=A0 =C2=A0case &quot;${1%-softmmu}:$c=
pu&quot; in<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0aarch64:aarch64 | \<br>&gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0i386:i386 | i386:x86_64 | i386:x32 | \<br>&g=
t; - =C2=A0 =C2=A0 =C2=A0 =C2=A0x86_64:i386 | x86_64:x86_64 | x86_64:x32 | =
\<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0mips:mips | mipsel:mips | mips64:mip=
s | mips64el:mips | \<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0ppc:ppc | ppc64:=
ppc | ppc:ppc64 | ppc64:ppc64 | ppc64:ppc64le | \<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0s390x:s390x)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return 0<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; - =C2=A0 =C2=A0=
esac<br>&gt; - =C2=A0 =C2=A0return 1<br>&gt; -}<br>&gt; -<br>&gt; -supporte=
d_xen_target() {<br>&gt; - =C2=A0 =C2=A0test &quot;$xen&quot; =3D &quot;ena=
bled&quot; || return 1<br>&gt; - =C2=A0 =C2=A0glob &quot;$1&quot; &quot;*-s=
oftmmu&quot; || return 1<br>&gt; - =C2=A0 =C2=A0# Only i386 and x86_64 prov=
ide the xenpv machine.<br>&gt; - =C2=A0 =C2=A0case &quot;${1%-softmmu}&quot=
; in<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0i386|x86_64)<br>&gt; - =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0;;<br>&gt; - =C2=A0 =C2=A0esac<br>&gt; - =C2=A0 =C2=A0return 1<br>&gt; -=
}<br>&gt; -<br>&gt; -supported_hvf_target() {<br>&gt; - =C2=A0 =C2=A0test &=
quot;$hvf&quot; =3D &quot;enabled&quot; || return 1<br>&gt; - =C2=A0 =C2=A0=
glob &quot;$1&quot; &quot;*-softmmu&quot; || return 1<br>&gt; - =C2=A0 =C2=
=A0case &quot;${1%-softmmu}&quot; in<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0x=
86_64)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>&gt; =
- =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; - =C2=A0 =C2=A0esac<br>&gt; - =C2=
=A0 =C2=A0return 1<br>&gt; -}<br>&gt; -<br>&gt; -supported_whpx_target() {<=
br>&gt; - =C2=A0 =C2=A0test &quot;$whpx&quot; =3D &quot;enabled&quot; || re=
turn 1<br>&gt; - =C2=A0 =C2=A0glob &quot;$1&quot; &quot;*-softmmu&quot; || =
return 1<br>&gt; - =C2=A0 =C2=A0case &quot;${1%-softmmu}&quot; in<br>&gt; -=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0i386|x86_64)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return 0<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; -=
 =C2=A0 =C2=A0esac<br>&gt; - =C2=A0 =C2=A0return 1<br>&gt; -}<br>&gt; -<br>=
&gt; -supported_target() {<br>&gt; - =C2=A0 =C2=A0case &quot;$1&quot; in<br=
>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0*-softmmu)<br>&gt; - =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0*-linux-use=
r)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;$linux&=
quot; !=3D &quot;yes&quot;; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0print_error &quot;Target &#39;$target&#39; is only =
available on a Linux host&quot;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; =
- =C2=A0 =C2=A0 =C2=A0 =C2=A0*-bsd-user)<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if test &quot;$bsd&quot; !=3D &quot;yes&quot;; then<br>&gt=
; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error &quo=
t;Target &#39;$target&#39; is only available on a BSD host&quot;<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0;;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0*)<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error &quot;Invalid target n=
ame &#39;$target&#39;&quot;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return 1<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt=
; - =C2=A0 =C2=A0esac<br>&gt; - =C2=A0 =C2=A0test &quot;$tcg&quot; =3D &quo=
t;enabled&quot; &amp;&amp; return 0<br>&gt; - =C2=A0 =C2=A0supported_kvm_ta=
rget &quot;$1&quot; &amp;&amp; return 0<br>&gt; - =C2=A0 =C2=A0supported_xe=
n_target &quot;$1&quot; &amp;&amp; return 0<br>&gt; - =C2=A0 =C2=A0supporte=
d_hax_target &quot;$1&quot; &amp;&amp; return 0<br>&gt; - =C2=A0 =C2=A0supp=
orted_hvf_target &quot;$1&quot; &amp;&amp; return 0<br>&gt; - =C2=A0 =C2=A0=
supported_whpx_target &quot;$1&quot; &amp;&amp; return 0<br>&gt; - =C2=A0 =
=C2=A0print_error &quot;TCG disabled, but hardware accelerator not availabl=
e for &#39;$target&#39;&quot;<br>&gt; - =C2=A0 =C2=A0return 1<br>&gt; -}<br=
>&gt; -<br>&gt; -<br>&gt; =C2=A0ld_has() {<br>&gt; =C2=A0 =C2=A0 =C2=A0$ld =
--help 2&gt;/dev/null | grep &quot;.$1&quot; &gt;/dev/null 2&gt;&amp;1<br>&=
gt; =C2=A0}<br>&gt; @@ -2292,12 +2199,13 @@ if test &quot;$solaris&quot; =
=3D &quot;yes&quot; ; then<br>&gt; =C2=A0fi<br>&gt;<br>&gt; =C2=A0if test -=
z &quot;${target_list+xxx}&quot; ; then<br>&gt; + =C2=A0 =C2=A0default_targ=
ets=3Dyes<br>&gt; =C2=A0 =C2=A0 =C2=A0for target in $default_target_list; d=
o<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_target $target 2&gt;/dev/n=
ull &amp;&amp; \<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0target_=
list=3D&quot;$target_list $target&quot;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0target_list=3D&quot;$target_list $target&quot;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0done<br>&gt; =C2=A0 =C2=A0 =C2=A0target_list=3D&quot;${target_list# }&qu=
ot;<br>&gt; =C2=A0else<br>&gt; + =C2=A0 =C2=A0default_targets=3Dno<br>&gt; =
=C2=A0 =C2=A0 =C2=A0target_list=3D$(echo &quot;$target_list&quot; | sed -e =
&#39;s/,/ /g&#39;)<br>&gt; =C2=A0 =C2=A0 =C2=A0for target in $target_list; =
do<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Check that we recognised the=
 target name; this allows a more<br>&gt; @@ -2309,7 +2217,6 @@ else<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_exit &=
quot;Unknown target name &#39;$target&#39;&quot;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;<br>&gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0esac<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0supported_target=
 $target || exit 1<br>&gt; =C2=A0 =C2=A0 =C2=A0done<br>&gt; =C2=A0fi<br>&gt=
;<br>&gt; @@ -2653,27 +2560,6 @@ if test &quot;$seccomp&quot; !=3D &quot;no=
&quot; ; then<br>&gt; =C2=A0 =C2=A0 =C2=A0fi<br>&gt; =C2=A0fi<br>&gt;<br>&g=
t; -##########################################<br>&gt; -# simple accelerato=
r probes<br>&gt; -<br>&gt; -if test &quot;$kvm&quot; =3D &quot;auto&quot; ;=
 then<br>&gt; - =C2=A0if test &quot;$linux&quot; =3D yes ; then<br>&gt; - =
=C2=A0 =C2=A0kvm=3Denabled<br>&gt; - =C2=A0else<br>&gt; - =C2=A0 =C2=A0if t=
est &quot;$kvm&quot; =3D &quot;enabled&quot; ; then<br>&gt; - =C2=A0 =C2=A0=
 =C2=A0feature_not_found &quot;kvm&quot; &quot;KVM is only available on Lin=
ux&quot;<br>&gt; - =C2=A0 =C2=A0fi<br>&gt; - =C2=A0fi<br>&gt; -fi<br>&gt; -=
<br>&gt; -if test &quot;$hax&quot; =3D &quot;auto&quot; ; then<br>&gt; - =
=C2=A0if test &quot;$mingw&quot; =3D yes || test &quot;$darwin&quot; =3D ye=
s || test &quot;$targetos&quot; =3D NetBSD; then<br>&gt; - =C2=A0 =C2=A0hax=
=3Denabled<br>&gt; - =C2=A0else<br>&gt; - =C2=A0 =C2=A0hax=3Ddisabled<br>&g=
t; - =C2=A0fi<br>&gt; -fi<br>&gt; -<br>&gt; =C2=A0#########################=
#################<br>&gt; =C2=A0# xen probe<br>&gt;<br>&gt; @@ -2992,22 +28=
78,6 @@ if test &quot;$xen_pci_passthrough&quot; !=3D &quot;disabled&quot;;=
 then<br>&gt; =C2=A0 =C2=A0fi<br>&gt; =C2=A0fi<br>&gt;<br>&gt; -###########=
###############################<br>&gt; -# Windows Hypervisor Platform acce=
lerator (WHPX) check<br>&gt; -if test &quot;$whpx&quot; =3D &quot;enabled&q=
uot; &amp;&amp; test &quot;$ARCH&quot; !=3D &quot;x86_64&quot;; then<br>&gt=
; - =C2=A0error_exit &quot;WHPX requires 64-bit host&quot;<br>&gt; -fi<br>&=
gt; -if test &quot;$whpx&quot; !=3D &quot;disabled&quot; &amp;&amp; test &q=
uot;$ARCH&quot; =3D &quot;x86_64&quot;; then<br>&gt; - =C2=A0 =C2=A0if chec=
k_include &quot;WinHvPlatform.h&quot; &amp;&amp; check_include &quot;WinHvE=
mulation.h&quot;; then<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0whpx=3D&quot;ye=
s&quot;<br>&gt; - =C2=A0 =C2=A0else<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 test &quot;$whpx&quot; =3D &quot;auto&quot;; then<br>&gt; - =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0feature_not_found &quot;WinHvPlatform&quot; &quo=
t;WinHvEmulation is not installed&quot;<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=
=A0fi<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0whpx=3D&quot;disabled&quot;<br>&=
gt; - =C2=A0 =C2=A0fi<br>&gt; -fi<br>&gt; -<br>&gt; =C2=A0#################=
#########################<br>&gt; =C2=A0# gettext probe<br>&gt; =C2=A0if te=
st &quot;$gettext&quot; !=3D &quot;false&quot; ; then<br>&gt; @@ -7375,281 =
+7245,13 @@ fi<br>&gt;<br>&gt; =C2=A0for target in $target_list; do<br>&gt;=
 =C2=A0target_dir=3D&quot;$target&quot;<br>&gt; -config_target_mak=3D$targe=
t_dir/config-target.mak<br>&gt; =C2=A0target_name=3D$(echo $target | cut -d=
 &#39;-&#39; -f 1)<br>&gt; -target_aligned_only=3D&quot;no&quot;<br>&gt; -c=
ase &quot;$target_name&quot; in<br>&gt; - =C2=A0alpha|hppa|mips64el|mips64|=
mipsel|mips|mipsn32|mipsn32el|sh4|sh4eb|sparc|sparc64|sparc32plus|xtensa|xt=
ensaeb)<br>&gt; - =C2=A0target_aligned_only=3D&quot;yes&quot;<br>&gt; - =C2=
=A0;;<br>&gt; -esac<br>&gt; -target_bigendian=3D&quot;no&quot;<br>&gt; -cas=
e &quot;$target_name&quot; in<br>&gt; - =C2=A0armeb|aarch64_be|hppa|lm32|m6=
8k|microblaze|mips|mipsn32|mips64|moxie|or1k|ppc|ppc64|ppc64abi32|s390x|sh4=
eb|sparc|sparc64|sparc32plus|xtensaeb)<br>&gt; - =C2=A0target_bigendian=3D&=
quot;yes&quot;<br>&gt; - =C2=A0;;<br>&gt; -esac<br>&gt; -target_softmmu=3D&=
quot;no&quot;<br>&gt; -target_user_only=3D&quot;no&quot;<br>&gt; -target_li=
nux_user=3D&quot;no&quot;<br>&gt; -target_bsd_user=3D&quot;no&quot;<br>&gt;=
 -case &quot;$target&quot; in<br>&gt; - =C2=A0${target_name}-softmmu)<br>&g=
t; - =C2=A0 =C2=A0target_softmmu=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0;=
;<br>&gt; - =C2=A0${target_name}-linux-user)<br>&gt; - =C2=A0 =C2=A0target_=
user_only=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0target_linux_user=3D&quo=
t;yes&quot;<br>&gt; - =C2=A0 =C2=A0;;<br>&gt; - =C2=A0${target_name}-bsd-us=
er)<br>&gt; - =C2=A0 =C2=A0target_user_only=3D&quot;yes&quot;<br>&gt; - =C2=
=A0 =C2=A0target_bsd_user=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0;;<br>&g=
t; - =C2=A0*)<br>&gt; - =C2=A0 =C2=A0error_exit &quot;Target &#39;$target&#=
39; not recognised&quot;<br>&gt; - =C2=A0 =C2=A0exit 1<br>&gt; - =C2=A0 =C2=
=A0;;<br>&gt; -esac<br>&gt; -<br>&gt; =C2=A0mkdir -p $target_dir<br>&gt; -e=
cho &quot;# Automatically generated by configure - do not modify&quot; &gt;=
 $config_target_mak<br>&gt; -<br>&gt; -bflt=3D&quot;no&quot;<br>&gt; -mttcg=
=3D&quot;no&quot;<br>&gt; -interp_prefix1=3D$(echo &quot;$interp_prefix&quo=
t; | sed &quot;s/%M/$target_name/g&quot;)<br>&gt; -gdb_xml_files=3D&quot;&q=
uot;<br>&gt; -<br>&gt; -TARGET_ARCH=3D&quot;$target_name&quot;<br>&gt; -TAR=
GET_BASE_ARCH=3D&quot;&quot;<br>&gt; -TARGET_ABI_DIR=3D&quot;&quot;<br>&gt;=
 -TARGET_SYSTBL_ABI=3D&quot;&quot;<br>&gt; -TARGET_SYSTBL=3D&quot;&quot;<br=
>&gt; -<br>&gt; -case &quot;$target_name&quot; in<br>&gt; - =C2=A0i386)<br>=
&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0gdb_xml_=
files=3D&quot;i386-32bit.xml&quot;<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=
=3Di386<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL=3Dsyscall_32.tbl<br>&gt; - =C2=
=A0;;<br>&gt; - =C2=A0x86_64)<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=3Di38=
6<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon,64<br>&gt; - =C2=A0 =C2=
=A0TARGET_SYSTBL=3Dsyscall_64.tbl<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&=
quot;<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;i386-64bit.xml&quot;<br>=
&gt; - =C2=A0;;<br>&gt; - =C2=A0alpha)<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot=
;yes&quot;<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon<br>&gt; - =C2=
=A0;;<br>&gt; - =C2=A0arm|armeb)<br>&gt; - =C2=A0 =C2=A0TARGET_ARCH=3Darm<b=
r>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon,oabi<br>&gt; - =C2=A0 =C2=
=A0bflt=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br=
>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;arm-core.xml arm-vfp.xml arm-vfp=
3.xml arm-neon.xml arm-m-profile.xml&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=
=A0aarch64|aarch64_be)<br>&gt; - =C2=A0 =C2=A0TARGET_ARCH=3Daarch64<br>&gt;=
 - =C2=A0 =C2=A0TARGET_BASE_ARCH=3Darm<br>&gt; - =C2=A0 =C2=A0bflt=3D&quot;=
yes&quot;<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; - =C2=A0 =
=C2=A0gdb_xml_files=3D&quot;aarch64-core.xml aarch64-fpu.xml arm-core.xml a=
rm-vfp.xml arm-vfp3.xml arm-neon.xml arm-m-profile.xml&quot;<br>&gt; - =C2=
=A0;;<br>&gt; - =C2=A0avr)<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;avr=
-cpu.xml&quot;<br>&gt; - =C2=A0 =C2=A0target_compiler=3D$cross_cc_avr<br>&g=
t; - =C2=A0;;<br>&gt; - =C2=A0cris)<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0hppa=
)<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0TAR=
GET_SYSTBL_ABI=3Dcommon,32<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0lm32)<br>&gt;=
 - =C2=A0;;<br>&gt; - =C2=A0m68k)<br>&gt; - =C2=A0 =C2=A0bflt=3D&quot;yes&q=
uot;<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;cf-core.xml cf-fp.xml m68=
k-core.xml m68k-fp.xml&quot;<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcom=
mon<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0microblaze|microblazeel)<br>&gt; - =
=C2=A0 =C2=A0TARGET_ARCH=3Dmicroblaze<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_=
ABI=3Dcommon<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; - =C2=
=A0 =C2=A0bflt=3D&quot;yes&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0mips|mi=
psel)<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=
=A0TARGET_ARCH=3Dmips<br>&gt; - =C2=A0 =C2=A0echo &quot;TARGET_ABI_MIPSO32=
=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL=
_ABI=3Do32<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL=3Dsyscall_o32.tbl<br>&gt; -=
 =C2=A0;;<br>&gt; - =C2=A0mipsn32|mipsn32el)<br>&gt; - =C2=A0 =C2=A0mttcg=
=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0TARGET_ARCH=3Dmips64<br>&gt; - =
=C2=A0 =C2=A0TARGET_BASE_ARCH=3Dmips<br>&gt; - =C2=A0 =C2=A0echo &quot;TARG=
ET_ABI_MIPSN32=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; - =C2=A0 =C2=
=A0echo &quot;TARGET_ABI32=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; - =
=C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dn32<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL=
=3Dsyscall_n32.tbl<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0mips64|mips64el)<br>&=
gt; - =C2=A0 =C2=A0mttcg=3D&quot;no&quot;<br>&gt; - =C2=A0 =C2=A0TARGET_ARC=
H=3Dmips64<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=3Dmips<br>&gt; - =C2=A0 =
=C2=A0echo &quot;TARGET_ABI_MIPSN64=3Dy&quot; &gt;&gt; $config_target_mak<b=
r>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dn64<br>&gt; - =C2=A0 =C2=A0TARGET=
_SYSTBL=3Dsyscall_n64.tbl<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0moxie)<br>&gt;=
 - =C2=A0;;<br>&gt; - =C2=A0nios2)<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0or1k)=
<br>&gt; - =C2=A0 =C2=A0TARGET_ARCH=3Dopenrisc<br>&gt; - =C2=A0 =C2=A0TARGE=
T_BASE_ARCH=3Dopenrisc<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0ppc)<br>&gt; - =
=C2=A0 =C2=A0gdb_xml_files=3D&quot;power-core.xml power-fpu.xml power-altiv=
ec.xml power-spe.xml&quot;<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommo=
n,nospu,32<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0ppc64)<br>&gt; - =C2=A0 =C2=
=A0TARGET_BASE_ARCH=3Dppc<br>&gt; - =C2=A0 =C2=A0TARGET_ABI_DIR=3Dppc<br>&g=
t; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon,nospu,64<br>&gt; - =C2=A0 =C2=
=A0mttcg=3Dyes<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;power64-core.xm=
l power-fpu.xml power-altivec.xml power-spe.xml power-vsx.xml&quot;<br>&gt;=
 - =C2=A0;;<br>&gt; - =C2=A0ppc64le)<br>&gt; - =C2=A0 =C2=A0TARGET_ARCH=3Dp=
pc64<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=3Dppc<br>&gt; - =C2=A0 =C2=A0T=
ARGET_ABI_DIR=3Dppc<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon,nospu=
,64<br>&gt; - =C2=A0 =C2=A0mttcg=3Dyes<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=
=3D&quot;power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml pow=
er-vsx.xml&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0ppc64abi32)<br>&gt; - =
=C2=A0 =C2=A0TARGET_ARCH=3Dppc64<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=3D=
ppc<br>&gt; - =C2=A0 =C2=A0TARGET_ABI_DIR=3Dppc<br>&gt; - =C2=A0 =C2=A0TARG=
ET_SYSTBL_ABI=3Dcommon,nospu,32<br>&gt; - =C2=A0 =C2=A0echo &quot;TARGET_AB=
I32=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; - =C2=A0 =C2=A0gdb_xml_fi=
les=3D&quot;power64-core.xml power-fpu.xml power-altivec.xml power-spe.xml =
power-vsx.xml&quot;<br>&gt; - =C2=A0 =C2=A0deprecated_features=3D&quot;ppc6=
4abi32 ${deprecated_features}&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0risc=
v32)<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=3Driscv<br>&gt; - =C2=A0 =C2=
=A0TARGET_ABI_DIR=3Driscv<br>&gt; - =C2=A0 =C2=A0mttcg=3Dyes<br>&gt; - =C2=
=A0 =C2=A0gdb_xml_files=3D&quot;riscv-32bit-cpu.xml riscv-32bit-fpu.xml ris=
cv-64bit-fpu.xml riscv-32bit-csr.xml riscv-32bit-virtual.xml&quot;<br>&gt; =
- =C2=A0;;<br>&gt; - =C2=A0riscv64)<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=
=3Driscv<br>&gt; - =C2=A0 =C2=A0TARGET_ABI_DIR=3Driscv<br>&gt; - =C2=A0 =C2=
=A0mttcg=3Dyes<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;riscv-64bit-cpu=
.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bi=
t-virtual.xml&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0rx)<br>&gt; - =C2=A0=
 =C2=A0TARGET_ARCH=3Drx<br>&gt; - =C2=A0 =C2=A0bflt=3D&quot;yes&quot;<br>&g=
t; - =C2=A0 =C2=A0target_compiler=3D$cross_cc_rx<br>&gt; - =C2=A0 =C2=A0gdb=
_xml_files=3D&quot;rx-core.xml&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0sh4=
|sh4eb)<br>&gt; - =C2=A0 =C2=A0TARGET_ARCH=3Dsh4<br>&gt; - =C2=A0 =C2=A0TAR=
GET_SYSTBL_ABI=3Dcommon<br>&gt; - =C2=A0 =C2=A0bflt=3D&quot;yes&quot;<br>&g=
t; - =C2=A0;;<br>&gt; - =C2=A0sparc)<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_A=
BI=3Dcommon,32<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0sparc64)<br>&gt; - =C2=A0=
 =C2=A0TARGET_BASE_ARCH=3Dsparc<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3D=
common,64<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0sparc32plus)<br>&gt; - =C2=A0 =
=C2=A0TARGET_ARCH=3Dsparc64<br>&gt; - =C2=A0 =C2=A0TARGET_BASE_ARCH=3Dsparc=
<br>&gt; - =C2=A0 =C2=A0TARGET_ABI_DIR=3Dsparc<br>&gt; - =C2=A0 =C2=A0TARGE=
T_SYSTBL_ABI=3Dcommon,32<br>&gt; - =C2=A0 =C2=A0echo &quot;TARGET_ABI32=3Dy=
&quot; &gt;&gt; $config_target_mak<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0s390x=
)<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon,64<br>&gt; - =C2=A0 =C2=
=A0mttcg=3Dyes<br>&gt; - =C2=A0 =C2=A0gdb_xml_files=3D&quot;s390x-core64.xm=
l s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.x=
ml&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0tilegx)<br>&gt; - =C2=A0;;<br>&=
gt; - =C2=A0tricore)<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0unicore32)<br>&gt; =
- =C2=A0;;<br>&gt; - =C2=A0xtensa|xtensaeb)<br>&gt; - =C2=A0 =C2=A0TARGET_A=
RCH=3Dxtensa<br>&gt; - =C2=A0 =C2=A0TARGET_SYSTBL_ABI=3Dcommon<br>&gt; - =
=C2=A0 =C2=A0bflt=3D&quot;yes&quot;<br>&gt; - =C2=A0 =C2=A0mttcg=3D&quot;ye=
s&quot;<br>&gt; - =C2=A0;;<br>&gt; - =C2=A0*)<br>&gt; - =C2=A0 =C2=A0error_=
exit &quot;Unsupported target CPU&quot;<br>&gt; - =C2=A0;;<br>&gt; -esac<br=
>&gt; -# TARGET_BASE_ARCH needs to be defined after TARGET_ARCH<br>&gt; -if=
 [ &quot;$TARGET_BASE_ARCH&quot; =3D &quot;&quot; ]; then<br>&gt; - =C2=A0T=
ARGET_BASE_ARCH=3D$TARGET_ARCH<br>&gt; -fi<br>&gt; -if [ &quot;$TARGET_SYST=
BL_ABI&quot; !=3D &quot;&quot; ] &amp;&amp; [ &quot;$TARGET_SYSTBL&quot; =
=3D &quot;&quot; ]; then<br>&gt; - =C2=A0TARGET_SYSTBL=3Dsyscall.tbl<br>&gt=
; -fi<br>&gt; -<br>&gt; -upper() {<br>&gt; - =C2=A0 =C2=A0echo &quot;$@&quo=
t;| LC_ALL=3DC tr &#39;[a-z]&#39; &#39;[A-Z]&#39;<br>&gt; -}<br>&gt; -<br>&=
gt; -target_arch_name=3D&quot;$(upper $TARGET_ARCH)&quot;<br>&gt; -echo &qu=
ot;TARGET_$target_arch_name=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; -=
echo &quot;TARGET_BASE_ARCH=3D$TARGET_BASE_ARCH&quot; &gt;&gt; $config_targ=
et_mak<br>&gt; -if [ &quot;$TARGET_ABI_DIR&quot; =3D &quot;&quot; ]; then<b=
r>&gt; - =C2=A0TARGET_ABI_DIR=3D$TARGET_ARCH<br>&gt; -fi<br>&gt; -echo &quo=
t;TARGET_ABI_DIR=3D$TARGET_ABI_DIR&quot; &gt;&gt; $config_target_mak<br>&gt=
; -if [ &quot;$TARGET_SYSTBL_ABI&quot; !=3D &quot;&quot; ]; then<br>&gt; - =
=C2=A0 =C2=A0echo &quot;TARGET_SYSTBL_ABI=3D$TARGET_SYSTBL_ABI&quot; &gt;&g=
t; $config_target_mak<br>&gt; - =C2=A0 =C2=A0echo &quot;TARGET_SYSTBL=3D$TA=
RGET_SYSTBL&quot; &gt;&gt; $config_target_mak<br>&gt; -fi<br>&gt; -<br>&gt;=
 -if test &quot;$target_aligned_only&quot; =3D &quot;yes&quot; ; then<br>&g=
t; - =C2=A0echo &quot;TARGET_ALIGNED_ONLY=3Dy&quot; &gt;&gt; $config_target=
_mak<br>&gt; -fi<br>&gt; -if test &quot;$target_bigendian&quot; =3D &quot;y=
es&quot; ; then<br>&gt; - =C2=A0echo &quot;TARGET_WORDS_BIGENDIAN=3Dy&quot;=
 &gt;&gt; $config_target_mak<br>&gt; -fi<br>&gt; -if test &quot;$target_sof=
tmmu&quot; =3D &quot;yes&quot; ; then<br>&gt; - =C2=A0if test &quot;$mttcg&=
quot; =3D &quot;yes&quot; ; then<br>&gt; - =C2=A0 =C2=A0echo &quot;TARGET_S=
UPPORTS_MTTCG=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; - =C2=A0fi<br>&=
gt; -fi<br>&gt; =C2=A0if test &quot;$target_user_only&quot; =3D &quot;yes&q=
uot; ; then<br>&gt; =C2=A0 =C2=A0symlink &quot;../qemu-$target_name&quot; &=
quot;$target_dir/qemu-$target_name&quot;<br>&gt; =C2=A0else<br>&gt; =C2=A0 =
=C2=A0symlink &quot;../qemu-system-$target_name&quot; &quot;$target_dir/qem=
u-system-$target_name&quot;<br>&gt; =C2=A0fi<br>&gt; -list=3D&quot;&quot;<b=
r>&gt; -if test ! -z &quot;$gdb_xml_files&quot; ; then<br>&gt; - =C2=A0for =
x in $gdb_xml_files; do<br>&gt; - =C2=A0 =C2=A0list=3D&quot;$list gdb-xml/$=
x&quot;<br>&gt; - =C2=A0done<br>&gt; - =C2=A0echo &quot;TARGET_XML_FILES=3D=
$list&quot; &gt;&gt; $config_target_mak<br>&gt; -fi<br>&gt; -<br>&gt; -if t=
est &quot;$target_user_only&quot; =3D &quot;yes&quot; &amp;&amp; test &quot=
;$bflt&quot; =3D &quot;yes&quot;; then<br>&gt; - =C2=A0echo &quot;TARGET_HA=
S_BFLT=3Dy&quot; &gt;&gt; $config_target_mak<br>&gt; -fi<br>&gt; -<br>&gt; =
=C2=A0done # for target in $targets<br>&gt;<br>&gt; =C2=A0if [ &quot;$fdt&q=
uot; =3D &quot;git&quot; ]; then<br>&gt; @@ -7659,6 +7261,9 @@ if [ &quot;$=
capstone&quot; =3D &quot;git&quot; -o &quot;$capstone&quot; =3D &quot;inter=
nal&quot; ]; then<br>&gt; =C2=A0 =C2=A0subdirs=3D&quot;$subdirs capstone&qu=
ot;<br>&gt; =C2=A0fi<br>&gt; =C2=A0echo &quot;CONFIG_QEMU_INTERP_PREFIX=3D$=
interp_prefix&quot; | sed &#39;s/%M/@0@/&#39; &gt;&gt; $config_host_mak<br>=
&gt; +if test &quot;$default_targets&quot; =3D &quot;yes&quot;; then<br>&gt=
; + =C2=A0echo &quot;CONFIG_DEFAULT_TARGETS=3Dy&quot; &gt;&gt; $config_host=
_mak<br>&gt; +fi<br>&gt; =C2=A0echo &quot;SUBDIRS=3D$subdirs&quot; &gt;&gt;=
 $config_host_mak<br>&gt; =C2=A0if test -n &quot;$LIBCAPSTONE&quot;; then<b=
r>&gt; =C2=A0 =C2=A0echo &quot;LIBCAPSTONE=3D$LIBCAPSTONE&quot; &gt;&gt; $c=
onfig_host_mak<br>&gt; diff --git a/default-configs/targets/aarch64-linux-u=
ser.mak b/default-configs/targets/aarch64-linux-user.mak<br>&gt; new file m=
ode 100644<br>&gt; index 0000000000..4495e86509<br>&gt; --- /dev/null<br>&g=
t; +++ b/default-configs/targets/aarch64-linux-user.mak<br>&gt; @@ -0,0 +1,=
5 @@<br>&gt; +TARGET_AARCH64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Darm<br>&gt; +T=
ARGET_ABI_DIR=3Daarch64<br>&gt; +TARGET_XML_FILES=3D gdb-xml/aarch64-core.x=
ml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml=
/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml<br>&gt; +TARGE=
T_HAS_BFLT=3Dy<br>&gt; diff --git a/default-configs/targets/aarch64-softmmu=
.mak b/default-configs/targets/aarch64-softmmu.mak<br>&gt; new file mode 10=
0644<br>&gt; index 0000000000..53f83ea81f<br>&gt; --- /dev/null<br>&gt; +++=
 b/default-configs/targets/aarch64-softmmu.mak<br>&gt; @@ -0,0 +1,5 @@<br>&=
gt; +TARGET_AARCH64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Darm<br>&gt; +TARGET_ABI=
_DIR=3Daarch64<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; +TARGET_XML_FILES=
=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml g=
db-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-=
profile.xml<br>&gt; diff --git a/default-configs/targets/aarch64_be-linux-u=
ser.mak b/default-configs/targets/aarch64_be-linux-user.mak<br>&gt; new fil=
e mode 100644<br>&gt; index 0000000000..da13693d3d<br>&gt; --- /dev/null<br=
>&gt; +++ b/default-configs/targets/aarch64_be-linux-user.mak<br>&gt; @@ -0=
,0 +1,6 @@<br>&gt; +TARGET_AARCH64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Darm<br>&=
gt; +TARGET_ABI_DIR=3Daarch64<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +=
TARGET_XML_FILES=3D gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xm=
l/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xm=
l gdb-xml/arm-m-profile.xml<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff --git=
 a/default-configs/targets/alpha-linux-user.mak b/default-configs/targets/a=
lpha-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..=
5ff89f5d48<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/alph=
a-linux-user.mak<br>&gt; @@ -0,0 +1,6 @@<br>&gt; +TARGET_ALPHA=3Dy<br>&gt; =
+TARGET_BASE_ARCH=3Dalpha<br>&gt; +TARGET_ABI_DIR=3Dalpha<br>&gt; +TARGET_S=
YSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALI=
GNED_ONLY=3Dy<br>&gt; diff --git a/default-configs/targets/alpha-softmmu.ma=
k b/default-configs/targets/alpha-softmmu.mak<br>&gt; new file mode 100644<=
br>&gt; index 0000000000..b78114b028<br>&gt; --- /dev/null<br>&gt; +++ b/de=
fault-configs/targets/alpha-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TA=
RGET_ALPHA=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dalpha<br>&gt; +TARGET_ABI_DIR=3D=
alpha<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.=
tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>=
&gt; diff --git a/default-configs/targets/arm-linux-user.mak b/default-conf=
igs/targets/arm-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 0=
000000000..7c54c3c2a2<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/t=
argets/arm-linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_ARM=3Dy<b=
r>&gt; +TARGET_BASE_ARCH=3Darm<br>&gt; +TARGET_ABI_DIR=3Darm<br>&gt; +TARGE=
T_SYSTBL_ABI=3Dcommon,oabi<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TA=
RGET_XML_FILES=3D gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3=
.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml<br>&gt; +TARGET_HAS_BFL=
T=3Dy<br>&gt; diff --git a/default-configs/targets/arm-softmmu.mak b/defaul=
t-configs/targets/arm-softmmu.mak<br>&gt; new file mode 100644<br>&gt; inde=
x 0000000000..d40b995f25<br>&gt; --- /dev/null<br>&gt; +++ b/default-config=
s/targets/arm-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_ARM=3Dy<b=
r>&gt; +TARGET_BASE_ARCH=3Darm<br>&gt; +TARGET_ABI_DIR=3Darm<br>&gt; +TARGE=
T_SYSTBL_ABI=3Dcommon,oabi<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TA=
RGET_SUPPORTS_MTTCG=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/arm-core.xml g=
db-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-=
profile.xml<br>&gt; diff --git a/default-configs/targets/armeb-linux-user.m=
ak b/default-configs/targets/armeb-linux-user.mak<br>&gt; new file mode 100=
644<br>&gt; index 0000000000..1882aa472d<br>&gt; --- /dev/null<br>&gt; +++ =
b/default-configs/targets/armeb-linux-user.mak<br>&gt; @@ -0,0 +1,8 @@<br>&=
gt; +TARGET_ARM=3Dy<br>&gt; +TARGET_BASE_ARCH=3Darm<br>&gt; +TARGET_ABI_DIR=
=3Darm<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,oabi<br>&gt; +TARGET_SYSTBL=3Dsy=
scall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_XML_FILES=3D =
gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-n=
eon.xml gdb-xml/arm-m-profile.xml<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff=
 --git a/default-configs/targets/avr-softmmu.mak b/default-configs/targets/=
avr-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..ecd2=
92b2f7<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/avr-soft=
mmu.mak<br>&gt; @@ -0,0 +1,4 @@<br>&gt; +TARGET_AVR=3Dy<br>&gt; +TARGET_BAS=
E_ARCH=3Davr<br>&gt; +TARGET_ABI_DIR=3Davr<br>&gt; +TARGET_XML_FILES=3D gdb=
-xml/avr-cpu.xml<br>&gt; diff --git a/default-configs/targets/cris-linux-us=
er.mak b/default-configs/targets/cris-linux-user.mak<br>&gt; new file mode =
100644<br>&gt; index 0000000000..ba61135172<br>&gt; --- /dev/null<br>&gt; +=
++ b/default-configs/targets/cris-linux-user.mak<br>&gt; @@ -0,0 +1,3 @@<br=
>&gt; +TARGET_CRIS=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dcris<br>&gt; +TARGET_ABI=
_DIR=3Dcris<br>&gt; diff --git a/default-configs/targets/cris-softmmu.mak b=
/default-configs/targets/cris-softmmu.mak<br>&gt; new file mode 100644<br>&=
gt; index 0000000000..ba61135172<br>&gt; --- /dev/null<br>&gt; +++ b/defaul=
t-configs/targets/cris-softmmu.mak<br>&gt; @@ -0,0 +1,3 @@<br>&gt; +TARGET_=
CRIS=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dcris<br>&gt; +TARGET_ABI_DIR=3Dcris<br=
>&gt; diff --git a/default-configs/targets/hppa-linux-user.mak b/default-co=
nfigs/targets/hppa-linux-user.mak<br>&gt; new file mode 100644<br>&gt; inde=
x 0000000000..94222e8fc6<br>&gt; --- /dev/null<br>&gt; +++ b/default-config=
s/targets/hppa-linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_HPPA=
=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dhppa<br>&gt; +TARGET_ABI_DIR=3Dhppa<br>&gt=
; +TARGET_SYSTBL_ABI=3Dcommon,32<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&g=
t; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; dif=
f --git a/default-configs/targets/hppa-softmmu.mak b/default-configs/target=
s/hppa-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..6=
17c6483c0<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/hppa-=
softmmu.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_HPPA=3Dy<br>&gt; +TARGE=
T_BASE_ARCH=3Dhppa<br>&gt; +TARGET_ABI_DIR=3Dhppa<br>&gt; +TARGET_SYSTBL_AB=
I=3Dcommon,32<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_=
ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_SUPPORTS_MTTCG=
=3Dy<br>&gt; diff --git a/default-configs/targets/i386-bsd-user.mak b/defau=
lt-configs/targets/i386-bsd-user.mak<br>&gt; new file mode 100644<br>&gt; i=
ndex 0000000000..34b52e9ee2<br>&gt; --- /dev/null<br>&gt; +++ b/default-con=
figs/targets/i386-bsd-user.mak<br>&gt; @@ -0,0 +1,6 @@<br>&gt; +TARGET_I386=
=3Dy<br>&gt; +TARGET_BASE_ARCH=3Di386<br>&gt; +TARGET_ABI_DIR=3Di386<br>&gt=
; +TARGET_SYSTBL_ABI=3Di386<br>&gt; +TARGET_SYSTBL=3Dsyscall_32.tbl<br>&gt;=
 +TARGET_XML_FILES=3D gdb-xml/i386-32bit.xml<br>&gt; diff --git a/default-c=
onfigs/targets/i386-linux-user.mak b/default-configs/targets/i386-linux-use=
r.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..34b52e9ee2<br>=
&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/i386-linux-user.ma=
k<br>&gt; @@ -0,0 +1,6 @@<br>&gt; +TARGET_I386=3Dy<br>&gt; +TARGET_BASE_ARC=
H=3Di386<br>&gt; +TARGET_ABI_DIR=3Di386<br>&gt; +TARGET_SYSTBL_ABI=3Di386<b=
r>&gt; +TARGET_SYSTBL=3Dsyscall_32.tbl<br>&gt; +TARGET_XML_FILES=3D gdb-xml=
/i386-32bit.xml<br>&gt; diff --git a/default-configs/targets/i386-softmmu.m=
ak b/default-configs/targets/i386-softmmu.mak<br>&gt; new file mode 100644<=
br>&gt; index 0000000000..be9198bb84<br>&gt; --- /dev/null<br>&gt; +++ b/de=
fault-configs/targets/i386-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TAR=
GET_I386=3Dy<br>&gt; +TARGET_BASE_ARCH=3Di386<br>&gt; +TARGET_ABI_DIR=3Di38=
6<br>&gt; +TARGET_SYSTBL_ABI=3Di386<br>&gt; +TARGET_SYSTBL=3Dsyscall_32.tbl=
<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/i3=
86-32bit.xml<br>&gt; diff --git a/default-configs/targets/lm32-softmmu.mak =
b/default-configs/targets/lm32-softmmu.mak<br>&gt; new file mode 100644<br>=
&gt; index 0000000000..c327d27d5f<br>&gt; --- /dev/null<br>&gt; +++ b/defau=
lt-configs/targets/lm32-softmmu.mak<br>&gt; @@ -0,0 +1,4 @@<br>&gt; +TARGET=
_LM32=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dlm32<br>&gt; +TARGET_ABI_DIR=3Dlm32<b=
r>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git a/default-configs/tar=
gets/m68k-linux-user.mak b/default-configs/targets/m68k-linux-user.mak<br>&=
gt; new file mode 100644<br>&gt; index 0000000000..e7c0af5881<br>&gt; --- /=
dev/null<br>&gt; +++ b/default-configs/targets/m68k-linux-user.mak<br>&gt; =
@@ -0,0 +1,8 @@<br>&gt; +TARGET_M68K=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dm68k<b=
r>&gt; +TARGET_ABI_DIR=3Dm68k<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +=
TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TA=
RGET_XML_FILES=3D gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.x=
ml gdb-xml/m68k-fp.xml<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff --git a/de=
fault-configs/targets/m68k-softmmu.mak b/default-configs/targets/m68k-softm=
mu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..f8bf4fc5ac<br=
>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/m68k-softmmu.mak<=
br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_M68K=3Dy<br>&gt; +TARGET_BASE_ARCH=
=3Dm68k<br>&gt; +TARGET_ABI_DIR=3Dm68k<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<=
br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br=
>&gt; +TARGET_XML_FILES=3D gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m6=
8k-core.xml gdb-xml/m68k-fp.xml<br>&gt; diff --git a/default-configs/target=
s/microblaze-linux-user.mak b/default-configs/targets/microblaze-linux-user=
.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..809819424d<br>&=
gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/microblaze-linux-us=
er.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_MICROBLAZE=3Dy<br>&gt; +TARG=
ET_BASE_ARCH=3Dmicroblaze<br>&gt; +TARGET_ABI_DIR=3Dmicroblaze<br>&gt; +TAR=
GET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGE=
T_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff --git a/def=
ault-configs/targets/microblaze-softmmu.mak b/default-configs/targets/micro=
blaze-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..1b=
0a76a61f<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/microb=
laze-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_MICROBLAZE=3Dy<br>=
&gt; +TARGET_BASE_ARCH=3Dmicroblaze<br>&gt; +TARGET_ABI_DIR=3Dmicroblaze<br=
>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&=
gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; =
diff --git a/default-configs/targets/microblazeel-linux-user.mak b/default-=
configs/targets/microblazeel-linux-user.mak<br>&gt; new file mode 100644<br=
>&gt; index 0000000000..416b42eeb6<br>&gt; --- /dev/null<br>&gt; +++ b/defa=
ult-configs/targets/microblazeel-linux-user.mak<br>&gt; @@ -0,0 +1,6 @@<br>=
&gt; +TARGET_MICROBLAZE=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmicroblaze<br>&gt; =
+TARGET_ABI_DIR=3Dmicroblaze<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +T=
ARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff --git =
a/default-configs/targets/microblazeel-softmmu.mak b/default-configs/target=
s/microblazeel-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 00000=
00000..3a2cf8be0f<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targe=
ts/microblazeel-softmmu.mak<br>&gt; @@ -0,0 +1,6 @@<br>&gt; +TARGET_MICROBL=
AZE=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmicroblaze<br>&gt; +TARGET_ABI_DIR=3Dmi=
croblaze<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsysca=
ll.tbl<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; diff --git a/default-conf=
igs/targets/mips-linux-user.mak b/default-configs/targets/mips-linux-user.m=
ak<br>&gt; new file mode 100644<br>&gt; index 0000000000..bcfff16a7b<br>&gt=
; --- /dev/null<br>&gt; +++ b/default-configs/targets/mips-linux-user.mak<b=
r>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_ABI_MIPSO32=3Dy<br>&gt; +TARGET_MIPS=
=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3Dmips<br>&gt=
; +TARGET_SYSTBL_ABI=3Do32<br>&gt; +TARGET_SYSTBL=3Dsyscall_o32.tbl<br>&gt;=
 +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff =
--git a/default-configs/targets/mips-softmmu.mak b/default-configs/targets/=
mips-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..8ab=
9ff2ac9<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/mips-so=
ftmmu.mak<br>&gt; @@ -0,0 +1,9 @@<br>&gt; +TARGET_ABI_MIPSO32=3Dy<br>&gt; +=
TARGET_MIPS=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3D=
mips<br>&gt; +TARGET_SYSTBL_ABI=3Do32<br>&gt; +TARGET_SYSTBL=3Dsyscall_o32.=
tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br=
>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; diff --git a/default-configs/targe=
ts/mips64-linux-user.mak b/default-configs/targets/mips64-linux-user.mak<br=
>&gt; new file mode 100644<br>&gt; index 0000000000..c02c5460a7<br>&gt; ---=
 /dev/null<br>&gt; +++ b/default-configs/targets/mips64-linux-user.mak<br>&=
gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_ABI_MIPSN64=3Dy<br>&gt; +TARGET_MIPS64=
=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3Dmips64<br>&=
gt; +TARGET_SYSTBL_ABI=3Dn64<br>&gt; +TARGET_SYSTBL=3Dsyscall_n64.tbl<br>&g=
t; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; dif=
f --git a/default-configs/targets/mips64-softmmu.mak b/default-configs/targ=
ets/mips64-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 000000000=
0..c02c5460a7<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/m=
ips64-softmmu.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_ABI_MIPSN64=3Dy<b=
r>&gt; +TARGET_MIPS64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_=
ABI_DIR=3Dmips64<br>&gt; +TARGET_SYSTBL_ABI=3Dn64<br>&gt; +TARGET_SYSTBL=3D=
syscall_n64.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGE=
NDIAN=3Dy<br>&gt; diff --git a/default-configs/targets/mips64el-linux-user.=
mak b/default-configs/targets/mips64el-linux-user.mak<br>&gt; new file mode=
 100644<br>&gt; index 0000000000..8cbbc38e78<br>&gt; --- /dev/null<br>&gt; =
+++ b/default-configs/targets/mips64el-linux-user.mak<br>&gt; @@ -0,0 +1,7 =
@@<br>&gt; +TARGET_ABI_MIPSN64=3Dy<br>&gt; +TARGET_MIPS64=3Dy<br>&gt; +TARG=
ET_BASE_ARCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3Dmips64<br>&gt; +TARGET_SYSTBL=
_ABI=3Dn64<br>&gt; +TARGET_SYSTBL=3Dsyscall_n64.tbl<br>&gt; +TARGET_ALIGNED=
_ONLY=3Dy<br>&gt; diff --git a/default-configs/targets/mips64el-softmmu.mak=
 b/default-configs/targets/mips64el-softmmu.mak<br>&gt; new file mode 10064=
4<br>&gt; index 0000000000..8cbbc38e78<br>&gt; --- /dev/null<br>&gt; +++ b/=
default-configs/targets/mips64el-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt=
; +TARGET_ABI_MIPSN64=3Dy<br>&gt; +TARGET_MIPS64=3Dy<br>&gt; +TARGET_BASE_A=
RCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3Dmips64<br>&gt; +TARGET_SYSTBL_ABI=3Dn6=
4<br>&gt; +TARGET_SYSTBL=3Dsyscall_n64.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy=
<br>&gt; diff --git a/default-configs/targets/mipsel-linux-user.mak b/defau=
lt-configs/targets/mipsel-linux-user.mak<br>&gt; new file mode 100644<br>&g=
t; index 0000000000..26aa9c8279<br>&gt; --- /dev/null<br>&gt; +++ b/default=
-configs/targets/mipsel-linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TAR=
GET_ABI_MIPSO32=3Dy<br>&gt; +TARGET_MIPS=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmi=
ps<br>&gt; +TARGET_ABI_DIR=3Dmips<br>&gt; +TARGET_SYSTBL_ABI=3Do32<br>&gt; =
+TARGET_SYSTBL=3Dsyscall_o32.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; d=
iff --git a/default-configs/targets/mipsel-softmmu.mak b/default-configs/ta=
rgets/mipsel-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000=
000..afa0851887<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets=
/mipsel-softmmu.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_ABI_MIPSO32=3Dy=
<br>&gt; +TARGET_MIPS=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_=
ABI_DIR=3Dmips<br>&gt; +TARGET_SYSTBL_ABI=3Do32<br>&gt; +TARGET_SYSTBL=3Dsy=
scall_o32.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_SUPPORTS_MTT=
CG=3Dy<br>&gt; diff --git a/default-configs/targets/mipsn32-linux-user.mak =
b/default-configs/targets/mipsn32-linux-user.mak<br>&gt; new file mode 1006=
44<br>&gt; index 0000000000..81d548e699<br>&gt; --- /dev/null<br>&gt; +++ b=
/default-configs/targets/mipsn32-linux-user.mak<br>&gt; @@ -0,0 +1,9 @@<br>=
&gt; +TARGET_ABI_MIPSN32=3Dy<br>&gt; +TARGET_ABI32=3Dy<br>&gt; +TARGET_MIPS=
64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3Dmips64<br=
>&gt; +TARGET_SYSTBL_ABI=3Dn32<br>&gt; +TARGET_SYSTBL=3Dsyscall_n32.tbl<br>=
&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; d=
iff --git a/default-configs/targets/mipsn32el-linux-user.mak b/default-conf=
igs/targets/mipsn32el-linux-user.mak<br>&gt; new file mode 100644<br>&gt; i=
ndex 0000000000..6de47f2a79<br>&gt; --- /dev/null<br>&gt; +++ b/default-con=
figs/targets/mipsn32el-linux-user.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARG=
ET_ABI_MIPSN32=3Dy<br>&gt; +TARGET_ABI32=3Dy<br>&gt; +TARGET_MIPS64=3Dy<br>=
&gt; +TARGET_BASE_ARCH=3Dmips<br>&gt; +TARGET_ABI_DIR=3Dmips64<br>&gt; +TAR=
GET_SYSTBL_ABI=3Dn32<br>&gt; +TARGET_SYSTBL=3Dsyscall_n32.tbl<br>&gt; +TARG=
ET_ALIGNED_ONLY=3Dy<br>&gt; diff --git a/default-configs/targets/moxie-soft=
mmu.mak b/default-configs/targets/moxie-softmmu.mak<br>&gt; new file mode 1=
00644<br>&gt; index 0000000000..da093f5b36<br>&gt; --- /dev/null<br>&gt; ++=
+ b/default-configs/targets/moxie-softmmu.mak<br>&gt; @@ -0,0 +1,4 @@<br>&g=
t; +TARGET_MOXIE=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dmoxie<br>&gt; +TARGET_ABI_=
DIR=3Dmoxie<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git a/defaul=
t-configs/targets/nios2-linux-user.mak b/default-configs/targets/nios2-linu=
x-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..a2308a16a=
a<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/nios2-linux-u=
ser.mak<br>&gt; @@ -0,0 +1,3 @@<br>&gt; +TARGET_NIOS2=3Dy<br>&gt; +TARGET_B=
ASE_ARCH=3Dnios2<br>&gt; +TARGET_ABI_DIR=3Dnios2<br>&gt; diff --git a/defau=
lt-configs/targets/nios2-softmmu.mak b/default-configs/targets/nios2-softmm=
u.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..a2308a16aa<br>=
&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/nios2-softmmu.mak<=
br>&gt; @@ -0,0 +1,3 @@<br>&gt; +TARGET_NIOS2=3Dy<br>&gt; +TARGET_BASE_ARCH=
=3Dnios2<br>&gt; +TARGET_ABI_DIR=3Dnios2<br>&gt; diff --git a/default-confi=
gs/targets/or1k-linux-user.mak b/default-configs/targets/or1k-linux-user.ma=
k<br>&gt; new file mode 100644<br>&gt; index 0000000000..2f5ff844df<br>&gt;=
 --- /dev/null<br>&gt; +++ b/default-configs/targets/or1k-linux-user.mak<br=
>&gt; @@ -0,0 +1,4 @@<br>&gt; +TARGET_OPENRISC=3Dy<br>&gt; +TARGET_BASE_ARC=
H=3Dopenrisc<br>&gt; +TARGET_ABI_DIR=3Dopenrisc<br>&gt; +TARGET_WORDS_BIGEN=
DIAN=3Dy<br>&gt; diff --git a/default-configs/targets/or1k-softmmu.mak b/de=
fault-configs/targets/or1k-softmmu.mak<br>&gt; new file mode 100644<br>&gt;=
 index 0000000000..2f5ff844df<br>&gt; --- /dev/null<br>&gt; +++ b/default-c=
onfigs/targets/or1k-softmmu.mak<br>&gt; @@ -0,0 +1,4 @@<br>&gt; +TARGET_OPE=
NRISC=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dopenrisc<br>&gt; +TARGET_ABI_DIR=3Dop=
enrisc<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git a/default-con=
figs/targets/ppc-linux-user.mak b/default-configs/targets/ppc-linux-user.ma=
k<br>&gt; new file mode 100644<br>&gt; index 0000000000..c4d912bfb1<br>&gt;=
 --- /dev/null<br>&gt; +++ b/default-configs/targets/ppc-linux-user.mak<br>=
&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_PPC=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dpp=
c<br>&gt; +TARGET_ABI_DIR=3Dppc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,nospu,3=
2<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<=
br>&gt; +TARGET_XML_FILES=3D gdb-xml/power-core.xml gdb-xml/power-fpu.xml g=
db-xml/power-altivec.xml gdb-xml/power-spe.xml<br>&gt; diff --git a/default=
-configs/targets/ppc-softmmu.mak b/default-configs/targets/ppc-softmmu.mak<=
br>&gt; new file mode 100644<br>&gt; index 0000000000..c4d912bfb1<br>&gt; -=
-- /dev/null<br>&gt; +++ b/default-configs/targets/ppc-softmmu.mak<br>&gt; =
@@ -0,0 +1,7 @@<br>&gt; +TARGET_PPC=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dppc<br>=
&gt; +TARGET_ABI_DIR=3Dppc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,nospu,32<br>=
&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&g=
t; +TARGET_XML_FILES=3D gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xm=
l/power-altivec.xml gdb-xml/power-spe.xml<br>&gt; diff --git a/default-conf=
igs/targets/ppc64-linux-user.mak b/default-configs/targets/ppc64-linux-user=
.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..7f96ab7e9d<br>&=
gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/ppc64-linux-user.ma=
k<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_PPC64=3Dy<br>&gt; +TARGET_BASE_AR=
CH=3Dppc<br>&gt; +TARGET_ABI_DIR=3Dppc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,=
nospu,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDI=
AN=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-=
fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.x=
ml<br>&gt; diff --git a/default-configs/targets/ppc64-softmmu.mak b/default=
-configs/targets/ppc64-softmmu.mak<br>&gt; new file mode 100644<br>&gt; ind=
ex 0000000000..a73211918a<br>&gt; --- /dev/null<br>&gt; +++ b/default-confi=
gs/targets/ppc64-softmmu.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_PPC64=
=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dppc<br>&gt; +TARGET_ABI_DIR=3Dppc<br>&gt; =
+TARGET_SYSTBL_ABI=3Dcommon,nospu,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<b=
r>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&g=
t; +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-=
xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml<br>&gt; d=
iff --git a/default-configs/targets/ppc64abi32-linux-user.mak b/default-con=
figs/targets/ppc64abi32-linux-user.mak<br>&gt; new file mode 100644<br>&gt;=
 index 0000000000..13a02700aa<br>&gt; --- /dev/null<br>&gt; +++ b/default-c=
onfigs/targets/ppc64abi32-linux-user.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +T=
ARGET_ABI32=3Dy<br>&gt; +TARGET_PPC64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dppc<b=
r>&gt; +TARGET_ABI_DIR=3Dppc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,nospu,32<b=
r>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>=
&gt; +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gd=
b-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml<br>&gt;=
 diff --git a/default-configs/targets/ppc64le-linux-user.mak b/default-conf=
igs/targets/ppc64le-linux-user.mak<br>&gt; new file mode 100644<br>&gt; ind=
ex 0000000000..3dd54b894c<br>&gt; --- /dev/null<br>&gt; +++ b/default-confi=
gs/targets/ppc64le-linux-user.mak<br>&gt; @@ -0,0 +1,6 @@<br>&gt; +TARGET_P=
PC64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dppc<br>&gt; +TARGET_ABI_DIR=3Dppc<br>&=
gt; +TARGET_SYSTBL_ABI=3Dcommon,nospu,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.t=
bl<br>&gt; +TARGET_XML_FILES=3D gdb-xml/power64-core.xml gdb-xml/power-fpu.=
xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml<b=
r>&gt; diff --git a/default-configs/targets/riscv32-linux-user.mak b/defaul=
t-configs/targets/riscv32-linux-user.mak<br>&gt; new file mode 100644<br>&g=
t; index 0000000000..91d72a46b0<br>&gt; --- /dev/null<br>&gt; +++ b/default=
-configs/targets/riscv32-linux-user.mak<br>&gt; @@ -0,0 +1,4 @@<br>&gt; +TA=
RGET_RISCV32=3Dy<br>&gt; +TARGET_BASE_ARCH=3Driscv<br>&gt; +TARGET_ABI_DIR=
=3Driscv<br>&gt; +TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/r=
iscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml =
gdb-xml/riscv-32bit-virtual.xml<br>&gt; diff --git a/default-configs/target=
s/riscv32-softmmu.mak b/default-configs/targets/riscv32-softmmu.mak<br>&gt;=
 new file mode 100644<br>&gt; index 0000000000..35e5b2fb85<br>&gt; --- /dev=
/null<br>&gt; +++ b/default-configs/targets/riscv32-softmmu.mak<br>&gt; @@ =
-0,0 +1,5 @@<br>&gt; +TARGET_RISCV32=3Dy<br>&gt; +TARGET_BASE_ARCH=3Driscv<=
br>&gt; +TARGET_ABI_DIR=3Driscv<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; =
+TARGET_XML_FILES=3D gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xm=
l gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-csr.xml gdb-xml/riscv-32b=
it-virtual.xml<br>&gt; diff --git a/default-configs/targets/riscv64-linux-u=
ser.mak b/default-configs/targets/riscv64-linux-user.mak<br>&gt; new file m=
ode 100644<br>&gt; index 0000000000..9e53193cdb<br>&gt; --- /dev/null<br>&g=
t; +++ b/default-configs/targets/riscv64-linux-user.mak<br>&gt; @@ -0,0 +1,=
4 @@<br>&gt; +TARGET_RISCV64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Driscv<br>&gt; =
+TARGET_ABI_DIR=3Driscv<br>&gt; +TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cp=
u.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv=
-64bit-csr.xml gdb-xml/riscv-64bit-virtual.xml<br>&gt; diff --git a/default=
-configs/targets/riscv64-softmmu.mak b/default-configs/targets/riscv64-soft=
mmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..4b9a61cd8f<b=
r>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/riscv64-softmmu.=
mak<br>&gt; @@ -0,0 +1,5 @@<br>&gt; +TARGET_RISCV64=3Dy<br>&gt; +TARGET_BAS=
E_ARCH=3Driscv<br>&gt; +TARGET_ABI_DIR=3Driscv<br>&gt; +TARGET_SUPPORTS_MTT=
CG=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/ris=
cv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-csr.xml gd=
b-xml/riscv-64bit-virtual.xml<br>&gt; diff --git a/default-configs/targets/=
rx-softmmu.mak b/default-configs/targets/rx-softmmu.mak<br>&gt; new file mo=
de 100644<br>&gt; index 0000000000..52a8c0df10<br>&gt; --- /dev/null<br>&gt=
; +++ b/default-configs/targets/rx-softmmu.mak<br>&gt; @@ -0,0 +1,4 @@<br>&=
gt; +TARGET_RX=3Dy<br>&gt; +TARGET_BASE_ARCH=3Drx<br>&gt; +TARGET_ABI_DIR=
=3Drx<br>&gt; +TARGET_XML_FILES=3D gdb-xml/rx-core.xml<br>&gt; diff --git a=
/default-configs/targets/s390x-linux-user.mak b/default-configs/targets/s39=
0x-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..77=
ebec769f<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/s390x-=
linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_S390X=3Dy<br>&gt; +T=
ARGET_BASE_ARCH=3Ds390x<br>&gt; +TARGET_ABI_DIR=3Ds390x<br>&gt; +TARGET_SYS=
TBL_ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WO=
RDS_BIGENDIAN=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/s390x-core64.xml gdb=
-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.=
xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml<br>&gt; diff --git a/default-=
configs/targets/s390x-softmmu.mak b/default-configs/targets/s390x-softmmu.m=
ak<br>&gt; new file mode 100644<br>&gt; index 0000000000..f2a80d3208<br>&gt=
; --- /dev/null<br>&gt; +++ b/default-configs/targets/s390x-softmmu.mak<br>=
&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_S390X=3Dy<br>&gt; +TARGET_BASE_ARCH=3D=
s390x<br>&gt; +TARGET_ABI_DIR=3Ds390x<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,6=
4<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<=
br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/s39=
0x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml=
 gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-gs.xml<br>&gt; diff=
 --git a/default-configs/targets/sh4-linux-user.mak b/default-configs/targe=
ts/sh4-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000=
..4292dd6128<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/sh=
4-linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_SH4=3Dy<br>&gt; +T=
ARGET_BASE_ARCH=3Dsh4<br>&gt; +TARGET_ABI_DIR=3Dsh4<br>&gt; +TARGET_SYSTBL_=
ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_O=
NLY=3Dy<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff --git a/default-configs/t=
argets/sh4-softmmu.mak b/default-configs/targets/sh4-softmmu.mak<br>&gt; ne=
w file mode 100644<br>&gt; index 0000000000..e46bf0e278<br>&gt; --- /dev/nu=
ll<br>&gt; +++ b/default-configs/targets/sh4-softmmu.mak<br>&gt; @@ -0,0 +1=
,6 @@<br>&gt; +TARGET_SH4=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dsh4<br>&gt; +TARG=
ET_ABI_DIR=3Dsh4<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=
=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; diff --git a/defaul=
t-configs/targets/sh4eb-linux-user.mak b/default-configs/targets/sh4eb-linu=
x-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..cf9178f4e=
a<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/sh4eb-linux-u=
ser.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_SH4=3Dy<br>&gt; +TARGET_BAS=
E_ARCH=3Dsh4<br>&gt; +TARGET_ABI_DIR=3Dsh4<br>&gt; +TARGET_SYSTBL_ABI=3Dcom=
mon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<b=
r>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; dif=
f --git a/default-configs/targets/sh4eb-softmmu.mak b/default-configs/targe=
ts/sh4eb-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000.=
.db4140ec32<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/sh4=
eb-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_SH4=3Dy<br>&gt; +TAR=
GET_BASE_ARCH=3Dsh4<br>&gt; +TARGET_ABI_DIR=3Dsh4<br>&gt; +TARGET_SYSTBL_AB=
I=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_ONL=
Y=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git a/default-conf=
igs/targets/sparc-bsd-user.mak b/default-configs/targets/sparc-bsd-user.mak=
<br>&gt; new file mode 100644<br>&gt; index 0000000000..7f2fcba978<br>&gt; =
--- /dev/null<br>&gt; +++ b/default-configs/targets/sparc-bsd-user.mak<br>&=
gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_SPARC=3Dy<br>&gt; +TARGET_BASE_ARCH=3Ds=
parc<br>&gt; +TARGET_ABI_DIR=3Dsparc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,32=
<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&=
gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git a/default-configs/target=
s/sparc-linux-user.mak b/default-configs/targets/sparc-linux-user.mak<br>&g=
t; new file mode 100644<br>&gt; index 0000000000..7f2fcba978<br>&gt; --- /d=
ev/null<br>&gt; +++ b/default-configs/targets/sparc-linux-user.mak<br>&gt; =
@@ -0,0 +1,7 @@<br>&gt; +TARGET_SPARC=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dsparc=
<br>&gt; +TARGET_ABI_DIR=3Dsparc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,32<br>=
&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; =
+TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git a/default-configs/targets/sp=
arc-softmmu.mak b/default-configs/targets/sparc-softmmu.mak<br>&gt; new fil=
e mode 100644<br>&gt; index 0000000000..7f2fcba978<br>&gt; --- /dev/null<br=
>&gt; +++ b/default-configs/targets/sparc-softmmu.mak<br>&gt; @@ -0,0 +1,7 =
@@<br>&gt; +TARGET_SPARC=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dsparc<br>&gt; +TAR=
GET_ABI_DIR=3Dsparc<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,32<br>&gt; +TARGET_=
SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS=
_BIGENDIAN=3Dy<br>&gt; diff --git a/default-configs/targets/sparc32plus-lin=
ux-user.mak b/default-configs/targets/sparc32plus-linux-user.mak<br>&gt; ne=
w file mode 100644<br>&gt; index 0000000000..f5fcb7879e<br>&gt; --- /dev/nu=
ll<br>&gt; +++ b/default-configs/targets/sparc32plus-linux-user.mak<br>&gt;=
 @@ -0,0 +1,8 @@<br>&gt; +TARGET_ABI32=3Dy<br>&gt; +TARGET_SPARC64=3Dy<br>&=
gt; +TARGET_BASE_ARCH=3Dsparc<br>&gt; +TARGET_ABI_DIR=3Dsparc<br>&gt; +TARG=
ET_SYSTBL_ABI=3Dcommon,32<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TAR=
GET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git=
 a/default-configs/targets/sparc64-bsd-user.mak b/default-configs/targets/s=
parc64-bsd-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..=
817529e587<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/spar=
c64-bsd-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_SPARC64=3Dy<br>&gt=
; +TARGET_BASE_ARCH=3Dsparc<br>&gt; +TARGET_ABI_DIR=3Dsparc64<br>&gt; +TARG=
ET_SYSTBL_ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TAR=
GET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --git=
 a/default-configs/targets/sparc64-linux-user.mak b/default-configs/targets=
/sparc64-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 00000000=
00..817529e587<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/=
sparc64-linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_SPARC64=3Dy<=
br>&gt; +TARGET_BASE_ARCH=3Dsparc<br>&gt; +TARGET_ABI_DIR=3Dsparc64<br>&gt;=
 +TARGET_SYSTBL_ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt=
; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff=
 --git a/default-configs/targets/sparc64-softmmu.mak b/default-configs/targ=
ets/sparc64-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 00000000=
00..817529e587<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/=
sparc64-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_SPARC64=3Dy<br>=
&gt; +TARGET_BASE_ARCH=3Dsparc<br>&gt; +TARGET_ABI_DIR=3Dsparc64<br>&gt; +T=
ARGET_SYSTBL_ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +=
TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; diff --=
git a/default-configs/targets/tilegx-linux-user.mak b/default-configs/targe=
ts/tilegx-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000=
000..064d3320d7<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets=
/tilegx-linux-user.mak<br>&gt; @@ -0,0 +1,3 @@<br>&gt; +TARGET_TILEGX=3Dy<b=
r>&gt; +TARGET_BASE_ARCH=3Dtilegx<br>&gt; +TARGET_ABI_DIR=3Dtilegx<br>&gt; =
diff --git a/default-configs/targets/tricore-softmmu.mak b/default-configs/=
targets/tricore-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000=
000000..356e5d8669<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targ=
ets/tricore-softmmu.mak<br>&gt; @@ -0,0 +1,3 @@<br>&gt; +TARGET_TRICORE=3Dy=
<br>&gt; +TARGET_BASE_ARCH=3Dtricore<br>&gt; +TARGET_ABI_DIR=3Dtricore<br>&=
gt; diff --git a/default-configs/targets/unicore32-softmmu.mak b/default-co=
nfigs/targets/unicore32-softmmu.mak<br>&gt; new file mode 100644<br>&gt; in=
dex 0000000000..d8c7860ac1<br>&gt; --- /dev/null<br>&gt; +++ b/default-conf=
igs/targets/unicore32-softmmu.mak<br>&gt; @@ -0,0 +1,3 @@<br>&gt; +TARGET_U=
NICORE32=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dunicore32<br>&gt; +TARGET_ABI_DIR=
=3Dunicore32<br>&gt; diff --git a/default-configs/targets/x86_64-bsd-user.m=
ak b/default-configs/targets/x86_64-bsd-user.mak<br>&gt; new file mode 1006=
44<br>&gt; index 0000000000..6a9418f9ff<br>&gt; --- /dev/null<br>&gt; +++ b=
/default-configs/targets/x86_64-bsd-user.mak<br>&gt; @@ -0,0 +1,6 @@<br>&gt=
; +TARGET_X86_64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Di386<br>&gt; +TARGET_ABI_D=
IR=3Dx86_64<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=
=3Dsyscall_64.tbl<br>&gt; +TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml<br>&g=
t; diff --git a/default-configs/targets/x86_64-linux-user.mak b/default-con=
figs/targets/x86_64-linux-user.mak<br>&gt; new file mode 100644<br>&gt; ind=
ex 0000000000..6a9418f9ff<br>&gt; --- /dev/null<br>&gt; +++ b/default-confi=
gs/targets/x86_64-linux-user.mak<br>&gt; @@ -0,0 +1,6 @@<br>&gt; +TARGET_X8=
6_64=3Dy<br>&gt; +TARGET_BASE_ARCH=3Di386<br>&gt; +TARGET_ABI_DIR=3Dx86_64<=
br>&gt; +TARGET_SYSTBL_ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=3Dsyscall_64.=
tbl<br>&gt; +TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml<br>&gt; diff --git =
a/default-configs/targets/x86_64-softmmu.mak b/default-configs/targets/x86_=
64-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..8b56e=
6e6da<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/x86_64-so=
ftmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_X86_64=3Dy<br>&gt; +TARGE=
T_BASE_ARCH=3Di386<br>&gt; +TARGET_ABI_DIR=3Dx86_64<br>&gt; +TARGET_SYSTBL_=
ABI=3Dcommon,64<br>&gt; +TARGET_SYSTBL=3Dsyscall_64.tbl<br>&gt; +TARGET_SUP=
PORTS_MTTCG=3Dy<br>&gt; +TARGET_XML_FILES=3D gdb-xml/i386-64bit.xml<br>&gt;=
 diff --git a/default-configs/targets/xtensa-linux-user.mak b/default-confi=
gs/targets/xtensa-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index=
 0000000000..63d9cff69f<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs=
/targets/xtensa-linux-user.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_XTEN=
SA=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dxtensa<br>&gt; +TARGET_ABI_DIR=3Dxtensa<=
br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br=
>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_HAS_BFLT=3Dy<br>&gt; diff --=
git a/default-configs/targets/xtensa-softmmu.mak b/default-configs/targets/=
xtensa-softmmu.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..2=
166f97738<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/xtens=
a-softmmu.mak<br>&gt; @@ -0,0 +1,7 @@<br>&gt; +TARGET_XTENSA=3Dy<br>&gt; +T=
ARGET_BASE_ARCH=3Dxtensa<br>&gt; +TARGET_ABI_DIR=3Dxtensa<br>&gt; +TARGET_S=
YSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET_ALI=
GNED_ONLY=3Dy<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; diff --git a/defau=
lt-configs/targets/xtensaeb-linux-user.mak b/default-configs/targets/xtensa=
eb-linux-user.mak<br>&gt; new file mode 100644<br>&gt; index 0000000000..e6=
6b7dd0e3<br>&gt; --- /dev/null<br>&gt; +++ b/default-configs/targets/xtensa=
eb-linux-user.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; +TARGET_XTENSA=3Dy<br>&gt=
; +TARGET_BASE_ARCH=3Dxtensa<br>&gt; +TARGET_ABI_DIR=3Dxtensa<br>&gt; +TARG=
ET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsyscall.tbl<br>&gt; +TARGET=
_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=3Dy<br>&gt; +TARGET_HAS_B=
FLT=3Dy<br>&gt; diff --git a/default-configs/targets/xtensaeb-softmmu.mak b=
/default-configs/targets/xtensaeb-softmmu.mak<br>&gt; new file mode 100644<=
br>&gt; index 0000000000..2372d22492<br>&gt; --- /dev/null<br>&gt; +++ b/de=
fault-configs/targets/xtensaeb-softmmu.mak<br>&gt; @@ -0,0 +1,8 @@<br>&gt; =
+TARGET_XTENSA=3Dy<br>&gt; +TARGET_BASE_ARCH=3Dxtensa<br>&gt; +TARGET_ABI_D=
IR=3Dxtensa<br>&gt; +TARGET_SYSTBL_ABI=3Dcommon<br>&gt; +TARGET_SYSTBL=3Dsy=
scall.tbl<br>&gt; +TARGET_ALIGNED_ONLY=3Dy<br>&gt; +TARGET_WORDS_BIGENDIAN=
=3Dy<br>&gt; +TARGET_SUPPORTS_MTTCG=3Dy<br>&gt; diff --git a/meson.build b/=
meson.build<br>&gt; index 6863b9febf..5ddaf16b88 100644<br>&gt; --- a/meson=
.build<br>&gt; +++ b/meson.build<br>&gt; @@ -722,13 +722,25 @@ kconfig_exte=
rnal_symbols =3D [<br>&gt; =C2=A0]<br>&gt; =C2=A0ignored =3D [&#39;TARGET_X=
ML_FILES&#39;, &#39;TARGET_ABI_DIR&#39;, &#39;TARGET_DIRS&#39;]<br>&gt;<br>=
&gt; +default_targets =3D &#39;CONFIG_DEFAULT_TARGETS&#39; in config_host<b=
r>&gt; +actual_target_dirs =3D []<br>&gt; =C2=A0foreach target : target_dir=
s<br>&gt; =C2=A0 =C2=A0config_target =3D { &#39;TARGET_NAME&#39;: target.sp=
lit(&#39;-&#39;)[0] }<br>&gt; =C2=A0 =C2=A0if target.endswith(&#39;linux-us=
er&#39;)<br>&gt; - =C2=A0 =C2=A0assert(targetos =3D=3D &#39;linux&#39;)<br>=
&gt; + =C2=A0 =C2=A0if targetos !=3D &#39;linux&#39;<br>&gt; + =C2=A0 =C2=
=A0 =C2=A0if default_targets<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0continue<=
br>&gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; + =C2=A0 =C2=A0 =C2=A0error(&#3=
9;Target @0@ is only available on a Linux host&#39;.format(target))<br>&gt;=
 + =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=A0 =C2=A0config_target +=3D { &#39=
;CONFIG_LINUX_USER&#39;: &#39;y&#39; }<br>&gt; =C2=A0 =C2=A0elif target.end=
swith(&#39;bsd-user&#39;)<br>&gt; - =C2=A0 =C2=A0assert(&#39;CONFIG_BSD&#39=
; in config_host)<br>&gt; + =C2=A0 =C2=A0if not &#39;CONFIG_BSD&#39; in con=
fig_host<br>&gt; + =C2=A0 =C2=A0 =C2=A0if default_targets<br>&gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0continue<br>&gt; + =C2=A0 =C2=A0 =C2=A0endif<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0error(&#39;Target @0@ is only available on a BSD host&#=
39;.format(target))<br>&gt; + =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=A0 =C2=
=A0config_target +=3D { &#39;CONFIG_BSD_USER&#39;: &#39;y&#39; }<br>&gt; =
=C2=A0 =C2=A0elif target.endswith(&#39;softmmu&#39;)<br>&gt; =C2=A0 =C2=A0 =
=C2=A0config_target +=3D { &#39;CONFIG_SOFTMMU&#39;: &#39;y&#39; }<br>&gt; =
@@ -752,8 +764,14 @@ foreach target : target_dirs<br>&gt; =C2=A0 =C2=A0 =C2=
=A0endif<br>&gt; =C2=A0 =C2=A0 =C2=A0have_accel =3D true<br>&gt; =C2=A0 =C2=
=A0endforeach<br>&gt; - =C2=A0assert(have_accel)<br>&gt; + =C2=A0if not hav=
e_accel<br>&gt; + =C2=A0 =C2=A0if default_targets<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0continue<br>&gt; + =C2=A0 =C2=A0endif<br>&gt; + =C2=A0 =C2=A0error(&#=
39;No accelerator available for target @0@&#39;.format(target))<br>&gt; + =
=C2=A0endif<br>&gt;<br>&gt; + =C2=A0actual_target_dirs +=3D target<br>&gt; =
=C2=A0 =C2=A0config_target +=3D keyval.load(&#39;default-configs/targets&#3=
9; / target + &#39;.mak&#39;)<br>&gt;<br>&gt; =C2=A0 =C2=A0foreach k, v: di=
sassemblers<br>&gt; @@ -815,6 +833,7 @@ foreach target : target_dirs<br>&gt=
; =C2=A0 =C2=A0endif<br>&gt; =C2=A0 =C2=A0config_target_mak +=3D {target: c=
onfig_target}<br>&gt; =C2=A0endforeach<br>&gt; +target_dirs =3D actual_targ=
et_dirs<br>&gt;<br>&gt; =C2=A0# This configuration is used to build files t=
hat are shared by<br>&gt; =C2=A0# multiple binaries, and then extracted out=
 of the &quot;common&quot;<br>&gt; @@ -1600,7 +1619,7 @@ if config_host.has=
_key(&#39;CONFIG_MODULES&#39;)<br>&gt; =C2=A0endif<br>&gt; =C2=A0summary_in=
fo +=3D {&#39;host CPU&#39;: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu}<br>&gt;=
 =C2=A0summary_info +=3D {&#39;host endianness&#39;: =C2=A0 build_machine.e=
ndian()}<br>&gt; -summary_info +=3D {&#39;target list&#39;: =C2=A0 =C2=A0 =
=C2=A0 config_host[&#39;TARGET_DIRS&#39;]}<br>&gt; +summary_info +=3D {&#39=
;target list&#39;: =C2=A0 =C2=A0 =C2=A0 &#39; &#39;.join(target_dirs)}<br>&=
gt; =C2=A0summary_info +=3D {&#39;gprof enabled&#39;: =C2=A0 =C2=A0 config_=
host.has_key(&#39;CONFIG_GPROF&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39=
;sparse enabled&#39;: =C2=A0 =C2=A0meson.get_compiler(&#39;c&#39;).cmd_arra=
y().contains(&#39;cgcc&#39;)}<br>&gt; =C2=A0summary_info +=3D {&#39;strip b=
inaries&#39;: =C2=A0 =C2=A0get_option(&#39;strip&#39;)}<br>&gt; --<br>&gt; =
2.26.2<br>&gt;<br>&gt;<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yo=
urs<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000abf8d405afbe7f2c--

