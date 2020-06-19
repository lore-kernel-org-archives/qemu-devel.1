Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F641C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D9220776
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D9220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmIcf-0000zv-Hg
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jmIbz-0000A4-Pa; Fri, 19 Jun 2020 11:07:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16256
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jmIbx-0007Cb-M5; Fri, 19 Jun 2020 11:07:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05JF2Skb131603; Fri, 19 Jun 2020 11:07:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31rthaa5w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 11:07:18 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JF2YIf132218;
 Fri, 19 Jun 2020 11:07:18 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31rthaa5vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 11:07:18 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JF5Wda012113;
 Fri, 19 Jun 2020 15:07:16 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 31q6bdmcwp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jun 2020 15:07:16 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05JF7G5Q37880118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Jun 2020 15:07:16 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6307CAC05B;
 Fri, 19 Jun 2020 15:07:16 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADBC9AC059;
 Fri, 19 Jun 2020 15:07:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 19 Jun 2020 15:07:15 +0000 (GMT)
Subject: Re: [PATCH v6 1/3] acpi: Some build_tpm2() code reshape
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20200619141851.16272-1-eric.auger@redhat.com>
 <20200619141851.16272-2-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <cd32ba20-a52d-4ff3-6f01-f03241dfc50d@linux.ibm.com>
Date: Fri, 19 Jun 2020 11:07:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200619141851.16272-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-19_16:2020-06-19,
 2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006190107
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 11:07:20
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, lersek@redhat.com, drjones@redhat.com,
 shannon.zhaosl@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com,
 ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 10:18 AM, Eric Auger wrote:
> Remove any reference to Acpi20TPM2 and adopt an implementation
> similar to build_ghes_v2().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>
> ---
>
> v5 -> v6:
> - add reference to the spec + comment about LAML and LASA fields
> - also moved LASA intro comment above build_append_int_noprefix()
>    as requested by Igor
> ---
>   hw/acpi/aml-build.c | 54 +++++++++++++++++++++++++++++----------------
>   1 file changed, 35 insertions(+), 19 deletions(-)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 2cb7b991ef..1cc08a3eb9 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1878,48 +1878,64 @@ build_hdr:
>                    "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_table_id);
>   }
>   
> +/*
> + * build_tpm2 - Build the TPM2 table as specified in table 7 of
> + * "TCG ACPI Specification; Family 1.2 and 2.0;
> + * Level 00 Revision 00.37, December 19, 2014"
> + * Note: the LASA and LAML fields are optional for TPM-2.0 (the above
> + * table does not mention them) but are needed at least for SeaBIOS.
> + * See the Acpi20TPM2 struct for the corresponding layout.
> + */
>   void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>   {
> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> -    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
> -    unsigned log_addr_offset =
> -        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>       uint8_t start_method_params[12] = {};
> +    unsigned log_addr_offset, tpm2_start;
> +    uint64_t control_area_start_address;
>       TPMIf *tpmif = tpm_find();
> +    uint32_t start_method;
> +    void *tpm2_ptr;
>   
> -    /* platform class */
> +    tpm2_start = table_data->len;
> +    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
> +
> +    /* Platform Class */
>       build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> -    /* reserved */
> +    /* Reserved */
>       build_append_int_noprefix(table_data, 0, 2);
>       if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
> -        /* address of control area */
> -        build_append_int_noprefix(table_data, 0, 8);
> -        /* start method */
> -        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
> +        control_area_start_address = 0;
> +        start_method = TPM2_START_METHOD_MMIO;
>       } else if (TPM_IS_CRB(tpmif)) {
> -        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
> -        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
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
> -    /* platform specific parameters */
> -    g_array_append_vals(table_data, &start_method_params, 12);
> +    /* Platform Specific Parameters */
> +    g_array_append_vals(table_data, &start_method_params,
> +                        ARRAY_SIZE(start_method_params));
>   
> -    /* log area minimum length */
> +    /* Log Area Minimum Length */
>       build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
>   
>       acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
>       bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
>                                false);
>   
> -    /* log area start address to be filled by Guest linker */
> +    log_addr_offset = table_data->len;
> +

Don't have to subtract tpm2_start from it ?


> +    /* Log Area Start Address to be filled by Guest linker */
>       build_append_int_noprefix(table_data, 0, 8);
>       bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
> -                                   log_addr_offset, log_addr_size,
> +                                   log_addr_offset, 8,
>                                      ACPI_BUILD_TPMLOG_FILE, 0);
>       build_header(linker, table_data,
> -                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, NULL);
> +                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4, NULL, NULL);
>   }
>   
>   /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */



