Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D77CC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4861221927
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 10:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axzbp470"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4861221927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6XHV-0002m6-BL
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 05:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j6XGH-00029J-P0
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j6XGG-0001gL-H1
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:16:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j6XGG-0001g3-Co
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 05:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582625780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8C6VrUguRMvheJSefNuRDddaoqJve1CMALV2OfJicM8=;
 b=axzbp470nktt1UZ70Hi3kUKK4DbS3CCwcNNoq7PsYvDd29t9/TwWyy78TTo7jZITIkS1+Z
 b3C78TdbkyY94vf47kbxpQwjeYTkmBVk+ysasgWQauXvzGGEV6WDv5Vz3QyXR0AFjnXEix
 Lpwbu+XWX9pl6gdOOes9ANyb3gzuok8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-_aAz08fzPKyS6lrBhPaySA-1; Tue, 25 Feb 2020 05:16:18 -0500
X-MC-Unique: _aAz08fzPKyS6lrBhPaySA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41D7818AB2CB;
 Tue, 25 Feb 2020 10:16:17 +0000 (UTC)
Received: from [10.36.116.59] (ovpn-116-59.ams2.redhat.com [10.36.116.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AB8D19C58;
 Tue, 25 Feb 2020 10:16:10 +0000 (UTC)
Subject: Re: [RFC v2 1/6] tpm: rename TPM_TIS into TPM_TIS_ISA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, stefanb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-2-eric.auger@redhat.com>
 <29cc9864-a016-b251-506a-8c04b37efe28@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <4dd1b4b0-7112-5a8a-9033-9c21eb01b8f9@redhat.com>
Date: Tue, 25 Feb 2020 11:16:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <29cc9864-a016-b251-506a-8c04b37efe28@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Phil,

On 2/14/20 7:55 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/14/20 7:36 PM, Eric Auger wrote:
>> As we plan to introduce a sysbus TPM_TIS, let's rename
>> TPM_TIS into TPM_TIS_ISA.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>> =C2=A0 hw/i386/acpi-build.c | 6 +++---
>> =C2=A0 hw/tpm/tpm_tis.c=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
>> =C2=A0 include/sysemu/tpm.h | 6 +++---
>> =C2=A0 3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 9c4e46fa74..26777f8828 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2026,7 +2026,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (TPM_IS_TIS(tpm_find())) {
>> +=C2=A0=C2=A0=C2=A0 if (TPM_IS_TIS_ISA(tpm_find())) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(crs, a=
ml_memory32_fixed(TPM_TIS_ADDR_BASE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_TIS_ADDR_SIZE, AML_REA=
D_WRITE));
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -2197,7 +2197,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Scan all PCI buses. Generate tables to support
>> hotplug. */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 build_append_pci_bus_devices(scope, bus,
>> pm->pcihp_bridge_en);
>> =C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 if (TPM_IS_TIS(tpm)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
TPM_IS_TIS_ISA(tpm)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (misc->tpm_version =3D=3D TPM_VERSION_2_0=
) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D aml_device("=
TPM");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_=
name_decl("_HID",
>> @@ -2304,7 +2304,7 @@ build_tpm2(GArray *table_data, BIOSLinker
>> *linker, GArray *tcpalog)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (char *)&tpm2_ptr=
->log_area_start_address - table_data->data;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->platform_class =3D cpu_t=
o_le16(TPM2_ACPI_CLASS_CLIENT);
>> -=C2=A0=C2=A0=C2=A0 if (TPM_IS_TIS(tpm_find())) {
>> +=C2=A0=C2=A0=C2=A0 if (TPM_IS_TIS_ISA(tpm_find())) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->control=
_area_address =3D cpu_to_le64(0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->start_m=
ethod =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (TPM_IS_CRB(tpm_find())) {
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 31facb896d..c609737272 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -91,7 +91,7 @@ typedef struct TPMState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPMPPI ppi;
>> =C2=A0 } TPMState;
>> =C2=A0 -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
>> +#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS_ISA)
>> =C2=A0 =C2=A0 #define DEBUG_TIS 0
>> =C2=A0 @@ -1008,7 +1008,7 @@ static void tpm_tis_class_init(ObjectClass
>> *klass, void *data)
>> =C2=A0 }
>> =C2=A0 =C2=A0 static const TypeInfo tpm_tis_info =3D {
>> -=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TPM_TIS,
>> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TPM_TIS_ISA,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_ISA_DEVICE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(TPMState),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_init =3D tpm_tis_initfn,
>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>> index 15979a3647..1691b92c28 100644
>> --- a/include/sysemu/tpm.h
>> +++ b/include/sysemu/tpm.h
>> @@ -43,12 +43,12 @@ typedef struct TPMIfClass {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum TPMVersion (*get_version)(TPMIf *obj=
);
>> =C2=A0 } TPMIfClass;
>> =C2=A0 -#define TYPE_TPM_TIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-tis"
>> +#define TYPE_TPM_TIS_ISA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "tpm-tis"
>=20
> It should be safe to rename this "tpm-tis-isa" in this patch.
This would change the name of the legacy ISA device and also the way we
instantiate it through the cmd line. To avoid breaking the compatibility
I kept the same name and used tpm-tis-device (?) for the new sysbus one.

Thanks

Eric
>=20
> Regardless:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
>> =C2=A0 #define TYPE_TPM_CRB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-crb"
>> =C2=A0 #define TYPE_TPM_SPAPR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-spapr"
>> =C2=A0 -#define TPM_IS_TIS(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> -=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
>> +#define TPM_IS_TIS_ISA(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
>> =C2=A0 #define TPM_IS_CRB(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM=
_CRB)
>> =C2=A0 #define TPM_IS_SPAPR(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>
>=20


