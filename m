Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60436C2BA83
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:15:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3213220857
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 18:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3213220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3ORq-000231-EX
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 13:15:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1j3OR1-0001T8-Nn
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1j3OR0-00030o-JC
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 13:14:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1j3OQy-0002st-3J; Sun, 16 Feb 2020 13:14:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01GI9C8x113130; Sun, 16 Feb 2020 13:14:18 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dkvt1g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 13:14:18 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01GIDF8t130981;
 Sun, 16 Feb 2020 13:14:18 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dkvt1ea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 13:14:17 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01GIABhB026178;
 Sun, 16 Feb 2020 18:14:11 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 2y689672u0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 16 Feb 2020 18:14:11 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01GIEA7T54460688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 16 Feb 2020 18:14:10 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CD99AE060;
 Sun, 16 Feb 2020 18:14:10 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FB0CAE05C;
 Sun, 16 Feb 2020 18:14:10 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Sun, 16 Feb 2020 18:14:10 +0000 (GMT)
Subject: Re: [RFC v2 1/6] tpm: rename TPM_TIS into TPM_TIS_ISA
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200214183704.14389-1-eric.auger@redhat.com>
 <20200214183704.14389-2-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <09c4557c-7f75-847a-ae49-7146778e9c4b@linux.ibm.com>
Date: Sun, 16 Feb 2020 13:14:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200214183704.14389-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-16_04:2020-02-14,
 2020-02-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002160165
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/14/20 1:36 PM, Eric Auger wrote:
> As we plan to introduce a sysbus TPM_TIS, let's rename
> TPM_TIS into TPM_TIS_ISA.
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/acpi-build.c | 6 +++---
>   hw/tpm/tpm_tis.c     | 4 ++--
>   include/sysemu/tpm.h | 6 +++---
>   3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 9c4e46fa74..26777f8828 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2026,7 +2026,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           }
>       }
>   
> -    if (TPM_IS_TIS(tpm_find())) {
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
>           aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
>                      TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
>       }
> @@ -2197,7 +2197,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               /* Scan all PCI buses. Generate tables to support hotplug. */
>               build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>   
> -            if (TPM_IS_TIS(tpm)) {
> +            if (TPM_IS_TIS_ISA(tpm)) {
>                   if (misc->tpm_version == TPM_VERSION_2_0) {
>                       dev = aml_device("TPM");
>                       aml_append(dev, aml_name_decl("_HID",
> @@ -2304,7 +2304,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>           (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>   
>       tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> -    if (TPM_IS_TIS(tpm_find())) {
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
>           tpm2_ptr->control_area_address = cpu_to_le64(0);
>           tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
>       } else if (TPM_IS_CRB(tpm_find())) {
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 31facb896d..c609737272 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -91,7 +91,7 @@ typedef struct TPMState {
>       TPMPPI ppi;
>   } TPMState;
>   
> -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> +#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS_ISA)
>   
>   #define DEBUG_TIS 0
>   
> @@ -1008,7 +1008,7 @@ static void tpm_tis_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo tpm_tis_info = {
> -    .name = TYPE_TPM_TIS,
> +    .name = TYPE_TPM_TIS_ISA,
>       .parent = TYPE_ISA_DEVICE,
>       .instance_size = sizeof(TPMState),
>       .instance_init = tpm_tis_initfn,
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 15979a3647..1691b92c28 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -43,12 +43,12 @@ typedef struct TPMIfClass {
>       enum TPMVersion (*get_version)(TPMIf *obj);
>   } TPMIfClass;
>   
> -#define TYPE_TPM_TIS                "tpm-tis"
> +#define TYPE_TPM_TIS_ISA            "tpm-tis"
>   #define TYPE_TPM_CRB                "tpm-crb"
>   #define TYPE_TPM_SPAPR              "tpm-spapr"
>   
> -#define TPM_IS_TIS(chr)                             \
> -    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
> +#define TPM_IS_TIS_ISA(chr)                         \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
>   #define TPM_IS_CRB(chr)                             \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>   #define TPM_IS_SPAPR(chr)                           \



