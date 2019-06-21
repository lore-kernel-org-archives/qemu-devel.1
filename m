Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE5EC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60BA220679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 07:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BA220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heDh5-00078X-HR
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 03:10:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34753)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1heDf5-0005zW-IX
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1heDaE-0007be-SD
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:03:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40209)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1heDaD-0007Z5-B4
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 03:03:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so5403801wre.7
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 00:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FsSvt2kljdqfU//U4CRsFXm6JmXXkMNLF0RQJy7HOEE=;
 b=nUsyTlUqk74+qJPgpufhXY31iB/kJ2UIHdHbxSC6LC87259buhKCxLqiymgN4i5ijl
 vd9N3C5ZEBWI3IjIIc3lkMfWHvsuNj2+yvUQGrZOAIpCxv4UhtkdCtkWuqQndDZ2OlXn
 ynM+TDQoU4urcnB1Uf/CEA7U6ULDVM31CEaPI3FrHZisy0iPv+Z5WXTq6RRVho5zuDKK
 xjJ8gUPf3Rl7nvfgJpe7NuZzvnhi/+r51x19OcLA97KRZ26j6iRDVAlJukPEcMeZAzj7
 H+2B6zDb8+66EKcZhgYAyWCmqme3cYpfkRxnUdfHtrafx8dBVIbVdnGKGrRSN3v9XkkV
 QgaA==
X-Gm-Message-State: APjAAAWSd7fthWjOhXRnAkssq79jgy53hKJjmcDOi9MYCf7wSpmZ/SX5
 vuSHxfUjqwcOtRCzEcGdgppsRQ==
X-Google-Smtp-Source: APXvYqxXacr4LTCAhhx11blTSuEG7UWKtIC6j3q+/QJ9+AzqLSfg4h6cHCBKsv6v4bsz+QtJzkU4Iw==
X-Received: by 2002:a5d:5448:: with SMTP id w8mr61966075wrv.180.1561100615373; 
 Fri, 21 Jun 2019 00:03:35 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id v65sm2108643wme.31.2019.06.21.00.03.34
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 21 Jun 2019 00:03:34 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190621060925.16214-1-crosa@redhat.com>
 <20190621060925.16214-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f18a5df8-201e-b8a1-1a3e-3e2254ce8b1e@redhat.com>
Date: Fri, 21 Jun 2019 09:03:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190621060925.16214-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH 1/2] Acceptance tests: exclude "flaky" tests
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/21/19 8:09 AM, Cleber Rosa wrote:
> It's a fact that some tests may not be 100% reliable in all
> environments.  While it's a tough call to remove a useful test that
> from the tree because it may fail every 1/100th time (or so), having
> human attention drawn to known issues is very bad for humans and for
> the projects they manage.
> 
> As a compromise solution, this marks tests that are known to have
> issues, or that exercises known issues in QEMU or other components,
> and excludes them from the entry point.  As a consequence, tests
> marked as "flaky" will not be executed as part of "make
> check-acceptance".
> 
> Because such tests should be forgiven but never be forgotten, it's
> possible to list them with (assuming "make check-venv" or "make
> check-acceptance" has already initiatilized the venv):
> 
>   $ ./tests/venv/bin/avocado list -t flaky tests/acceptance
> 
> The current list of tests marked as flaky are a result of running
> the entire set of acceptance tests around 20 times.  The results
> were then processed with a helper script[1].  That either confirmed
> known issues (in the case of aarch64 and arm)[2] or revealed new
> ones (mips).
> 
> This also bumps the Avocado version to one that includes a fix to the
> parsing of multiple and mix "key:val" and simple tag values.
> 
> [1] https://raw.githubusercontent.com/avocado-framework/avocado/master/contrib/scripts/summarize-job-failures.py
> [2] https://bugs.launchpad.net/qemu/+bug/1829779
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  docs/devel/testing.rst                   | 17 +++++++++++++++++
>  tests/Makefile.include                   |  6 +++++-
>  tests/acceptance/boot_linux_console.py   |  2 ++
>  tests/acceptance/linux_ssh_mips_malta.py |  2 ++
>  tests/requirements.txt                   |  2 +-
>  5 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index da2d0fc964..ff4d8e2e1c 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -574,6 +574,23 @@ may be invoked by running:
>  
>    tests/venv/bin/avocado run $OPTION1 $OPTION2 tests/acceptance/
>  
> +Tagging tests
> +-------------
> +
> +flaky
> +~~~~~
> +
> +If a test is known to fail intermittently, even if only every one
> +hundredth time, it's highly advisable to mark it as a flaky test.
> +This will prevent these individual tests from failing much larger
> +jobs, will avoid human interaction and time wasted to verify a known
> +issue, and worse of all, can lead to the discredit of automated
> +testing.
> +
> +To mark a test as flaky, add to its docstring.::
> +
> +  :avocado: tags=flaky

I certainly disagree with this patch, failing tests have to be fixed.
Why not tag all the codebase flaky and sing "happy coding"?

Anyway if this get accepted, 'flaky' tags must have the intermittent
failure well described, and a Launchpad/Bugzilla tracking ticket referenced.

> +
>  Manual Installation
>  -------------------
>  
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index db750dd6d0..4c97da2878 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1125,7 +1125,11 @@ TESTS_RESULTS_DIR=$(BUILD_DIR)/tests/results
>  # Any number of command separated loggers are accepted.  For more
>  # information please refer to "avocado --help".
>  AVOCADO_SHOW=app
> -AVOCADO_TAGS=$(patsubst %-softmmu,-t arch:%, $(filter %-softmmu,$(TARGET_DIRS)))
> +
> +# Additional tags that are added to each occurence of "--filter-by-tags"
> +AVOCADO_EXTRA_TAGS := ,-flaky
> +
> +AVOCADO_TAGS=$(patsubst %-softmmu,--filter-by-tags=arch:%$(AVOCADO_EXTRA_TAGS), $(filter %-softmmu,$(TARGET_DIRS)))
>  
>  ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)
>  $(TESTS_VENV_DIR): $(TESTS_VENV_REQ)
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
> index 32159503e9..6bd5c1ab53 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -249,6 +249,7 @@ class BootLinuxConsole(Test):
>          """
>          :avocado: tags=arch:aarch64
>          :avocado: tags=machine:virt
> +        :avocado: tags=flaky
>          """
>          kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
>                        'releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz')
> @@ -270,6 +271,7 @@ class BootLinuxConsole(Test):
>          """
>          :avocado: tags=arch:arm
>          :avocado: tags=machine:virt
> +        :avocado: tags=flaky
>          """
>          kernel_url = ('https://download.fedoraproject.org/pub/fedora/linux/'
>                        'releases/29/Everything/armhfp/os/images/pxeboot/vmlinuz')
> diff --git a/tests/acceptance/linux_ssh_mips_malta.py b/tests/acceptance/linux_ssh_mips_malta.py
> index aafb0c39f6..ae70b658e0 100644
> --- a/tests/acceptance/linux_ssh_mips_malta.py
> +++ b/tests/acceptance/linux_ssh_mips_malta.py
> @@ -208,6 +208,7 @@ class LinuxSSH(Test):
>          :avocado: tags=machine:malta
>          :avocado: tags=endian:big
>          :avocado: tags=device:pcnet32
> +        :avocado: tags=flaky
>          """
>          kernel_url = ('https://people.debian.org/~aurel32/qemu/mips/'
>                        'vmlinux-3.2.0-4-5kc-malta')
> @@ -222,6 +223,7 @@ class LinuxSSH(Test):
>          :avocado: tags=machine:malta
>          :avocado: tags=endian:little
>          :avocado: tags=device:pcnet32
> +        :avocado: tags=flaky
>          """
>          kernel_url = ('https://people.debian.org/~aurel32/qemu/mipsel/'
>                        'vmlinux-3.2.0-4-5kc-malta')
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 3ae0e29ad7..58d63d171f 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -1,5 +1,5 @@
>  # Add Python module requirements, one per line, to be installed
>  # in the tests/venv Python virtual environment. For more info,
>  # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
> -avocado-framework==68.0
> +avocado-framework==69.1
>  paramiko
> 

