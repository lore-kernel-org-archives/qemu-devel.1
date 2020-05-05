Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268E5C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB2F206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 16:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB2F206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jW0Ht-0005sg-1x
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 12:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jW0Gl-00051P-Mi; Tue, 05 May 2020 12:18:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59598
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jW0Gi-0007LW-Ev; Tue, 05 May 2020 12:18:06 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 045Facig168306; Tue, 5 May 2020 12:18:01 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30s50gsvgq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 12:18:01 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 045FvkuG028334;
 Tue, 5 May 2020 12:18:00 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 30s50gsvga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 12:18:00 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 045GG38H020500;
 Tue, 5 May 2020 16:17:59 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma03dal.us.ibm.com with ESMTP id 30s0g78mj1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2020 16:17:59 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 045GHxPj52953446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2020 16:17:59 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ED26EAE05C;
 Tue,  5 May 2020 16:17:58 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0E1FAE063;
 Tue,  5 May 2020 16:17:58 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2020 16:17:58 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] acpi: Move build_tpm2() in the generic part
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, shannon.zhaosl@gmail.com, mst@redhat.com
References: <20200505144419.29174-1-eric.auger@redhat.com>
 <20200505144419.29174-2-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8ba036ba-950f-55c2-450b-4106cab3e683@linux.ibm.com>
Date: Tue, 5 May 2020 12:17:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200505144419.29174-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-05_08:2020-05-04,
 2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050124
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 12:16:19
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
> We plan to build the tpm2 table on ARM too. In order to reuse the
> generation code, let's move build_tpm2() to aml-build.c.
>
> No change in the implementation.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   include/hw/acpi/aml-build.h |  2 ++
>   hw/acpi/aml-build.c         | 30 ++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c        | 30 ------------------------------
>   3 files changed, 32 insertions(+), 30 deletions(-)
>
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 0f4ed53d7f..a67ab4618a 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -437,4 +437,6 @@ void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms);
>   
>   void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                   const char *oem_id, const char *oem_table_id);
> +
> +void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog);
>   #endif
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 2c3702b882..1f7fd09112 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -26,6 +26,7 @@
>   #include "qemu/bitops.h"
>   #include "sysemu/numa.h"
>   #include "hw/boards.h"
> +#include "hw/acpi/tpm.h"
>   
>   static GArray *build_alloc_array(void)
>   {
> @@ -1875,6 +1876,35 @@ build_hdr:
>                    "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
>   }
>   
> +void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> +{
> +    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
> +    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
> +    unsigned log_addr_offset =
> +        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> +
> +    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
> +        tpm2_ptr->control_area_address = cpu_to_le64(0);
> +        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> +    } else if (TPM_IS_CRB(tpm_find())) {
> +        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
> +        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
> +    } else {
> +        g_warn_if_reached();
> +    }
> +
> +    tpm2_ptr->log_area_minimum_length =
> +        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +
> +    /* log area start address to be filled by Guest linker */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +                                   log_addr_offset, log_addr_size,
> +                                   ACPI_BUILD_TPMLOG_FILE, 0);
> +    build_header(linker, table_data,
> +                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
> +}
> +
>   /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
>   static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags,
>                                     uint16_t type_flags,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 23c77eeb95..c7c560e269 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2296,36 +2296,6 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>                    (void *)tcpa, "TCPA", sizeof(*tcpa), 2, NULL, NULL);
>   }
>   
> -static void
> -build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> -{
> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
> -    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
> -    unsigned log_addr_offset =
> -        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> -
> -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> -    if (TPM_IS_TIS_ISA(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> -    } else if (TPM_IS_CRB(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
> -    } else {
> -        g_warn_if_reached();
> -    }
> -
> -    tpm2_ptr->log_area_minimum_length =
> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> -
> -    /* log area start address to be filled by Guest linker */
> -    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -                                   log_addr_offset, log_addr_size,
> -                                   ACPI_BUILD_TPMLOG_FILE, 0);
> -    build_header(linker, table_data,
> -                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
> -}
> -
>   #define HOLE_640K_START  (640 * KiB)
>   #define HOLE_640K_END   (1 * MiB)
>   



