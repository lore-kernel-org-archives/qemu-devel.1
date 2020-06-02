Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F26C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06C8206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06C8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg70a-0006nB-16
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jg6zp-0006DC-PB; Tue, 02 Jun 2020 09:30:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2940
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jg6zo-0004CZ-OQ; Tue, 02 Jun 2020 09:30:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 052DB5Cd028439; Tue, 2 Jun 2020 09:30:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31dhekvt0b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 09:30:19 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 052DQrlZ085268;
 Tue, 2 Jun 2020 09:30:18 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31dhekvsyn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 09:30:18 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052DPanw025760;
 Tue, 2 Jun 2020 13:30:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma03wdc.us.ibm.com with ESMTP id 31bf48j7sd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 02 Jun 2020 13:30:18 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 052DUHRd34668828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 2 Jun 2020 13:30:17 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C4E8112062;
 Tue,  2 Jun 2020 13:30:17 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 854ED112064;
 Tue,  2 Jun 2020 13:30:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  2 Jun 2020 13:30:16 +0000 (GMT)
Subject: Re: [PATCH v3 1/4] acpi: Convert build_tpm2() to build_append* API
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200601095737.32671-1-eric.auger@redhat.com>
 <20200601095737.32671-2-eric.auger@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <46c71777-b588-ce1f-eb8d-de1c5b3e2186@linux.ibm.com>
Date: Tue, 2 Jun 2020 09:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200601095737.32671-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-02_13:2020-06-02,
 2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 cotscore=-2147483648 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020093
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:30:21
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 5:57 AM, Eric Auger wrote:
> In preparation of its move to the generic acpi code,
> let's convert build_tpm2() to use build_append API. This
> latter now is prefered in place of direct ACPI struct field
> settings with manual endianness conversion.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/acpi-build.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b5669d6c65..f0d35d7b17 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -2298,30 +2298,40 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>   static void
>   build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>   {
> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
> +    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));

And now you want to build the data structure by pushing fields? I would 
definitely NOT do this.


>       unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>       unsigned log_addr_offset =
>           (char *)&tpm2_ptr->log_area_start_address - table_data->data;
> +    uint8_t start_method_params[12] = {};
>   
> -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
> +    /* platform class */
> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
> +    /* reserved */
> +    build_append_int_noprefix(table_data, 0, 2);
>       if (TPM_IS_TIS_ISA(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
> +        /* address of control area */
> +        build_append_int_noprefix(table_data, 0, 8);
> +        /* start method */
> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO, 4);
>       } else if (TPM_IS_CRB(tpm_find())) {
> -        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
> +        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
> +        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
>       } else {
>           g_warn_if_reached();
>       }
>   
> -    tpm2_ptr->log_area_minimum_length =
> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
> +    /* platform specific parameters */
> +    g_array_append_vals(table_data, &start_method_params, 12);
>   
> -    acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
> +    /* log area minimum length */
> +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
> +
> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
>       bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
>                                false);
>   
>       /* log area start address to be filled by Guest linker */
> +    build_append_int_noprefix(table_data, 0, 8);
>       bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>                                      log_addr_offset, log_addr_size,
>                                      ACPI_BUILD_TPMLOG_FILE, 0);



