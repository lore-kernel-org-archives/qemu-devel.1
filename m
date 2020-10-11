Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF25C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674162074D
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx/Xu2Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674162074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRib6-00030q-FR
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 17:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiZ2-00010I-Am; Sun, 11 Oct 2020 17:07:32 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiZ0-0000Iu-NU; Sun, 11 Oct 2020 17:07:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id q5so15569915wmq.0;
 Sun, 11 Oct 2020 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bE3ar9sw2hBaOaG6Bp96M3jGWwC7xKV/hXut9gEwRyw=;
 b=fx/Xu2Bb3Wxqd3azlSQWLcVGF86n/jS7EpqsX8AdWarqqXA5ESAjzX2a5ok9+wi5GN
 sxMZvMMeOV2sCpshcRmpAzF3p1AgDVA5E3bZh6w4BQRYMvEPWfM+I6J1eesRue2XroJC
 xyJXlfUFsKkQ3HeQWWhCeGOloW+TLTmlqmncIxxvFlfiqTuNGzd2f5v52jPkrbCfafe1
 KB2i5TqqmCoXMWRlDRXHO5T0GLsfoMxEeT/wsGkZDK549Bvaujl7Yoivyc/bCUmveCbk
 ykMWupAQrMaxBAc2WU/lCNrTV49daXz5zK10mvPiP79v4TTLXrf3Azh9JlOPg4VxDIyv
 FvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bE3ar9sw2hBaOaG6Bp96M3jGWwC7xKV/hXut9gEwRyw=;
 b=fSLdvTbP1tAqhMNR+GzrVoPVFkwL7zQ4DMpOLMHMVQxXlO9a81pWsAkb33vQDUZzWP
 PZ14H3ry47Ub0d7rlVayr+lIWefuj0XsT8U7yg0zbZb4fjFiTAaoEJ72OT6uKwd/7liU
 TxPqrQhpJG+n5coztItw1f40UkxMX5CiTIXPpVq6nbXCNyKgFC30TB0IRPy+fDyBxdzq
 i8UESfjH1zYe7SsdP/yl+i7sewW+FSY7pYl5GcWYcy3ueqNOEFBrWBEFbWCSpWazWW/b
 JCMjRrPjRljsQKKfmFSsWvcVuGda/Y6tPZCO/SsBKUkBOfgJ3naXGqlyAiOFWEriWCEb
 S8bg==
X-Gm-Message-State: AOAM533rVBtB6cSw9BV/dFP/veQwbYQr+sHeNiDQiCMOIq8dYNxbs2qA
 632CEUFClrZZ8TdQQeWBHu0=
X-Google-Smtp-Source: ABdhPJzPd7Tzx6bZBXzh2hMoLDPU2ZVjlpPVi250LTSvgr2Mn/cAZe03VkkOtTRM58EZCS683obBVQ==
X-Received: by 2002:a1c:6804:: with SMTP id d4mr7849875wmc.27.1602450447946;
 Sun, 11 Oct 2020 14:07:27 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id o3sm18593134wru.15.2020.10.11.14.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2020 14:07:27 -0700 (PDT)
Subject: Re: [PATCH 04/10] hw/isa: Add the ISA_IRQ_TPM_DEFAULT definition
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20201011193229.3210774-1-f4bug@amsat.org>
 <20201011193229.3210774-5-f4bug@amsat.org>
 <1976a77d-8799-5f2a-1dcb-5c8dbdb21a3f@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8c8922be-6495-f50c-8924-497d8c98eda4@amsat.org>
Date: Sun, 11 Oct 2020 23:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1976a77d-8799-5f2a-1dcb-5c8dbdb21a3f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Corey Minyard <minyard@acm.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/20 10:28 PM, Stefan Berger wrote:
> On 10/11/20 3:32 PM, Philippe Mathieu-Daudé wrote:
>> The TPM TIS device uses IRQ #5 by default. Add this
>> default definition to the IsaIrqNumber enum.
>>
>> Avoid magic values in the code, replace them by the
>> newly introduced definition.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   include/hw/isa/isa.h   | 1 +
>>   hw/i386/acpi-build.c   | 2 +-
>>   hw/ipmi/isa_ipmi_bt.c  | 2 +-
>>   hw/ipmi/isa_ipmi_kcs.c | 2 +-
>>   hw/tpm/tpm_tis_isa.c   | 2 +-
>>   5 files changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/isa/isa.h b/include/hw/isa/isa.h
>> index 519296d5823..e4f2aed004f 100644
>> --- a/include/hw/isa/isa.h
>> +++ b/include/hw/isa/isa.h
>> @@ -11,6 +11,7 @@
>>   enum IsaIrqNumber {
>>       ISA_IRQ_KBD_DEFAULT =  1,
>>       ISA_IRQ_SER_DEFAULT =  4,
>> +    ISA_IRQ_TPM_DEFAULT =  5,
>>       ISA_NUM_IRQS        = 16
>>   };
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 45ad2f95334..2b6038ab015 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1886,7 +1886,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>                       Rewrite to take IRQ from TPM device model and
>>                       fix default IRQ value there to use some unused IRQ
>>                    */
>> -                /* aml_append(crs, aml_irq_no_flags(TPM_TIS_IRQ)); */
>> +                /* aml_append(crs, 
>> aml_irq_no_flags(ISA_IRQ_TPM_DEFAULT)); */
>>                   aml_append(dev, aml_name_decl("_CRS", crs));
>>
>>                   tpm_build_ppi_acpi(tpm, dev);
>> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
>> index b7c2ad557b2..13a92bd2c44 100644
>> --- a/hw/ipmi/isa_ipmi_bt.c
>> +++ b/hw/ipmi/isa_ipmi_bt.c
>> @@ -137,7 +137,7 @@ static void 
>> *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
>>
>>   static Property ipmi_isa_properties[] = {
>>       DEFINE_PROP_UINT32("ioport", ISAIPMIBTDevice, bt.io_base,  0xe4),
>> -    DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
>> +    DEFINE_PROP_INT32("irq", ISAIPMIBTDevice, isairq, 
>> ISA_IRQ_TPM_DEFAULT),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
>>
>> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
>> index 7dd6bf0040a..c956b539688 100644
>> --- a/hw/ipmi/isa_ipmi_kcs.c
>> +++ b/hw/ipmi/isa_ipmi_kcs.c
>> @@ -144,7 +144,7 @@ static void 
>> *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
>>
>>   static Property ipmi_isa_properties[] = {
>>       DEFINE_PROP_UINT32("ioport", ISAIPMIKCSDevice, kcs.io_base,  
>> 0xca2),
>> -    DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
>> +    DEFINE_PROP_INT32("irq", ISAIPMIKCSDevice, isairq, 
>> ISA_IRQ_TPM_DEFAULT),
>>       DEFINE_PROP_END_OF_LIST(),
>>   };
> 
> 
> I don't know what these devices do but this looks like an unwanted clash.

Yes, sorry :( Maybe better to drop this patch.

> 
>> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
>> index 6fd876eebf1..5a4afda42df 100644
>> --- a/hw/tpm/tpm_tis_isa.c
>> +++ b/hw/tpm/tpm_tis_isa.c
>> @@ -91,7 +91,7 @@ static void tpm_tis_isa_reset(DeviceState *dev)
>>   }
>>
>>   static Property tpm_tis_isa_properties[] = {
>> -    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
>> +    DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, 
>> ISA_IRQ_TPM_DEFAULT),
>>       DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
>>       DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
>>       DEFINE_PROP_END_OF_LIST(),
> 
> 
> 

