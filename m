Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85143C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5116C20675
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 12:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jei6MkZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5116C20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIthX-00034X-Db
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jItgl-0002ZY-Dl
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:38:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jItgj-0008IY-VK
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:38:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52157)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jItgj-0008IM-RG
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 08:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585571925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4cUzeidLCschmMx+521qeR+2AGe9fkhbWsqAhHXFkg=;
 b=Jei6MkZohwWkaJ0GFaOPY+9Wyuch94fZKKz9l/VPvrNx7L66Ahn45CvhnAYmYUu3pFt7C6
 JDq9n8Dt6Veurj2Hkx7F1+EqAurISyI1pD/VQcwynZuezHaHizoT+7eddi1kxwmQMLpOS3
 QuXk5q/T9LzJ51K/TLzeUwlEFUWBOoA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-e6d9mGMXOOW6hD0m0hqhTQ-1; Mon, 30 Mar 2020 08:38:41 -0400
X-MC-Unique: e6d9mGMXOOW6hD0m0hqhTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A27618AB2C4;
 Mon, 30 Mar 2020 12:38:40 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 89E3C5DA66;
 Mon, 30 Mar 2020 12:38:34 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 13/13] arm/arm64: ITS: pending table
 migration test
To: Zenghui Yu <yuzenghui@huawei.com>
References: <20200320092428.20880-1-eric.auger@redhat.com>
 <20200320092428.20880-14-eric.auger@redhat.com>
 <296c574b-810c-9c90-a613-df732a9ac193@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ea74559c-2ab4-752c-e587-2bf40eab14b0@redhat.com>
Date: Mon, 30 Mar 2020 14:38:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <296c574b-810c-9c90-a613-df732a9ac193@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On 3/30/20 2:06 PM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/20 17:24, Eric Auger wrote:
>> Add two new migration tests. One testing the migration of
>> a topology where collection were unmapped. The second test
>> checks the migration of the pending table.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>=20
> [...]
>=20
>> @@ -659,6 +678,15 @@ static int its_prerequisites(int nb_cpus)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> =C2=A0 +static void set_lpi(struct its_device *dev, u32 eventid, u32 p=
hysid,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct its_collection *col)
>> +{
>> +=C2=A0=C2=A0=C2=A0 assert(dev && col);
>> +
>> +=C2=A0=C2=A0=C2=A0 its_send_mapti(dev, physid, eventid, col);
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
>> +}
>=20
> I'd say we can just drop this helper and open-code it anywhere
> necessarily. The name 'set_lpi' doesn't tell me too much about
> what has been implemented inside the helper.
>=20
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Setup the configuration for those mappings:
>> =C2=A0=C2=A0 * dev_id=3D2 event=3D20 -> vcpu 3, intid=3D8195
>> @@ -790,6 +818,108 @@ static void test_its_migration(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its_send_int(dev7, 255);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev7/eventid=3D255 tri=
ggers LPI 8196 on PE #2
>> after migration");
>> =C2=A0 }
>> +
>> +static void test_migrate_unmapped_collection(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct its_collection *col;
>> +=C2=A0=C2=A0=C2=A0 struct its_device *dev2, *dev7;
>> +=C2=A0=C2=A0=C2=A0 int pe0 =3D 0;
>> +=C2=A0=C2=A0=C2=A0 u8 config;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (its_setup1())
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 col =3D its_create_collection(pe0, pe0);
>> +=C2=A0=C2=A0=C2=A0 dev2 =3D its_get_device(2);
>> +=C2=A0=C2=A0=C2=A0 dev7 =3D its_get_device(7);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* MAPTI with the collection unmapped */
>> +=C2=A0=C2=A0=C2=A0 set_lpi(dev2, 0, 8192, col);
>=20
> ... and it's only invoked here.
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 puts("Now migrate the VM, then press a key to cont=
inue...\n");
>> +=C2=A0=C2=A0=C2=A0 (void)getchar();
>> +=C2=A0=C2=A0=C2=A0 report_info("Migration complete");
>> +
>> +=C2=A0=C2=A0=C2=A0 /* on the destination, map the collection */
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(col, true);
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col);
>> +
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(2, 8196);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev7, 255);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev7/eventid=3D 255 triggered LPI=
 8196 on PE #2");
>> +
>> +=C2=A0=C2=A0=C2=A0 config =3D gicv3_lpi_get_config(8192);
>> +=C2=A0=C2=A0=C2=A0 report(config =3D=3D LPI_PROP_DEFAULT,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Config =
of LPI 8192 was properly migrated");
>> +
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(pe0, 8192);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 0);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("dev2/eventid =3D 0 triggered LPI =
8192 on PE0");
>> +}
>> +
>> +static void test_its_pending_migration(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct its_device *dev;
>> +=C2=A0=C2=A0=C2=A0 struct its_collection *collection[2];
>> +=C2=A0=C2=A0=C2=A0 int *expected =3D malloc(nr_cpus * sizeof(int));
>> +=C2=A0=C2=A0=C2=A0 int pe0 =3D nr_cpus - 1, pe1 =3D nr_cpus - 2;
>> +=C2=A0=C2=A0=C2=A0 u64 pendbaser;
>> +=C2=A0=C2=A0=C2=A0 void *ptr;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (its_prerequisites(4))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev =3D its_create_device(2 /* dev id */, 8 /* nb_=
ites */);
>> +=C2=A0=C2=A0=C2=A0 its_send_mapd(dev, true);
>> +
>> +=C2=A0=C2=A0=C2=A0 collection[0] =3D its_create_collection(pe0, pe0);
>> +=C2=A0=C2=A0=C2=A0 collection[1] =3D its_create_collection(pe1, pe1);
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(collection[0], true);
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(collection[1], true);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* disable lpi at redist level */
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_rdist_disable(pe0);
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_rdist_disable(pe1);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* lpis are interleaved inbetween the 2 PEs */
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 256; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_collection *col=
 =3D i % 2 ? collection[0] :
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 collection[1];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int vcpu =3D col->target_a=
ddress >> 16;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 its_send_mapti(dev, LPI(i)=
, i, col);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(LPI(i=
), LPI_PROP_DEFAULT);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_clr_pending(=
vcpu, LPI(i), true);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(collection[0]);
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(collection[1]);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Clear the PTZ bit on each pendbaser */
>> +
>> +=C2=A0=C2=A0=C2=A0 expected[pe0] =3D 128;
>> +=C2=A0=C2=A0=C2=A0 expected[pe1] =3D 128;
>=20
> Do we need to initialize expected[] for other PEs? Or it has always
> been zeroed by the kvm-unit-tests implementation of malloc()?
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 ptr =3D gicv3_data.redist_base[pe0] + GICR_PENDBAS=
ER;
>> +=C2=A0=C2=A0=C2=A0 pendbaser =3D readq(ptr);
>> +=C2=A0=C2=A0=C2=A0 writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
>> +
>> +=C2=A0=C2=A0=C2=A0 ptr =3D gicv3_data.redist_base[pe1] + GICR_PENDBAS=
ER;
>> +=C2=A0=C2=A0=C2=A0 pendbaser =3D readq(ptr);
>> +=C2=A0=C2=A0=C2=A0 writeq(pendbaser & ~GICR_PENDBASER_PTZ, ptr);
>> +
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_rdist_enable(pe0);
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_rdist_enable(pe1);
>=20
> I don't know how the migration gets implemented in kvm-unit-tests.
> But is there any guarantee that the LPIs will only be triggered on the
> destination side? As once the EnableLPIs bit becomes 1, VGIC will start
> reading the pending bit in guest memory and potentially injecting LPIs
> into the target vcpu (in the source side).

I expect some LPIs to hit on source and some others to hit on the
destination. To me, this does not really matter as long as the handlers
gets called and accumulate the stats. Given the number of LPIs, we will
at least test the migration of some of the pending bits and especially
adjacent ones. It does work as it allows to test your fix:

ca185b260951  KVM: arm/arm64: vgic: Don't rely on the wrong pending table

Thanks

Eric
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 puts("Now migrate the VM, then press a key to cont=
inue...\n");
>> +=C2=A0=C2=A0=C2=A0 (void)getchar();
>> +=C2=A0=C2=A0=C2=A0 report_info("Migration complete");
>> +
>> +=C2=A0=C2=A0=C2=A0 /* let's wait for the 256 LPIs to be handled */
>> +=C2=A0=C2=A0=C2=A0 mdelay(1000);
>> +
>> +=C2=A0=C2=A0=C2=A0 check_lpi_hits(expected, "128 LPIs on both PE0 and=
 PE1 after
>> migration");
>> +}
>=20
>=20
> Thanks,
> Zenghui
>=20
>=20


