Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0E4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8416E20851
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 12:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8416E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU9Ty-0005aV-NQ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 08:39:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU9RY-0004BY-VJ
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU9RX-000139-Ln
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:37:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hU9RX-00012m-DP
	for qemu-devel@nongnu.org; Fri, 24 May 2019 08:37:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA836C06783D;
	Fri, 24 May 2019 12:37:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E317A5B689;
	Fri, 24 May 2019 12:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 788621138648; Fri, 24 May 2019 14:36:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-6-armbru@redhat.com>
	<b7370040-3076-5ff5-3b51-b96b0d84184f@redhat.com>
Date: Fri, 24 May 2019 14:36:58 +0200
In-Reply-To: <b7370040-3076-5ff5-3b51-b96b0d84184f@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	24 May 2019 07:49:39 +0200")
Message-ID: <877eag9ggl.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Fri, 24 May 2019 12:37:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 5/23/19 10:15 AM, Markus Armbruster wrote:
>> Make target check-source is for checking the source code itself.  For
>> now, there's just one such check, make target check-headers.  It
>> checks basic header sanity: for each header "FOO.h", test whether
>>=20
>> 	#include "qemu/osdep.h"
>> 	#include "FOO.h"
>> 	#include "FOO.h"
>>=20
>> compiles.
>>=20
>> The test works only in a git tree, with git installed.  It is skipped
>> unless $(SRC_PATH)/.git exists.
>>=20
>> Third-party headers we don't intend to clean up are excluded from this
>> test.  So are a few "funny" headers.  See make variable
>> excluded-headers.
>>=20
>> A large number of headers don't pass this test, by design or by
>> accident.  To keep things more manageable, exclude all headers outside
>> include/ for now.
>>=20
>> Headers known to fail the test are marked with
>>=20
>>     /* FIXME Does not pass make check-headers, yet! */
>>=20
>> Headers known to work only in certain configurations are marked like
>>=20
>>     /* FIXME Does not pass make check-headers without CONFIG_WIN32, yet!=
 */
>>=20
>> I tried to find and mark all of them by testing various
>> configurations.  Still, "make check" might fail for configurations I
>> didn't test.
>>=20
>> Known issue: some of these don't actually need fixing; they're *meant*
>> to work only in certain configurations.  We'll want to invent a
>> suitable marker that doesn't claim FIXME.
>>=20
>> Some headers may only be included into target-dependent code: they use
>> identifiers poisoned by exec/poison.h, or include cpu.h.  These
>> headers are marked with a comment
>>=20
>>     /* NOTE: May only be included into target-dependent code */
>>=20
>> The test treats them specially.
>>=20
>> Known issue: some of these are intended for specific targets.  The
>> test should skip them for other targets, but doesn't.  They're marked
>> FIXME instead, which is wrong.
>>=20
>> New make target check-bad-headers runs the test for headers expected
>> to fail it.  This helps with examining the failures.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
> [...]>
>> diff --git a/Makefile b/Makefile
>> index 59de8e2494..42f02c5ceb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -416,6 +416,8 @@ dummy :=3D $(call unnest-vars,, \
>>                  audio-obj-m \
>>                  trace-obj-y)
>>=20=20
>> +RECURSIVE_TARGETS :=3D all clean install
>> +
>>  include $(SRC_PATH)/tests/Makefile.include
>>=20=20
>>  all: $(DOCS) $(if $(BUILD_DOCS),sphinxdocs) $(TOOLS) $(HELPERS-y) recur=
se-all modules
>> @@ -436,7 +438,7 @@ config-host.h-timestamp: config-host.mak
>>  qemu-options.def: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN",=
"$@")
>>=20=20
>> -TARGET_DIRS_RULES :=3D $(foreach t, all clean install, $(addsuffix /$(t=
), $(TARGET_DIRS)))
>> +TARGET_DIRS_RULES:=3D$(foreach t, $(RECURSIVE_TARGETS), $(addsuffix /$(=
t), $(TARGET_DIRS)))
>>=20=20
>>  SOFTMMU_ALL_RULES=3D$(filter %-softmmu/all, $(TARGET_DIRS_RULES))
>>  $(SOFTMMU_ALL_RULES): $(authz-obj-y)
>> diff --git a/Makefile.target b/Makefile.target
>> index fdbe7c89f4..a46cfda580 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -41,6 +41,7 @@ STPFILES=3D
>>=20=20
>>  # Makefile Tests
>>  include $(SRC_PATH)/tests/tcg/Makefile.include
>> +include $(SRC_PATH)/tests/check-headers.mak
>>=20=20
>>  config-target.h: config-target.h-timestamp
>>  config-target.h-timestamp: config-target.mak
>> @@ -216,6 +217,22 @@ hmp-commands.h: $(SRC_PATH)/hmp-commands.hx $(SRC_P=
ATH)/scripts/hxtool
>>  hmp-commands-info.h: $(SRC_PATH)/hmp-commands-info.hx $(SRC_PATH)/scrip=
ts/hxtool
>>  	$(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -h < $< > $@,"GEN",=
"$(TARGET_DIR)$@")
>>=20=20
>> +.PHONY: check-headers
>> +ifeq ($(wildcard $(SRC_PATH)/.git),)
>> +check-headers check-bad-headers:
>> +	@echo "  SKIP  $@ (requires a git tree)"
>> +else
>> +check-headers: $(check-target-header-tests:.c=3D.o)
>> +
>> +# Expected to fail:
>> +check-bad-headers: $(check-bad-target-header-tests:.c=3D.o)
>> +
>> +.SECONDARY: $(check-target-header-tests)
>> +$(check-target-header-tests) $(check-bad-target-header-tests): tests/he=
ader-test-template.c
>> +	@mkdir -p $(dir $@)
>> +	@sed 's,@header@,$(subst tests/headers/,,$(@:.c=3D.h)),' <$< >$@
>> +endif
>> +
>>  clean: clean-target
>>  	rm -f *.a *~ $(PROGS)
>>  	rm -f $(shell find . -name '*.[od]')
>> @@ -238,3 +255,5 @@ endif
>>=20=20
>>  generated-files-y +=3D config-target.h
>>  Makefile: $(generated-files-y)
>> +
>> +-include $(check-target-header-tests:.c=3D.d) $(check-bad-target-header=
-tests:.c=3D.d)
>
> $ make microblazeel-softmmu/tests/headers/include/exec/user/abitypes.o
> ./include/exec/user/abitypes.h:6:10: fatal error: cpu.h: No such file or
> directory
> make: *** [./rules.mak:69:
> microblazeel-softmmu/tests/headers/include/exec/user/abitypes.o] Error 1
>
> ^ this one looks legit, it's arch-specific, right?

Yes: it includes cpu.h.

> $ make tests/headers/include/hw/net/lance.o
>   CC      tests/headers/include/hw/net/lance.o
> In file included from tests/headers/include/hw/net/lance.c:14:
> ./include/hw/net/lance.h:42:5: error: unknown type name =E2=80=98SysBusDe=
vice=E2=80=99
>      SysBusDevice parent_obj;
>      ^~~~~~~~~~~~
> make: *** [./rules.mak:69: tests/headers/include/hw/net/lance.o] Error 1
>
> $ make tests/headers/include/hw/isa/vt82c686.o
>   CC      tests/headers/include/hw/isa/vt82c686.o
> In file included from tests/headers/include/hw/isa/vt82c686.c:14:
> ./include/hw/isa/vt82c686.h:13:27: error: unknown type name =E2=80=98qemu=
_irq=E2=80=99
>                            qemu_irq sci_irq);
>                            ^~~~~~~~
> make: *** [./rules.mak:69: tests/headers/include/hw/isa/vt82c686.o]
>
> Nice, I like it :)
>
> The rule pattern is not obvious (in particular with arch-specific
> targets), but it has probably always been like that.
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

