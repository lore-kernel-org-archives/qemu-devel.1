Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1205DC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC982073B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 09:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doKSMTIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC982073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icQZe-0004V5-W8
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 04:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1icQSH-0002Fb-HX
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1icQS8-0006Gt-Vg
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:56:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24697
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1icQS8-00063H-QV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575449765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cbWiGpXkxeZBowjqw4b/kOuKxJHmXGDA4E7mwLbSIZw=;
 b=doKSMTIwb25uxyvTbb46MPCU3LCC2296j3Pe+9spdG7Ykq8IC7oPo1/f/L9HjvwqJwfRiC
 U0/YJvPa0e+uqbYjnT4PKyj5kiLgXIzLfuTxLiYkWcq+JJxKoLv5R0sUNBmmLFKnkxOpRK
 JocZ/24orEaI60rBoIW1MgOzLiKuCPE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-z0jkhT0IM6K1zpLpwxn0pA-1; Wed, 04 Dec 2019 03:56:04 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B69D10054E3;
 Wed,  4 Dec 2019 08:56:03 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-39.ams2.redhat.com [10.36.117.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07FB51001901;
 Wed,  4 Dec 2019 08:55:51 +0000 (UTC)
Subject: Re: [RFC] QEMU Gating CI
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20191202140552.GA5353@localhost.localdomain>
 <87a789bizf.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9c695582-783c-aae6-43b3-b68e8e6d061a@redhat.com>
Date: Wed, 4 Dec 2019 09:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87a789bizf.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: z0jkhT0IM6K1zpLpwxn0pA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 Jeff Nelson <jen@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/2019 15.07, Alex Benn=C3=A9e wrote:
[...]
>> GitLab Jobs and Pipelines
>> -------------------------
>>
>> GitLab CI is built around two major concepts: jobs and pipelines.  The
>> current GitLab CI configuration in QEMU uses jobs only (or putting it
>> another way, all jobs in a single pipeline stage).

Yeah, the initial gitlab-ci.yml file was one of the very first YAML file
and one the very first CI files that I wrote, with hardly any experience
in this area ... there is definitely a lot of room for improvement here!

>>  Consider the
>> folowing job definition[9]:
>>
>>    build-tci:
>>     script:
>>     - TARGETS=3D"aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390=
x x86_64"
>>     - ./configure --enable-tcg-interpreter
>>          --target-list=3D"$(for tg in $TARGETS; do echo -n ${tg}'-softmm=
u '; done)"
>>     - make -j2
>>     - make tests/boot-serial-test tests/cdrom-test tests/pxe-test
>>     - for tg in $TARGETS ; do
>>         export QTEST_QEMU_BINARY=3D"${tg}-softmmu/qemu-system-${tg}" ;
>>         ./tests/boot-serial-test || exit 1 ;
>>         ./tests/cdrom-test || exit 1 ;
>>       done
>>     - QTEST_QEMU_BINARY=3D"x86_64-softmmu/qemu-system-x86_64" ./tests/px=
e-test
>>     - QTEST_QEMU_BINARY=3D"s390x-softmmu/qemu-system-s390x" ./tests/pxe-=
test -m slow
>>
>> All the lines under "script" are performed sequentially.  It should be
>> clear that there's the possibility of breaking this down into multiple
>> stages, so that a build happens first, and then "common set of tests"
>> run in parallel.  Using the example above, it would look something
>> like:
>>
>>    +---------------+------------------------+
>>    |  BUILD STAGE  |        TEST STAGE      |
>>    +---------------+------------------------+
>>    |   +-------+   |  +------------------+  |
>>    |   | build |   |  | boot-serial-test |  |
>>    |   +-------+   |  +------------------+  |
>>    |               |                        |
>>    |               |  +------------------+  |
>>    |               |  | cdrom-test       |  |
>>    |               |  +------------------+  |
>>    |               |                        |
>>    |               |  +------------------+  |
>>    |               |  | x86_64-pxe-test  |  |
>>    |               |  +------------------+  |
>>    |               |                        |
>>    |               |  +------------------+  |
>>    |               |  | s390x-pxe-test   |  |
>>    |               |  +------------------+  |
>>    |               |                        |
>>    +---------------+------------------------+
>>
>> Of course it would be silly to break down that job into smaller jobs tha=
t
>> would run individual tests like "boot-serial-test" or "cdrom-test".  Sti=
ll,
>> the pipeline approach is valid because:
>>
>>  * Common set of tests would run in parallel, giving a quicker result
>>    turnaround

Ok, full ack for the idea to use separate pipelines for the testing
(Philippe once showed me this idea already, too, he's using it for EDK2
testing IIRC). But the example with the build-tci is quite bad. The
single steps here are basically just a subset of "check-qtest" to skip
the tests that we are not interested in here. If we don't care about
losing some minutes of testing, we can simply replace all those steps
with "make check-qtest" again.

I think what we really want to put into different pipelines are the
sub-steps of "make check", i.e.:

- check-block
- check-qapi-schema
- check-unit
- check-softfloat
- check-qtest
- check-decodetree

And of course also the other ones that are not included in "make check"
yet, e.g. "check-acceptance" etc.

> check-unit is a good candidate for parallel tests. The others depends -
> I've recently turned most make check's back to -j 1 on travis because
> it's a real pain to see what test has hung when other tests keep
> running.

If I understood correctly, it's not about running the check steps in
parallel with "make -jXX" in one pipeline, but rather about running the
different test steps in different pipelines. So you get a separate
output for each test subsystem.

>> Current limitations for a multi-stage pipeline
>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Because it's assumed that each job will happen in an isolated and
>> independent execution environment, jobs must explicitly define the
>> resources that will be shared between stages.  GitLab will make sure
>> the same source code revision will be available on all jobs
>> automatically.  Additionaly, GitLab supports the concept of artifacts.
>> By defining artifacts in the "build" stage, jobs in the "test" stage
>> can expect to have a copy of those artifacts automatically.
>>
>> In theory, there's nothing that prevents an entire QEMU build
>> directory, to be treated as an artifact.  In practice, there are
>> predefined limits on GitLab that prevents that from being possible,
>> resulting in errors such as:
>>
>>    Uploading artifacts...
>>    build: found 3164 matching files                  =20
>>    ERROR: Uploading artifacts to coordinator... too large archive
>>           id=3Dxxxxxxx responseStatus=3D413 Request Entity Too Large
>>           status=3D413 Request Entity Too Large token=3Dyyyyyyyyy
>>    FATAL: too large                                  =20
>>    ERROR: Job failed: exit code 1
>>
>> As far as I can tell, this is an instance define limit that's clearly
>> influenced by storage costs.  I see a few possible solutions to this
>> limitation:
>>
>>  1) Provide our own "artifact" like solution that uses our own storage
>>     solution
>>
>>  2) Reduce or eliminate the dependency on a complete build tree
>>
>> The first solution can go against the general trend of not having to
>> maintain CI infrastructure.  It could be made simpler by using cloud
>> storage, but there would still be some interaction with another
>> external infrastructure component.
>>
>> I find the second solution preferrable, given that most tests depend
>> on having one or a few binaries available.  I've run multi-stage
>> pipelines with some of those binaries (qemu-img,
>> $target-softmmu/qemu-system-$target) defined as artifcats and they
>> behaved as expected.  But, this could require some intrusive changes
>> to the current "make"-based test invocation.

I think it should be sufficient to define a simple set of artifacts like:

- tests/*
- *-softmmu/qemu-system-*
- qemu-img, qemu-nbd ... and all the other helper binaries
- Makefile*

... and maybe some more missing files. It's some initial work, but once
we have the basic list, I don't expect to change it much in the course
of time.

 Thomas


