Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F95C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9C7206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9C7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0GL-0004Tm-E2
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jW0F6-0003Yo-1X; Tue, 05 May 2020 12:16:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59602)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jW0F4-0004Dl-Rj; Tue, 05 May 2020 12:16:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 045G7Vuh153284; Tue, 5 May 2020 12:16:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8jyg0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 12:16:17 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045G7XJq153319;
 Tue, 5 May 2020 12:16:16 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8jyfyq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 12:16:15 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045GFXk1002998;
 Tue, 5 May 2020 16:16:13 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma03dal.us.ibm.com with ESMTP id 30s0g78m15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 16:16:13 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 045GGDA351380494
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2020 16:16:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5579AE067;
 Tue,  5 May 2020 16:16:12 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DE62AE05C;
 Tue,  5 May 2020 16:16:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2020 16:16:12 +0000 (GMT)
Subject: Re: [PATCH v2 2/3] arm/acpi: TPM2 ACPI table support
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-3-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <51386527-f887-603b-048d-5ad1dff0cb35@linux.ibm.com>
Date: Tue, 5 May 2020 12:16:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200505144419.29174-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-05_09:2020-05-04,
 2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005050124
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 12:16:19
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, gshan@redhat.com,
 lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 10:44 AM, Eric Auger wrote:
> Add a TPM2 ACPI table if a TPM2.0 sysbus device has been
> dynamically instantiated.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


>
> ---
>
> v1 -> v2:
> - reuse generic build_tpm2() and alloc log area externally
> - call tpm_find() once in build_tpm2()
> ---
>   include/sysemu/tpm.h     |  2 ++
>   hw/acpi/aml-build.c      |  5 +++--
>   hw/arm/virt-acpi-build.c | 11 +++++++++++
>   3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index f37851b1aa..03fb25941c 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -50,6 +50,8 @@ typedef struct TPMIfClass {
>   
>   #define TPM_IS_TIS_ISA(chr)                         \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_ISA)
> +#define TPM_IS_TIS_SYSBUS(chr)                      \
> +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS_SYSBUS)
>   #define TPM_IS_CRB(chr)                             \
>       object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>   #define TPM_IS_SPAPR(chr)                           \
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1f7fd09112..4224675cb2 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1882,12 +1882,13 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>       unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>       unsigned log_addr_offset =
>           (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> +    TPMIf *tpmif = tpm_find();
>   
>       tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> -    if (TPM_IS_TIS_ISA(tpm_find())) {
> +    if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
>           tpm2_ptr->control_area_address = cpu_to_le64(0);
>           tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> -    } else if (TPM_IS_CRB(tpm_find())) {
> +    } else if (TPM_IS_CRB(tpmif)) {
>           tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
>           tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
>       } else {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 81d41a3990..1a2ec10c8f 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -41,11 +41,13 @@
>   #include "hw/acpi/pci.h"
>   #include "hw/acpi/memory_hotplug.h"
>   #include "hw/acpi/generic_event_device.h"
> +#include "hw/acpi/tpm.h"
>   #include "hw/pci/pcie_host.h"
>   #include "hw/pci/pci.h"
>   #include "hw/arm/virt.h"
>   #include "sysemu/numa.h"
>   #include "sysemu/reset.h"
> +#include "sysemu/tpm.h"
>   #include "kvm_arm.h"
>   #include "migration/vmstate.h"
>   
> @@ -831,6 +833,15 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>           build_iort(tables_blob, tables->linker, vms);
>       }
>   
> +    if (tpm_get_version(tpm_find()) == TPM_VERSION_2_0) {
> +        acpi_data_push(tables->tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> +        bios_linker_loader_alloc(tables->linker, ACPI_BUILD_TPMLOG_FILE,
> +                                 tables->tcpalog, 1, false);
> +
> +        acpi_add_table(table_offsets, tables_blob);
> +        build_tpm2(tables_blob, tables->linker, tables->tcpalog);
> +    }
> +
>       /* XSDT is pointed to by RSDP */
>       xsdt = tables_blob->len;
>       build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);



