Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF592C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8807B20732
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 08:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTkVOMWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8807B20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIq6P-0003YL-Nl
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 04:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jIq4d-0001y7-FM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jIq4c-0005M5-FR
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:47:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24623)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jIq4c-0005LZ-CC
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 04:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585558029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V3toyHtdmIDsvhTBATPytSTJjTPkQkswWc1NSEnUkCA=;
 b=LTkVOMWBQRhpPmr+aAo23tg0yHahoUOyYTuWNPb/7yfuw5n66o/d2Ex8bF14OSGznhTSOO
 ZOAdv5IPHsbVNyPJQ+ITOtaJMDbTKBGPab536hEQ9X8Qwr0UY2UPSKUD52+at9v7focON8
 o+tgiIq6JmLDH5AiVthFIDCHgRG363A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-PV9z_La-NdqheXia0TXc2w-1; Mon, 30 Mar 2020 04:47:05 -0400
X-MC-Unique: PV9z_La-NdqheXia0TXc2w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 427BD1937FC0;
 Mon, 30 Mar 2020 08:47:04 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C33CE19925;
 Mon, 30 Mar 2020 08:46:58 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 06/13] arm/arm64: ITS: Introspection
 tests
To: Zenghui Yu <yuzenghui@huawei.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-7-eric.auger@redhat.com>
 <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <8878be7f-7653-b427-cd0d-722f82fb6b65@redhat.com>
Date: Mon, 30 Mar 2020 10:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <947a79f5-1f79-532b-9ec7-6fd539ccd183@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, thuth@redhat.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zenghui,

On 3/30/20 10:30 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/20 17:24, Eric Auger wrote:
>> +static void its_cmd_queue_init(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned long order =3D get_order(SZ_64K >> PAGE_S=
HIFT);
>> +=C2=A0=C2=A0=C2=A0 u64 cbaser;
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.cmd_base =3D (void *)virt_to_phys(alloc_p=
ages(order));
>=20
> Shouldn't the cmd_base (and the cmd_write) be set as a GVA?
yes it should
>=20
> Otherwise I think we will end-up with memory corruption when writing
> the command queue.=C2=A0 But it seems that everything just works fine .=
..
> So I'm really confused here :-/
I was told by Paolo that the VA/PA memory map is flat in kvmunit test.

>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 cbaser =3D ((u64)its_data.cmd_base | (SZ_64K / SZ_=
4K - 1)=C2=A0=C2=A0=C2=A0 |
>> GITS_CBASER_VALID);
>> +
>> +=C2=A0=C2=A0=C2=A0 writeq(cbaser, its_data.base + GITS_CBASER);
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.cmd_write =3D its_data.cmd_base;
>> +=C2=A0=C2=A0=C2=A0 writeq(0, its_data.base + GITS_CWRITER);
>> +}
>=20
> Otherwise this looks good,
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Thanks!

Eric
>=20
>=20
> Thanks
>=20


