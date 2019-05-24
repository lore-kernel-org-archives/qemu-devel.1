Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A06C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4E22168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 05:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4E22168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49265 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU36R-0001tU-BS
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 01:50:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU35a-0001VO-DL
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU35T-0003Vp-89
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:49:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU35Q-0003QZ-KT
	for qemu-devel@nongnu.org; Fri, 24 May 2019 01:49:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id l17so189243wrm.10
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 22:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=dpc+72flo8t81legvShnc9CcRVnNYNtLKeta/gvSeWY=;
	b=c3fSbdNh4lLJY+mPkhNAdhQIfTBA/HF6HWXKkwOgqAzPXPZPurgNDsio9TDSlNAm2H
	fUnJWz9OBghDaBWvq/KoQX+AVZUH3RlWNnLRkGFxUYBkV5BrqcdlT8U6rjeiRxxqVu55
	FngNu3AIzDpbcaQOaCct2hwNE2vYGOQfD/RWLs1AXNPM2un7RbsnM2r13l4ylcsX5len
	TiBLrDnls2jz6f+FcMqTCN5LCkeAq4O5JQxzJTM0EcuaJZ1Bv9oojjhf3AU5F2Gg2e0Y
	3h0o/niSR3cW9oFMkj5jxo4GJpCt97pJYWSn1oirbKD10cgRkiVQxTwUoh6dPF2AchOz
	gUNw==
X-Gm-Message-State: APjAAAXYY2d2D+ENSfGUvfe9Erpn5Bt8CaNL85YsyRk2uQ23CLLCiUKy
	AtbAJ+HSV9xKDV5qYBrdtCFBhg==
X-Google-Smtp-Source: APXvYqyNbVbDq1XT5t3N7FS7J69ZziFRgLDCzcwYveNC9dz7Pp9MQUcrAApjCK766Wohylp48n/hWg==
X-Received: by 2002:adf:ab45:: with SMTP id r5mr36299125wrc.100.1558676981393; 
	Thu, 23 May 2019 22:49:41 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id y12sm898984wrh.40.2019.05.23.22.49.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 22:49:40 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b7370040-3076-5ff5-3b51-b96b0d84184f@redhat.com>
Date: Fri, 24 May 2019 07:49:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523081538.2291-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [RFC v4 5/7] tests: New make target check-source
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
> Make target check-source is for checking the source code itself.  For
> now, there's just one such check, make target check-headers.  It
> checks basic header sanity: for each header "FOO.h", test whether
> 
> 	#include "qemu/osdep.h"
> 	#include "FOO.h"
> 	#include "FOO.h"
> 
> compiles.
> 
> The test works only in a git tree, with git installed.  It is skipped
> unless $(SRC_PATH)/.git exists.
> 
> Third-party headers we don't intend to clean up are excluded from this
> test.  So are a few "funny" headers.  See make variable
> excluded-headers.
> 
> A large number of headers don't pass this test, by design or by
> accident.  To keep things more manageable, exclude all headers outside
> include/ for now.
> 
> Headers known to fail the test are marked with
> 
>     /* FIXME Does not pass make check-headers, yet! */
> 
> Headers known to work only in certain configurations are marked like
> 
>     /* FIXME Does not pass make check-headers without CONFIG_WIN32, yet! */
> 
> I tried to find and mark all of them by testing various
> configurations.  Still, "make check" might fail for configurations I
> didn't test.
> 
> Known issue: some of these don't actually need fixing; they're *meant*
> to work only in certain configurations.  We'll want to invent a
> suitable marker that doesn't claim FIXME.
> 
> Some headers may only be included into target-dependent code: they use
> identifiers poisoned by exec/poison.h, or include cpu.h.  These
> headers are marked with a comment
> 
>     /* NOTE: May only be included into target-dependent code */
> 
> The test treats them specially.
> 
> Known issue: some of these are intended for specific targets.  The
> test should skip them for other targets, but doesn't.  They're marked
> FIXME instead, which is wrong.
> 
> New make target check-bad-headers runs the test for headers expected
> to fail it.  This helps with examining the failures.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]>
> diff --git a/Makefile b/Makefile
> index 59de8e2494..42f02c5ceb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -416,6 +416,8 @@ dummy := $(call unnest-vars,, \
>                  audio-obj-m \
>                  trace-obj-y)
>  
> +RECURSIVE_TARGETS := all clean install
> +
>  include $(SRC_PATH)/tests/Makefile.include
>  
>  all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recurse-all modules
> @@ -436,7 +438,7 @@ config-host.h-timestamp: config-host.mak
>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$@")
>  
> -TARGET_DIRS_RULES := $(foreach t, all clean install, $(addsuffix /$(t), $(TARGET_DIRS)))
> +TARGET_DIRS_RULES:=$(foreach t, $(RECURSIVE_TARGETS), $(addsuffix /$(t), $(TARGET_DIRS)))
>  
>  SOFTMMU_ALL_RULES=$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
>  $(SOFTMMU_ALL_RULES): $(authz-obj-y)
> diff --git a/Makefile.target b/Makefile.target
> index fdbe7c89f4..a46cfda580 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -41,6 +41,7 @@ STPFILES=
>  
>  # Makefile Tests
>  include $(SRC_PATH)/tests/tcg/Makefile.include
> +include $(SRC_PATH)/tests/check-headers.mak
>  
>  config-target.h: config-target.h-timestamp
>  config-target.h-timestamp: config-target.mak
> @@ -216,6 +217,22 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_PATH)/scripts/hxtool
>  hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scripts/hxtool
>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN","$(TARGET_DIR)$@")
>  
> +.PHONY: check-headers
> +ifeq ($(wildcard $(SRC_PATH)/.git),)
> +check-headers check-bad-headers:
> +	@echo "  SKIP  $@ (requires a git tree)"
> +else
> +check-headers: $(check-target-header-tests:.c=.o)
> +
> +# Expected to fail:
> +check-bad-headers: $(check-bad-target-header-tests:.c=.o)
> +
> +.SECONDARY: $(check-target-header-tests)
> +$(check-target-header-tests) $(check-bad-target-header-tests): tests/header-test-template.c
> +	@mkdir -p $(dir $@)
> +	@sed 's,@header@,$(subst tests/headers/,,$(@:.c=.h)),' <$< >$@
> +endif
> +
>  clean: clean-target
>  	rm -f *.a *~ $(PROGS)
>  	rm -f $(shell find . -name '*.[od]')
> @@ -238,3 +255,5 @@ endif
>  
>  generated-files-y += config-target.h
>  Makefile: $(generated-files-y)
> +
> +-include $(check-target-header-tests:.c=.d) $(check-bad-target-header-tests:.c=.d)

$ make microblazeel-softmmu/tests/headers/include/exec/user/abitypes.o
./include/exec/user/abitypes.h:6:10: fatal error: cpu.h: No such file or
directory
make: *** [./rules.mak:69:
microblazeel-softmmu/tests/headers/include/exec/user/abitypes.o] Error 1

^ this one looks legit, it's arch-specific, right?

$ make tests/headers/include/hw/net/lance.o
  CC      tests/headers/include/hw/net/lance.o
In file included from tests/headers/include/hw/net/lance.c:14:
./include/hw/net/lance.h:42:5: error: unknown type name ‘SysBusDevice’
     SysBusDevice parent_obj;
     ^~~~~~~~~~~~
make: *** [./rules.mak:69: tests/headers/include/hw/net/lance.o] Error 1

$ make tests/headers/include/hw/isa/vt82c686.o
  CC      tests/headers/include/hw/isa/vt82c686.o
In file included from tests/headers/include/hw/isa/vt82c686.c:14:
./include/hw/isa/vt82c686.h:13:27: error: unknown type name ‘qemu_irq’
                           qemu_irq sci_irq);
                           ^~~~~~~~
make: *** [./rules.mak:69: tests/headers/include/hw/isa/vt82c686.o]

Nice, I like it :)

The rule pattern is not obvious (in particular with arch-specific
targets), but it has probably always been like that.

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

