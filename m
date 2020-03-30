Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C52206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 09:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHfHlPya"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C52206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrCl-0006G6-UT
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 05:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jIr9W-0002q4-2w
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jIr9U-0000MQ-TR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:56:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42041)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jIr9U-0000MB-Pz
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 05:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585562176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+i48u5EVTvTZXlAFzW/M3AOj4ZvswK4iw2XDLheQWkE=;
 b=SHfHlPyaQRbcqbGJt78LlBXMXUe43GOiaXXDHKZDQWnxbFl8cGB7Z4oOC2k6MJS88FmkCz
 KT5MWt24qOPAhC5PzJsfm0UudmxCUBqk7SBhwyMzZLEhGjEV2u3cwvw7rH6Knd4Is9EuEA
 ciVRCd3aYHYRJ1fYbxLuDKA2XW7ScBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-jk6K2iO_ORCgrkaHNScO6Q-1; Mon, 30 Mar 2020 05:56:12 -0400
X-MC-Unique: jk6K2iO_ORCgrkaHNScO6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B4E7801E53;
 Mon, 30 Mar 2020 09:56:10 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA160953D6;
 Mon, 30 Mar 2020 09:56:04 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
To: Andrew Jones <drjones@redhat.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
 <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
 <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7d6dc4e7-82b4-3c54-574f-2149d4a85c48@redhat.com>
Date: Mon, 30 Mar 2020 11:56:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200330091139.i2d6vv64f5diamlz@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, Zenghui Yu <yuzenghui@huawei.com>,
 alexandru.elisei@arm.com, kvmarm@lists.cs.columbia.edu,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 3/30/20 11:11 AM, Andrew Jones wrote:
> On Mon, Mar 30, 2020 at 10:46:57AM +0200, Auger Eric wrote:
>> Hi Zenghui,
>>
>> On 3/30/20 10:30 AM, Zenghui Yu wrote:
>>> Hi Eric,
>>>
>>> On 2020/3/20 17:24, Eric Auger wrote:
>>>> +static void its_cmd_queue_init(void)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long order =3D get_order(SZ_64K >> PAGE=
_SHIFT);
>>>> +=C2=A0=C2=A0=C2=A0 u64 cbaser;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 its_data.cmd_base =3D (void *)virt_to_phys(alloc=
_pages(order));
>>>
>>> Shouldn't the cmd_base (and the cmd_write) be set as a GVA?
>> yes it should
>=20
> If it's supposed to be a virtual address, when why do the virt_to_phys?
What is programmed in CBASER register is a physical address. So the
virt_to_phys() is relevant. The inconsistency is in its_allocate_entry()
introduced later on where I return the physical address instead of the
virtual address. I will fix that.


>=20
>>>
>>> Otherwise I think we will end-up with memory corruption when writing
>>> the command queue.=C2=A0 But it seems that everything just works fine=
 ...
>>> So I'm really confused here :-/
>> I was told by Paolo that the VA/PA memory map is flat in kvmunit test.
>=20
> What does flat mean?

Yes I meant an identity map.

 kvm-unit-tests, at least arm/arm64, does prepare
> an identity map of all physical memory, which explains why the above
> is working.

should be the same on x86

 It's doing virt_to_phys(some-virt-addr), which gets a
> phys addr, but when the ITS uses it as a virt addr it works because
> we *also* have a virt addr =3D=3D phys addr mapping in the default page
> table, which is named "idmap" for good reason.
>=20
> I think it would be better to test with the non-identity mapped address=
es
> though.

is there any way to exercise a non idmap?

Thanks

Eric
>=20
> Thanks,
> drew
>=20
>>
>>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 cbaser =3D ((u64)its_data.cmd_base | (SZ_64K / S=
Z_4K - 1)=C2=A0=C2=A0=C2=A0 |
>>>> GITS_CBASER_VALID);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 writeq(cbaser, its_data.base + GITS_CBASER);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 its_data.cmd_write =3D its_data.cmd_base;
>>>> +=C2=A0=C2=A0=C2=A0 writeq(0, its_data.base + GITS_CWRITER);
>>>> +}
>>>
>>> Otherwise this looks good,
>>> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
>> Thanks!
>>
>> Eric
>>>
>>>
>>> Thanks
>>>
>>
>>


