Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C014C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E261E20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJvitfNT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E261E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhpU-0002BS-4L
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:32:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwhov-0001mw-8E
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwhou-0007PM-0g
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:31:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30619
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwhot-0007PC-Tp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580283087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=5dRJmPQE1Mg0S26rlgFk7lAOsfmKC81qBBo8wB1Ueek=;
 b=CJvitfNTcSS6U5L3NMDAbfP1YUAng77YB6epgAk6tgBZoiR85nOGuir8/M/MSBDjUztFbj
 WGoN+ssrHIf6f1hQjhFnWU+WBdVyVbvTvUTcpP+n1pdnCVhG9ZNAd1+KO19GfozOw/IMQ7
 980UKN5urJ07i3Q2F/79RT90MRkFwaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-mlvdkGipOsegqXjaDv7gXw-1; Wed, 29 Jan 2020 02:31:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF46A1937FC2;
 Wed, 29 Jan 2020 07:31:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD61C5D9C5;
 Wed, 29 Jan 2020 07:31:16 +0000 (UTC)
Subject: Re: [PATCH] .travis.yml: Add description to each job
To: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com>
 <49fd82df-eaf7-c15f-17a3-1e19f314ab84@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5d470559-d63d-b787-bfd5-205f41d314ac@redhat.com>
Date: Wed, 29 Jan 2020 08:31:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <49fd82df-eaf7-c15f-17a3-1e19f314ab84@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: mlvdkGipOsegqXjaDv7gXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On 28/01/2020 14.20, Wainer dos Santos Moschetta wrote:
>=20
> On 1/26/20 5:54 AM, Thomas Huth wrote:
>> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The NAME variable can be used to describe nicely a job (see [*]).
>>> As we currently have 32 jobs, use it. This helps for quickly
>>> finding a particular job.
>>>
>>> =C2=A0=C2=A0 before: https://travis-ci.org/qemu/qemu/builds/639887646
>>> =C2=A0=C2=A0 after: https://travis-ci.org/philmd/qemu/builds/641795043
>> Very good idea, correlating a job in the GUI to an entry in the yml file
>> was really a pain, so far.
>>
>>> [*]
>>> https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-with=
in-matrices
>>>
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> ---
>>> =C2=A0 .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------=
------
>>> =C2=A0 1 file changed, 67 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6c1038a0f1..d68e35a2c5 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -94,24 +94,28 @@ after_script:
>>> =C2=A0 =C2=A0 matrix:
>>> =C2=A0=C2=A0=C2=A0 include:
>>> -=C2=A0=C2=A0=C2=A0 - env:
>>> +=C2=A0=C2=A0=C2=A0 - name: "[x86] GCC static (user)"
>> Could you please drop the [x86] and other architectures from the names?
>> Travis already lists the build architecture in the job status page, so
>> this information is redundant.
>>
>> [...]
>=20
>=20
> I agree on dropping the architecture from the names, so:
>=20
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>=20
>=20
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Alternate coroutines implementations a=
re only really of
>>> interest to KVM users
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # However we can't test against KVM on T=
ravis so we can only
>>> run unit tests
>=20
>=20
> Yet another off-topic comment: If we switch those coroutine test jobs to
> Bionic then we can use KVM.

Good idea, that's certainly worth a try once your KVM-enablement patch
got included (or maybe you could also respin that patch with KVM enabled
here, too?)

 Thomas


