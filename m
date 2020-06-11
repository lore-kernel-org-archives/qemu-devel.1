Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A18FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAEE2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:25:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAEE2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjP5F-0001S0-Jj
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjOuN-0006KA-M4; Thu, 11 Jun 2020 11:14:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjOuL-0003if-PQ; Thu, 11 Jun 2020 11:14:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05BF41jN149616; Thu, 11 Jun 2020 11:14:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31kdn6spaf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 11:14:17 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BF4Ewc150462;
 Thu, 11 Jun 2020 11:14:16 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31kdn6sp9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 11:14:16 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BFAt3O006648;
 Thu, 11 Jun 2020 15:14:15 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma02wdc.us.ibm.com with ESMTP id 31g2s8w2j4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 15:14:15 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05BFEE6v49807814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 15:14:15 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF35B112061;
 Thu, 11 Jun 2020 15:14:14 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC52E112066;
 Thu, 11 Jun 2020 15:14:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2020 15:14:14 +0000 (GMT)
Subject: Re: [PATCH v4 2/5] acpi: Move build_tpm2() in the generic part
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200611135917.18300-1-eric.auger@redhat.com>
 <20200611135917.18300-3-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <0c34a3c3-a5b0-15a1-e8e9-418d611a26f3@linux.ibm.com>
Date: Thu, 11 Jun 2020 11:14:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200611135917.18300-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_15:2020-06-11,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110115
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 10:26:43
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 9:59 AM, Eric Auger wrote:
> We plan to build the TPM2 table on ARM too. In order to reuse the
> generation code, let's move build_tpm2() to aml-build.c.
>
> No change in the implementation.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   include/hw/acpi/aml-build.h |  2 ++
>   hw/acpi/aml-build.c         | 51 +++++++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c        | 51 -------------------------------------
>   3 files changed, 53 insertions(+), 51 deletions(-)
>
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index ed7c89309e..d27da03d64 100644
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
> index 3681ec6e3d..2a1d9fc839 100644
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
> @@ -1877,6 +1878,56 @@ build_hdr:
>                    "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
>   }
>   
> +void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> +{
> +    uint8_t start_method_params[12] = {};
> +    unsigned log_addr_offset, tpm2_start;
> +    uint64_t control_area_start_address;
> +    uint32_t start_method;
> +    void *tpm2_ptr;
> +
> +    tpm2_start = table_data->len;
> +    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    /* Platform Class */
> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
> +    if (TPM_IS_TIS_ISA(tpm_find())) {
> +        control_area_start_address = 0;
> +        start_method = TPM2_START_METHOD_MMIO;
> +    } else if (TPM_IS_CRB(tpm_find())) {
> +        control_area_start_address = TPM_CRB_ADDR_CTRL;
> +        start_method = TPM2_START_METHOD_CRB;
> +    } else {
> +        g_assert_not_reached();
> +    }
> +    /* Address of Control Area */
> +    build_append_int_noprefix(table_data, control_area_start_address, 8);
> +    /* Start Method */
> +    build_append_int_noprefix(table_data, start_method, 4);
> +
> +    /* Platform Specific Parameters */
> +    g_array_append_vals(table_data, &start_method_params,
> +                        ARRAY_SIZE(start_method_params));
> +
> +    /* Log Area Minimum Length */
> +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
> +
> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> +    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
> +                             false);
> +
> +    log_addr_offset = table_data->len;
> +    build_append_int_noprefix(table_data, 0, 8);
> +    /* Log Area Start Address to be filled by Guest linker */
> +    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> +                                   log_addr_offset, 8,
> +                                   ACPI_BUILD_TPMLOG_FILE, 0);
> +    build_header(linker, table_data,
> +                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
> +}
> +
>   /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
>   static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags,
>                                     uint16_t type_flags,
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f150d95ecc..b7c7583b5f 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2295,57 +2295,6 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>                    (void *)tcpa, "TCPA", sizeof(*tcpa), 2, NULL, NULL);
>   }
>   
> -static void
> -build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> -{
> -    uint8_t start_method_params[12] = {};
> -    unsigned log_addr_offset, tpm2_start;
> -    uint64_t control_area_start_address;
> -    uint32_t start_method;
> -    void *tpm2_ptr;
> -
> -    tpm2_start = table_data->len;
> -    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> -
> -    /* Platform Class */
> -    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> -    /* Reserved */
> -    build_append_int_noprefix(table_data, 0, 2);
> -    if (TPM_IS_TIS_ISA(tpm_find())) {
> -        control_area_start_address = 0;
> -        start_method = TPM2_START_METHOD_MMIO;
> -    } else if (TPM_IS_CRB(tpm_find())) {
> -        control_area_start_address = TPM_CRB_ADDR_CTRL;
> -        start_method = TPM2_START_METHOD_CRB;
> -    } else {
> -        g_assert_not_reached();
> -    }
> -    /* Address of Control Area */
> -    build_append_int_noprefix(table_data, control_area_start_address, 8);
> -    /* Start Method */
> -    build_append_int_noprefix(table_data, start_method, 4);
> -
> -    /* Platform Specific Parameters */
> -    g_array_append_vals(table_data, &start_method_params,
> -                        ARRAY_SIZE(start_method_params));
> -
> -    /* Log Area Minimum Length */
> -    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
> -
> -    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> -    bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
> -                             false);
> -
> -    log_addr_offset = table_data->len;
> -    build_append_int_noprefix(table_data, 0, 8);
> -    /* Log Area Start Address to be filled by Guest linker */
> -    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -                                   log_addr_offset, 8,
> -                                   ACPI_BUILD_TPMLOG_FILE, 0);
> -    build_header(linker, table_data,
> -                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
> -}
> -
>   #define HOLE_640K_START  (640 * KiB)
>   #define HOLE_640K_END   (1 * MiB)
>   




