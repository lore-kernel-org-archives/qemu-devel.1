Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E444C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CC120760
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAK0A8YC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CC120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfFN-0003lv-1j
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf9R-00054V-Qg
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:59:58 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:37342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqf9P-0003oV-VI
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:59:57 -0400
Received: by mail-ej1-x641.google.com with SMTP id lx13so6714943ejb.4
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vWyTOJ0gJZqQnb+e8CIRNzlbT2jRcTwfWDz7YwtpvWs=;
 b=bAK0A8YCuOq8UqHHlFQ4a3CNPGv2GRvKVjBD2OnKn5RC7iTxT3D6in3IDkkCa7HikL
 q7SRqmJFwbuoZNc2Wfez2hdUMRW++eP2lX9lUt67HwBOOLbmc0pK4cVLnSVTBX/ycam1
 n82AZgjIYBn8+r8kj3Db4E8faVjdTqYWjCb+d0ZRB5+0trFNZD3sSReRAMXP54NNq94l
 /WCQWwXCJgS9UIvQ4i68zvVh4LP3EZDiPvmgWHWk2kwLd/erMOl1yhBEovQWFMRPm9lR
 ZECRlApX4PMez2l2LCF/pgmVd2XHYoXrbH1BbXjtqQ8DT1IqlF/ASqyY3LwvdSFrxjSI
 bQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vWyTOJ0gJZqQnb+e8CIRNzlbT2jRcTwfWDz7YwtpvWs=;
 b=mxmXJotho1IOPBEyOxN1v0dRnVg04HF3tga6aTRA/pqXz6Cfxnx2NC7XDojVXuTDBn
 75hw5CqFtuIu30fMLUwVzx6gLKIKl2men7Mn0EQfVwxeqKk6lJpTtwCJztMKwwq8kotQ
 +sVYuCU44Y3lJ3wphdN34y1LnrlJMnpA34CJqGOaEJx+4CERL//cRsvOLJyouAxd44/B
 deLDIyFhxAXmpnXe/ibXzk6dhQJNOqSeH69e5+ITC9di6Z8JH77KC8waJNNqmalOp5TY
 PKCTAT/Mj3aN1AtX0HhMTAtPH8octTEyU8ZqG+plW6PqX1xiRmFaX+vxARYZZ/eXbmOC
 5wzw==
X-Gm-Message-State: AOAM531xzrZgH73GFI7S6QZAphS+jEDEaTU4Arv9MQ5cmKAZDZo9m1e+
 EzhL5f7qUX9zvgAGskihgQq0MAwwiKw=
X-Google-Smtp-Source: ABdhPJzteFYRquKFGOF2nccI46jihi8SafeCPZUv1X7/0r8K4gDWEdUJWkaC6vN6zw6HoPe6DDnypw==
X-Received: by 2002:a17:906:9244:: with SMTP id
 c4mr23174804ejx.60.1593619194218; 
 Wed, 01 Jul 2020 08:59:54 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c9sm6600121edv.8.2020.07.01.08.59.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:59:53 -0700 (PDT)
Subject: Re: [PATCH v4 39/40] testing: add check-build target
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-40-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0cd46360-19ff-6ca3-46f7-7e3712a971e4@amsat.org>
Date: Wed, 1 Jul 2020 17:59:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200701135652.1366-40-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 3:56 PM, Alex Bennée wrote:
> If we want to continue to split build and check phase it seems like a
> good idea to allow building of the tests during our multi-threaded
> build phase.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.yml         |  5 ++++-
>  tests/Makefile.include | 17 +++++++++++++----
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 83e38ea19f3..b0e5417146b 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -36,7 +36,7 @@ include:
>      - make -j"$JOBS"
>      - if test -n "$MAKE_CHECK_ARGS";
>        then
> -        make $MAKE_CHECK_ARGS ;
> +        make -j"$JOBS" $MAKE_CHECK_ARGS ;
>        fi
>  
>  .native_test_job_template: &native_test_job_definition
> @@ -60,6 +60,7 @@ build-system-ubuntu-main:
>      TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
>        moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
>        riscv64-softmmu sparc-softmmu
> +    MAKE_CHECK_ARGS: check-build
>    artifacts:
>      paths:
>        - build
> @@ -90,6 +91,7 @@ build-system-fedora-alt:
>      TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
>        riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
>        xtensa-softmmu nios2-softmmu or1k-softmmu
> +    MAKE_CHECK_ARGS: check-build
>    artifacts:
>      paths:
>        - build
> @@ -124,6 +126,7 @@ build-system-fedora-disabled:
>        --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>        --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
>      TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
> +    MAKE_CHECK_ARGS: check-build
>    artifacts:
>      paths:
>        - build
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c316e0d6647..94b1cc8302e 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -22,6 +22,8 @@ endif
>  	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>  	@echo " $(MAKE) check-clean          Clean the tests and related data"
>  	@echo
> +	@echo "The following are useful for CI builds"
> +	@echo " $(MAKE) check-build          Build most test binaris"

Typo "binaries".

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  	@echo " $(MAKE) get-vm-images        Downloads all images used by acceptance tests, according to configured targets (~350 MB each, 1.5 GB max)"
>  	@echo
>  	@echo
> @@ -649,6 +651,10 @@ $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/all $(c
>  	  QTEST_QEMU_BINARY=$*-softmmu/qemu-system-$* \
>  	  QTEST_QEMU_IMG=qemu-img$(EXESUF))
>  
> +build-qtest: $(patsubst %, %-softmmu/all, $(QTEST_TARGETS)) $(check-qtest-y)
> +
> +build-unit: $(check-unit-y)
> +
>  check-unit: $(check-unit-y)
>  	$(call do_test_human, $^)
>  
> @@ -680,7 +686,6 @@ check-report.tap: $(patsubst %,check-report-qtest-%.tap, $(QTEST_TARGETS)) check
>  FP_TEST_BIN=$(BUILD_DIR)/tests/fp/fp-test
>  
>  # the build dir is created by configure
> -.PHONY: $(FP_TEST_BIN)
>  $(FP_TEST_BIN): config-host.h $(test-util-obj-y)
>  	$(call quiet-command, \
>  	 	$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V="$(V)" $(notdir $@), \
> @@ -814,9 +819,10 @@ check-softfloat-ops: $(SF_MATH_RULES)
>  
>  .PHONY: check-softfloat
>  ifeq ($(CONFIG_TCG),y)
> -check-softfloat: check-softfloat-conv check-softfloat-compare check-softfloat-ops
> +build-softfloat: $(FP_TEST_BIN)
> +check-softfloat: build-softfloat check-softfloat-conv check-softfloat-compare check-softfloat-ops
>  else
> -check-softfloat:
> +build-softfloat check-softfloat:
>  	$(call quiet-command, /bin/true, "FLOAT TEST", \
>  		"SKIPPED for non-TCG builds")
>  endif
> @@ -955,7 +961,8 @@ check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  ifeq ($(CONFIG_TOOLS),y)
>  check-block: $(patsubst %,check-%, $(check-block-y))
>  endif
> -check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
> +check-build: build-unit build-softfloat build-qtest
> +
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y:%=tests/qtest/%$(EXESUF))) $(check-qtest-generic-y:%=tests/qtest/%$(EXESUF)))
> @@ -963,6 +970,8 @@ check-clean:
>  	rm -f tests/qtest/dbus-vmstate1-gen-timestamp
>  	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
>  
> +check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
> +
>  clean: check-clean
>  
>  # Build the help program automatically
> 

