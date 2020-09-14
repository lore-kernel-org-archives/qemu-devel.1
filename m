Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B59DC2BC11
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF6722242
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 13:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF6722242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHoA8-00077z-5H
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 09:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHo9R-0006hz-Mx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:04:09 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:45537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kHo9N-0005S6-My
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 09:04:09 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.6])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id AE82C616C1E5;
 Mon, 14 Sep 2020 15:04:01 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 14 Sep
 2020 15:04:00 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0018df47402-f128-48fb-87ec-2aec69e0959c,
 33559CD024D4F69900824C14C2AC4808F9346AFD) smtp.auth=groug@kaod.org
Date: Mon, 14 Sep 2020 15:03:32 +0200
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] add a source path Makefile
Message-ID: <20200914150332.6b89da73@bahia.lan>
In-Reply-To: <20200912084656.111174-1-pbonzini@redhat.com>
References: <20200912084656.111174-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7147f680-a936-4c0a-922a-2460cb770ab6
X-Ovh-Tracer-Id: 7656400844409772509
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeiiedgiedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegsvghrrhgrnhhgvgesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 09:04:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 12 Sep 2020 10:46:56 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Now that QEMU is always built out-of-tree, the rules to build
> QEMU need not be in a file called "Makefile".  Move them to
> "Makefile.build" (which is symlinked to Makefile in the build
> tree) and only leave the support for fake in-tree build in the
> source directory Makefile.  This support is enabled conditionally
> if the marker file is found in the build/ directory, and therefore
> configure does not have to create a makefile of its own anymore.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Hi Paolo,

This doesn't apply on master, likely because some changes got
merged this week-end with the latest PR of the trivial tree.

Also, please use my <groug@kaod.org> address for upstream work.

Cheers,

--
Greg

>  Makefile                   | 298 +++++--------------------------------
>  Makefile => Makefile.build |  39 +----
>  configure                  |  25 +---
>  3 files changed, 42 insertions(+), 320 deletions(-)
>  copy Makefile => Makefile.build (90%)
> 
> diff --git a/Makefile b/Makefile
> index d6c5c9fdef..643041dc04 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,288 +1,68 @@
> -# Makefile for QEMU.
> +# Makefile for the QEMU source directory.
>  
>  ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>    $(error main directory cannot contain spaces nor colons)
>  endif
>  
> -# Always point to the root of the build tree (needs GNU make).
> -BUILD_DIR=$(CURDIR)
> +SRCPATH_GOALS = docker docker-% vm-% ctags TAGS cscope dist clean distclean recurse
> +.PHONY: all clean distclean ctags TAGS cscope dist help
> +.NOTPARALLEL: %
>  
> -# Before including a proper config-host.mak, assume we are in the source tree
> -SRC_PATH=.
> -
> -# Don't use implicit rules or variables
> -# we have explicit rules for everything
> -MAKEFLAGS += -rR
> -
> -# Usage: $(call quiet-command,command and args,"NAME","args to print")
> -# This will run "command and args", and either:
> -#  if V=1 just print the whole command and args
> -#  otherwise print the 'quiet' output in the format "  NAME     args to print"
> -# NAME should be a short name of the command, 7 letters or fewer.
> -# If called with only a single argument, will print nothing in quiet mode.
> -quiet-command-run = $(if $(V),,$(if $2,printf "  %-7s %s\n" $2 $3 && ))$1
> -quiet-@ = $(if $(V),,@)
> -quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
> -
> -UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
> -    help check-help print-% \
> -    docker docker-% vm-help vm-test vm-build-%
> -
> -# All following code might depend on configuration variables
> -ifneq ($(wildcard config-host.mak),)
> -# Put the all: rule here so that config-host.mak can contain dependencies.
>  all:
> -include config-host.mak
> -
> -git-submodule-update:
> -
> -.PHONY: git-submodule-update
> -
> -git_module_status := $(shell \
> -  cd '$(SRC_PATH)' && \
> -  GIT="$(GIT)" ./scripts/git-submodule.sh status $(GIT_SUBMODULES); \
> -  echo $$?; \
> -)
> -
> -ifeq (1,$(git_module_status))
> -ifeq (no,$(GIT_UPDATE))
> -git-submodule-update:
> -	$(call quiet-command, \
> -            echo && \
> -            echo "GIT submodule checkout is out of date. Please run" && \
> -            echo "  scripts/git-submodule.sh update $(GIT_SUBMODULES)" && \
> -            echo "from the source directory checkout $(SRC_PATH)" && \
> -            echo && \
> -            exit 1)
> -else
> -git-submodule-update:
> -	$(call quiet-command, \
> -          (cd $(SRC_PATH) && GIT="$(GIT)" ./scripts/git-submodule.sh update $(GIT_SUBMODULES)), \
> -          "GIT","$(GIT_SUBMODULES)")
> -endif
> -endif
> -
> -export NINJA=./ninjatool
> -
> -# Running meson regenerates both build.ninja and ninjatool, and that is
> -# enough to prime the rest of the build.
> -ninjatool: build.ninja
> -
> -Makefile.ninja: build.ninja ninjatool
> -	./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < $< > $@
> --include Makefile.ninja
> -
> -${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
> -
> -# If MESON is empty, the rule will be re-evaluated after Makefiles are
> -# reread (and MESON won't be empty anymore).
> -ifneq ($(MESON),)
> -Makefile.mtest: build.ninja scripts/mtest2make.py
> -	$(MESON) introspect --tests --benchmarks | $(PYTHON) scripts/mtest2make.py > $@
> --include Makefile.mtest
> -endif
> -
> -Makefile: .git-submodule-status
> -.git-submodule-status: git-submodule-update config-host.mak
> -
> -# Check that we're not trying to do an out-of-tree build from
> -# a tree that's been used for an in-tree build.
> -ifneq ($(realpath $(SRC_PATH)),$(realpath .))
> -ifneq ($(wildcard $(SRC_PATH)/config-host.mak),)
> -$(error This is an out of tree build but your source tree ($(SRC_PATH)) \
> -seems to have been used for an in-tree build. You can fix this by running \
> -"$(MAKE) distclean && rm -rf *-linux-user *-softmmu" in your source tree)
> -endif
> -endif
> -
> -config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
> -	@echo $@ is out-of-date, running configure
> -	@if test -f meson-private/coredata.dat; then \
> -	  ./config.status --skip-meson; \
> -	else \
> -	  ./config.status; \
> -	fi
> -
> -# Force configure to re-run if the API symbols are updated
> -ifeq ($(CONFIG_PLUGIN),y)
> -config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
> -endif
> -
> -else
> -config-host.mak:
> -ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
> -	@echo "Please call configure before running make!"
> -	@exit 1
> -endif
> -endif
> -
> -# Only needed in case Makefile.ninja does not exist.
> -.PHONY: ninja-clean ninja-distclean clean-ctlist
> -clean-ctlist:
> -ninja-clean::
> -ninja-distclean::
> -build.ninja: config-host.mak
> -
> -# Don't try to regenerate Makefile or configure
> -# We don't generate any of them
> -Makefile: ;
> -configure: ;
> -
> -.PHONY: all clean cscope distclean install \
> -	recurse-all dist msi FORCE
> -
> -SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
> +clean:; @:
> +distclean::; @:
>  
> -include $(SRC_PATH)/tests/Makefile.include
> -
> -all: recurse-all
> -Makefile: $(addsuffix /all, $(SUBDIRS))
> -
> -# LIBFDT_lib="": avoid breaking existing trees with objects requiring -fPIC
> -DTC_MAKE_ARGS=-I$(SRC_PATH)/dtc VPATH=$(SRC_PATH)/dtc -C dtc V="$(V)" LIBFDT_lib=""
> -DTC_CFLAGS=$(CFLAGS) $(QEMU_CFLAGS)
> -DTC_CPPFLAGS=-I$(SRC_PATH)/dtc/libfdt
> -
> -.PHONY: dtc/all
> -dtc/all: .git-submodule-status dtc/libfdt
> -	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS="$(DTC_CPPFLAGS)" CFLAGS="$(DTC_CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)" ARFLAGS="$(ARFLAGS)" CC="$(CC)" AR="$(AR)" LD="$(LD)" $(SUBDIR_MAKEFLAGS) libfdt,)
> -
> -dtc/%: .git-submodule-status
> -	@mkdir -p $@
> -
> -# Overriding CFLAGS causes us to lose defines added in the sub-makefile.
> -# Not overriding CFLAGS leads to mis-matches between compilation modes.
> -# Therefore we replicate some of the logic in the sub-makefile.
> -# Remove all the extra -Warning flags that QEMU uses that Capstone doesn't;
> -# no need to annoy QEMU developers with such things.
> -CAP_CFLAGS = $(patsubst -W%,,$(CFLAGS) $(QEMU_CFLAGS)) $(CAPSTONE_CFLAGS)
> -CAP_CFLAGS += -DCAPSTONE_USE_SYS_DYN_MEM
> -CAP_CFLAGS += -DCAPSTONE_HAS_ARM
> -CAP_CFLAGS += -DCAPSTONE_HAS_ARM64
> -CAP_CFLAGS += -DCAPSTONE_HAS_POWERPC
> -CAP_CFLAGS += -DCAPSTONE_HAS_X86
> -
> -.PHONY: capstone/all
> -capstone/all: .git-submodule-status
> -	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=no BUILDDIR="$(BUILD_DIR)/capstone" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BUILD_DIR)/capstone/$(LIBCAPSTONE))
> -
> -.PHONY: slirp/all
> -slirp/all: .git-submodule-status
> -	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp		\
> -		BUILD_DIR="$(BUILD_DIR)/slirp" 			\
> -		PKG_CONFIG="$(PKG_CONFIG)" 				\
> -		CC="$(CC)" AR="$(AR)" 	LD="$(LD)" RANLIB="$(RANLIB)"	\
> -		CFLAGS="$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS="$(QEMU_LDFLAGS)")
> -
> -ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
> -ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
> -# Only keep -O and -g cflags
> -.PHONY: $(ROM_DIRS_RULES)
> -$(ROM_DIRS_RULES):
> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
> -
> -.PHONY: recurse-all recurse-clean
> -recurse-all: $(addsuffix /all, $(ROM_DIRS))
> -recurse-clean: $(addsuffix /clean, $(ROM_DIRS))
> -
> -######################################################################
> -
> -clean: recurse-clean ninja-clean clean-ctlist
> -	if test -f ninjatool; then ./ninjatool $(if $(V),-v,) -t clean; fi
> -# avoid old build problems by removing potentially incorrect old files
> -	rm -f config.mak op-i386.h opc-i386.h gen-op-i386.h op-arm.h opc-arm.h gen-op-arm.h
> -	find . \( -name '*.so' -o -name '*.dll' -o -name '*.[oda]' \) -type f \
> -		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-aarch64.a \
> -		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
> -		! -path ./roms/edk2/BaseTools/Source/Python/UPT/Dll/sqlite3.dll \
> -		-exec rm {} +
> -	rm -f TAGS cscope.* *.pod *~ */*~
> -	rm -f fsdev/*.pod scsi/*.pod
> -
> -VERSION = $(shell cat $(SRC_PATH)/VERSION)
> -
> -dist: qemu-$(VERSION).tar.bz2
> -
> -qemu-%.tar.bz2:
> -	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
> -
> -distclean: clean ninja-distclean
> -	-test -f ninjatool && ./ninjatool $(if $(V),-v,) -t clean -g
> -	rm -f config-host.mak config-host.h*
> -	rm -f tests/tcg/config-*.mak
> -	rm -f config-all-disas.mak config.status
> -	rm -f tests/qemu-iotests/common.env
> -	rm -f roms/seabios/config.mak roms/vgabios/config.mak
> -	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
> -	rm -f *-config-target.h *-config-devices.mak *-config-devices.h
> -	rm -rf meson-private meson-logs meson-info compile_commands.json
> -	rm -f Makefile.ninja ninjatool ninjatool.stamp Makefile.mtest
> -	rm -f config.log
> -	rm -f linux-headers/asm
> -	rm -Rf .sdk
> -
> -.PHONY: ctags
>  ctags:
>  	rm -f tags
> -	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
> +	find . -name '*.[hc]' -exec ctags --append {} +
>  
> -.PHONY: TAGS
>  TAGS:
>  	rm -f TAGS
> -	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
> +	find . -name '*.[hc]' -exec etags --append {} +
>  
> -.PHONY: cscope
>  cscope:
> -	rm -f "$(SRC_PATH)"/cscope.*
> -	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
> -	cscope -b -i"$(SRC_PATH)/cscope.files"
> +	rm -f ./cscope.*
> +	find . -name "*.[chsS]" -print | sed -e 's,^\./,,' > "./cscope.files"
> +	cscope -b -i./cscope.files
> +
> +VERSION = $(shell cat VERSION)
> +.PHONY: dist
> +dist: qemu-$(VERSION).tar.bz2
> +qemu-%.tar.bz2:
> +	./scripts/make-release . "$(patsubst qemu-%.tar.bz2,%,$@)"
>  
> -# Needed by "meson install"
> -export DESTDIR
> +SRC_PATH = .
> +include tests/docker/Makefile.include
> +include tests/vm/Makefile.include
>  
> -include $(SRC_PATH)/tests/docker/Makefile.include
> -include $(SRC_PATH)/tests/vm/Makefile.include
> +print-help = @printf "  %-30s - %s\\n" "$1" "$2"
>  
> -print-help-run = printf "  %-30s - %s\\n" "$1" "$2"
> -print-help = $(quiet-@)$(call print-help-run,$1,$2)
> +# Fake in-tree build support
> +
> +ifeq ($(wildcard build/auto-created-by-configure),)
> +all: help
> +	@exit 1
>  
> -.PHONY: help
>  help:
> +	@echo 'This is not a build directory.'
> +	@echo 'Please call configure to build QEMU.'
> +	@echo  ''
>  	@echo  'Generic targets:'
> -	$(call print-help,all,Build all)
> -	$(call print-help,dir/file.o,Build specified target only)
> -	$(call print-help,install,Install QEMU, documentation and tools)
>  	$(call print-help,ctags/TAGS,Generate tags file for editors)
>  	$(call print-help,cscope,Generate cscope index)
> -	$(call print-help,sparse,Run sparse on the QEMU source)
> -	@echo  ''
> -	@echo  'Cleaning targets:'
> -	$(call print-help,clean,Remove most generated files but keep the config)
> -	$(call print-help,distclean,Remove all generated files)
>  	$(call print-help,dist,Build a distributable tarball)
>  	@echo  ''
>  	@echo  'Test targets:'
> -	$(call print-help,check,Run all tests (check-help for details))
> -	$(call print-help,bench,Run all benchmarks)
>  	$(call print-help,docker,Help about targets running tests inside containers)
>  	$(call print-help,vm-help,Help about targets running tests inside VM)
> -	@echo  ''
> -	@echo  'Documentation targets:'
> -	$(call print-help,html info pdf txt man,Build documentation in specified format)
> -	@echo  ''
> -ifdef CONFIG_WIN32
> -	@echo  'Windows targets:'
> -	$(call print-help,installer,Build NSIS-based installer for QEMU)
> -ifdef QEMU_GA_MSI_ENABLED
> -	$(call print-help,msi,Build MSI-based installer for qemu-ga)
> -endif
> -	@echo  ''
> -endif
> -	$(call print-help,$(MAKE) [targets],(quiet build, default))
> -	$(call print-help,$(MAKE) V=1 [targets],(verbose build))
> -
> -# will delete the target of a rule if commands exit with a nonzero exit status
> -.DELETE_ON_ERROR:
>  
> -print-%:
> -	@echo '$*=$($*)'
> +else
> +$(filter-out $(SRCPATH_GOALS), all $(MAKECMDGOALS)): recurse
> +.PHONY: $(MAKECMDGOALS)
> +recurse:
> +	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
> +	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
> +
> +distclean::
> +	rm -rf build
> +endif
> diff --git a/Makefile b/Makefile.build
> similarity index 90%
> copy from Makefile
> copy to Makefile.build
> index d6c5c9fdef..1c75d4e3b5 100644
> --- a/Makefile
> +++ b/Makefile.build
> @@ -24,14 +24,7 @@ quiet-command-run = $(if $(V),,$(if $2,printf "  %-7s %s\n" $2 $3 && ))$1
>  quiet-@ = $(if $(V),,@)
>  quiet-command = $(quiet-@)$(call quiet-command-run,$1,$2,$3)
>  
> -UNCHECKED_GOALS := %clean TAGS cscope ctags dist \
> -    help check-help print-% \
> -    docker docker-% vm-help vm-test vm-build-%
> -
>  # All following code might depend on configuration variables
> -ifneq ($(wildcard config-host.mak),)
> -# Put the all: rule here so that config-host.mak can contain dependencies.
> -all:
>  include config-host.mak
>  
>  git-submodule-update:
> @@ -69,7 +62,7 @@ export NINJA=./ninjatool
>  ninjatool: build.ninja
>  
>  Makefile.ninja: build.ninja ninjatool
> -	./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < $< > $@
> +	./ninjatool -t ninja2make --omit clean dist uninstall < $< > $@
>  -include Makefile.ninja
>  
>  ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
> @@ -108,14 +101,6 @@ ifeq ($(CONFIG_PLUGIN),y)
>  config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
>  endif
>  
> -else
> -config-host.mak:
> -ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
> -	@echo "Please call configure before running make!"
> -	@exit 1
> -endif
> -endif
> -
>  # Only needed in case Makefile.ninja does not exist.
>  .PHONY: ninja-clean ninja-distclean clean-ctlist
>  clean-ctlist:
> @@ -128,8 +113,7 @@ build.ninja: config-host.mak
>  Makefile: ;
>  configure: ;
>  
> -.PHONY: all clean cscope distclean install \
> -	recurse-all dist msi FORCE
> +.PHONY: all clean distclean recurse-all dist msi
>  
>  SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
>  
> @@ -176,7 +160,6 @@ slirp/all: .git-submodule-status
>  
>  ROM_DIRS = $(addprefix pc-bios/, $(ROMS))
>  ROM_DIRS_RULES=$(foreach t, all clean, $(addsuffix /$(t), $(ROM_DIRS)))
> -# Only keep -O and -g cflags
>  .PHONY: $(ROM_DIRS_RULES)
>  $(ROM_DIRS_RULES):
>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" TARGET_DIR="$(dir $@)" $(notdir $@),)
> @@ -200,9 +183,7 @@ clean: recurse-clean ninja-clean clean-ctlist
>  	rm -f fsdev/*.pod scsi/*.pod
>  
>  VERSION = $(shell cat $(SRC_PATH)/VERSION)
> -
>  dist: qemu-$(VERSION).tar.bz2
> -
>  qemu-%.tar.bz2:
>  	$(SRC_PATH)/scripts/make-release "$(SRC_PATH)" "$(patsubst qemu-%.tar.bz2,%,$@)"
>  
> @@ -221,22 +202,6 @@ distclean: clean ninja-distclean
>  	rm -f linux-headers/asm
>  	rm -Rf .sdk
>  
> -.PHONY: ctags
> -ctags:
> -	rm -f tags
> -	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
> -
> -.PHONY: TAGS
> -TAGS:
> -	rm -f TAGS
> -	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
> -
> -.PHONY: cscope
> -cscope:
> -	rm -f "$(SRC_PATH)"/cscope.*
> -	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
> -	cscope -b -i"$(SRC_PATH)/cscope.files"
> -
>  # Needed by "meson install"
>  export DESTDIR
>  
> diff --git a/configure b/configure
> index 91c5d78184..dffbde47a5 100755
> --- a/configure
> +++ b/configure
> @@ -33,29 +33,6 @@ then
>  
>      mkdir build
>      touch $MARKER
> -
> -    cat > GNUmakefile <<'EOF'
> -# This file is auto-generated by configure to support in-source tree
> -# 'make' command invocation
> -
> -ifeq ($(MAKECMDGOALS),)
> -recurse: all
> -endif
> -
> -.NOTPARALLEL: %
> -%: force
> -	@echo 'changing dir to build for $(MAKE) "$(MAKECMDGOALS)"...'
> -	@$(MAKE) -C build -f Makefile $(MAKECMDGOALS)
> -	@if test "$(MAKECMDGOALS)" = "distclean" && \
> -	    test -e build/auto-created-by-configure ; \
> -	then \
> -	    rm -rf build GNUmakefile ; \
> -	fi
> -force: ;
> -.PHONY: force
> -GNUmakefile: ;
> -
> -EOF
>      cd build
>      exec $source_path/configure "$@"
>  fi
> @@ -7856,7 +7833,6 @@ DIRS="$DIRS tests/qtest tests/qemu-iotests tests/vm tests/fp tests/qgraph"
>  DIRS="$DIRS docs docs/interop fsdev scsi"
>  DIRS="$DIRS pc-bios/optionrom pc-bios/s390-ccw"
>  DIRS="$DIRS roms/seabios"
> -LINKS="Makefile"
>  LINKS="$LINKS tests/tcg/lm32/Makefile"
>  LINKS="$LINKS tests/tcg/Makefile.target"
>  LINKS="$LINKS pc-bios/optionrom/Makefile"
> @@ -7888,6 +7864,7 @@ for f in $LINKS ; do
>          symlink "$source_path/$f" "$f"
>      fi
>  done
> +symlink "$source_path/Makefile.build" "Makefile"
>  for f in $UNLINK ; do
>      if [ -L "$f" ]; then
>          rm -f "$f"


