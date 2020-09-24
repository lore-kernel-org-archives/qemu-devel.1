Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF58C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B9C2220D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="avdxlDUi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B9C2220D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPZy-0003KP-93
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLPZ4-0002sX-7Q
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:37:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:32768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kLPZ2-0006GY-CY
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:37:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id o25so1760337pgm.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 04:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=H9GxJMYPdtSEDnc4MOgbutjnjWkuSABG+McJyFbCDTU=;
 b=avdxlDUizBkEUb0fgdhztVjbxZpJ60yhjT3Tz4SkPZKc4d+z7Aqjn3lEC6YiyQJzm+
 8iSKxU12uRKVyq/W8r/QhYWYv8ltUNgm9NwwkwZsh0HP+RSygaXrg1r9cIGLU8cR/E4Y
 ygSzHbHoH73EQcrc/uizW1CMPrdXbyVML61mNNFpvJW0e4jUji+RsNkhRbm9IRDcJQb9
 ZceTrKuW7VzifUVdiYQ/yEkv5fJ7Eka7MlSkbTYR7qC1w4i8oFdTpSOt1hWyYBcXI0sS
 kHA93T8fRnrUkq9th/xAwXUptnjIlO5aHv0FsdQuFdpkii+t356vAccNRRzbKsWDEHPe
 pLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=H9GxJMYPdtSEDnc4MOgbutjnjWkuSABG+McJyFbCDTU=;
 b=PMy4iAAQdi7zK+k1bfVDz4EWegPBU3CoZxZfGvQczj9TSI0RKig53cWCes9PyTXuSX
 Pl/xn9T/0SpEmeS9gf1Qgzi/bg9p5hpXSkG3QzueJaygWXigCrOv6Nvw3BZTCzNpZ9IA
 dWf79UsYFBtalZozn2dQ8YE8NyFj5Nk/LBXRcbbomVwA/dhWJSE2ibJe0XxrjZXXQL/I
 1yqhg27wDg6InrYNgmxhK+OoL13oy13zOaRqK9Il30kpjq8JcoH6DAzIzz2Ubhz7GNgP
 COAFvy+SMyhWzmLRV8wUOwbAZHciRw1Zh0n5/CU6dAbEmZneH726RdKNol0VH6qBh8Xg
 sdUA==
X-Gm-Message-State: AOAM530hEJkUl1wIsuHAn9/Wc4gt3irU64LKNVZnzi93aOLHFw1meSXv
 NTJokfg1Yt5A03lePdYpzt9v8g==
X-Google-Smtp-Source: ABdhPJzrHKF1P3S02aJhpF2Q+pY2UokDDw8udIUDuBfdOVPVekKcmDqDdyHWzp1oxasL7Mfr4MxEkg==
X-Received: by 2002:a63:ce17:: with SMTP id y23mr3750075pgf.447.1600947444400; 
 Thu, 24 Sep 2020 04:37:24 -0700 (PDT)
Received: from ani-ubuntu ([115.96.139.162])
 by smtp.googlemail.com with ESMTPSA id 64sm2957176pgi.90.2020.09.24.04.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:37:23 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
X-Google-Original-From: Ani Sinha <ani@ani-ubuntu>
Date: Thu, 24 Sep 2020 17:07:17 +0530 (IST)
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC PATCH v3 3/7] hw/pci/pcie: Do not initialize slot capability
 if acpihp is used
In-Reply-To: <20200924131440.49432dfc@redhat.com>
Message-ID: <alpine.DEB.2.21.2009241707010.17687@ani-ubuntu>
References: <20200924070013.165026-1-jusual@redhat.com>
 <20200924070013.165026-4-jusual@redhat.com>
 <20200924131440.49432dfc@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Ani Sinha <ani@anisinha.ca>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, 24 Sep 2020, Igor Mammedov wrote:

> On Thu, 24 Sep 2020 09:00:09 +0200
> Julia Suvorova <jusual@redhat.com> wrote:
>
>> Instead of changing the hot-plug type in _OSC register, do not
>> initialize the slot capability or set the 'Slot Implemented' flag.
>> This way guest will choose ACPI hot-plug if it is preferred and leave
>> the option to use SHPC with pcie-pci-bridge.
>>
>> Signed-off-by: Julia Suvorova <jusual@redhat.com>
>> ---
>>  hw/i386/acpi-build.h |  2 ++
>>  hw/i386/acpi-build.c |  2 +-
>>  hw/pci/pcie.c        | 16 ++++++++++++++++
>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
>> index 487ec7710f..4c5bfb3d0b 100644
>> --- a/hw/i386/acpi-build.h
>> +++ b/hw/i386/acpi-build.h
>> @@ -11,4 +11,6 @@ extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>>
>>  void acpi_setup(void);
>>
>> +Object *object_resolve_type_unambiguous(const char *typename);
>> +
>>  #endif
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index cf503b16af..b7811a8912 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -174,7 +174,7 @@ static void init_common_fadt_data(MachineState *ms, Object *o,
>>      *data = fadt;
>>  }
>>
>> -static Object *object_resolve_type_unambiguous(const char *typename)
>> +Object *object_resolve_type_unambiguous(const char *typename)
>>  {
>>      bool ambig;
>>      Object *o = object_resolve_path_type("", typename, &ambig);
>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>> index 5b48bae0f6..c1a082e8b9 100644
>> --- a/hw/pci/pcie.c
>> +++ b/hw/pci/pcie.c
>> @@ -27,6 +27,8 @@
>>  #include "hw/pci/pci_bus.h"
>>  #include "hw/pci/pcie_regs.h"
>>  #include "hw/pci/pcie_port.h"
>> +#include "hw/i386/ich9.h"
>> +#include "hw/i386/acpi-build.h"
>>  #include "qemu/range.h"
>>
>>  //#define DEBUG_PCIE
>> @@ -515,12 +517,26 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>>      pcie_cap_slot_push_attention_button(hotplug_pdev);
>>  }
>>
>> +static bool acpi_pcihp_enabled(void)
>> +{
>> +    Object *lpc = object_resolve_type_unambiguous(TYPE_ICH9_LPC_DEVICE);
>> +
>> +    return lpc &&
>> +           object_property_get_bool(lpc, "acpi-pci-hotplug-with-bridge-support",
>> +                                    NULL);
>> +
>> +}
>> +
>>  /* pci express slot for pci express root/downstream port
>>     PCI express capability slot registers */
>>  void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>>  {
>>      uint32_t pos = dev->exp.exp_cap;
>>
>> +    if (acpi_pcihp_enabled()) {
>> +        return;
>> +    }
>> +
>>      pci_word_test_and_set_mask(dev->config + pos + PCI_EXP_FLAGS,
>>                                 PCI_EXP_FLAGS_SLOT);
>>
> why do you drop all slot caps instead of disabling just "if (s->hotplug) {" branch?

+1 to Igor's suggestion.


>
>

