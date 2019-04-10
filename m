Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD4C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:19:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2E120854
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2E120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE5e9-0001WL-B8
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:19:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5dH-0001Ap-7y
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5dF-0007Yl-EB
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:18:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE5dF-0007VI-1O
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:18:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so1281383wrp.0
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3yYrKWdGM4vSr7xZvotJ2+VVxLJ5xabeLHnp1gIWcMI=;
	b=HEzOjE+vAzHDJCaFFuYHLQePkjBA5wGx3JOY3H9BYiU6ly91HZ4tqAHZQx3cQj8H+O
	8Bkz41ioNXy8nv5HudK5VQTmo/PC1qwZ0Ca/CqCPz/nlQVf0uZbv9knjdiqHte+gMwDB
	aNYQotxcE+wV+iGI7tccoPZgdVgtt0UtdAEM4Jl2R0a4ZX0Y0s2sQXNkhdyjEjhEk+KF
	pzMfXYt0ly9YRdplZBh22eP+duX19gas5e6P60xIjXLHxJVAhX/fHCbU3yKaSXqm7G74
	Ammu82NFAQ/vTHeDBp6NVCasRtvAi52B7YzZQEUwY5XCPpcP0Mnw8Pz3zL20lDy04XeX
	KShQ==
X-Gm-Message-State: APjAAAVJrkmX/GfhVzd9ujQEdYi8WEJUkjQmoMC/bth101bqDJu7lXdq
	rJG9AtyMj3C30SR+bKwBLUBiMEqwqII=
X-Google-Smtp-Source: APXvYqx4yU/iyKRbz/TmPk0v4tnCQJIi9QeMrzgMXfDdTztgeK7YI2M3P7DsT+xWGXx9SmOB8+bKBg==
X-Received: by 2002:adf:ef8e:: with SMTP id d14mr23796917wro.81.1554873523799; 
	Tue, 09 Apr 2019 22:18:43 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	a22sm1035868wmj.44.2019.04.09.22.18.42
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 22:18:43 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, 
	f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com,
	mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
	qemu-devel@nongnu.org
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-8-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e5a92027-cf9b-d1f5-c241-09a4fc7931ac@redhat.com>
Date: Wed, 10 Apr 2019 07:18:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-8-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 07/12] roms: build edk2 firmware
 binaries and variable store templates
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410051841.vcemaQvhW2QXypdAYOwZJwft2FWLTCq4lpQOmlIsjCc@z>

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> Add the "efi" target to "Makefile".
> 
> Introduce "Makefile.edk2" for building and cleaning the firmware images
> and varstore templates.
> 
> Collect the common bits from the recipes in the helper script
> "edk2-build.sh".
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v4:
>     
>     - no change
>     
>     v3:
>     
>     - pick up Michal's R-b
>     
>     - pick up Phil's R-b
>     
>     - pick up Michael's R-b
>     
>     - compress FD files with bzip2 rather than xz, so that decompression at
>       "make install" time succeed on older build OSes too [Peter]
>     
>     - do not pick up Phil's T-b, consequently
>     
>     - do not pick up Igor's T-b for the same reason
>     
>     v2:
>     
>     - drop comma after copyright year, in both new files [Eric]
>     
>     - define the SHELL macro as /bin/bash near the top of "Makefile.edk2",
>       so that various bashisms (e.g. the "source" built-in, and the ==
>       operator of "[") work even if /bin/sh isn't bash [Phil, Eric]
>     
>     - rework "Makefile.edk2" to produce xz-compressed flash device files
>       [Dan, Michael, Phil]:
>     
>       - add implicit rule for compression,
>     
>       - mark uncompressed FD files as intermediate,
>     
>       - factor out the "flashdevs" macro for sharing between the "all" and
>         ".INTERMEDIATE" targets
>     
>     - due to said rework above, do not pick up Phil's R-b / T-b, and
>       Michal's and Michael's R-b's
> 
>  roms/Makefile      |   5 +
>  roms/Makefile.edk2 | 148 ++++++++++++++++++++
>  roms/edk2-build.sh |  55 ++++++++
>  3 files changed, 208 insertions(+)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 93c3d467be14..0ce84a45ad57 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -61,6 +61,7 @@ default:
>  	@echo "  skiboot        -- update skiboot.lid"
>  	@echo "  u-boot.e500    -- update u-boot.e500"
>  	@echo "  u-boot.sam460  -- update u-boot.sam460"
> +	@echo "  efi            -- update UEFI (edk2) platform firmware"
>  
>  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>  	cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> @@ -156,6 +157,9 @@ skiboot:
>  	$(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
>  	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
>  
> +efi: edk2-basetools
> +	$(MAKE) -f Makefile.edk2
> +
>  clean:
>  	rm -rf seabios/.config seabios/out seabios/builds
>  	$(MAKE) -C sgabios clean
> @@ -166,3 +170,4 @@ clean:
>  	rm -rf u-boot/build.e500
>  	$(MAKE) -C u-boot-sam460ex distclean
>  	$(MAKE) -C skiboot clean
> +	$(MAKE) -f Makefile.edk2 clean
> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
> new file mode 100644
> index 000000000000..822c547fec64
> --- /dev/null
> +++ b/roms/Makefile.edk2
> @@ -0,0 +1,148 @@
> +# Makefile for building firmware binaries and variable store templates for a
> +# number of virtual platforms in edk2.
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
> +#
> +# This program and the accompanying materials are licensed and made available
> +# under the terms and conditions of the BSD License that accompanies this
> +# distribution. The full text of the license may be found at
> +# <http://opensource.org/licenses/bsd-license.php>.
> +#
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
> +
> +SHELL = /bin/bash
> +
> +toolchain = $(shell source ./edk2-funcs.sh && qemu_edk2_get_toolchain $(1))
> +
> +licenses := \
> +	edk2/License.txt \
> +	edk2/OvmfPkg/License.txt \
> +	edk2/CryptoPkg/Library/OpensslLib/openssl/LICENSE
> +
> +# The "edk2-arm-vars.fd" varstore template is suitable for aarch64 as well.
> +# Similarly, the "edk2-i386-vars.fd" varstore template is suitable for x86_64
> +# as well, independently of "secure" too.
> +flashdevs := \
> +	aarch64-code \
> +	arm-code \
> +	i386-code \
> +	i386-secure-code \
> +	x86_64-code \
> +	x86_64-secure-code \
> +	\
> +	arm-vars \
> +	i386-vars
> +
> +all: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd.bz2) \
> +	../pc-bios/edk2-licenses.txt
> +
> +../pc-bios/edk2-%.fd.bz2: ../pc-bios/edk2-%.fd
> +	bzip2 -9 -c $< > $@
> +
> +# When the build completes, we need not keep the uncompressed flash device
> +# files.
> +.INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flashdev).fd)
> +
> +submodules:
> +	cd edk2 && git submodule update --init --force
> +
> +# See notes on the ".NOTPARALLEL" target and the "+" indicator in
> +# "tests/uefi-test-tools/Makefile".
> +.NOTPARALLEL:
> +
> +../pc-bios/edk2-aarch64-code.fd: submodules
> +	+./edk2-build.sh \
> +		aarch64 \
> +		--arch=AARCH64 \
> +		--platform=ArmVirtPkg/ArmVirtQemu.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE
> +	cp edk2/Build/ArmVirtQemu-AARCH64/DEBUG_$(call toolchain,aarch64)/FV/QEMU_EFI.fd \
> +		$@
> +	truncate --size=64M $@
> +
> +../pc-bios/edk2-arm-code.fd: submodules
> +	+./edk2-build.sh \
> +		arm \
> +		--arch=ARM \
> +		--platform=ArmVirtPkg/ArmVirtQemu.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE
> +	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_EFI.fd \
> +		$@
> +	truncate --size=64M $@
> +
> +../pc-bios/edk2-i386-code.fd: submodules
> +	+./edk2-build.sh \
> +		i386 \
> +		--arch=IA32 \
> +		--platform=OvmfPkg/OvmfPkgIa32.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE
> +	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-i386-secure-code.fd: submodules
> +	+./edk2-build.sh \
> +		i386 \
> +		--arch=IA32 \
> +		--platform=OvmfPkg/OvmfPkgIa32.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE \
> +		-D SECURE_BOOT_ENABLE \
> +		-D SMM_REQUIRE
> +	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-x86_64-code.fd: submodules
> +	+./edk2-build.sh \
> +		x86_64 \
> +		--arch=X64 \
> +		--platform=OvmfPkg/OvmfPkgX64.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE
> +	cp edk2/Build/OvmfX64/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-x86_64-secure-code.fd: submodules
> +	+./edk2-build.sh \
> +		x86_64 \
> +		--arch=IA32 \
> +		--arch=X64 \
> +		--platform=OvmfPkg/OvmfPkgIa32X64.dsc \
> +		-D NETWORK_IP6_ENABLE \
> +		-D HTTP_BOOT_ENABLE \
> +		-D TLS_ENABLE \
> +		-D TPM2_ENABLE \
> +		-D TPM2_CONFIG_ENABLE \
> +		-D SECURE_BOOT_ENABLE \
> +		-D SMM_REQUIRE
> +	cp edk2/Build/Ovmf3264/DEBUG_$(call toolchain,x86_64)/FV/OVMF_CODE.fd $@
> +
> +../pc-bios/edk2-arm-vars.fd: ../pc-bios/edk2-arm-code.fd
> +	cp edk2/Build/ArmVirtQemu-ARM/DEBUG_$(call toolchain,arm)/FV/QEMU_VARS.fd \
> +		$@
> +	truncate --size=64M $@
> +
> +../pc-bios/edk2-i386-vars.fd: ../pc-bios/edk2-i386-code.fd
> +	cp edk2/Build/OvmfIa32/DEBUG_$(call toolchain,i386)/FV/OVMF_VARS.fd $@
> +
> +# The license file accumulates several individual licenses from under edk2,
> +# prefixing each individual license with a header (generated by "tail") that
> +# states its pathname.
> +../pc-bios/edk2-licenses.txt: submodules
> +	tail -n $(shell cat $(licenses) | wc -l) $(licenses) > $@
> +	dos2unix $@
> +
> +clean:
> +	rm -rf edk2/Build
> +	cd edk2/Conf && \
> +		rm -rf .cache BuildEnv.sh build_rule.txt target.txt \
> +			tools_def.txt
> diff --git a/roms/edk2-build.sh b/roms/edk2-build.sh
> new file mode 100755
> index 000000000000..4f46f8a6a217
> --- /dev/null
> +++ b/roms/edk2-build.sh
> @@ -0,0 +1,55 @@
> +#!/bin/bash
> +
> +# Wrapper shell script for building a  virtual platform firmware in edk2.
> +#
> +# Copyright (C) 2019 Red Hat, Inc.
> +#
> +# This program and the accompanying materials are licensed and made available
> +# under the terms and conditions of the BSD License that accompanies this
> +# distribution. The full text of the license may be found at
> +# <http://opensource.org/licenses/bsd-license.php>.
> +#
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, WITHOUT
> +# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
> +
> +set -e -u -C
> +
> +# Save the command line arguments. We need to reset $# to 0 before sourcing
> +# "edksetup.sh", as it will inherit $@.
> +emulation_target=$1
> +shift
> +num_args=0
> +args=()
> +for arg in "$@"; do
> +  args[num_args++]="$arg"
> +done
> +shift $num_args
> +
> +cd edk2
> +
> +# Work around <https://bugzilla.tianocore.org/show_bug.cgi?id=1607>.
> +export PYTHON_COMMAND=python2
> +
> +# Source "edksetup.sh" carefully.
> +set +e +u +C
> +source ./edksetup.sh
> +ret=$?
> +set -e -u -C
> +if [ $ret -ne 0 ]; then
> +  exit $ret
> +fi
> +
> +# Fetch some option arguments, and set the cross-compilation environment (if
> +# any), for the edk2 "build" utility.
> +source ../edk2-funcs.sh
> +edk2_toolchain=$(qemu_edk2_get_toolchain "$emulation_target")
> +edk2_thread_count=$(qemu_edk2_get_thread_count "$MAKEFLAGS")
> +qemu_edk2_set_cross_env "$emulation_target"
> +
> +# Build the platform firmware.
> +build \
> +  --cmd-len=65536 \
> +  -n "$edk2_thread_count" \
> +  --buildtarget=DEBUG \
> +  --tagname="$edk2_toolchain" \
> +  "${args[@]}"
> 

