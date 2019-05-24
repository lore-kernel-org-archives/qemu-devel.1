Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA952C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A38F20675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A38F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9S7-0004NG-PY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:37:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU9Ot-0001tZ-Jb
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU9Os-0007y4-4h
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hU9Or-0007wa-TU
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:34:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B44B356C4;
	Fri, 24 May 2019 12:34:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 967F35D71B;
	Fri, 24 May 2019 12:34:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 259C31138648; Fri, 24 May 2019 14:34:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-4-armbru@redhat.com>
	<d70ddf0d-0eaa-406a-7427-dc1df1fac76f@redhat.com>
Date: Fri, 24 May 2019 14:34:08 +0200
In-Reply-To: <d70ddf0d-0eaa-406a-7427-dc1df1fac76f@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	24 May 2019 07:28:32 +0200")
Message-ID: <87blzs9glb.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 24 May 2019 12:34:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, pbonzini@redhat.com,
	Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/23/19 10:15 AM, Markus Armbruster wrote:
>> We make a few sub-directories recursively, in particular
>> $(TARGET_DIRS).
>>=20
>> For goal "all", we do it the nice way: "all" has a prerequisite
>> subdir-T for each T in $(TARGET_DIRS), and T's recipe runs make
>> recursively.  Behaves nicely with -j and -k.
>>=20
>> For other goals such as "clean" and "install", the recipe runs make
>> recursively in a for loop.  Ignores -j and -k.
>>=20
>> The next commit will fix that for "clean" and "install".  This commit
>> prepares the ground by renaming the targets we use for "all" to
>> include the goal for the sub-make.  This will permit reusing them for
>> goals other than "all".
>>=20
>> Targets subdir-T for T in $(TARGET_DIRS) run "make all" in T.  Rename
>> to T/all, and declare phony.
>>=20
>> Targets romsubdir-R for R in $(ROMS) run "make" in pc-bios/R.  Default
>> goal is "all" for all R.  Rename to pc-bios/R/all, and declare phony.
>>=20
>> The remainder are renamed just for consistency.
>>=20
>> Target subdir-dtc runs "make libbft/libfdt.a" in dtc.  Rename to
>> dtc/all, and declare phony.
>>=20
>> Target subdir-capstone runs make $(BUILD_DIR)/capstone/$(LIBCAPSTONE)
>> in $(SRC_PATH)/capstone.  Rename to capstone/all, and declare phony.
>>=20
>> Target subdir-slirp runs "make" in $(SRC_PATH)/slirp.  Default goal is
>> all, which builds $(BUILD_DIR)/libslirp.a.  Rename to slirp/all, and
>> declare phony.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  Makefile               | 30 ++++++++++++++++++------------
>>  configure              |  6 +++---
>>  tests/Makefile.include |  3 ++-
>>  3 files changed, 23 insertions(+), 16 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 12e470fa03..09c726bcc2 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -436,8 +436,8 @@ config-host.h-timestamp: config-host.mak
>>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN",=
"$@")
>>=20=20
>> -SUBDIR_RULES=3D$(patsubst %,subdir-%, $(TARGET_DIRS))
>> -SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu,$(SUBDIR_RULES))
>> +SUBDIR_RULES=3D$(addsuffix /all, $(TARGET_DIRS))
>> +SOFTMMU_SUBDIR_RULES=3D$(filter %-softmmu/all,$(SUBDIR_RULES))
>>=20=20
>>  $(SOFTMMU_SUBDIR_RULES): $(authz-obj-y)
>>  $(SOFTMMU_SUBDIR_RULES): $(block-obj-y)
>> @@ -447,14 +447,16 @@ $(SOFTMMU_SUBDIR_RULES): $(io-obj-y)
>>  $(SOFTMMU_SUBDIR_RULES): config-all-devices.mak
>>  $(SOFTMMU_SUBDIR_RULES): $(edk2-decompressed)
>>=20=20
>> -subdir-%:
>> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $* V=3D"$(V)" TARG=
ET_DIR=3D"$*/" all,)
>> +.PHONY: $(SUBDIR_RULES)
>> +$(SUBDIR_RULES):
>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V=
)" TARGET_DIR=3D"$(dir $@)" all,)
>>=20=20
>>  DTC_MAKE_ARGS=3D-I$(SRC_PATH)/dtc VPATH=3D$(SRC_PATH)/dtc -C dtc V=3D"$=
(V)" LIBFDT_srcdir=3D$(SRC_PATH)/dtc/libfdt
>>  DTC_CFLAGS=3D$(CFLAGS) $(QEMU_CFLAGS)
>>  DTC_CPPFLAGS=3D-I$(BUILD_DIR)/dtc -I$(SRC_PATH)/dtc -I$(SRC_PATH)/dtc/l=
ibfdt
>>=20=20
>> -subdir-dtc: .git-submodule-status dtc/libfdt dtc/tests
>> +.PHONY: dtc/all
>> +dtc/all: .git-submodule-status dtc/libfdt dtc/tests
>>  	$(call quiet-command,$(MAKE) $(DTC_MAKE_ARGS) CPPFLAGS=3D"$(DTC_CPPFLA=
GS)" CFLAGS=3D"$(DTC_CFLAGS)" LDFLAGS=3D"$(LDFLAGS)" ARFLAGS=3D"$(ARFLAGS)"=
 CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" $(SUBDIR_MAKEFLAGS) libfdt/libfdt.a=
,)
>
> OK
>
>>=20=20
>>  dtc/%: .git-submodule-status
>> @@ -472,21 +474,25 @@ CAP_CFLAGS +=3D -DCAPSTONE_HAS_ARM64
>>  CAP_CFLAGS +=3D -DCAPSTONE_HAS_POWERPC
>>  CAP_CFLAGS +=3D -DCAPSTONE_HAS_X86
>>=20=20
>> -subdir-capstone: .git-submodule-status
>> +.PHONY: capstone/all
>> +capstone/all: .git-submodule-status
>>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/capstone CAPSTONE_SHARED=
=3Dno BUILDDIR=3D"$(BUILD_DIR)/capstone" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(=
LD)" RANLIB=3D"$(RANLIB)" CFLAGS=3D"$(CAP_CFLAGS)" $(SUBDIR_MAKEFLAGS) $(BU=
ILD_DIR)/capstone/$(LIBCAPSTONE))
>
> OK
>
>>=20=20
>> -subdir-slirp: .git-submodule-status
>> +.PHONY: slirp/all
>> +slirp/all: .git-submodule-status
>>  	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR=3D"$(BUILD=
_DIR)/slirp" CC=3D"$(CC)" AR=3D"$(AR)" LD=3D"$(LD)" RANLIB=3D"$(RANLIB)" CF=
LAGS=3D"$(QEMU_CFLAGS) $(CFLAGS)" LDFLAGS=3D"$(LDFLAGS)")
>
> OK
>
>>=20=20
>>  $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) \
>>  	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
>>=20=20
>> -ROMSUBDIR_RULES=3D$(patsubst %,romsubdir-%, $(ROMS))
>> +ROM_DIRS =3D $(addprefix pc-bios/, $(ROMS))
>> +ROMSUBDIR_RULES=3D$(addsuffix /all, $(ROM_DIRS))
>>  # Only keep -O and -g cflags
>> -romsubdir-%:
>> -	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C pc-bios/$* V=3D"$(=
V)" TARGET_DIR=3D"$*/" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))",)
>> +.PHONY: $(ROMSUBDIR_RULES)
>> +$(ROMSUBDIR_RULES):
>> +	$(call quiet-command,$(MAKE) $(SUBDIR_MAKEFLAGS) -C $(dir $@) V=3D"$(V=
)" TARGET_DIR=3D"$(dir $@)" CFLAGS=3D"$(filter -O% -g%,$(CFLAGS))",)
>
> OK
>
>>=20=20
>> -ALL_SUBDIRS=3D$(TARGET_DIRS) $(patsubst %,pc-bios/%, $(ROMS))
>> +ALL_SUBDIRS=3D$(TARGET_DIRS) $(ROM_DIRS)
>>=20=20
>>  recurse-all: $(SUBDIR_RULES) $(ROMSUBDIR_RULES)
>>=20=20
>> @@ -1087,7 +1093,7 @@ endif
>>  	@$(if $(TARGET_DIRS), \
>>  		echo 'Architecture specific targets:'; \
>>  		$(foreach t, $(TARGET_DIRS), \
>> -		printf "  %-30s - Build for %s\\n" $(patsubst %,subdir-%,$(t)) $(t);)=
 \
>> +		printf "  %-30s - Build for %s\\n" $(t)/all $(t);) \
>
> OK
>
>>  		echo '')
>>  	@echo  'Cleaning targets:'
>>  	@echo  '  clean           - Remove most generated files but keep the c=
onfig'
>> diff --git a/configure b/configure
>> index d2fc346302..2897434dda 100755
>> --- a/configure
>> +++ b/configure
>> @@ -6570,7 +6570,7 @@ if test "$slirp" !=3D "no"; then
>>    echo "SLIRP_LIBS=3D$slirp_libs" >> $config_host_mak
>>  fi
>>  if [ "$slirp" =3D "git" -o "$slirp" =3D "internal" ]; then
>> -    echo "config-host.h: subdir-slirp" >> $config_host_mak
>> +    echo "config-host.h: slirp/all" >> $config_host_mak
>>  fi
>>  if test "$vde" =3D "yes" ; then
>>    echo "CONFIG_VDE=3Dy" >> $config_host_mak
>> @@ -7836,10 +7836,10 @@ if test -n "$enabled_cross_compilers"; then
>>  fi
>>=20=20
>>  if [ "$fdt" =3D "git" ]; then
>> -  echo "config-host.h: subdir-dtc" >> $config_host_mak
>> +  echo "config-host.h: dtc/all" >> $config_host_mak
>>  fi
>>  if [ "$capstone" =3D "git" -o "$capstone" =3D "internal" ]; then
>> -  echo "config-host.h: subdir-capstone" >> $config_host_mak
>> +  echo "config-host.h: capstone/all" >> $config_host_mak
>>  fi
>>  if test -n "$LIBCAPSTONE"; then
>>    echo "LIBCAPSTONE=3D$LIBCAPSTONE" >> $config_host_mak
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 1865f6b322..2b8d34ca25 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -1,3 +1,4 @@
>> +# -*- Mode: makefile -*-
>>=20=20
>>  .PHONY: check-help
>>  check-help:
>> @@ -880,7 +881,7 @@ define do_test_tap
>>  endef
>>=20=20
>>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
>> -$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: subdir-%=
-softmmu $(check-qtest-y)
>> +$(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmm=
u/all $(check-qtest-y)
>>  	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
>>  	  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
>>  	  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
>>=20
>
> There is another one:
>
> -- >8 --
>  # gtester tests with TAP output
>
> -$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: subdir-%-softmmu $(check-qtest-y)
> +$(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: %-softmmu/all $(check-qtest-y)
>         $(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y),=
 \
>           QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
>           QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))

Good catch.

> ---
>
> With the fix amended:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

