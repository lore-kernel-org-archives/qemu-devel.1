Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CA2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F72206D3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1H5LXp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F72206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYmZ-000353-Px
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixYMf-0003BY-9B
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:37:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixYMc-0001cr-PK
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:37:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40382
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixYMc-0001ZR-Km
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580485065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9jy40/GjKC7DYdS/NvjQ3SUh+0kwsNSaJnXA5Cb+cHg=;
 b=E1H5LXp/eqSUG5G1NKyUeag0wb3M1+YFVfLG7MjQ509aHi79PtGz6ZpXSgq064OywubcAH
 SVUht9pK3oZdC60PxJFvP9H9n7JtgtGrZDo8+g5iBuN3KBXTsD0R+5fj1SJPguKFX2IftZ
 Hxs1xPRJG47+pZHb7waN/AZyGvIBTm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-pbb4seWrMCeL4l8JVPufoA-1; Fri, 31 Jan 2020 10:37:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EB5A800D5C;
 Fri, 31 Jan 2020 15:37:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D3095DA81;
 Fri, 31 Jan 2020 15:37:25 +0000 (UTC)
Subject: Re: [PATCH v2 08/12] .travis.yml: Add description to each job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-9-alex.bennee@linaro.org>
 <79ebc114-fb94-7dee-b57c-b3df7be038bf@redhat.com>
 <ca68c7c0-3750-b5b5-5bf2-e16b2cd503dd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7f124f8c-7d01-c7b4-b23d-3c776ca3f17a@redhat.com>
Date: Fri, 31 Jan 2020 16:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ca68c7c0-3750-b5b5-5bf2-e16b2cd503dd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: pbb4seWrMCeL4l8JVPufoA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/01/2020 16.24, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/30/20 8:06 PM, Thomas Huth wrote:
>> On 30/01/2020 12.32, Alex Benn=C3=A9e wrote:
>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>> The NAME variable can be used to describe nicely a job (see [*]).
>>> As we currently have 32 jobs, use it. This helps for quickly
>>> finding a particular job.
>>>
>>> =C2=A0=C2=A0 before: https://travis-ci.org/qemu/qemu/builds/639887646
>>> =C2=A0=C2=A0 after: https://travis-ci.org/philmd/qemu/builds/641795043
>>>
>>> [*]
>>> https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-with=
in-matrices
>>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Message-Id: <20200125183135.28317-1-f4bug@amsat.org>
>>>
>>> ---
>>> [ajb]
>>> =C2=A0=C2=A0 - drop [x86]
>>> ---
>>> =C2=A0 .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------=
------
>>> =C2=A0 1 file changed, 67 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 7526967847..056db1adac 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -96,24 +96,28 @@ after_script:
>>> =C2=A0 =C2=A0 matrix:
>>> =C2=A0=C2=A0=C2=A0 include:
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC static (user)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--di=
sable-system --static"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CACHE_NAME=3D"=
${TRAVIS_BRANCH}-linux-gcc-default"
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # we split the system buil=
ds as it takes a while to build
>>> them all
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC (main-softmmu)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--di=
sable-user
>>> --target-list=3D${MAIN_SOFTMMU_TARGETS}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CACHE_NAME=3D"=
${TRAVIS_BRANCH}-linux-gcc-default"
>>> =C2=A0 =C2=A0 -=C2=A0=C2=A0=C2=A0 - env:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--disable-user
>>> --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}"
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC (other-softmmu)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--disable-user
>>> --target-list-exclude=3D${MAIN_SOFTMMU_TARGETS}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CACHE_NAME=3D"=
${TRAVIS_BRANCH}-linux-gcc-default"
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Just build tools and run=
 minimal unit and softfloat checks
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC check-softfloat (user)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - BASE_CONFIG=3D=
"--enable-tools"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--di=
sable-user --disable-system"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"ma=
ke check-unit check-softfloat -j3"
>>> @@ -121,41 +125,48 @@ matrix:
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # --enable-debug implies -=
-enable-debug-tcg, also runs
>>> quite a bit slower
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC debug (main-softmmu)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--en=
able-debug
>>> --target-list=3D${MAIN_SOFTMMU_TARGETS}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CACHE_NAME=3D"=
${TRAVIS_BRANCH}-linux-gcc-debug"
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # TCG debug can be run jus=
t on its own and is mostly
>>> agnostic to user/softmmu distinctions
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC debug (user)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--en=
able-debug-tcg --disable-system"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CACHE_NAME=3D"=
${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>> =C2=A0 =C2=A0 -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC some libs disabled (main-softmmu)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--di=
sable-linux-aio --disable-cap-ng
>>> --disable-attr --disable-brlapi --disable-libusb
>>> --disable-replication --target-list=3D${MAIN_SOFTMMU_TARGETS}"
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Module builds are mostly=
 of interest to major distros
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "GCC modules (main-softmmu)"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--en=
able-modules
>>> --target-list=3D${MAIN_SOFTMMU_TARGETS}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CACHE_NAME=3D"=
${TRAVIS_BRANCH}-linux-gcc-default"
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Alternate coroutines imp=
lementations are only really of
>>> interest to KVM users
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # However we can't test against KVM on T=
ravis so we can only
>>> run unit tests
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "check-unit coroutine=3Ducontext"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--wi=
th-coroutine=3Ducontext --disable-tcg"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"ma=
ke check-unit -j3 V=3D1"
>>> =C2=A0 =C2=A0 -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "check-unit coroutine=3Dsigaltstack"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--wi=
th-coroutine=3Dsigaltstack --disable-tcg"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"ma=
ke check-unit -j3 V=3D1"
>>> =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check we can build docs =
and tools (out of tree)
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "[x86] tools and docs"
>>
>> Could you please also drop this "[x86]" here?
>=20
> The hunk got applied into the next patch:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 # Check we can build docs and tools (out of tree=
)
> -=C2=A0=C2=A0=C2=A0 - name: "[x86] tools and docs"
> +=C2=A0=C2=A0=C2=A0 - name: "tools and docs (bionic)"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dist: bionic

Ok, fine for me, too.

 Thomas


