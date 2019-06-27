Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7CC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A59472080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59472080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgR02-0007DP-MA
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 05:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40344)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dinechin@redhat.com>) id 1hgQzA-0006XC-B2
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1hgQz8-0007sR-Em
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:46:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1hgQz5-0007bm-EB
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:46:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D25F30821F4
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 09:46:14 +0000 (UTC)
Received: from ptitpuce (ovpn-116-202.ams2.redhat.com [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36D5A5D9C6;
 Thu, 27 Jun 2019 09:46:12 +0000 (UTC)
References: <1560165301-39026-1-git-send-email-pbonzini@redhat.com>
 <1560165301-39026-4-git-send-email-pbonzini@redhat.com>
 <87woh8i725.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.2; emacs 26.2
From: Christophe de Dinechin <dinechin@redhat.com>
To: qemu-devel@nongnu.org
In-reply-to: <87woh8i725.fsf@dusky.pond.sub.org>
Date: Thu, 27 Jun 2019 11:46:10 +0200
Message-ID: <m1v9wr4azh.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 27 Jun 2019 09:46:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/7] configure: integrate Meson in the
 build system
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> The Meson build system is integrated in the existing configure/make steps
>> by invoking Meson from the configure script and converting Meson's build.ninja
>> rules to an included Makefile.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  Makefile             |   9 +
>>  configure            |  30 ++
>>  meson.build          |   9 +
>>  scripts/ninjatool.py | 964 +++++++++++++++++++++++++++++++++++++++++++++++++++
>
> Uff.
>
>>  4 files changed, 1012 insertions(+)
>>  create mode 100644 meson.build
>>  create mode 100644 scripts/ninjatool.py
>>
>> diff --git a/Makefile b/Makefile
>> index 8e2fc66..b8f802c 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -48,6 +48,15 @@ git-submodule-update:
>>  endif
>>  endif
>>
>> +export NINJA=./ninjatool
>> +Makefile.ninja: build.ninja ninjatool
>> +	./ninjatool -t ninja2make --omit dist uninstall < $< > $@
>> +-include Makefile.ninja
>> +
>> +ninjatool: $(SRC_PATH)/scripts/ninjatool.py
>> +	sed -e '1c\' -e '#! $(PYTHON)' $< > $@
>> +	chmod +x $@
>
> Why do we need this here, but not for other Python scripts?
>
> We have 39 Python scripts with #!/usr/bin/env python, one with
> #!/usr/bin/env python2, and 12 with #!/usr/bin/python.  The Makefiles
> generally use $(PYTHON) SCRIPT ARGS...
>
>> +
>>  .git-submodule-status: git-submodule-update config-host.mak
>>
>>  # Check that we're not trying to do an out-of-tree build from
>> diff --git a/configure b/configure
>> index 0814a5f..b8c3c58 100755
>> --- a/configure
>> +++ b/configure
>> @@ -493,6 +493,7 @@ docker="no"
>>  debug_mutex="no"
>>  libpmem=""
>>  default_devices="yes"
>> +meson=meson
>>
>>  # cross compilers defaults, can be overridden with --cross-cc-ARCH
>>  cross_cc_aarch64="aarch64-linux-gnu-gcc"
>> @@ -983,6 +984,8 @@ for opt do
>>    ;;
>>    --python=*) python="$optarg"
>>    ;;
>> +  --meson=*) meson="$optarg"
>> +  ;;
>>    --gcov=*) gcov_tool="$optarg"
>>    ;;
>>    --smbd=*) smbd="$optarg"
>> @@ -1685,6 +1688,7 @@ Advanced options (experts only):
>>    --make=MAKE              use specified make [$make]
>>    --install=INSTALL        use specified install [$install]
>>    --python=PYTHON          use specified python [$python]
>> +  --meson=PYTHON           use specified meson [$meson]

Typo: --meson=MESON

>>    --smbd=SMBD              use specified smbd [$smbd]
>>    --with-git=GIT           use specified git [$git]
>>    --static                 enable static build [$static]
>> @@ -1850,6 +1854,11 @@ then
>>      error_exit "Python not found. Use --python=/path/to/python"
>>  fi
>>
>> +if ! has "$meson"
>> +then
>> +    error_exit "Meson not found. Use --meson=/path/to/meson"
>> +fi
>> +
>>  # Note that if the Python conditional here evaluates True we will exit
>>  # with status 1 which is a shell 'false' value.
>>  if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
>> @@ -7983,6 +7992,27 @@ echo "# Automatically generated by configure - do not modify" > "$iotests_common
>>  echo >> "$iotests_common_env"
>>  echo "export PYTHON='$python'" >> "$iotests_common_env"
>>
>> +# bootstrap ninjatool, we need it before Make runs
>> +if ! test -x ninjatool; then
>> +  sed -e '1c\' -e "#! $python" ${source_path}/scripts/ninjatool.py > ninjatool
>> +  chmod +x ninjatool
>> +fi
>> +rm -rf meson-private meson-info meson-logs
>
> Ignorant question: why do we need configure remove this stuff?
>
>> +NINJA=$PWD/ninjatool $python $meson setup \
>
> This prints
>
>     /usr/bin/python3: can't open file 'meson': [Errno 2] No such file or directory
>
> for me, then goes on happily.
>
> For what it's worth:
>
>     $ type meson
>     meson is /usr/bin/meson
>
> Are you sure you want to override /usr/bin/meson's #! line?
>
> If I drop $python, I get
>
>     meson.build:1:0: ERROR: Meson version is 0.50.1 but project requires >=0.50.999.
>
> which is expected.
>
> It's too hot right for me now to figure out how to obtain a suitable
> version.
>
>> +	--prefix "$prefix" \
>> +	--libdir "$libdir" \
>> +	--libexecdir "$libexecdir" \
>> +	--bindir "$bindir" \
>> +	--includedir "$includedir" \
>> +	--datadir "$datadir" \
>> +	--mandir "$mandir" \
>> +	--sysconfdir "$sysconfdir" \
>> +	--localstatedir "$local_statedir" \
>> +	$(test "$strip_opt" = yes && echo --strip) \
>> +	--buildtype $(if test "$debug" = yes; then echo debug; else echo release; fi) \
>> +	"$PWD" "$source_path"
>> +
>> +
>>  # Save the configure command line for later reuse.
>>  cat <<EOD >config.status
>>  #!/bin/sh
>> diff --git a/meson.build b/meson.build
>> new file mode 100644
>> index 0000000..b683d70
>> --- /dev/null
>> +++ b/meson.build
>> @@ -0,0 +1,9 @@
>> +project('qemu', 'c', meson_version: '>=0.50.999')
>> +
>> +kconfig = import('unstable-kconfig')
>> +config_host = kconfig.load(meson.current_build_dir() / 'config-host.mak')
>> +
>> +add_project_arguments(config_host['QEMU_CFLAGS'].split(),
>> +                      language: 'c')
>> +add_project_arguments(config_host['QEMU_INCLUDES'].split(),
>> +                      language: 'c')
>> diff --git a/scripts/ninjatool.py b/scripts/ninjatool.py
>> new file mode 100644
>> index 0000000..6d90919
>> --- /dev/null
>> +++ b/scripts/ninjatool.py
> [Lots of code...]
>
> Did you write ninjatool.py specifically for QEMU, or did you steal it
> (or parts) somewhere?


--
Cheers,
Christophe de Dinechin (IRC c3d)

