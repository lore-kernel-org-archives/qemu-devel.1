Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6412C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D6C62175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:29:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6C62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU2lh-0005Sy-VW
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 01:29:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU2ku-0005A2-8F
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:28:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU2ks-00027p-RG
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:28:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU2ks-00026z-K0
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:28:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so7954620wme.0
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 22:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7wmukxwmmEqunJEF3ALuRC2/POvzetrqYyp0hDnFZ+o=;
	b=gtFlIIy4L27/AVRL6XMKGuG2tAylTM/V/pcbdYVea7G0m8NgaXroiVsMlklR+IfeIV
	GXJnTFc+qHnuQ1JWnhkuuMbb6TLLRa1QE4Lbia0jSwxI/HsN86iQs0l6/IeELb4juDvf
	GWyCE0D5rEABUYB+FtA8I7DYi45fKkl841YCa97ZglI5hQOBTWFfDNLWsH0f5375+0bL
	S7P+5SXW01hNiQ5nP+fyKZ2GcwvawvNncGBvzWlB84tLtD5SYYD+GskccmqlirZLDycQ
	NMdYaLx5ls5MV+9H3uhvyyk642U8IAsSSDAA2X059dgkNFCW524QgT0suskuaI0CxfCq
	UydQ==
X-Gm-Message-State: APjAAAX2EczbskXxcpH0SIG94RwphUQ9pVjB8L4Y0ISr/AB4E3KB1546
	k888Y+Jdr91RJSc6Y+NebF2zev4rM94=
X-Google-Smtp-Source: APXvYqy57zHZPiQxeWO4BpDw/jouWD4ksNNMBmhN3Afk4YLxP2WulaIW2UvvbChtRmt6Wzkn+ZSvRA==
X-Received: by 2002:a1c:ca1a:: with SMTP id a26mr797182wmg.70.1558675713501;
	Thu, 23 May 2019 22:28:33 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id r2sm1880927wma.26.2019.05.23.22.28.32
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 22:28:33 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d70ddf0d-0eaa-406a-7427-dc1df1fac76f@redhat.com>
Date: Fri, 24 May 2019 07:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [RFC v4 3/7] Makefile: Rename targets for make
 recursion
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 10:15 AM, Markus Armbruster wrote:
> We make a few sub-directories recursively, in particular
> $(TARGET_DIRS).
> 
> For goal "all", we do it the nice way: "all" has a prerequisite
> subdir-T for each T in $(TARGET_DIRS), and T's recipe runs make
> recursively.  Behaves nicely with -j and -k.
> 
> For other goals such as "clean" and "install", the recipe runs make
> recursively in a for loop.  Ignores -j and -k.
> 
> The next commit will fix that for "clean" and "install".  This commit
> prepares the ground by renaming the targets we use for "all" to
> include the goal for the sub-make.  This will permit reusing them for
> goals other than "all".
> 
> Targets subdir-T for T in $(TARGET_DIRS) run "make all" in T.  Rename
> to T/all, and declare phony.
> 
> Targets romsubdir-R for R in $(ROMS) run "make" in pc-bios/R.  Default
> goal is "all" for all R.  Rename to pc-bios/R/all, and declare phony.
> 
> The remainder are renamed just for consistency.
> 
> Target subdir-dtc runs "make libbft/libfdt.a" in dtc.  Rename to
> dtc/all, and declare phony.
> 
> Target subdir-capstone runs make $(BUILD_DIR)/capstone/$(LIBCAPSTONE)
> in $(SRC_PATH)/capstone.  Rename to capstone/all, and declare phony.
> 
> Target subdir-slirp runs "make" in $(SRC_PATH)/slirp.  Default goal is
> all, which builds $(BUILD_DIR)/libslirp.a.  Rename to slirp/all, and
> declare phony.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile               | 30 ++++++++++++++++++------------
>  configure              |  6 +++---
>  tests/Makefile.include |  3 ++-
>  3 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 12e470fa03..09c726bcc2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -436,8 +436,8 @@ config-host.h-timestamp: config-host.mak
>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>  
> -SUBDIR_RULES=$(patsubst %,subdir-%, $(TARGET_DIRS))
> -SOFTMMU_SUBDIR_RULES=$(filter %-softmmu,$(SUBDIR_RULES))
> +SUBDIR_RULES=$(addsuffix /all, $(TARGET_DIRS))
> +SOFTMMU_SUBDIR_RULES=$(filter %-softmmu/all,$(SUBDIR_RULES))
>  
>  $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
> @@ -447,14 +447,16 @@ $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>  $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
>  $(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
>  
> -subdir-%:
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V="$(V)" TARGET_DIR="$*/" all,)
> +.PHONY: $(SUBDIR_RULES)
> +$(SUBDIR_RULES):
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" all,)
>  
>  DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
>  DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
>  DTC_CPPFLAGS=-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/libfdt
>  
> -subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
> +.PHONY: dtc/all
> +dtc/all: .git-submodule-status dtc/libfdt dtc/tests
>  	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a,)

OK

>  
>  dtc/%: .git-submodule-status
> @@ -472,21 +474,25 @@ CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
>  CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
>  CAP_CFLAGS += -DCAPSTONE_HAS_X86
>  
> -subdir-capstone: .git-submodule-status
> +.PHONY: capstone/all
> +capstone/all: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))

OK

>  
> -subdir-slirp: .git-submodule-status
> +.PHONY: slirp/all
> +slirp/all: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")

OK

>  
>  $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
>  	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
>  
> -ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
> +ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
> +ROMSUBDIR_RULES=$(addsuffix /all, $(ROM_DIRS))
>  # Only keep -O and -g cflags
> -romsubdir-%:
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pc-bios/$* V="$(V)" TARGET_DIR="$*/" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)
> +.PHONY: $(ROMSUBDIR_RULES)
> +$(ROMSUBDIR_RULES):
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)

OK

>  
> -ALL_SUBDIRS=$(TARGET_DIRS) $(patsubst %,pc-bios/%, $(ROMS))
> +ALL_SUBDIRS=$(TARGET_DIRS) $(ROM_DIRS)
>  
>  recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
>  
> @@ -1087,7 +1093,7 @@ endif
>  	@$(if $(TARGET_DIRS), \
>  		echo 'Architecture specific targets:'; \
>  		$(foreach t, $(TARGET_DIRS), \
> -		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);) \
> +		printf "  %-30s - Build for %s\\n" $(t)/all $(t);) \

OK

>  		echo '')
>  	@echo  'Cleaning targets:'
>  	@echo  '  clean           - Remove most generated files but keep the config'
> diff --git a/configure b/configure
> index d2fc346302..2897434dda 100755
> --- a/configure
> +++ b/configure
> @@ -6570,7 +6570,7 @@ if test "$slirp" != "no"; then
>    echo "SLIRP_LIBS=$slirp_libs" >> $config_host_mak
>  fi
>  if [ "$slirp" = "git" -o "$slirp" = "internal" ]; then
> -    echo "config-host.h: subdir-slirp" >> $config_host_mak
> +    echo "config-host.h: slirp/all" >> $config_host_mak
>  fi
>  if test "$vde" = "yes" ; then
>    echo "CONFIG_VDE=y" >> $config_host_mak
> @@ -7836,10 +7836,10 @@ if test -n "$enabled_cross_compilers"; then
>  fi
>  
>  if [ "$fdt" = "git" ]; then
> -  echo "config-host.h: subdir-dtc" >> $config_host_mak
> +  echo "config-host.h: dtc/all" >> $config_host_mak
>  fi
>  if [ "$capstone" = "git" -o "$capstone" = "internal" ]; then
> -  echo "config-host.h: subdir-capstone" >> $config_host_mak
> +  echo "config-host.h: capstone/all" >> $config_host_mak
>  fi
>  if test -n "$LIBCAPSTONE"; then
>    echo "LIBCAPSTONE=$LIBCAPSTONE" >> $config_host_mak
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 1865f6b322..2b8d34ca25 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1,3 +1,4 @@
> +# -*- Mode: makefile -*-
>  
>  .PHONY: check-help
>  check-help:
> @@ -880,7 +881,7 @@ define do_test_tap
>  endef
>  
>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
> -$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%-softmmu $(check-qtest-y)
> +$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(check-qtest-y)
>  	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
>  	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
> 

There is another one:

-- >8 --
 # gtester tests with TAP output

-$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)):
check-report-qtest-%.tap: subdir-%-softmmu $(check-qtest-y)
+$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)):
check-report-qtest-%.tap: %-softmmu/all $(check-qtest-y)
        $(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
          QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
          QTEST_QEMU_IMG=qemu-img$(EXESUF))
---

With the fix amended:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Regards,

Phil.

