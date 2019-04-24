Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A0AC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 20:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD9C20835
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 20:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD9C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47173 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJOxD-0002gd-2s
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 16:57:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJOvJ-0001BH-IM
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 16:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1hJOiy-0006Ft-Ly
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 16:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>)
	id 1hJOiq-000621-Hk; Wed, 24 Apr 2019 16:42:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F840309848B;
	Wed, 24 Apr 2019 20:42:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-118.rdu2.redhat.com
	[10.10.122.118])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A22615D719;
	Wed, 24 Apr 2019 20:42:15 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-6-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <6b284aaa-353c-92c1-b01b-21882e7ff9ef@redhat.com>
Date: Wed, 24 Apr 2019 17:42:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190424103747.10173-6-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 24 Apr 2019 20:42:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/6] tests: Run the iotests during "make
 check" again
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424204214.8kfKtbDl6q2ozUaod_9wTlXcABp0B-t9Jl5Dg1NIFNE@z>

Hi Thomas,


On 04/24/2019 07:37 AM, Thomas Huth wrote:
> People often forget to run the iotests before submitting patches or
> pull requests - this is likely due to the fact that we do not run the
> tests during our mandatory "make check" tests yet. Now that we've got
> a new "ci" group of iotests that should be fine to run in every environ-
> ment, it should be OK to enable the iotests during "make check" again.
> Thus we now run the "ci" tests by default from the qemu-iotests-quick.sh
> script, and only use the former "quick" group (that contains some tests
> that are failing in some environments) when the user decided to run
> "make check SPEED=thorough" or something similar.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include      |  2 +-
>   tests/qemu-iotests-quick.sh | 17 ++++++++++++++++-
>   2 files changed, 17 insertions(+), 2 deletions(-)

One of Patchew's runners failed with this patch series:
https://patchew.org/QEMU/20190424103747.10173-1-thuth@redhat.com/

I encountered same failures with `make check` locally on Fedora 29 
x86_64 (pulled latest qemu, and configured with defaults and 
x86_64-softmmu target):
---
Not run: 233
Failures: 069 103 114 133 140 143 197 215 226 244
Failed 10 of 91 tests
---

Let me know if you need more details.

- Wainer

>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 36fc73fef5..eb6a7a41e2 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1168,7 +1168,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>   check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) check-tests/qapi-schema/doc-good.texi
>   check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>   check-block: $(patsubst %,check-%, $(check-block-y))
> -check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree
> +check: check-qapi-schema check-unit check-softfloat check-qtest check-decodetree check-block
>   check-clean:
>   	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>   	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> diff --git a/tests/qemu-iotests-quick.sh b/tests/qemu-iotests-quick.sh
> index 0e554bb972..416b3fc48b 100755
> --- a/tests/qemu-iotests-quick.sh
> +++ b/tests/qemu-iotests-quick.sh
> @@ -1,8 +1,23 @@
>   #!/bin/sh
>   
> +# Honor the SPEED environment variable, just like we do it for the qtests.
> +# The default is to run all tests that still work fine in a CI environments,
> +# but if the user set SPEED=slow or SPEED=thorough, we also run all other
> +# tests that are still marked as "quick"
> +if [ "$SPEED" = "slow" -o "$SPEED" = "thorough" ]; then
> +    group=quick
> +else
> +    group=ci
> +fi
> +
> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
> +    echo "No qemu-system binary available. Skipped qemu-iotests."
> +    exit 0
> +fi
> +
>   cd tests/qemu-iotests
>   
>   ret=0
> -TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g quick || ret=1
> +TEST_DIR=${TEST_DIR:-/tmp/qemu-iotests-quick-$$} ./check -T -qcow2 -g "$group" || ret=1
>   
>   exit $ret


