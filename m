Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEAEC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 00:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 690C4246AF
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 00:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690C4246AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7pqF-00039U-Au
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 19:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1j7ppY-0002k6-LN
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:18:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1j7ppX-0000Le-6p
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:18:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3253 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1j7ppW-0000HF-L1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 19:18:07 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 54F9F95EDB6C40CDFD78;
 Sat, 29 Feb 2020 08:17:56 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0;
 Sat, 29 Feb 2020 08:17:48 +0800
Subject: Re: [PATCH] hw/smbios: add options for type 4 max_speed and
 current_speed
To: Igor Mammedov <imammedo@redhat.com>
References: <20200225075046.30151-1-guoheyi@huawei.com>
 <4bd58f6e-e522-d920-bc9a-8198147e8856@redhat.com>
 <6e6c6c8b-c67c-6433-2bb8-d246c5f49b62@huawei.com>
 <20200228103950.6fd7ecb5@redhat.com>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <6ee4aed5-211a-e290-9252-f02420e19f34@huawei.com>
Date: Sat, 29 Feb 2020 08:17:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200228103950.6fd7ecb5@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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

Hi Igor,

On 2020/2/28 17:39, Igor Mammedov wrote:
> On Thu, 27 Feb 2020 17:12:21 +0800
> Heyi Guo <guoheyi@huawei.com> wrote:
>
>> On 2020/2/25 17:24, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 2/25/20 8:50 AM, Heyi Guo wrote:
>>>> Common VM users sometimes care about CPU speed, so we add two new
>>>> options to allow VM vendors to present CPU speed to their users.
>>>> Normally these information can be fetched from host smbios.
>>>>
>>>> Strictly speaking, the "max speed" and "current speed" in type 4
>>>> are not really for the max speed and current speed of processor, for
>>>> "max speed" identifies a capability of the system, and "current spee=
d"
>>>> identifies the processor's speed at boot (see smbios spec), but some
>>>> applications do not tell the differences.
>>>>
>>>> Signed-off-by: Heyi Guo <guoheyi@huawei.com>
>>>>
>>>> ---
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>>  =C2=A0 hw/smbios/smbios.c | 22 +++++++++++++++++++---
>>>>  =C2=A0 qemu-options.hx=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>>>>  =C2=A0 2 files changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
>>>> index ffd98727ee..1d5439643d 100644
>>>> --- a/hw/smbios/smbios.c
>>>> +++ b/hw/smbios/smbios.c
>>>> @@ -94,6 +94,8 @@ static struct {
>>>>  =C2=A0 =C2=A0 static struct {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *sock_pfx, *manufacturer,=
 *version, *serial, *asset,
>>>> *part;
>>>> +=C2=A0=C2=A0=C2=A0 uint32_t max_speed;
>>>> +=C2=A0=C2=A0=C2=A0 uint32_t current_speed;
>>>>  =C2=A0 } type4;
>>>>  =C2=A0 =C2=A0 static struct {
>>>> @@ -272,6 +274,14 @@ static const QemuOptDesc
>>>> qemu_smbios_type4_opts[] =3D {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "v=
ersion",
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QE=
MU_OPT_STRING,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "v=
ersion number",
>>>> +=C2=A0=C2=A0=C2=A0 },{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "max_speed",
> I'd suggest to use - instead of _ in option name

Thanks for your comments. However I can see other options like=20
"sock_pfx" and "loc_pfx" also use "_" in option names. Should we keep=20
consistent with the context?

Thanks,

Heyi


>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QEMU_OPT_NUMBE=
R,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "max speed in =
MHz",
>>>> +=C2=A0=C2=A0=C2=A0 },{
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "current_speed=
",
> ditto
>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QEMU_OPT_NUMBE=
R,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .help =3D "speed at syst=
em boot in MHz",
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },{
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "s=
erial",
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D QE=
MU_OPT_STRING,
>>>> @@ -586,9 +596,8 @@ static void
>>>> smbios_build_type_4_table(MachineState *ms, unsigned instance)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SMBIOS_TABLE_SET_STR(4, processor_ve=
rsion_str, type4.version);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->voltage =3D 0;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->external_clock =3D cpu_to_le16(0)=
; /* Unknown */
>>>> -=C2=A0=C2=A0=C2=A0 /* SVVP requires max_speed and current_speed to =
not be unknown. */
>>>> -=C2=A0=C2=A0=C2=A0 t->max_speed =3D cpu_to_le16(2000); /* 2000 MHz =
*/
>>>> -=C2=A0=C2=A0=C2=A0 t->current_speed =3D cpu_to_le16(2000); /* 2000 =
MHz */
>>>> +=C2=A0=C2=A0=C2=A0 t->max_speed =3D cpu_to_le16(type4.max_speed);
>>>> +=C2=A0=C2=A0=C2=A0 t->current_speed =3D cpu_to_le16(type4.current_s=
peed);
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->status =3D 0x41; /* Socket popula=
ted, CPU enabled */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->processor_upgrade =3D 0x01; /* Ot=
her */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t->l1_cache_handle =3D cpu_to_le16(0=
xFFFF); /* N/A */
>>>> @@ -1129,6 +1138,13 @@ void smbios_entry_add(QemuOpts *opts, Error
>>>> **errp)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 save_opt(&type4.serial, opts, "serial");
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 save_opt(&type4.asset, opts, "asset");
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 save_opt(&type4.part, opts, "part");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * SVVP requires max_speed and current_speed to not be
>>>> unknown, and
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * we set the default value to 2000MHz as we did before.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
type4.max_speed =3D qemu_opt_get_number(opts, "max_speed",
>>>> 2000);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
type4.current_speed =3D qemu_opt_get_number(opts,
>>>> "current_speed",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2000);
>>> Maybe check speeds are <=3D UINT16_MAX else set errp?
>> OK; I can do that in the v2. But I would wait for the maintainers to
>> provide more comments :)
>>
>> Thanks,
>>
>> Heyi
>>
>>>  =20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 11:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qemu_opts_validate(opts, qemu_smbios_type11_opts, &err);
>>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>>> index ac315c1ac4..bc9ef0fda8 100644
>>>> --- a/qemu-options.hx
>>>> +++ b/qemu-options.hx
>>>> @@ -2233,6 +2233,7 @@ DEF("smbios", HAS_ARG, QEMU_OPTION_smbios,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specify SMBIOS typ=
e 3 fields\n"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-smbios
>>>> type=3D4[,sock_pfx=3Dstr][,manufacturer=3Dstr][,version=3Dstr][,seri=
al=3Dstr]\n"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [,asset=3Dstr][,part=3Dstr]\n"
>>>> +=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [,max_speed=3D%d][,current_speed=3D%d]\n"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 specify SMBIOS typ=
e 4 fields\n"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-smbios
>>>> type=3D17[,loc_pfx=3Dstr][,bank=3Dstr][,manufacturer=3Dstr][,serial=3D=
str]\n"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [,asset=3Dstr][,part=3Ds=
tr][,speed=3D%d]\n"
>>>> @@ -2255,7 +2256,7 @@ Specify SMBIOS type 2 fields
>>>>  =C2=A0 @item -smbios
>>>> type=3D3[,manufacturer=3D@var{str}][,version=3D@var{str}][,serial=3D=
@var{str}][,asset=3D@var{str}][,sku=3D@var{str}]
>>>>  =C2=A0 Specify SMBIOS type 3 fields
>>>>  =C2=A0 -@item -smbios
>>>> type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,version=3D=
@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}]
>>>> +@item -smbios
>>>> type=3D4[,sock_pfx=3D@var{str}][,manufacturer=3D@var{str}][,version=3D=
@var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}][,m=
ax_speed=3D@var{%d}][,current_speed=3D@var{%d}]
>>>>  =C2=A0 Specify SMBIOS type 4 fields
>>>>  =C2=A0 =C2=A0 @item -smbios
>>>> type=3D17[,loc_pfx=3D@var{str}][,bank=3D@var{str}][,manufacturer=3D@=
var{str}][,serial=3D@var{str}][,asset=3D@var{str}][,part=3D@var{str}][,sp=
eed=3D@var{%d}]
>>>>  =20
>>>
>>> .
>
> .


