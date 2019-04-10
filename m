Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4F5C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 10:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD29206B7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 10:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD29206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56950 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEAKA-0000xF-Iq
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 06:19:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAJI-0000fV-Nt
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEAJH-0005w3-AD
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:18:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEAJH-0005v8-0I
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 06:18:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id p10so2283297wrq.1
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 03:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cyk+HYILrAuN9mcUvvzI8SF40y/Jn3DdBCJZztLcks0=;
	b=IhGCShokl+dAJyZXGvZdXSMSWrRxnPnWs4iXQinq4wGCJfaq2lCJJvFGVOCq29FlfT
	kQqv9uE7PjvFvA8+NRG/pAI2MAJzx+dUW8B2SugXNDr3JDpEtOVBOaDiA+NJ9KI+UuT2
	Ge28mF6gpzKOZwFjl5vcglF2fp0pWsFrcQDwN2IDwSitwYodbOOp3xyMaoboUFbTcmoG
	4lU992Y88OhNrEKjI96ra0gPYrc9cDfghd2rVfowSCJNDjamS2tgpE48y9KVLYWVLFu7
	DudSPm0ehfTlOxi2cw/R2vinsNbRpaJOGetgu2+H2ZR6o2ZxiNvU6EClEiTtbJh3KnqN
	MRIw==
X-Gm-Message-State: APjAAAWBdWduHpAUzVUN5LORNjGkgcGWfFFaLMi1Pb8xmu7UBgMGGK7J
	etnvksEVZwxJcQNS1V6nfoS82i4pE74=
X-Google-Smtp-Source: APXvYqzhPKFEzSzdpoDEag3ZCgsQu8Kb61tH7APSoianyAJhgklrlG65ehA8lFAi6FHulFvTgR0K5g==
X-Received: by 2002:a5d:5190:: with SMTP id k16mr27224650wrv.10.1554891505703; 
	Wed, 10 Apr 2019 03:18:25 -0700 (PDT)
Received: from [10.201.33.53] ([195.166.127.210])
	by smtp.gmail.com with ESMTPSA id x18sm2686877wmi.6.2019.04.10.03.18.23
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 03:18:24 -0700 (PDT)
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, 
	f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com,
	mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org,
	qemu-devel@nongnu.org
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-12-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <c093a13c-efa6-caa0-8c16-b889ef30e775@redhat.com>
Date: Wed, 10 Apr 2019 12:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-12-lersek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 11/12] Makefile: install the
 edk2 firmware images and their descriptors
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
Message-ID: <20190410101822.E8a2inyCo76uW33if70FbX_o2fCLjwk2p4li-x9esNQ@z>

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> Decompress and install the edk2 firmware blobs as part of "make install",
> unless blob installation was disabled with configure's "--disable-blobs"
> option.
> 
> Additionally, decompress the blobs as a pre-requisite for building softmmu
> binaries -- this is helpful for both "make check" and other ad-hoc tests
> one might want to run in the build directory.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Note that this job (with install) on Travis takes <30min:
https://travis-ci.org/philmd/qemu/jobs/518117217

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
>     - Decompress fd.bz2 files with bzip2 rather than fd.xz files with xz, so
>       that decompression at "make install" time succeed on older build OSes
>       too [Peter]. Note that "BUNZIP2" matches the name of the actual
>       command "bunzip2" (i.e. it is sensible), and that it consists of 7
>       characters, satisfying the quiet-command limit.
>     
>     - do not pick up Phil's T-b, consequently
>     
>     - do not pick up Igor's T-b for the same reason
>     
>     v2:
>     
>     - adapt to tracking the edk2 flash device files in compressed form [Dan,
>       Michael, Phil]
>     
>     - do not pick up Michal's and Michael's R-b's due to the above change
> 
>  configure  |  1 +
>  Makefile   | 29 +++++++++++++++++++-
>  .gitignore |  1 +
>  3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 1c563a70276a..e1ad87b697e0 100755
> --- a/configure
> +++ b/configure
> @@ -7892,6 +7892,7 @@ for bios_file in \
>      $source_path/pc-bios/*.img \
>      $source_path/pc-bios/openbios-* \
>      $source_path/pc-bios/u-boot.* \
> +    $source_path/pc-bios/edk2-*.fd.bz2 \
>      $source_path/pc-bios/palcode-*
>  do
>      LINKS="$LINKS pc-bios/$(basename $bios_file)"
> diff --git a/Makefile b/Makefile
> index 04a0d4505085..626a04d305cc 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -296,6 +296,10 @@ ui/input-keymap-%.c: $(KEYCODEMAP_GEN) $(KEYCODEMAP_CSV) $(SRC_PATH)/ui/Makefile
>  $(KEYCODEMAP_GEN): .git-submodule-status
>  $(KEYCODEMAP_CSV): .git-submodule-status
>  
> +edk2-decompressed = $(basename $(wildcard pc-bios/edk2-*.fd.bz2))
> +pc-bios/edk2-%.fd: pc-bios/edk2-%.fd.bz2
> +	$(call quiet-command,bzip2 -d -c $< > $@,"BUNZIP2",$<)
> +
>  # Don't try to regenerate Makefile or configure
>  # We don't generate any of them
>  Makefile: ;
> @@ -445,6 +449,7 @@ $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
> +$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
>  
>  subdir-%:
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" all,)
> @@ -633,6 +638,7 @@ clean:
>  		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
>  		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
>  		-exec rm {} +
> +	rm -f $(edk2-decompressed)
>  	rm -f $(filter-out %.tlb,$(TOOLS)) $(HELPERS-y) qemu-ga TAGS cscope.* *.pod *~ */*~
>  	rm -f fsdev/*.pod scsi/*.pod
>  	rm -f qemu-img-cmds.h
> @@ -723,9 +729,14 @@ spapr-rtas.bin slof.bin skiboot.lid \
>  palcode-clipper \
>  u-boot.e500 u-boot-sam460-20100605.bin \
>  qemu_vga.ndrv \
> +edk2-licenses.txt \
>  hppa-firmware.img
> +
> +DESCS=50-edk2-i386-secure.json 50-edk2-x86_64-secure.json \
> +60-edk2-aarch64.json 60-edk2-arm.json 60-edk2-i386.json 60-edk2-x86_64.json
>  else
>  BLOBS=
> +DESCS=
>  endif
>  
>  # Note that we manually filter-out the non-Sphinx documentation which
> @@ -786,7 +797,8 @@ endif
>  
>  ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
>  
> -install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir
> +install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
> +	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
>  ifneq ($(TOOLS),)
>  	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
>  endif
> @@ -808,6 +820,21 @@ ifneq ($(BLOBS),)
>  	set -e; for x in $(BLOBS); do \
>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
>  	done
> +endif
> +ifdef INSTALL_BLOBS
> +	set -e; for x in $(edk2-decompressed); do \
> +		$(INSTALL_DATA) $$x "$(DESTDIR)$(qemu_datadir)"; \
> +	done
> +endif
> +ifneq ($(DESCS),)
> +	$(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)/firmware"
> +	set -e; tmpf=$$(mktemp); trap 'rm -f -- "$$tmpf"' EXIT; \
> +	for x in $(DESCS); do \
> +		sed -e 's,@DATADIR@,$(DESTDIR)$(qemu_datadir),' \
> +			"$(SRC_PATH)/pc-bios/descriptors/$$x" > "$$tmpf"; \
> +		$(INSTALL_DATA) "$$tmpf" \
> +			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
> +	done
>  endif
>  	for s in $(ICON_SIZES); do \
>  		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
> diff --git a/.gitignore b/.gitignore
> index 8f782218044e..fd6e6c38c7b9 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -97,6 +97,7 @@
>  *.gcno
>  *.gcov
>  /pc-bios/bios-pq/status
> +/pc-bios/edk2-*.fd
>  /pc-bios/vgabios-pq/status
>  /pc-bios/optionrom/linuxboot.asm
>  /pc-bios/optionrom/linuxboot.bin
> 

