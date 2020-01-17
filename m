Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1364C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2246C2073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 10:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2246C2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isPBj-0004oL-VG
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 05:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gengdongjiu@huawei.com>) id 1isPAr-000477-Fc
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:48:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gengdongjiu@huawei.com>) id 1isPAq-0007Kv-1s
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 05:48:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2684 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
 id 1isPAk-0007Ek-DF; Fri, 17 Jan 2020 05:48:14 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 01F3682DCE72C510EE0B;
 Fri, 17 Jan 2020 18:48:07 +0800 (CST)
Received: from [127.0.0.1] (10.142.68.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 18:47:56 +0800
Subject: Re: [PATCH v22 5/9] ACPI: Record the Generic Error Status Block
 address
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>, <fam@euphon.net>,
 <rth@twiddle.net>, <ehabkost@redhat.com>, <mtosatti@redhat.com>,
 <xuwei5@huawei.com>, <jonathan.cameron@huawei.com>, <james.morse@arm.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, <qemu-arm@nongnu.org>
References: <1578483143-14905-1-git-send-email-gengdongjiu@huawei.com>
 <1578483143-14905-6-git-send-email-gengdongjiu@huawei.com>
 <11c62b51-7a94-5e34-39c6-60c5e989a63b@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <de0dbaaa-01aa-aba7-df9a-ddfb9a2164b0@huawei.com>
Date: Fri, 17 Jan 2020 18:47:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <11c62b51-7a94-5e34-39c6-60c5e989a63b@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
X-Originating-IP: [10.142.68.147]
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
Cc: zhengxiang9@huawei.com, linuxarm@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/1/17 15:39, Philippe Mathieu-Daud=E9 wrote:
>> =A0 =A0=A0=A0=A0=A0 table_offsets =3D g_array_new(false, true /* clear=
 */,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(uint32_t));
>> @@ -831,7 +832,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBu=
ildTables *tables)
>> =A0=A0=A0=A0=A0 acpi_add_table(table_offsets, tables_blob);
>> =A0=A0=A0=A0=A0 build_spcr(tables_blob, tables->linker, vms);
>> =A0 -=A0=A0=A0 if (vms->ras) {
>> +=A0=A0=A0 acpi_ged_state =3D ACPI_GED(object_resolve_path_type("", TY=
PE_ACPI_GED,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 NULL));
>=20
> Testing vms->ras first is cheaper than calling object_resolve_path_type=
(). Since some people are spending lot of time to reduce VM boot time, it=
 might be worth considering.
Thanks Philippe's comments.

Do you think it should be written to below[1]? right?

[1]:
if (vms->ras && acpi_ged_state)


>=20
>> +=A0=A0=A0 if (acpi_ged_state &&=A0 vms->ras) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 acpi_add_table(table_offsets, tables_blob)=
;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 build_ghes_error_table(tables->hardware_er=
rors, tables->linker);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 acpi_build_hest(tables_blob, tables->hardw=
are_errors,
>> @@ -925,6 +928,7 @@ void virt_acpi_setup(VirtMachineState *vms)
>> =A0 {=20


