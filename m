Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C3C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BB92077C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 14:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiRwhglw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BB92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipvMW-0002wC-Sy
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 09:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ipvKs-0001ZD-1u
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ipvKp-0000B5-Td
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:32:25 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29254
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ipvKp-00009l-Cg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 09:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578666742;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=719g42u2rz+9V3916YPTM/uativVLpzDKDsVaRSjTdU=;
 b=RiRwhglwFGTTdlxPSULn9qLANtJULMkSAgM9QQXVIUCVrvyVjH1CNuBFcZFxTAPXusEbm/
 s3K3QVEgTWzNhF5WRqn0GEx4ykq3ppM2jzqwfSgch2r00xL19Z6zw9VLt6ynwy/ou6vdl+
 wggQBO3uQk6Vhb9+DO6Ff8PBGMELBjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-abbg4ELiP0qL4yvf3JxD8w-1; Fri, 10 Jan 2020 09:32:19 -0500
X-MC-Unique: abbg4ELiP0qL4yvf3JxD8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF3698C507A;
 Fri, 10 Jan 2020 14:32:16 +0000 (UTC)
Received: from [10.36.117.108] (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F4FF87ED7;
 Fri, 10 Jan 2020 14:32:12 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 11/16] arm/arm64: ITS: Device and
 collection Initialization
To: Zenghui Yu <yuzenghui@huawei.com>, eric.auger.pro@gmail.com,
 maz@kernel.org, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20191216140235.10751-1-eric.auger@redhat.com>
 <20191216140235.10751-12-eric.auger@redhat.com>
 <1f170d74-0ee5-6415-d84e-cd7de4d0f071@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <bb18550e-e9e5-f6ba-a5ff-8dc16cec866a@redhat.com>
Date: Fri, 10 Jan 2020 15:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1f170d74-0ee5-6415-d84e-cd7de4d0f071@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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

Hi Zenghui,

On 12/20/19 8:25 AM, Zenghui Yu wrote:
> Hi Eric,
>=20
> On 2019/12/16 22:02, Eric Auger wrote:
>> Introduce an helper functions to register
>> - a new device, characterized by its device id and the
>> =C2=A0=C2=A0 max number of event IDs that dimension its ITT (Interrupt
>> =C2=A0=C2=A0 Translation Table).=C2=A0 The function allocates the ITT.
>>
>> - a new collection, characterized by its ID and the
>> =C2=A0=C2=A0 target processing engine (PE).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> ---
>> =C2=A0 lib/arm/asm/gic-v3-its.h | 20 +++++++++++++++++
>> =C2=A0 lib/arm/gic-v3-its.c=C2=A0=C2=A0=C2=A0=C2=A0 | 46 +++++++++++++=
+++++++++++++++++++++++++++
>> =C2=A0 2 files changed, 66 insertions(+)
>>
>> diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
>> index ab639c5..245ef61 100644
>> --- a/lib/arm/asm/gic-v3-its.h
>> +++ b/lib/arm/asm/gic-v3-its.h
>> @@ -87,6 +87,9 @@
>> =C2=A0 =C2=A0 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (1ULL << 0)
>> =C2=A0 +#define GITS_MAX_DEVICES=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 8
>> +#define GITS_MAX_COLLECTIONS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 8
>> +
>> =C2=A0 struct its_typer {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int ite_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int eventid_bits;
>> @@ -117,6 +120,17 @@ struct its_cmd_block {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=C2=A0=C2=A0=C2=A0=C2=A0 raw_cmd[4];
>> =C2=A0 };
>> =C2=A0 +struct its_device {
>> +=C2=A0=C2=A0=C2=A0 u32 device_id;=C2=A0=C2=A0=C2=A0 /* device ID */
>> +=C2=A0=C2=A0=C2=A0 u32 nr_ites;=C2=A0=C2=A0=C2=A0 /* Max Interrupt Tr=
anslation Entries */
>> +=C2=A0=C2=A0=C2=A0 void *itt;=C2=A0=C2=A0=C2=A0 /* Interrupt Translat=
ion Table GPA */
>> +};
>> +
>> +struct its_collection {
>> +=C2=A0=C2=A0=C2=A0 u64 target_address;
>> +=C2=A0=C2=A0=C2=A0 u16 col_id;
>> +};
>> +
>> =C2=A0 struct its_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *base;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_typer typer;
>> @@ -124,6 +138,10 @@ struct its_data {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_cmd_block *cmd_base;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_cmd_block *cmd_write;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct its_cmd_block *cmd_readr;
>> +=C2=A0=C2=A0=C2=A0 struct its_device devices[GITS_MAX_DEVICES];
>> +=C2=A0=C2=A0=C2=A0 u32 nb_devices;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Allocated Devices */
>> +=C2=A0=C2=A0=C2=A0 struct its_collection collections[GITS_MAX_COLLECT=
IONS];
>> +=C2=A0=C2=A0=C2=A0 u32 nb_collections;=C2=A0=C2=A0=C2=A0 /* Allocated=
 Collections */
>=20
> ('nr_*' may be the more widely used one.)
>=20
>> =C2=A0 };
>> =C2=A0 =C2=A0 extern struct its_data its_data;
>> @@ -140,6 +158,8 @@ extern u8 get_lpi_config(int n);
>> =C2=A0 extern void set_pending_table_bit(int rdist, int n, bool set);
>> =C2=A0 extern void gicv3_rdist_ctrl_lpi(u32 redist, bool set);
>> =C2=A0 extern void its_enable_defaults(void);
>> +extern struct its_device *its_create_device(u32 dev_id, int nr_ites);
>> +extern struct its_collection *its_create_collection(u32 col_id, u32
>> target_pe);
>> =C2=A0 =C2=A0 #endif /* !__ASSEMBLY__ */
>> =C2=A0 #endif /* _ASMARM_GIC_V3_ITS_H_ */
>> diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
>> index 9a51ef4..9906428 100644
>> --- a/lib/arm/gic-v3-its.c
>> +++ b/lib/arm/gic-v3-its.c
>> @@ -284,3 +284,49 @@ void its_enable_defaults(void)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writel(GITS_CTLR_ENABLE, its_dat=
a.base + GITS_CTLR);
>> =C2=A0 }
>> +
>> +struct its_device *its_create_device(u32 device_id, int nr_ites)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct its_baser *baser;
>> +=C2=A0=C2=A0=C2=A0 struct its_device *new;
>> +=C2=A0=C2=A0=C2=A0 unsigned long n, order;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (its_data.nb_devices >=3D GITS_MAX_DEVICES)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 report_abort("%s redimensi=
on GITS_MAX_DEVICES", __func__);
>> +
>> +=C2=A0=C2=A0=C2=A0 baser =3D its_lookup_baser(GITS_BASER_TYPE_DEVICE)=
;
>> +=C2=A0=C2=A0=C2=A0 if (!baser)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> +=C2=A0=C2=A0=C2=A0 new =3D &its_data.devices[its_data.nb_devices];
>> +
>> +=C2=A0=C2=A0=C2=A0 new->device_id =3D device_id;
>> +=C2=A0=C2=A0=C2=A0 new->nr_ites =3D nr_ites;
>> +
>> +=C2=A0=C2=A0=C2=A0 n =3D (baser->esz * nr_ites) >> PAGE_SHIFT;
>=20
> baser->esz is GITS_BASER.Entry_Size, which indicates the size of
> Device Table entry.
> We're allocating ITT for this device now, shouldn't we use
> its_data.typer.esz?

Yes you're definitively right. I should use its_data.typer.ite_size.

Thank you!

Eric
>=20
>=20
> Thanks,
> Zenghui
>=20
>> +=C2=A0=C2=A0=C2=A0 order =3D is_power_of_2(n) ? fls(n) : fls(n) + 1;
>> +=C2=A0=C2=A0=C2=A0 new->itt =3D (void *)virt_to_phys(alloc_pages(orde=
r));
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.nb_devices++;
>> +=C2=A0=C2=A0=C2=A0 return new;
>> +}
>> +
>> +struct its_collection *its_create_collection(u32 col_id, u32 pe)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct its_collection *new;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (its_data.nb_collections >=3D GITS_MAX_COLLECTI=
ONS)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 report_abort("%s redimensi=
on GITS_MAX_COLLECTIONS", __func__);
>> +
>> +=C2=A0=C2=A0=C2=A0 new =3D &its_data.collections[its_data.nb_collecti=
ons];
>> +
>> +=C2=A0=C2=A0=C2=A0 new->col_id =3D col_id;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (its_data.typer.pta)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new->target_address =3D (u=
64)gicv3_data.redist_base[pe];
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new->target_address =3D pe=
 << 16;
>> +
>> +=C2=A0=C2=A0=C2=A0 its_data.nb_collections++;
>> +=C2=A0=C2=A0=C2=A0 return new;
>> +}
>>
>=20


