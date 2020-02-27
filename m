Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AFFC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B1A222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B1A222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FEn-00011d-BL
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41505)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j7FDk-0000K7-D2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j7FDi-0003hA-UK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:12:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3177 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1j7FDi-00036G-IZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:12:38 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id EF9FA6AB7851BC2FF506;
 Thu, 27 Feb 2020 17:12:29 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0;
 Thu, 27 Feb 2020 17:12:22 +0800
Subject: Re: [PATCH] hw/smbios: add options for type 4 max_speed and
 current_speed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <qemu-devel@nongnu.org>
References: <20200225075046.30151-1-guoheyi@huawei.com>
 <4bd58f6e-e522-d920-bc9a-8198147e8856@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <6e6c6c8b-c67c-6433-2bb8-d246c5f49b62@huawei.com>
Date: Thu, 27 Feb 2020 17:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4bd58f6e-e522-d920-bc9a-8198147e8856@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: wanghaibin.wang@huawei.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/25 17:24, Philippe Mathieu-Daud=E9 wrote:
> On 2/25/20 8:50 AM, Heyi Guo wrote:
>> Common VM users sometimes care about CPU speed, so we add two new
>> options to allow VM vendors to present CPU speed to their users.
>> Normally these information can be fetched from host smbios.
>>
>> Strictly speaking, the "max speed" and "current speed" in type 4
>> are not really for the max speed and current speed of processor, for
>> "max speed" identifies a capability of the system, and "current speed"
>> identifies the processor's speed at boot (see smbios spec), but some
>> applications do not tell the differences.
>>
>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>
>> ---
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Igor Mammedov <imammedo@redhat.com>
>> ---
>> =A0 hw/smbios/smbios.c | 22 +++++++++++++++++++---
>> =A0 qemu-options.hx=A0=A0=A0 |=A0 3 ++-
>> =A0 2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>> index ffd98727ee..1d5439643d 100644
>> --- a/hw/smbios/smbios.c
>> +++ b/hw/smbios/smbios.c
>> @@ -94,6 +94,8 @@ static struct {
>> =A0 =A0 static struct {
>> =A0=A0=A0=A0=A0 const char *sock_pfx, *manufacturer, *version, *serial=
, *asset,=20
>> *part;
>> +=A0=A0=A0 uint32_t max_speed;
>> +=A0=A0=A0 uint32_t current_speed;
>> =A0 } type4;
>> =A0 =A0 static struct {
>> @@ -272,6 +274,14 @@ static const QemuOptDesc=20
>> qemu_smbios_type4_opts[] =3D {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "version",
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D QEMU_OPT_STRING,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .help =3D "version number",
>> +=A0=A0=A0 },{
>> +=A0=A0=A0=A0=A0=A0=A0 .name =3D "max_speed",
>> +=A0=A0=A0=A0=A0=A0=A0 .type =3D QEMU_OPT_NUMBER,
>> +=A0=A0=A0=A0=A0=A0=A0 .help =3D "max speed in MHz",
>> +=A0=A0=A0 },{
>> +=A0=A0=A0=A0=A0=A0=A0 .name =3D "current_speed",
>> +=A0=A0=A0=A0=A0=A0=A0 .type =3D QEMU_OPT_NUMBER,
>> +=A0=A0=A0=A0=A0=A0=A0 .help =3D "speed at system boot in MHz",
>> =A0=A0=A0=A0=A0 },{
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "serial",
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D QEMU_OPT_STRING,
>> @@ -586,9 +596,8 @@ static void=20
>> smbios_build_type_4_table(MachineState *ms, unsigned instance)
>> =A0=A0=A0=A0=A0 SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.v=
ersion);
>> =A0=A0=A0=A0=A0 t->voltage =3D 0;
>> =A0=A0=A0=A0=A0 t->external_clock =3D cpu_to_le16(0); /* Unknown */
>> -=A0=A0=A0 /* SVVP requires max_speed and current_speed to not be unkn=
own. */
>> -=A0=A0=A0 t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
>> -=A0=A0=A0 t->current_speed =3D cpu_to_le16(2000); /* 2000 MHz */
>> +=A0=A0=A0 t->max_speed =3D cpu_to_le16(type4.max_speed);
>> +=A0=A0=A0 t->current_speed =3D cpu_to_le16(type4.current_speed);
>> =A0=A0=A0=A0=A0 t->status =3D 0x41; /* Socket populated, CPU enabled *=
/
>> =A0=A0=A0=A0=A0 t->processor_upgrade =3D 0x01; /* Other */
>> =A0=A0=A0=A0=A0 t->l1_cache_handle =3D cpu_to_le16(0xFFFF); /* N/A */
>> @@ -1129,6 +1138,13 @@ void smbios_entry_add(QemuOpts *opts, Error=20
>> **errp)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 save_opt(&type4.serial, opts, =
"serial");
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 save_opt(&type4.asset, opts, "=
asset");
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 save_opt(&type4.part, opts, "p=
art");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * SVVP requires max_speed and cu=
rrent_speed to not be=20
>> unknown, and
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * we set the default value to 20=
00MHz as we did before.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type4.max_speed =3D qemu_opt_get_nu=
mber(opts, "max_speed",=20
>> 2000);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 type4.current_speed =3D qemu_opt_ge=
t_number(opts,=20
>> "current_speed",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 2000);
>
> Maybe check speeds are <=3D UINT16_MAX else set errp?

OK; I can do that in the v2. But I would wait for the maintainers to=20
provide more comments :)

Thanks,

Heyi

>
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 case 11:
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 qemu_opts_validate(opts, qemu_=
smbios_type11_opts, &err);
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index ac315c1ac4..bc9ef0fda8 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>> =A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 specify=
 SMBIOS type 3 fields\n"
>> =A0=A0=A0=A0=A0 "-smbios=20
>> type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr][,serial=
=3Dstr]\n"
>> =A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [,asset=3Dstr=
][,part=3Dstr]\n"
>> +=A0=A0=A0 "=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [,max_speed=3D%d][=
,current_speed=3D%d]\n"
>> =A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 specify=
 SMBIOS type 4 fields\n"
>> =A0=A0=A0=A0=A0 "-smbios=20
>> type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,serial=3D=
str]\n"
>> =A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 [,asset=3D=
str][,part=3Dstr][,speed=3D%d]\n"
>> @@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
>> =A0 @item -smbios=20
>> type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str}][,serial=3D@v=
ar{str}][,asset=3D@var{str}][,sku=3D@var{str}]
>> =A0 Specify SMBIOS type 3 fields
>> =A0 -@item -smbios=20
>> type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,version=3D=
@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}]
>> +@item -smbios=20
>> type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,version=3D=
@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}][,m=
ax_speed=3D@var{%d}][,current_speed=3D@var{%d}]
>> =A0 Specify SMBIOS type 4 fields
>> =A0 =A0 @item -smbios=20
>> type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufacturer=3D@va=
r{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}][,spee=
d=3D@var{%d}]
>>
>
>
> .


