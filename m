Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8FBC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863C621BE3
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 13:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863C621BE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvLxg-0006xx-So
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 09:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56765)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hvLxJ-0006Xs-9b
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hvLxH-00059p-Ou
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:26:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hvLxH-00059B-Ih
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 09:26:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so1113149wrj.12
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 06:26:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ELWBVRe8LKXltQTmIZV4RzgxZRLwcTTzj7GQpENBNpk=;
 b=FZeQ5QnyjEr0/m1D4toPbslhsdY9+YchY1+pA+m/HCOjR3N2zZc21kHTQH8f2e6ZFR
 20SZMSt0TYYlZSzH/YcvHM3xo1kd6JsB9Nio3NW1OmJFjK94ephlixFXEyqiDIEbRqKz
 pVY0vNl/1z4s4ZkUXpX3XL32cQqPGLkzPv/nc/kNcNzou9lXjsv0QGCJ1lN1gHjxobgH
 Q9CStTwe4CNXSQGh7MJ5nL0YYxZM5mzeoRq7wvLbaW6CWSOlKoR5TaU4LAcu9bBMCqN8
 NUnUJyeUe1RHNgJBi6403K0OOWBm51HnbNYw73qlQTwoHkepUHLyancV+8++Dn5Ojhdv
 hmXA==
X-Gm-Message-State: APjAAAXMj7y8OopHt+WhQ2DqMSCCTLYLG7dRmEUEA2BqT1INRQJABEjT
 6SQpJ3he4M7V5ktBTGgDVfnEaDnSJnE=
X-Google-Smtp-Source: APXvYqxjZfRXnpdzUsUix5/yc3S68ao5dGUGwHlW0TC14EszfVBKX5am7hmAiDJktfcrbwce7vQXnw==
X-Received: by 2002:a5d:518d:: with SMTP id k13mr10988257wrv.40.1565184374287; 
 Wed, 07 Aug 2019 06:26:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:dc26:ed70:9e4c:3810?
 ([2001:b07:6468:f312:dc26:ed70:9e4c:3810])
 by smtp.gmail.com with ESMTPSA id o4sm72729460wmh.35.2019.08.07.06.26.13
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 06:26:13 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190730123759.21723-1-pbonzini@redhat.com>
 <20190730123759.21723-4-pbonzini@redhat.com> <87lfw5i0j1.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8b9e239c-a047-1d76-04ad-3304ff44b7a0@redhat.com>
Date: Wed, 7 Aug 2019 15:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87lfw5i0j1.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 3/3] tests/tcg: move configuration to a
 sub-shell script
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/08/19 15:10, Alex Bennée wrote:
>> -DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
>> +DIRS="tests tests/tcg tests/tcg/lm32 tests/libqos tests/qapi-schema tests/qemu-iotests tests/vm"
>>  DIRS="$DIRS tests/fp tests/qgraph"
>>  DIRS="$DIRS docs docs/interop fsdev scsi"
>>  DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>>  DIRS="$DIRS roms/seabios roms/vgabios"
>> -LINKS="Makefile tests/tcg/Makefile"
>> -LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>> -LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
>> -LINKS="$LINKS tests/fp/Makefile"
>> +LINKS="Makefile"
>> +LINKS="$LINKS tests/tcg/lm32/Makefile po/Makefile"
>> +LINKS="$LINKS tests/tcg/Makefile.target tests/fp/Makefile"
> 
> Is this why I get complaints on a clean tree:
> 
>   libpmem support   no
>   libudev           yes
>   default devices   yes
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 179: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-user.mak: Directory nonexistent
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 180: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-user.mak: Directory nonexistent
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 183: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-user.mak: Directory nonexistent
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 184: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-user.mak: Directory nonexistent
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 193: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-user.mak: Directory nonexistent
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 213: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-aarch64-linux-user.mak: Directory nonexistent
>   /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: 179: /home/alex/lsrc/qemu.git/tests/tcg/configure.sh: cannot create tests/tcg/config-arm-linux-user.mak: Directory nonexist

configure.sh is invoked too early.

> 
> 
>>  LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
>>  LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
>>  LINKS="$LINKS pc-bios/s390-ccw/Makefile"
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 8bb5c97..a3ee649 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -1058,30 +1058,28 @@ BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
>>  CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))
>>  RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
>>
>> -ifeq ($(HAVE_USER_DOCKER),y)
>>  # Probe for the Docker Builds needed for each build
>>  $(foreach PROBE_TARGET,$(TARGET_DIRS), 				\
>>  	$(eval -include $(SRC_PATH)/tests/tcg/Makefile.prereqs))
>> -endif
>>
>>  build-tcg-tests-%:
>>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
>>  		SRC_PATH=$(SRC_PATH) \
>> -	       	V="$(V)" TARGET_DIR="$*/" guest-tests, \
>> +	       	V="$(V)" TARGET="$*" guest-tests, \
>>  		"BUILD", "TCG tests for $*")
>>
>>  run-tcg-tests-%: build-tcg-tests-% %/all
>>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
>>  		SRC_PATH=$(SRC_PATH) SPEED="$(SPEED)" \
>> -		V="$(V)" TARGET_DIR="$*/" run-guest-tests, \
>> +		V="$(V)" TARGET="$*" run-guest-tests, \
>>  		"RUN", "TCG tests for $*")
>>
>>  clean-tcg-tests-%:
>>  	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) \
>>  		-f $(SRC_PATH)/tests/tcg/Makefile.qemu \
>> -		SRC_PATH=$(SRC_PATH) TARGET_DIR="$*/" clean-guest-tests, \
>> +		SRC_PATH=$(SRC_PATH) TARGET="$*" clean-guest-tests, \
>>  		"RUN", "TCG tests for $*")
>>
>>  .PHONY: build-tcg
>> diff --git a/tests/tcg/Makefile.prereqs b/tests/tcg/Makefile.prereqs
>> index 53b0196..7494b31 100644
>> --- a/tests/tcg/Makefile.prereqs
>> +++ b/tests/tcg/Makefile.prereqs
>> @@ -7,24 +7,12 @@
>>  # selection of required docker targets before we invoke a sub-make for
>>  # each target.
>>
>> -# First we need the target makefile which tells us the target architecture
>> -CROSS_CC_GUEST:=
>> --include $(BUILD_DIR)/$(PROBE_TARGET)/config-target.mak
>> -
>> -# Then we load up the target architecture makefiles which tell us
>> -# about the compilers
>>  DOCKER_IMAGE:=
>>
>> --include $(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include
>> --include $(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include
>> +-include $(BUILD_DIR)/tests/tcg/config-$(PROBE_TARGET).mak
>>
>> -ifndef CROSS_CC_GUEST
>>  ifneq ($(DOCKER_IMAGE),)
>>  build-tcg-tests-$(PROBE_TARGET): docker-image-$(DOCKER_IMAGE)
>> +$(BUILD_DIR)/tests/tcg/config_$(PROBE_TARGET).mak: config-host.mak
>> +config-host.mak: $(SRC_PATH)/tests/tcg/configure.sh
>>  endif
>> -endif
>> -
>> -# Clean-up
>> -# undefine TARGET_NAME
>> -# undefine TARGET_BASE_ARCH
>> -# undefine TARGET_ABI_DIR
>> diff --git a/tests/tcg/Makefile.qemu b/tests/tcg/Makefile.qemu
>> index d3f3437..c8bec7b 100644
>> --- a/tests/tcg/Makefile.qemu
>> +++ b/tests/tcg/Makefile.qemu
>> @@ -8,17 +8,22 @@
>>  # to do it for us.
>>  #
>>
>> -# The per ARCH makefile, if it exists, holds extra information about
>> +include $(SRC_PATH)/rules.mak
>> +
>> +# The configure script fills in extra information about
>>  # useful docker images or alternative compiler flags.
>>
>> -include $(TARGET_DIR)config-target.mak
>> -include $(SRC_PATH)/rules.mak
>> -include $(wildcard \
>> -	$(SRC_PATH)/tests/tcg/$(TARGET_BASE_ARCH)/Makefile.include \
>> -	$(SRC_PATH)/tests/tcg/$(TARGET_NAME)/Makefile.include)
>> +CROSS_CC_GUEST:=
>> +DOCKER_IMAGE:=
>> +-include $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak
>>
>>  GUEST_BUILD=
>>  TCG_MAKE=../Makefile.target
>> +
>> +# We also need the Docker make rules to depend on
>> +SKIP_DOCKER_BUILD=1
>> +include $(SRC_PATH)/tests/docker/Makefile.include
>> +
>>  # Support installed Cross Compilers
>>
>>  ifdef CROSS_CC_GUEST
>> @@ -26,11 +31,11 @@ ifdef CROSS_CC_GUEST
>>  .PHONY: cross-build-guest-tests
>>  cross-build-guest-tests:
>>  	$(call quiet-command, \
>> -	   (mkdir -p tests/tcg/$(TARGET_DIR) && cd tests/tcg/$(TARGET_DIR) && \
>> -	    $(MAKE) -f $(TCG_MAKE) TARGET_DIR="$(TARGET_DIR)" CC="$(CROSS_CC_GUEST)" \
>> +	   (mkdir -p tests/tcg/$(TARGET) && cd tests/tcg/$(TARGET) && \
>> +	    $(MAKE) -f $(TCG_MAKE) TARGET="$(TARGET)" CC="$(CROSS_CC_GUEST)" \
>>  			SRC_PATH="$(SRC_PATH)" BUILD_STATIC=$(CROSS_CC_GUEST_STATIC) \
>> -			EXTRA_CFLAGS=$(CROSS_CC_GUEST_CFLAGS)), \
> 
> I expect given we need config-FOO.mak files before that these mkdir's are in the wrong place.

These are mkdirs for tests/tcg/FOO, but I do need to add mkdir -p
tests/tcg to the configure.sh script.

Paolo

