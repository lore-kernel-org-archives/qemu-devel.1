Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9704CC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E3D20675
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 10:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E3D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37519 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMV3T-0003JQ-Kb
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 06:04:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMV2F-0002ii-Vn
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMV2E-0003gr-LW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 06:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hMV2B-0003e5-Js; Fri, 03 May 2019 06:03:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9CB353151C5B;
	Fri,  3 May 2019 10:03:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-70.ams2.redhat.com [10.36.116.70])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 774B85D9C4;
	Fri,  3 May 2019 10:03:07 +0000 (UTC)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-8-thuth@redhat.com>
	<87tveb50el.fsf@zen.linaroharston>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <9ca8f727-9627-8aca-4edc-24f7d518c30c@redhat.com>
Date: Fri, 3 May 2019 12:03:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87tveb50el.fsf@zen.linaroharston>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 03 May 2019 10:03:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 7/7] tests: Run the iotests during "make
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
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503100306.w8Jzsww3Te_7jUGINYoRovV0N8BLenH7jga5NVvR6Rk@z>

On 03/05/2019 11.53, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> People often forget to run the iotests before submitting patches or
>> pull requests - this is likely due to the fact that we do not run the
>> tests during our mandatory "make check" tests yet. Now that we've got
>> a proper "auto" group of iotests that should be fine to run in every
>> environment, we can enable the iotests during "make check" again by
>> running the "auto" tests by default from the check-block.sh script.
>>
>> Some cases still need to be checked first, though: iotests need bash
>> and GNU sed (otherwise they fail), and if gprof is enabled, it spoils
>> the output of some test cases causing them to fail. So if we detect
>> that one of the required programs is missing or that gprof is enabled,
>> we still have to skip the iotests to avoid failures.
>>
>> And finally, since we are using check-block.sh now again, this patch a=
lso
>> removes the qemu-iotests-quick.sh script since we do not need that any=
more
>> (and having two shell wrapper scripts around the block tests seem
>> rather confusing than helpful).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include      |  8 +++----
>>  tests/check-block.sh        | 44 ++++++++++++++++++++++++++++--------=
-
>>  tests/qemu-iotests-quick.sh |  8 -------
>>  3 files changed, 38 insertions(+), 22 deletions(-)
>>  delete mode 100755 tests/qemu-iotests-quick.sh
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index e2432d5e77..3bb7793d4a 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -140,7 +140,7 @@ check-unit-y +=3D tests/test-uuid$(EXESUF)
>>  check-unit-y +=3D tests/ptimer-test$(EXESUF)
>>  check-unit-y +=3D tests/test-qapi-util$(EXESUF)
>>
>> -check-block-$(CONFIG_POSIX) +=3D tests/qemu-iotests-quick.sh
>> +check-block-$(CONFIG_POSIX) +=3D tests/check-block.sh
>>
>>  # All QTests for now are POSIX-only, but the dependencies are
>>  # really in libqtest, not in the testcases themselves.
>> @@ -1096,8 +1096,8 @@ clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>>
>>  QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) =3D=
 tests/qemu-iotests/socket_scm_helper$(EXESUF)
>>
>> -.PHONY: check-tests/qemu-iotests-quick.sh
>> -check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-i=
mg$(EXESUF) qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
>> +.PHONY: check-tests/check-block.sh
>> +check-tests/check-block.sh: tests/check-block.sh qemu-img$(EXESUF) qe=
mu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
>>  	$<
>>
>>  .PHONY: $(patsubst %, check-%, $(check-qapi-schema-y))
>> @@ -1168,7 +1168,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR=
)
>>  check-qapi-schema: $(patsubst %,check-%, $(check-qapi-schema-y)) chec=
k-tests/qapi-schema/doc-good.texi
>>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>>  check-block: $(patsubst %,check-%, $(check-block-y))
>> -check: check-qapi-schema check-unit check-softfloat check-qtest check=
-decodetree
>> +check: check-qapi-schema check-unit check-softfloat check-qtest check=
-decodetree check-block
>>  check-clean:
>>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
>>  	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-=
$(target)-y)) $(check-qtest-generic-y))
>> diff --git a/tests/check-block.sh b/tests/check-block.sh
>> index f3d12fd602..3b971d6cf4 100755
>> --- a/tests/check-block.sh
>> +++ b/tests/check-block.sh
>> @@ -1,24 +1,48 @@
>>  #!/bin/sh
>>
>> -FORMAT_LIST=3D"raw qcow2 qed vmdk vpc"
>> +# Honor the SPEED environment variable, just like we do it for the qt=
ests.
>> +if [ "$SPEED" =3D "slow" ]; then
>> +    format_list=3D"raw qcow2"
>> +    group=3D
>> +elif [ "$SPEED" =3D "thorough" ]; then
>> +    format_list=3D"raw qcow2 qed vmdk vpc"
>> +    group=3D
>> +else
>> +    format_list=3Dqcow2
>> +    group=3D"-g auto"
>> +fi
>> +
>>  if [ "$#" -ne 0 ]; then
>> -    FORMAT_LIST=3D"$@"
>> +    format_list=3D"$@"
>> +fi
>> +
>> +if grep -q "TARGET_GPROF=3Dy" *-softmmu/config-target.mak 2>/dev/null=
 ; then
>> +    echo "GPROF is enabled =3D=3D> Not running the qemu-iotests."
>> +    exit 0
>>  fi
>>
>> -export QEMU_PROG=3D"$PWD/x86_64-softmmu/qemu-system-x86_64"
>> -export QEMU_IMG_PROG=3D"$PWD/qemu-img"
>> -export QEMU_IO_PROG=3D"$PWD/qemu-io"
>> +if [ -z "$(find . -name 'qemu-system-*' -print)" ]; then
>> +    echo "No qemu-system binary available =3D=3D> Not running the qem=
u-iotests."
>> +    exit 0
>> +fi
>> +
>> +if ! command -v bash >/dev/null 2>&1 ; then
>> +    echo "bash not available =3D=3D> Not running the qemu-iotests."
>> +    exit 0
>> +fi
>>
>> -if [ ! -x $QEMU_PROG ]; then
>> -    echo "'make check-block' requires qemu-system-x86_64"
>> -    exit 1
>> +if ! (sed --version | grep 'GNU sed') > /dev/null 2>&1 ; then
>> +    if ! command -v gsed >/dev/null 2>&1; then
>> +        echo "GNU sed not available =3D=3D> Not running the qemu-iote=
sts."
>> +        exit 0
>> +    fi
>>  fi
>>
>>  cd tests/qemu-iotests
>>
>>  ret=3D0
>> -for FMT in $FORMAT_LIST ; do
>> -    ./check -T -nocache -$FMT || ret=3D1
>> +for fmt in $format_list ; do
>> +    ./check -$fmt $group || ret=3D1
>=20
> This is all looking good and my only remaining objection is aesthetic.
> If you run "make check -jN" you end up with the with the block test
> output intermingled with the rest of the output which is now fairly
> uniform.
>=20
> Any chance we could hide the verbosity unless requested and have
> something like:
>=20
>     TEST    check-block: test xxx
>=20
> emitted for each passing test?
Yeah, I noticed this already, too. I was already thinking of changing
the tests/qemu-iotests/check script a little bit (maybe even teaching it
the TAP protocol?), but I felt it was too much for this series.
Considering that the iotests have been broken two times already after
the 4.1 tree has been opened, I think we should get this merged as soon
as possible to avoid at least partly future regressions. Clean up of the
test output can and will be done in a separate patch later.

 Thomas

