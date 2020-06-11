Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E88C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9A722075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A722075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOBZ-0004kR-W4
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjOAI-0003cU-On; Thu, 11 Jun 2020 10:26:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jjOAH-0008Vf-Dy; Thu, 11 Jun 2020 10:26:46 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05BE1p2W094426; Thu, 11 Jun 2020 10:26:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ka4j990t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 10:26:41 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05BE1p8R094434;
 Thu, 11 Jun 2020 10:26:41 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31ka4j990d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 10:26:41 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05BELHMm003046;
 Thu, 11 Jun 2020 14:26:39 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma03dal.us.ibm.com with ESMTP id 31hw1c7e6x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2020 14:26:39 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05BEPcHS54460814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jun 2020 14:25:38 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3DEE112061;
 Thu, 11 Jun 2020 14:25:38 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B10E5112064;
 Thu, 11 Jun 2020 14:25:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jun 2020 14:25:38 +0000 (GMT)
Subject: Re: [PATCH v4 1/5] acpi: Convert build_tpm2() to build_append* API
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200611135917.18300-1-eric.auger@redhat.com>
 <20200611135917.18300-2-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <28121558-7a75-73da-6939-da0c0e776087@linux.ibm.com>
Date: Thu, 11 Jun 2020 10:25:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200611135917.18300-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-11_14:2020-06-11,
 2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006110106
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 10:26:43
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
> In preparation of its move to the generic acpi code,
> let's convert build_tpm2() to use build_append API. This
> latter now is prefered in place of direct ACPI struct field
> settings with manual endianness conversion.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v3 -> v4:
> - Don't use Acpi20TPM2 *tpm2_ptr anymore
> - Use variables for control area start address and start method
> - Simplified arg values passed to bios_linker_loader_add_pointer
> - use g_assert_not_reached()
> ---
>   hw/i386/acpi-build.c | 49 +++++++++++++++++++++++++++++---------------
>   1 file changed, 33 insertions(+), 16 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b5669d6c65..f150d95ecc 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2298,35 +2298,52 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>   static void
>   build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>   {
> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
> -    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
> -    unsigned log_addr_offset =
> -        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> +    uint8_t start_method_params[12] = {};
> +    unsigned log_addr_offset, tpm2_start;
> +    uint64_t control_area_start_address;
> +    uint32_t start_method;
> +    void *tpm2_ptr;
>   
> -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> +    tpm2_start = table_data->len;
> +    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    /* Platform Class */
> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> +    /* Reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
>       if (TPM_IS_TIS_ISA(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> +        control_area_start_address = 0;
> +        start_method = TPM2_START_METHOD_MMIO;
>       } else if (TPM_IS_CRB(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
> +        control_area_start_address = TPM_CRB_ADDR_CTRL;
> +        start_method = TPM2_START_METHOD_CRB;
>       } else {
> -        g_warn_if_reached();
> +        g_assert_not_reached();
>       }
> +    /* Address of Control Area */
> +    build_append_int_noprefix(table_data, control_area_start_address, 8);
> +    /* Start Method */
> +    build_append_int_noprefix(table_data, start_method, 4);
>   
> -    tpm2_ptr->log_area_minimum_length =
> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +    /* Platform Specific Parameters */
> +    g_array_append_vals(table_data, &start_method_params,
> +                        ARRAY_SIZE(start_method_params));
>   
> -    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
> +    /* Log Area Minimum Length */
> +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);

Here you push data related to TPM2 table...


> +
> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);

... here you push log area memory ...


>       bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
>                                false);
>   
> -    /* log area start address to be filled by Guest linker */
> +    log_addr_offset = table_data->len;
> +    build_append_int_noprefix(table_data, 0, 8);


... here you push TPM2 table related data again. Is this right or did we 
just mess up the TPM 2 table?


> +    /* Log Area Start Address to be filled by Guest linker */
>       bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -                                   log_addr_offset, log_addr_size,
> +                                   log_addr_offset, 8,
>                                      ACPI_BUILD_TPMLOG_FILE, 0);
>       build_header(linker, table_data,
> -                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
> +                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
>   }
>   
>   #define HOLE_640K_START  (640 * KiB)



