Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD50EC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77D6D20873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtHMMYqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D6D20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1kY-000182-No
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 09:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jC1jt-0007iJ-7L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jC1jr-0007YE-L7
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:49:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jC1jr-0007Y3-HB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsvML7TjAQJWusNVkCpKgOQx6lENNDL9bm3AiV1RPfc=;
 b=FtHMMYqcx71j1Q1XV3hxocOLcKCMQ+nSS+rhYs8VvhVa1276naiKcUZbSFAO23tX53vXne
 xNlbvS/7XB3/yaVx8qPdfjuydHQUNy+8LrUwIgGe4YvwQZSL7OJOuuT+4e/v+4O9fUbxRy
 Fni/+nMxgNyigv5pU06xUKCcqdZ1Gh0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-49vmNWx9MBC47vDTZl3Pig-1; Wed, 11 Mar 2020 09:49:31 -0400
X-MC-Unique: 49vmNWx9MBC47vDTZl3Pig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A9C01137841;
 Wed, 11 Mar 2020 13:49:29 +0000 (UTC)
Received: from [10.36.118.12] (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 397A692D2C;
 Wed, 11 Mar 2020 13:49:25 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v5 13/13] arm/arm64: ITS: pending table
 migration test
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200310145410.26308-1-eric.auger@redhat.com>
 <20200310145410.26308-14-eric.auger@redhat.com>
 <54139b63-3a1d-7276-4d0b-4d38f9901536@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <96f01985-6515-8501-2b14-c8f91dcdfa81@redhat.com>
Date: Wed, 11 Mar 2020 14:49:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <54139b63-3a1d-7276-4d0b-4d38f9901536@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: andre.przywara@arm.com, drjones@redhat.com, alexandru.elisei@arm.com,
 thuth@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 3/11/20 1:07 PM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2020/3/10 22:54, Eric Auger wrote:
>> Add two new migration tests. One testing the migration of
>> a topology where collection were unmapped. The second test
>> checks the migration of the pending table.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v4 -> v5:
>> - move stub from header to arm/gic.c
>>
>> v3 -> v4:
>> - do not talk about odd/even CPUs, use pe0 and pe1
>> - comment the delay
>>
>> v2 -> v3:
>> - tests belong to both its and migration groups
>> - use LPI(i)
>> - gicv3_lpi_set_pending_table_bit renamed into gicv3_lpi_set_clr_pendi=
ng
>> ---
>> =C2=A0 arm/gic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 146=
 ++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 arm/unittests.cfg |=C2=A0 16 +++++
>> =C2=A0 2 files changed, 162 insertions(+)
>>
>> diff --git a/arm/gic.c b/arm/gic.c
>> index b8fbc13..e6ffbc3 100644
>> --- a/arm/gic.c
>> +++ b/arm/gic.c
>> @@ -193,6 +193,7 @@ static void lpi_handler(struct pt_regs *regs
>> __unused)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_rmb(); /* pairs with wmb in lpi_sta=
ts_expect */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpi_stats.observed.cpu_id =3D smp_proce=
ssor_id();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lpi_stats.observed.lpi_id =3D irqnr;
>> +=C2=A0=C2=A0=C2=A0 acked[lpi_stats.observed.cpu_id]++;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smp_wmb(); /* pairs with rmb in check_l=
pi_stats */
>> =C2=A0 }
>> =C2=A0 @@ -236,6 +237,22 @@ static void secondary_lpi_test(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (1)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wfi();
>> =C2=A0 }
>> +
>> +static void check_lpi_hits(int *expected, const char *msg)
>> +{
>> +=C2=A0=C2=A0=C2=A0 bool pass =3D true;
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nr_cpus; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (acked[i] !=3D expected=
[i]) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
port_info("expected %d LPIs on PE #%d, %d observed",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expected[i], i, acked[i]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
ss =3D false;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 report(pass, "%s", msg);
>> +}
>> =C2=A0 #endif
>> =C2=A0 =C2=A0 static void gicv2_ipi_send_self(void)
>> @@ -591,6 +608,8 @@ static void gic_test_mmio(void)
>> =C2=A0 static void test_its_introspection(void) {}
>> =C2=A0 static void test_its_trigger(void) {}
>> =C2=A0 static void test_its_migration(void) {}
>> +static void test_its_pending_migration(void) {}
>> +static void test_migrate_unmapped_collection(void) {}
>> =C2=A0 =C2=A0 #else /* __aarch64__ */
>> =C2=A0 @@ -659,6 +678,17 @@ static int its_prerequisites(int nb_cpus)
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
>> +
>> +=C2=A0=C2=A0=C2=A0 gicv3_lpi_set_config(physid, LPI_PROP_DEFAULT);
>> +=C2=A0=C2=A0=C2=A0 its_send_invall(col);
>=20
> Again, the col hasn't been mapped currently.
right. Moving it outside of the helper then
>=20
>> +}
>> +
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Setup the configuration for those mappings:
>> =C2=A0=C2=A0 * dev_id=3D2 event=3D20 -> vcpu 3, intid=3D8195
>> @@ -799,6 +829,114 @@ static void test_its_migration(void)
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
>> +=C2=A0=C2=A0=C2=A0 int pe0 =3D nr_cpus - 1;
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
>> +
>> +=C2=A0=C2=A0=C2=A0 puts("Now migrate the VM, then press a key to cont=
inue...\n");
>> +=C2=A0=C2=A0=C2=A0 (void)getchar();
>> +=C2=A0=C2=A0=C2=A0 report_info("Migration complete");
>> +
>> +=C2=A0=C2=A0=C2=A0 /* on the destination, map the collection */
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(col, true);
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
>> +
>> +=C2=A0=C2=A0=C2=A0 /* unmap the collection */
>> +=C2=A0=C2=A0=C2=A0 its_send_mapc(col, false);
>=20
> Again, behavior is unpredictable.
yep removing that test.
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 lpi_stats_expect(-1, -1);
>> +=C2=A0=C2=A0=C2=A0 its_send_int(dev2, 0);
>> +=C2=A0=C2=A0=C2=A0 check_lpi_stats("no LPI triggered after collection=
 unmapping");
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
>> +=C2=A0=C2=A0=C2=A0 /* Set the PTZ bit on each pendbaser */
>=20
> 'Clear' the PTZ.
yep
>=20
> Otherwise looks good!

Thank you for your careful review!

Best Regards

Eric
>=20
>> +
>> +=C2=A0=C2=A0=C2=A0 expected[pe0] =3D 128;
>> +=C2=A0=C2=A0=C2=A0 expected[pe1] =3D 128;
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
> Thanks,
> Zenghui
>=20


