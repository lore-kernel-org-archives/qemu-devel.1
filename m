Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C5C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39312075E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNQVpCIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39312075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOeX-0001Pe-1n
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjObP-00069V-6D
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:54:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56949
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jjObL-00061U-Ns
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591887282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O76wbMtg4ieFnfz05YM9/fazyxOuvfNEeSKyik2p3AQ=;
 b=ZNQVpCIkaKYoIu7+tqMRC1WIepd7wu6/+3TgrbkmjXDDEPGD8oPX0i95hnWg1PKyzawIge
 weSTKka2bxpycdp8BSKQNElZ4uJvUMj30LNsYmMkWhT9qCo/R6aDRtfxUcrPhcDcs95pJF
 /LAjqFtTATXvfaJOmzcRrR+wbN/j3Qc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-3pNF1nmBOc2TJpnxpEcYiA-1; Thu, 11 Jun 2020 10:54:40 -0400
X-MC-Unique: 3pNF1nmBOc2TJpnxpEcYiA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A6FD107ACF5;
 Thu, 11 Jun 2020 14:54:39 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 699815D9DC;
 Thu, 11 Jun 2020 14:54:30 +0000 (UTC)
Subject: Re: [PATCH v4 1/5] acpi: Convert build_tpm2() to build_append* API
To: Stefan Berger <stefanb@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 mst@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com
References: <20200611135917.18300-1-eric.auger@redhat.com>
 <20200611135917.18300-2-eric.auger@redhat.com>
 <28121558-7a75-73da-6939-da0c0e776087@linux.ibm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <47b20185-48a8-87d5-a492-9db37ba7ea9f@redhat.com>
Date: Thu, 11 Jun 2020 16:54:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <28121558-7a75-73da-6939-da0c0e776087@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@redhat.com, drjones@redhat.com, lersek@redhat.com,
 ardb@kernel.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,

On 6/11/20 4:25 PM, Stefan Berger wrote:
> On 6/11/20 9:59 AM, Eric Auger wrote:
>> In preparation of its move to the generic acpi code,
>> let's convert build_tpm2() to use build_append API. This
>> latter now is prefered in place of direct ACPI struct field
>> settings with manual endianness conversion.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - Don't use Acpi20TPM2 *tpm2_ptr anymore
>> - Use variables for control area start address and start method
>> - Simplified arg values passed to bios_linker_loader_add_pointer
>> - use g_assert_not_reached()
>> ---
>>   hw/i386/acpi-build.c | 49 +++++++++++++++++++++++++++++---------------
>>   1 file changed, 33 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index b5669d6c65..f150d95ecc 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -2298,35 +2298,52 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker
>> *linker, GArray *tcpalog)
>>   static void
>>   build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
>>   {
>> -    Acpi20TPM2 *tpm2_ptr = acpi_data_push(table_data, sizeof *tpm2_ptr);
>> -    unsigned log_addr_size = sizeof(tpm2_ptr->log_area_start_address);
>> -    unsigned log_addr_offset =
>> -        (char *)&tpm2_ptr->log_area_start_address - table_data->data;
>> +    uint8_t start_method_params[12] = {};
>> +    unsigned log_addr_offset, tpm2_start;
>> +    uint64_t control_area_start_address;
>> +    uint32_t start_method;
>> +    void *tpm2_ptr;
>>   -    tpm2_ptr->platform_class = cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
>> +    tpm2_start = table_data->len;
>> +    tpm2_ptr = acpi_data_push(table_data, sizeof(AcpiTableHeader));
>> +
>> +    /* Platform Class */
>> +    build_append_int_noprefix(table_data, TPM2_ACPI_CLASS_CLIENT, 2);
>> +    /* Reserved */
>> +    build_append_int_noprefix(table_data, 0, 2);
>>       if (TPM_IS_TIS_ISA(tpm_find())) {
>> -        tpm2_ptr->control_area_address = cpu_to_le64(0);
>> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_MMIO);
>> +        control_area_start_address = 0;
>> +        start_method = TPM2_START_METHOD_MMIO;
>>       } else if (TPM_IS_CRB(tpm_find())) {
>> -        tpm2_ptr->control_area_address = cpu_to_le64(TPM_CRB_ADDR_CTRL);
>> -        tpm2_ptr->start_method = cpu_to_le32(TPM2_START_METHOD_CRB);
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
>>   -    tpm2_ptr->log_area_minimum_length =
>> -        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
>> +    /* Platform Specific Parameters */
>> +    g_array_append_vals(table_data, &start_method_params,
>> +                        ARRAY_SIZE(start_method_params));
>>   -    acpi_data_push(tcpalog,
>> le32_to_cpu(tpm2_ptr->log_area_minimum_length));
>> +    /* Log Area Minimum Length */
>> +    build_append_int_noprefix(table_data, TPM_LOG_AREA_MINIMUM_SIZE, 4);
> 
> Here you push data related to TPM2 table...
yes it was
    tpm2_ptr->log_area_minimum_length =
        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
altering tpm2
> 
> 
>> +
>> +    acpi_data_push(tcpalog, TPM_LOG_AREA_MINIMUM_SIZE);
> 
> ... here you push log area memory ...
in "acpi: tpm: Do not build TCPA table for TPM 2" there is
acpi_data_push(tcpalog, le32_to_cpu(tpm2_ptr->log_area_minimum_length));
bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
                         false);

So to me this matches
> 
> 
>>       bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE,
>> tcpalog, 1,
>>                                false);
>>   -    /* log area start address to be filled by Guest linker */
>> +    log_addr_offset = table_data->len;
>> +    build_append_int_noprefix(table_data, 0, 8);
> 
> 
> ... here you push TPM2 table related data again. Is this right or did we
> just mess up the TPM 2 table?
here I increment the table_data->len to take into account the last
field, ie. log_addr_offset
So I think it is correct.
bios-tables-test pass so at least TPM2 ACPI tables shouldn't have veen
altered.

Thanks

Eric
> 
> 
>> +    /* Log Area Start Address to be filled by Guest linker */
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
>>     #define HOLE_640K_START  (640 * KiB)
> 
> 
> 


