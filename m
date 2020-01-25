Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CCBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 16:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C5DD2070A
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnuDRHWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C5DD2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivOXv-0008Ux-JP
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 11:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ivOX3-0007n4-IY
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 11:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ivOX1-0004NQ-5x
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 11:43:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60227
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ivOX0-0004Md-TH
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 11:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579970614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jXg3gy8idxtbMe3z1X4AlsIInvp9LQQzBBdoww9+aWI=;
 b=QnuDRHWPU0NfdBmGg7Wlo5T4jcWAdTd74+nUAAn8+2IftPd21Qfv705zZnnPTsHgOH/VkT
 FTelTHAGlxPJ5RJi5Vbt4lgekgjAXJeVes+NctSpqGNMQJFjrji9uqS7RBNMsofia/3u31
 FR181rQqSzdMVAFfByk3eJHVkiv5fLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-p4dPon5mMmChpfZiIgFKTQ-1; Sat, 25 Jan 2020 11:43:30 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6750B1005512;
 Sat, 25 Jan 2020 16:43:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-42.ams2.redhat.com [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2738E10013A1;
 Sat, 25 Jan 2020 16:43:24 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
 <8f085a1a-b9df-29d4-db51-eb345a44a971@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1f564925-2ee1-ab17-a946-f9bcd656926f@redhat.com>
Date: Sat, 25 Jan 2020 17:43:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8f085a1a-b9df-29d4-db51-eb345a44a971@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: p4dPon5mMmChpfZiIgFKTQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 22.28, Wainer dos Santos Moschetta wrote:
>=20
> On 1/24/20 3:03 PM, Thomas Huth wrote:
>> The 2018 edition of the QEMU advent calendar 2018 featured Linux images
>> for various non-x86 machines. We can use them for a boot tests in our
>> acceptance test suite.
>>
>> Let's also make sure that we build the corresponding machines in Travis,
>> and while we're there, drop the superfluous --python parameter (python3
>> is now the only supported version anyway).
>=20
> Yes, please, removal of --python was in my wish list.
>=20
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 .travis.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 tests/acceptance/boot_linux_console.py | 96 +++++++++++++++++++++=
+++++
>> =C2=A0 2 files changed, 97 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 6c1038a0f1..73ca12c921 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -268,7 +268,7 @@ matrix:
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Acceptance (Functional) tests
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - env:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CONFIG=3D"--python=3D/usr/=
bin/python3
>> --target-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-sof=
tmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k=
-softmmu,sparc-softmmu"
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
>> CONFIG=3D"--target-list=3Daarch64-softmmu,alpha-softmmu,arm-softmmu,m68k=
-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1=
k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-soft=
mmu,xtensa-softmmu"
>>
>=20
>=20
> Perhaps use MAIN_SOFTMMU_TARGETS in only append the other targets, like:
>=20
> --target-list=3D${MAIN_SOFTMMU_TARGETS},alpha-softmmu,sparc-softmmu,....

Not sure ... while it is a nice way to shorten the line here, it adds a
dependecy to that variable ... and MAIN_SOFTMMU_TARGETS has been changed
a couple of times during the course of time, so we might risk to lose
some testing coverage here in case someone removes a target from
MAIN_SOFTMMU_TARGETS but forgets to add it here again...? I think we
should better use the explicit list here instead.

 Thomas


