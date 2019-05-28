Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C21DC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23E4E21670
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23E4E21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVeTX-00024U-AQ
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 11:57:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVeRz-0001PN-EW
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hVeRp-0003Ed-2t
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:55:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hVeRj-0002kA-Hy
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:55:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id f8so20854763wrt.1
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 08:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ZK82juEfh1rugfESyHjMEr+9pf1hX8/DUHrn62BqHU0=;
	b=HyUTLwrCiEJPHrksXYCPIOUaUnRHWSD0wkNGbwW7Fvl3kEH2IIvlpqZDqKf/B7uRkE
	n6ncl8ZxaoH7oi6ZL+oBnUAAL0tuT1UbVHvFwjHEPmVeOw3NejU/W4ULeNUgf7vHSAPB
	DDNhZGd1z836yQ9V2dSSA1OPjzt26Twr6XoGubeh02dGVd9dUayN+hOrCXBuV8Ah54PF
	R8xBjSqz+ADBwebv9JFntJ92q4XoAaqs3aiFEfvBsVvV2UgrSx3bjSPVxEZLUaUKr8ye
	XAUCIpDFTTiCxvxsJ1/1XGx+WrOVLjPNic6Dsjibhb+tLLbCUgqaHBYrCAGDWVs1Naku
	gl3A==
X-Gm-Message-State: APjAAAWhrptk4WG17CX+b3s34QLE+BCW7/wsAQVhxJSbQ8HGRVTov2iI
	aRq1YVBeR+aaHoo9ugMHRJY0EQ==
X-Google-Smtp-Source: APXvYqxwa5qV39IREdJXE5Hy8eoY5NG4UeyCBqg22RuT9tJwRiNTSy3LSpgzMY5Q+9seuoJW740rVg==
X-Received: by 2002:adf:de8b:: with SMTP id w11mr11547381wrl.254.1559058911436;
	Tue, 28 May 2019 08:55:11 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id j2sm5828185wrx.65.2019.05.28.08.55.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 08:55:10 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190528082308.22032-1-armbru@redhat.com>
	<20190528082308.22032-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a78a4cc0-d68c-4182-5f44-85e4680119aa@redhat.com>
Date: Tue, 28 May 2019 17:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528082308.22032-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 4/4] Makefile: Reuse all's recursion
 machinery for clean and install
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
Cc: pbonzini@redhat.com, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/28/19 10:23 AM, Markus Armbruster wrote:
> Targets "clean" and "install" run make recursively in a for loop.
> This ignores -j and -k.  Target "all" depends on SUBDIR/all to recurse
> into each SUBDIR.  Behaves nicely with -j and -k.  Put that to use for
> "clean" and "install": depend on SUBDIR/clean or SUBDIR/install,
> respectively, and delete the loop.

Very nice!

> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  Makefile | 53 +++++++++++++++++++++++++----------------------------
>  1 file changed, 25 insertions(+), 28 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 42930b7749..f194c61122 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -437,20 +437,22 @@ config-host.h-timestamp: config-host.mak
>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>  
> -SUBDIR_RULES=$(addsuffix /all, $(TARGET_DIRS))
> -SOFTMMU_SUBDIR_RULES=$(filter %-softmmu/all,$(SUBDIR_RULES))
> +TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
>  
> -$(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): $(chardev-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): $(crypto-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
> -$(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
> -$(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
> +SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
> +$(SOFTMMU_ALL_RULES): $(authz-obj-y)
> +$(SOFTMMU_ALL_RULES): $(block-obj-y)
> +$(SOFTMMU_ALL_RULES): $(chardev-obj-y)
> +$(SOFTMMU_ALL_RULES): $(crypto-obj-y)
> +$(SOFTMMU_ALL_RULES): $(io-obj-y)
> +$(SOFTMMU_ALL_RULES): config-all-devices.mak
> +$(SOFTMMU_ALL_RULES): $(edk2-decompressed)
>  
> -.PHONY: $(SUBDIR_RULES)
> -$(SUBDIR_RULES):
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" all,)
> +.PHONY: $(TARGET_DIRS_RULES)
> +# The $(TARGET_DIRS_RULES) are of the form SUBDIR/GOAL, so that
> +# $(dir $@) yields the sub-directory, and $(notdir $@) yields the sub-goal
> +$(TARGET_DIRS_RULES):
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
>  
>  DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_srcdir=$(SRC_PATH)/dtc/libfdt
>  DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
> @@ -483,19 +485,19 @@ capstone/all: .git-submodule-status
>  slirp/all: .git-submodule-status
>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(LDFLAGS)")
>  
> -$(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
> +$(filter %/all, $(TARGET_DIRS_RULES)): libqemuutil.a $(common-obj-y) \
>  	$(qom-obj-y) $(crypto-user-obj-$(CONFIG_USER_ONLY))
>  
>  ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
> -ROMSUBDIR_RULES=$(addsuffix /all, $(ROM_DIRS))
> +ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
>  # Only keep -O and -g cflags
> -.PHONY: $(ROMSUBDIR_RULES)
> -$(ROMSUBDIR_RULES):
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))",)
> +.PHONY: $(ROM_DIRS_RULES)
> +$(ROM_DIRS_RULES):
> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" CFLAGS="$(filter -O% -g%,$(CFLAGS))" $(notdir $@),)
>  
> -ALL_SUBDIRS=$(TARGET_DIRS) $(ROM_DIRS)
> -
> -recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
> +recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
> +recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
> +recurse-install: $(addsuffix /install, $(TARGET_DIRS))
>  
>  $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
>  	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")
> @@ -641,7 +643,7 @@ clean-coverage:
>  		"CLEAN", "coverage files")
>  endif
>  
> -clean:
> +clean: recurse-clean
>  # avoid old build problems by removing potentially incorrect old files
>  	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
>  	rm -f qemu-options.def
> @@ -662,9 +664,6 @@ clean:
>  	rm -f $(foreach f,$(generated-files-y),$(f) $(f)-timestamp)
>  	rm -f qapi-gen-timestamp
>  	rm -rf qga/qapi-generated
> -	for d in $(ALL_SUBDIRS); do \
> -	if test -d $$d; then $(MAKE) -C $$d $@ || exit 1; fi; \
> -        done
>  	rm -f config-all-devices.mak
>  
>  VERSION ?= $(shell cat VERSION)
> @@ -810,7 +809,8 @@ endif
>  ICON_SIZES=16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
>  
>  install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-localstatedir \
> -	$(if $(INSTALL_BLOBS),$(edk2-decompressed))
> +	$(if $(INSTALL_BLOBS),$(edk2-decompressed)) \
> +	recurse-install
>  ifneq ($(TOOLS),)
>  	$(call install-prog,$(subst qemu-ga,qemu-ga$(EXESUF),$(TOOLS)),$(DESTDIR)$(bindir))
>  endif
> @@ -870,9 +870,6 @@ endif
>  		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/keymaps/$$x "$(DESTDIR)$(qemu_datadir)/keymaps"; \
>  	done
>  	$(INSTALL_DATA) $(BUILD_DIR)/trace-events-all "$(DESTDIR)$(qemu_datadir)/trace-events-all"
> -	for d in $(TARGET_DIRS); do \
> -	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
> -        done
>  
>  .PHONY: ctags
>  ctags:
> 

