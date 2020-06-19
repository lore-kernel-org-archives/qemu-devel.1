Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BCEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844C72168B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 16:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbdGUC20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844C72168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJgp-0000SP-Pz
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jmJfS-00087h-8b
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:15:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49271
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jmJfP-00038r-Ni
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 12:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592583287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSb7a2HVPEyro4IgWZrApi+W8wMfkPhnS+RcTDCXHh8=;
 b=AbdGUC20J/xStqlIAXtpqdhjn+PbTNGY92PC3LudLRMmilwKMzmBAQ/Z3/xviLYTxU7F9l
 5xkpuDlznEddmI9CYsLmlFxCLAS3YkQp5AmtxadXglzWRvD3KSBEEPLjwVPjTJ2sO5dfjP
 EYwxpBZT752/oq6Yg8/NVdlHvwIzJ4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-9_999KXpN_CcuJi83BhxmA-1; Fri, 19 Jun 2020 12:14:44 -0400
X-MC-Unique: 9_999KXpN_CcuJi83BhxmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC49E8AB3AC;
 Fri, 19 Jun 2020 16:14:33 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82F8361465;
 Fri, 19 Jun 2020 16:14:17 +0000 (UTC)
Subject: Re: [PATCH v6 1/3] acpi: Some build_tpm2() code reshape
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20200619141851.16272-1-eric.auger@redhat.com>
 <20200619141851.16272-2-eric.auger@redhat.com>
 <bfd5813b-12ef-04c8-0f21-4a3934fa0035@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <cc346cfb-57c5-a5b8-812f-f8a2ab152373@redhat.com>
Date: Fri, 19 Jun 2020 18:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <bfd5813b-12ef-04c8-0f21-4a3934fa0035@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Stefan,

On 6/19/20 6:09 PM, Stefan Berger wrote:
> On 6/19/20 10:18 AM, Eric Auger wrote:
>> Remove any reference to Acpi20TPM2 and adopt an implementation
>> similar to build_ghes_v2().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks!

Eric
> 
> 
>>
>> ---
>>
>> v5 -> v6:
>> - add reference to the spec + comment about LAML and LASA fields
>> - also moved LASA intro comment above build_append_int_noprefix()
>>    as requested by Igor
>> ---
>>   hw/acpi/aml-build.c | 54 +++++++++++++++++++++++++++++----------------
>>   1 file changed, 35 insertions(+), 19 deletions(-)
>>
>> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
>> index 2cb7b991ef..1cc08a3eb9 100644
>> --- a/hw/acpi/aml-build.c
>> +++ b/hw/acpi/aml-build.c
>> @@ -1878,48 +1878,64 @@ build_hdr:
>>                    "FACP", tbl->len - fadt_start, f->rev, oem_id,
>> oem_table_id);
>>   }
>>   +/*
>> + * build_tpm2 - Build the TPM2 table as specified in table 7 of
>> + * "TCG ACPI Specification; Family 1.2 and 2.0;
>> + * Level 00 Revision 00.37, December 19, 2014"
>> + * Note: the LASA and LAML fields are optional for TPM-2.0 (the above
>> + * table does not mention them) but are needed at least for SeaBIOS.
>> + * See the Acpi20TPM2 struct for the corresponding layout.
>> + */
>>   void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray
>> *tcpalog)
>>   {
>> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data,
>> sizeof(AcpiTableHeader));
>> -    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>> -    unsigned log_addr_offset =
>> -        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>>       uint8_t start_method_params[12] = {};
>> +    unsigned log_addr_offset, tpm2_start;
>> +    uint64_t control_area_start_address;
>>       TPMIf *tpmif = tpm_find();
>> +    uint32_t start_method;
>> +    void *tpm2_ptr;
>>   -    /* platform class */
>> +    tpm2_start = table_data->len;
>> +    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
>> +
>> +    /* Platform Class */
>>       build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
>> -    /* reserved */
>> +    /* Reserved */
>>       build_append_int_noprefix(table_data, 0, 2);
>>       if (TPM_IS_TIS_ISA(tpmif) || TPM_IS_TIS_SYSBUS(tpmif)) {
>> -        /* address of control area */
>> -        build_append_int_noprefix(table_data, 0, 8);
>> -        /* start method */
>> -        build_append_int_noprefix(table_data, TPM2_START_METHOD_MMIO,
>> 4);
>> +        control_area_start_address = 0;
>> +        start_method = TPM2_START_METHOD_MMIO;
>>       } else if (TPM_IS_CRB(tpmif)) {
>> -        build_append_int_noprefix(table_data, TPM_CRB_ADDR_CTRL, 8);
>> -        build_append_int_noprefix(table_data, TPM2_START_METHOD_CRB, 4);
>> +        control_area_start_address = TPM_CRB_ADDR_CTRL;
>> +        start_method = TPM2_START_METHOD_CRB;
>>       } else {
>> -        g_warn_if_reached();
>> +        g_assert_not_reached();
>>       }
>> +    /* Address of Control Area */
>> +    build_append_int_noprefix(table_data, control_area_start_address,
>> 8);
>> +    /* Start Method */
>> +    build_append_int_noprefix(table_data, start_method, 4);
>>   -    /* platform specific parameters */
>> -    g_array_append_vals(table_data, &start_method_params, 12);
>> +    /* Platform Specific Parameters */
>> +    g_array_append_vals(table_data, &start_method_params,
>> +                        ARRAY_SIZE(start_method_params));
>>   -    /* log area minimum length */
>> +    /* Log Area Minimum Length */
>>       build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE,
>> 4);
>>         acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
>>       bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE,
>> tcpalog, 1,
>>                                false);
>>   -    /* log area start address to be filled by Guest linker */
>> +    log_addr_offset = table_data->len;
>> +
>> +    /* Log Area Start Address to be filled by Guest linker */
>>       build_append_int_noprefix(table_data, 0, 8);
>>       bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
>> -                                   log_addr_offset, log_addr_size,
>> +                                   log_addr_offset, 8,
>>                                      ACPI_BUILD_TPMLOG_FILE, 0);
>>       build_header(linker, table_data,
>> -                 (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4,
>> NULL, NULL);
>> +                 tpm2_ptr, "TPM2", table_data->len - tpm2_start, 4,
>> NULL, NULL);
>>   }
>>     /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
> 
> 
> 


