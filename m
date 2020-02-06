Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9BDC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C278B20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 23:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C278B20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisible.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izqdH-0005OO-TR
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 18:32:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jmcneill@invisible.ca>) id 1izoMV-0002al-0J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jmcneill@invisible.ca>) id 1izoMT-0000z7-Ee
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:06:58 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jmcneill@invisible.ca>)
 id 1izoMT-0000s1-56
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:06:57 -0500
X-Originating-IP: 159.2.138.7
Received: from performa.invisible.ca
 (stjhnbsu6iw-159-2-138-7.dhcp-dynamic.fibreop.nb.bellaliant.net
 [159.2.138.7]) (Authenticated sender: jmcneill@invisible.ca)
 by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3445660007;
 Thu,  6 Feb 2020 21:06:51 +0000 (UTC)
Date: Thu, 6 Feb 2020 17:06:49 -0400 (AST)
From: Jared McNeill <jmcneill@invisible.ca>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH v3 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
In-Reply-To: <20200206115731.13552-3-n54@gmx.com>
Message-ID: <alpine.NEB.2.21.2002061706410.671@performa.invisible.ca>
References: <20200128140945.929-1-n54@gmx.com>
 <20200206115731.13552-1-n54@gmx.com> <20200206115731.13552-3-n54@gmx.com>
User-Agent: Alpine 2.21 (NEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-271522811-1581023215=:671"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.70.183.195
X-Mailman-Approved-At: Thu, 06 Feb 2020 18:31:31 -0500
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 Kamil Rytarowski <krytarowski@gmail.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com, max@m00nbsd.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-271522811-1581023215=:671
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Tested-by: Jared McNeill <jmcneill@invisible.ca>

On Thu, 6 Feb 2020, Kamil Rytarowski wrote:

> From: Maxime Villard <max@m00nbsd.net>
>
> Introduces the configure support for the new NetBSD Virtual Machine Monitor that
> allows for hypervisor acceleration from usermode components on the NetBSD
> platform.
>
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> configure       | 37 +++++++++++++++++++++++++++++++++++++
> qemu-options.hx | 16 ++++++++--------
> 2 files changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/configure b/configure
> index 115dc38085..d4a837cf9d 100755
> --- a/configure
> +++ b/configure
> @@ -241,6 +241,17 @@ supported_whpx_target() {
>     return 1
> }
>
> +supported_nvmm_target() {
> +    test "$nvmm" = "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}" in
> +        i386|x86_64)
> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}
> +
> supported_target() {
>     case "$1" in
>         *-softmmu)
> @@ -268,6 +279,7 @@ supported_target() {
>     supported_hax_target "$1" && return 0
>     supported_hvf_target "$1" && return 0
>     supported_whpx_target "$1" && return 0
> +    supported_nvmm_target "$1" && return 0
>     print_error "TCG disabled, but hardware accelerator not available for '$target'"
>     return 1
> }
> @@ -388,6 +400,7 @@ kvm="no"
> hax="no"
> hvf="no"
> whpx="no"
> +nvmm="no"
> rdma=""
> pvrdma=""
> gprof="no"
> @@ -823,6 +836,7 @@ DragonFly)
> NetBSD)
>   bsd="yes"
>   hax="yes"
> +  nvmm="yes"
>   make="${MAKE-gmake}"
>   audio_drv_list="oss try-sdl"
>   audio_possible_drivers="oss sdl"
> @@ -1169,6 +1183,10 @@ for opt do
>   ;;
>   --enable-whpx) whpx="yes"
>   ;;
> +  --disable-nvmm) nvmm="no"
> +  ;;
> +  --enable-nvmm) nvmm="yes"
> +  ;;
>   --disable-tcg-interpreter) tcg_interpreter="no"
>   ;;
>   --enable-tcg-interpreter) tcg_interpreter="yes"
> @@ -1773,6 +1791,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>   hax             HAX acceleration support
>   hvf             Hypervisor.framework acceleration support
>   whpx            Windows Hypervisor Platform acceleration support
> +  nvmm            NetBSD Virtual Machine Monitor acceleration support
>   rdma            Enable RDMA-based migration
>   pvrdma          Enable PVRDMA support
>   vde             support for vde network
> @@ -2764,6 +2783,20 @@ if test "$whpx" != "no" ; then
>     fi
> fi
>
> +##########################################
> +# NetBSD Virtual Machine Monitor (NVMM) accelerator check
> +if test "$nvmm" != "no" ; then
> +    if check_include "nvmm.h" ; then
> +        nvmm="yes"
> +	LIBS="-lnvmm $LIBS"
> +    else
> +        if test "$nvmm" = "yes"; then
> +            feature_not_found "NVMM" "NVMM is not available"
> +        fi
> +        nvmm="no"
> +    fi
> +fi
> +
> ##########################################
> # Sparse probe
> if test "$sparse" != "no" ; then
> @@ -6543,6 +6576,7 @@ echo "KVM support       $kvm"
> echo "HAX support       $hax"
> echo "HVF support       $hvf"
> echo "WHPX support      $whpx"
> +echo "NVMM support      $nvmm"
> echo "TCG support       $tcg"
> if test "$tcg" = "yes" ; then
>     echo "TCG debug enabled $debug_tcg"
> @@ -7828,6 +7862,9 @@ fi
> if test "$target_aligned_only" = "yes" ; then
>   echo "TARGET_ALIGNED_ONLY=y" >> $config_target_mak
> fi
> +if supported_nvmm_target $target; then
> +    echo "CONFIG_NVMM=y" >> $config_target_mak
> +fi
> if test "$target_bigendian" = "yes" ; then
>   echo "TARGET_WORDS_BIGENDIAN=y" >> $config_target_mak
> fi
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 224a8e8712..10c046c916 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>     "-machine [type=]name[,prop[=value][,...]]\n"
>     "                selects emulated machine ('-machine help' for list)\n"
>     "                property accel=accel1[:accel2[:...]] selects accelerator\n"
> -    "                supported accelerators are kvm, xen, hax, hvf, whpx or tcg (default: tcg)\n"
> +    "                supported accelerators are kvm, xen, hax, hvf, nvmm, whpx or tcg (default: tcg)\n"
>     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
>     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
>     "                mem-merge=on|off controls memory merge support (default: on)\n"
> @@ -64,9 +64,9 @@ Supported machine properties are:
> @table @option
> @item accel=@var{accels1}[:@var{accels2}[:...]]
> This is used to enable an accelerator. Depending on the target architecture,
> -kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
> -more than one accelerator specified, the next one is used if the previous one
> -fails to initialize.
> +kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg is used.
> +If there is more than one accelerator specified, the next one is used if the
> +previous one fails to initialize.
> @item vmport=on|off|auto
> Enables emulation of VMWare IO port, for vmmouse etc. auto says to select the
> value based on accel. For accel=xen the default is off otherwise the default
> @@ -114,7 +114,7 @@ ETEXI
>
> DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>     "-accel [accel=]accelerator[,prop[=value][,...]]\n"
> -    "                select accelerator (kvm, xen, hax, hvf, whpx or tcg; use 'help' for a list)\n"
> +    "                select accelerator (kvm, xen, hax, hvf, nvmm, whpx or tcg; use 'help' for a list)\n"
>     "                igd-passthru=on|off (enable Xen integrated Intel graphics passthrough, default=off)\n"
>     "                kernel-irqchip=on|off|split controls accelerated irqchip support (default=on)\n"
>     "                kvm-shadow-mem=size of KVM shadow MMU in bytes\n"
> @@ -124,9 +124,9 @@ STEXI
> @item -accel @var{name}[,prop=@var{value}[,...]]
> @findex -accel
> This is used to enable an accelerator. Depending on the target architecture,
> -kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is used. If there is
> -more than one accelerator specified, the next one is used if the previous one
> -fails to initialize.
> +kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg is used.
> +If there is more than one accelerator specified, the next one is used if the
> +previous one fails to initialize.
> @table @option
> @item igd-passthru=on|off
> When Xen is in use, this option controls whether Intel integrated graphics
> --
> 2.25.0
>
>
--0-271522811-1581023215=:671--

