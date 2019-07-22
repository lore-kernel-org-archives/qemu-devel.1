Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B69C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 19:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EDA82239E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 19:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EDA82239E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpeNg-0000TT-6X
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 15:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37174)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpeNV-0008Vw-Gh
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpeNU-0001oX-0W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:53:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpeNT-0001nx-Qd
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 15:53:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so15593525wrr.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 12:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZVLrVuR2wX5zPzRfkWl2TkchzDgNojYin1mrt5y9IAY=;
 b=bNmTIz7NMAlZwaJoVhC9slN/vjOWwZ7rryhi7zguRC5z0pHwrfezQmqcE0xy6UXyvI
 DGqblVyYhcYP/DH6Wn+aPylfrbFqEJ+7LYJPHcTnOT9uJIHHdjERxxuhrt6VXk8EXoy3
 Lds+S6rtFt/5+P4+JrZfO0Yz8B3lbc7/0mTbaRViliUS8njPZyuWwxlYAHLThk0lQth3
 hUwGmRxZ8Q8xImKlFofvXqu3dFhjomfATsOjBx+HOuvuulstgzE5Ue4ocsuupZOzsJlY
 xrzNSIhklRv+PF7LoDpZcGi/ASz55MCR5ytpVyeHFYxRLpzrQ96dbVUjvv0LdHr40va0
 pFvQ==
X-Gm-Message-State: APjAAAUKTh6nFd6Ur/alTEgkz3DwFX9oDFh9PKtjiUbmY+ZnrS//yYyO
 SR9SJcNOSZgEtwlUMRirmUK9yw==
X-Google-Smtp-Source: APXvYqwk6FXV3lMy0P9DCN//zqnFJ8Ts/K5E057/QlcayA5jC1Xu6r47tmrVhVVVjf5TtZtEHoZ6gA==
X-Received: by 2002:adf:e8c8:: with SMTP id k8mr75803469wrn.285.1563825222838; 
 Mon, 22 Jul 2019 12:53:42 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x16sm30141886wmj.4.2019.07.22.12.53.42
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 12:53:42 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
 <20190717134335.15351-23-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <1e1ae24a-bed3-2acc-7727-16cfb7d877bc@redhat.com>
Date: Mon, 22 Jul 2019 21:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717134335.15351-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v2 22/23] tests: Run the iotests during
 "make check" again
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 3:43 PM, Alex Bennée wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> People often forget to run the iotests before submitting patches or pull
> requests - this is likely due to the fact that we do not run the tests
> during our mandatory "make check" tests yet. Now that we've got a proper
> "auto" group of iotests that should be fine to run in every environment,
> we can enable the iotests during "make check" again by running the "auto"
> tests by default from the check-block.sh script.
> 
> Some cases still need to be checked first, though: iotests need bash and
> GNU sed (otherwise they fail), and if gprof is enabled, it spoils the
> output of some test cases causing them to fail. So if we detect that one
> of the required programs is missing or that gprof is enabled, we still
> have to skip the iotests to avoid failures.
> 
> And finally, since we are using check-block.sh now again, this patch also
> removes the qemu-iotests-quick.sh script since we do not need that anymore
> (and having two shell wrapper scripts around the block tests seems rather
> confusing than helpful).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> [AJB: -makecheck to check-block.sh, move check-block to start and gate it]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20190717111947.30356-4-thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include      | 10 +++++----
>  tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---------
>  tests/qemu-iotests-quick.sh |  8 -------
>  3 files changed, 40 insertions(+), 22 deletions(-)
>  delete mode 100755 tests/qemu-iotests-quick.sh
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index fd7fdb86586..6f02dfcc019 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -142,7 +142,7 @@ check-unit-y += tests/test-uuid$(EXESUF)
>  check-unit-y += tests/ptimer-test$(EXESUF)
>  check-unit-y += tests/test-qapi-util$(EXESUF)
>  
> -check-block-$(CONFIG_POSIX) += tests/qemu-iotests-quick.sh
> +check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) += tests/check-block.sh
>  
>  # All QTests for now are POSIX-only, but the dependencies are
>  # really in libqtest, not in the testcases themselves.
> @@ -1092,8 +1092,10 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  
>  QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
>  
> -.PHONY: check-tests/qemu-iotests-quick.sh
> -check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
> +.PHONY: check-tests/check-block.sh
> +check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) \
> +		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> +		$(patsubst %,%/all,$(filter %-softmmu,$(TARGET_DIRS)))
>  	$<
>  
>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
> @@ -1167,7 +1169,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>  check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  check-block: $(patsubst %,check-%, $(check-block-y))
> -check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
> +check: check-block check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> diff --git a/tests/check-block.sh b/tests/check-block.sh
> index f3d12fd602d..c8b6cec3f68 100755
> --- a/tests/check-block.sh
> +++ b/tests/check-block.sh
> @@ -1,24 +1,48 @@
>  #!/bin/sh
>  
> -FORMAT_LIST="raw qcow2 qed vmdk vpc"
> +# Honor the SPEED environment variable, just like we do it for the qtests.
> +if [ "$SPEED" = "slow" ]; then
> +    format_list="raw qcow2"
> +    group=
> +elif [ "$SPEED" = "thorough" ]; then
> +    format_list="raw qcow2 qed vmdk vpc"
> +    group=
> +else
> +    format_list=qcow2
> +    group="-g auto"
> +fi
> +
>  if [ "$#" -ne 0 ]; then
> -    FORMAT_LIST="$@"
> +    format_list="$@"
> +fi
> +
> +if grep -q "TARGET_GPROF=y" *-softmmu/config-target.mak 2>/dev/null ; then
> +    echo "GPROF is enabled ==> Not running the qemu-iotests."
> +    exit 0
>  fi
>  
> -export QEMU_PROG="$PWD/x86_64-softmmu/qemu-system-x86_64"
> -export QEMU_IMG_PROG="$PWD/qemu-img"
> -export QEMU_IO_PROG="$PWD/qemu-io"
> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +    echo "No qemu-system binary available ==> Not running the qemu-iotests."
> +    exit 0
> +fi
> +
> +if ! command -v bash >/dev/null 2>&1 ; then
> +    echo "bash not available ==> Not running the qemu-iotests."
> +    exit 0
> +fi
>  
> -if [ ! -x $QEMU_PROG ]; then
> -    echo "'make check-block' requires qemu-system-x86_64"
> -    exit 1
> +if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
> +    if ! command -v gsed >/dev/null 2>&1; then
> +        echo "GNU sed not available ==> Not running the qemu-iotests."
> +        exit 0
> +    fi
>  fi
>  
>  cd tests/qemu-iotests
>  
>  ret=0
> -for FMT in $FORMAT_LIST ; do
> -    ./check -T -nocache -$FMT || ret=1
> +for fmt in $format_list ; do
> +    ./check -makecheck -$fmt $group || ret=1
>  done
>  
>  exit $ret
> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
> deleted file mode 100755
> index 0e554bb9724..00000000000
> --- a/tests/qemu-iotests-quick.sh
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -
> -cd tests/qemu-iotests
> -
> -ret=0
> -TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
> -
> -exit $ret
> 

Since Gerd updated the OpenBSD image, do you know if we can run vm-test
again?

I haven't check which what got merged from this previous series:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg07527.html

