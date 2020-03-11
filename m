Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3CDC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2342413B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT3EYx6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2342413B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2FR-0006zs-1b
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maz@kernel.org>) id 1jC1uS-0004d2-CI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maz@kernel.org>) id 1jC1uR-0006wy-7w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53670)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maz@kernel.org>)
 id 1jC1uG-0006bp-Hz; Wed, 11 Mar 2020 10:00:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org
 [51.254.78.96])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D44A21D56;
 Wed, 11 Mar 2020 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583935218;
 bh=0OhcIcZrD2BAj+IbJhSUJLV6Mv2HMcdowWmdsbMbNhY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hT3EYx6uOpjy1EAwyCTjY6+WpJ5Jl4+nlTYOM1Vi2FQKFukSHtjNZeet9m2Em3MkX
 ypwcs2QckRkoy2Vw4PJxXmM1eFw+8XI4FBzqmEwoVmOzFY8DCKKfvQwJttcf4jjYi+
 b1nE90aNOKAZrzYelCvCXhL5i4jKplfAXywUiTgc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
 by disco-boy.misterjones.org with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <maz@kernel.org>)
 id 1jC1uC-00BvZI-Lr; Wed, 11 Mar 2020 14:00:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 11 Mar 2020 14:00:16 +0000
From: Marc Zyngier <maz@kernel.org>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 10/13] arm/arm64: ITS: INT functional
 tests
In-Reply-To: <46f0ed1d-3bda-f91b-e2b0-addf1c61c373@redhat.com>
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-11-eric.auger@redhat.com>
 <d3f651a0-2344-4d6e-111b-be133db7e068@huawei.com>
 <46f0ed1d-3bda-f91b-e2b0-addf1c61c373@redhat.com>
Message-ID: <301a8b402ff7e480e927b0f8f8b093f2@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: eric.auger@redhat.com, yuzenghui@huawei.com,
 eric.auger.pro@gmail.com, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com,
 andre.przywara@arm.com, peter.maydell@linaro.org, alexandru.elisei@arm.com,
 thuth@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org);
 SAEximRunCond expanded to false
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 198.145.29.99
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, kvm@vger.kernel.org,
 andre.przywara@arm.com, qemu-devel@nongnu.org, thuth@redhat.com,
 qemu-arm@nongnu.org, Zenghui Yu <yuzenghui@huawei.com>,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-03-11 13:48, Auger Eric wrote:
> Hi Zenghui,
>=20
> On 3/11/20 12:59 PM, Zenghui Yu wrote:
>> Hi Eric,
>>=20
>> On 2020/3/10 22:54, Eric Auger wrote:
>>> Triggers LPIs through the INT command.
>>>=20
>>> the test checks the LPI hits the right CPU and triggers
>>> the right LPI intid, ie. the translation is correct.
>>>=20
>>> Updates to the config table also are tested, along with inv
>>> and invall commands.
>>>=20
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>=20
>>> ---
>>=20
>> [...]
>>=20
>>> +static void test_its_trigger(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct its_collection *col3, *col2;
>>> +=C2=A0=C2=A0=C2=A0 struct its_device *dev2, *dev7;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (its_prerequisites(4))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dev2 =3D its_create_device(2 /* dev id */, 8 /* n=
b_ites */);
>>> +=C2=A0=C2=A0=C2=A0 dev7 =3D its_create_device(7 /* dev id */, 8 /* n=
b_ites */);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 col3 =3D its_create_collection(3 /* col id */, 3/=
* target PE */);
>>> +=C2=A0=C2=A0=C2=A0 col2 =3D its_create_collection(2 /* col id */, 2/=
* target PE */);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(8195, LPI_PROP_DEFAULT);
>>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(8196, LPI_PROP_DEFAULT);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col2);
>>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col3);
>>=20
>> These two INVALLs should be issued after col2 and col3 are mapped,
>> otherwise this will cause the INVALL command error as per the spec
>> (though KVM doesn't complain it at all).
> Yes you're right. reading the spec again:
>=20
> A command error occurs if any of the following apply:
> ../..
> The collection specified by ICID has not been mapped to an RDbase using
> MAPC.
>=20
> But as mentionned in the cover letter, no real means to retrieve the
> error at the moment.

That is still a problem with the ITS. There is no architectural way
to report an error, even if the error numbers are architected...

One thing we could do though is to implement the stall model (as=20
described
in 5.3.2). It still doesn't give us the error, but at least the command
queue would stop on detecting an error.

         M.
--=20
Jazz is not dead. It just smells funny...

