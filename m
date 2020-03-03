Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B64C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC0E2083E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 11:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC0E2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95t1-0003LT-5b
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 06:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j95ry-0001im-K1
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j95rx-00075z-2D
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:37:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3181 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1j95rw-00073G-Nw
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 06:37:49 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 86F7D5D1A363D3CA5615;
 Tue,  3 Mar 2020 19:37:35 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0;
 Tue, 3 Mar 2020 19:37:25 +0800
Subject: Re: [PATCH v3] hw/smbios: add options for type 4 max-speed and
 current-speed
To: Igor Mammedov <imammedo@redhat.com>
References: <20200303010158.52994-1-guoheyi@huawei.com>
 <997b0093-6820-0c27-0d73-55afb97019f1@huawei.com>
 <20200303093321.262ff477@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <f9841459-ebd7-c296-f085-1a204424d636@huawei.com>
Date: Tue, 3 Mar 2020 19:37:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200303093321.262ff477@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
Cc: wanghaibin.wang@huawei.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/3/3 16:33, Igor Mammedov wrote:
> On Tue, 3 Mar 2020 11:18:56 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> One comment from myself after going through the code...
>>
>> On 2020/3/3 9:01, Heyi Guo wrote:
>>> Common VM users sometimes care about CPU speed, so we add two new
>>> options to allow VM vendors to present CPU speed to their users.
>>> Normally these information can be fetched from host smbios.
>>>
>>> Strictly speaking, the "max speed" and "current speed" in type 4
>>> are not really for the max speed and current speed of processor, for
>>> "max speed" identifies a capability of the system, and "current speed=
"
>>> identifies the processor's speed at boot (see smbios spec), but some
>>> applications do not tell the differences.
>>>
>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>>>
>>> ---
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>
>>> v2 -> v3:
>>> - Refine comments per Igor's suggestion.
>>>
>>> v1 -> v2:
>>> - change "_" in option names to "-"
>>> - check if option value is too large to fit in SMBIOS type 4 speed
>>> fields.
>>> ---
>>>    hw/smbios/smbios.c | 29 ++++++++++++++++++++++++++---
>>>    qemu-options.hx    |  3 ++-
>>>    2 files changed, 28 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>>> index ffd98727ee..4c5992241c 100644
>>> --- a/hw/smbios/smbios.c
>>> +++ b/hw/smbios/smbios.c
>>> @@ -94,6 +94,8 @@ static struct {
>>>   =20
>>>    static struct {
>>>        const char *sock_pfx, *manufacturer, *version, *serial, *asset=
, *part;
>>> +    uint32_t max_speed;
>>> +    uint32_t current_speed;
>> How about defining these two fields as uint16_t, just like "speed" in
>> type17? Then we can also drop the range check against UIN16_MAX.
> Well,
> someone should check if values provided by user make sense anyway
> so check should be there but in some other form.

Shall we define the temporal variables as uint64_t, and check the values=20
no larger than UINT16_MAX after invoking qemu_opt_get_number()? So any=20
value larger than uint64_max will be blocked by qemu option parser, and=20
value in (uint16_max, uint64_max] will be blocked by ourselves.

Thanks,

Heyi


>
>> Please advise.
>>
>> Thanks,
>>
>> Heyi
>>
>>
>>>    } type4;
>>>   =20
>>>    static struct {
>>> @@ -272,6 +274,14 @@ static const QemuOptDesc qemu_smbios_type4_opts[=
] =3D {
>>>            .name =3D "version",
>>>            .type =3D QEMU_OPT_STRING,
>>>            .help =3D "version number",
>>> +    },{
>>> +        .name =3D "max-speed",
>>> +        .type =3D QEMU_OPT_NUMBER,
>>> +        .help =3D "max speed in MHz",
>>> +    },{
>>> +        .name =3D "current-speed",
>>> +        .type =3D QEMU_OPT_NUMBER,
>>> +        .help =3D "speed at system boot in MHz",
>>>        },{
>>>            .name =3D "serial",
>>>            .type =3D QEMU_OPT_STRING,
>>> @@ -586,9 +596,8 @@ static void smbios_build_type_4_table(MachineStat=
e *ms, unsigned instance)
>>>        SMBIOS_TABLE_SET_STR(4, processor_version_str, type4.version);
>>>        t->voltage =3D 0;
>>>        t->external_clock =3D cpu_to_le16(0); /* Unknown */
>>> -    /* SVVP requires max_speed and current_speed to not be unknown. =
*/
>>> -    t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz */
>>> -    t->current_speed =3D cpu_to_le16(2000); /* 2000 MHz */
>>> +    t->max_speed =3D cpu_to_le16(type4.max_speed);
>>> +    t->current_speed =3D cpu_to_le16(type4.current_speed);
>>>        t->status =3D 0x41; /* Socket populated, CPU enabled */
>>>        t->processor_upgrade =3D 0x01; /* Other */
>>>        t->l1_cache_handle =3D cpu_to_le16(0xFFFF); /* N/A */
>>> @@ -1129,6 +1138,20 @@ void smbios_entry_add(QemuOpts *opts, Error **=
errp)
>>>                save_opt(&type4.serial, opts, "serial");
>>>                save_opt(&type4.asset, opts, "asset");
>>>                save_opt(&type4.part, opts, "part");
>>> +            /*
>>> +             * SVVP requires max_speed and current_speed to be set a=
nd not being
>>> +             * 0 which counts as unknown (SMBIOS 3.1.0/Table 21). Se=
t the
>>> +             * default value to 2000MHz as we did before.
>>> +             */
>>> +            type4.max_speed =3D qemu_opt_get_number(opts, "max-speed=
", 2000);
>>> +            type4.current_speed =3D qemu_opt_get_number(opts, "curre=
nt-speed",
>>> +                                                      2000);
>>> +            if (type4.max_speed > UINT16_MAX ||
>>> +                type4.current_speed > UINT16_MAX) {
>>> +                error_setg(errp, "SMBIOS CPU speed is too large (> %=
d)",
>>> +                           UINT16_MAX);
>>> +            }
>>> +
>>>                return;
>>>            case 11:
>>>                qemu_opts_validate(opts, qemu_smbios_type11_opts, &err=
);
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index ac315c1ac4..7a2f7c1f66 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>>>        "                specify SMBIOS type 3 fields\n"
>>>        "-smbios type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,versi=
on=3Dstr][,serial=3Dstr]\n"
>>>        "              [,asset=3Dstr][,part=3Dstr]\n"
>>> +    "              [,max-speed=3D%d][,current-speed=3D%d]\n"
>>>        "                specify SMBIOS type 4 fields\n"
>>>        "-smbios type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3D=
str][,serial=3Dstr]\n"
>>>        "               [,asset=3Dstr][,part=3Dstr][,speed=3D%d]\n"
>>> @@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
>>>    @item -smbios type=3D3[,manufacturer=3D@var{str}][,version=3D@var{=
str}][,serial=3D@var{str}][,asset=3D@var{str}][,sku=3D@var{str}]
>>>    Specify SMBIOS type 3 fields
>>>   =20
>>> -@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{s=
tr}][,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=
=3D@var{str}]
>>> +@item -smbios type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{s=
tr}][,version=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=
=3D@var{str}][,max-speed=3D@var{%d}][,current-speed=3D@var{%d}]
>>>    Specify SMBIOS type 4 fields
>>>   =20
>>>    @item -smbios type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,=
manufacturer=3D@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D=
@var{str}][,speed=3D@var{%d}]
>
> .


