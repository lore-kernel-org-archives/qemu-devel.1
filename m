Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47255C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A393206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTNy0IOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A393206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQpG-0002m3-2Q
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 08:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwQnq-0001In-UX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwQnp-0004l1-FP
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:21:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwQno-0004ik-AM
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 08:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580217672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lQGypXWsO8tu2jsYj6nPuuVSrp9IGPvZ70nk5CXzlKc=;
 b=CTNy0IOYe7xnSbTduNh2ENOoMFTRsWbMHl5q2PtzXSCFx4D+G2NMlIhxGaDptxMYVqe160
 I/McuGPSf5VJYYddbtK6FTe5mDJJ1hJauqWsUmOPkYNuAcGNBm3wTRvymsIXPCbzIBSoZu
 qMFh7dKBKZ0R2kSa8kViIUlJ1H5uu/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-QMpiycC-NxerACySlu-kCg-1; Tue, 28 Jan 2020 08:21:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E341800D41;
 Tue, 28 Jan 2020 13:21:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCAF987044;
 Tue, 28 Jan 2020 13:21:00 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, qemu-devel@nongnu.org
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <49fd82df-eaf7-c15f-17a3-1e19f314ab84@redhat.com>
Date: Tue, 28 Jan 2020 11:20:58 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: QMpiycC-NxerACySlu-kCg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/26/20 5:54 AM, Thomas Huth wrote:
> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>> The NAME variable can be used to describe nicely a job (see [*]).
>> As we currently have 32 jobs, use it. This helps for quickly
>> finding a particular job.
>>
>>    before: https://travis-ci.org/qemu/qemu/builds/639887646
>>    after: https://travis-ci.org/philmd/qemu/builds/641795043
> Very good idea, correlating a job in the GUI to an entry in the yml file
> was really a pain, so far.
>
>> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-w=
ithin-matrices
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
>>   1 file changed, 67 insertions(+), 34 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 6c1038a0f1..d68e35a2c5 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -94,24 +94,28 @@ after_script:
>>  =20
>>   matrix:
>>     include:
>> -    - env:
>> +    - name: "[x86] GCC static (user)"
> Could you please drop the [x86] and other architectures from the names?
> Travis already lists the build architecture in the job status page, so
> this information is redundant.
>
> [...]


I agree on dropping the architecture from the names, so:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>>       # Alternate coroutines implementations are only really of interest=
 to KVM users
>>       # However we can't test against KVM on Travis so we can only run u=
nit tests


Yet another off-topic comment: If we switch those coroutine test jobs to=20
Bionic then we can use KVM.

- Wainer

>> -    - env:
>> +    - name: "[x86] check-unit coroutine=3Ducontext"
>> +      env:
>>           - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
>>           - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>  =20
>>  =20
>> -    - env:
>> +    - name: "[x86] check-unit coroutine=3Dsigaltstack"
>> +      env:
>>           - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
>>           - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>
> Off-topic to your patch, but aren't coroutines something that is only
> used in the softmmu targets? If so, we could add --disable-user to the
> above two builds to speed things up a little bit.
>
>>  =20
>>       # Check we can build docs and tools (out of tree)
>> -    - env:
>> +    - name: "[x86] tools and docs"
>> +      env:
>>           - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
> Also off-topic, but I think we can now remove the above line and fix the
> comment - since all builds are now out-of-tree anyway, see commit
> bc4486fb233573e.
>
>
>> @@ -250,7 +271,8 @@ matrix:
>>  =20
>>  =20
>>       # Python builds
>> -    - env:
>> +    - name: "[x86] GCC Python 3.5 (x86_64-softmmu)"
>> +      env:
> Off-topic again:
> Python 3.5 is the default on xenial, and since we stopped using Python
> 2.7, I think we could remove this job now.
>
> We could add some jobs with Bionic + Python 3.7 and 3.8 instead.
>
>>           - CONFIG=3D"--target-list=3Dx86_64-softmmu"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>         language: python
>> @@ -258,7 +280,8 @@ matrix:
>>           - "3.5"
>>  =20
>>  =20
>> -    - env:
>> +    - name: "[x86] GCC Python 3.6 (x86_64-softmmu)"
>> +      env:
>>           - CONFIG=3D"--target-list=3Dx86_64-softmmu"
>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>         language: python
>   Thomas
>
>


