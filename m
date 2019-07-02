Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FC5C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 400C920663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400C920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiEm3-00056S-1v
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32990)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiElK-0004Zd-L1
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiElI-0001RH-Jn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:07:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiElG-0001Ju-NK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:07:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id c27so9155714wrb.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 02:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gUVtXY2OUP84mS7rth9ROiVao0pYd2o2w9QXRMVfTto=;
 b=YYHdYjtms5vz9XrjXiQ3O6eNjrqJ99XG5qNIHfMLU3LMwb0c4IHvCRUYCgadDXfxp6
 kt/G2AmlAsdS95Op7oXAReNZEQFGGsb3hcw2t1x4DI3Di7rUNHIvgmjqTM/sJ6Ib0Fjt
 EDSzJ4nv/Lg2q686qPDZy/E2BdjpKWdCLXsG8l4AoWBD78ZgotTxEqIWCOT0OSzkgMBP
 vB8RTknjCxFa2iK/wrR/+FHvdplhEm23awtMfmQwLHQb4h9Mw4lzNw5CZfYhvKXl9m/p
 sSAN/MNlL2D7QHeXcDWZsrfKiQ6MSeB/RMa9NoBKrs3aKKenB2EAmsMzbANgijNbKi7U
 2vfw==
X-Gm-Message-State: APjAAAUjKvehzLyIKMG2Vkjx2GZLgouDjBMOHpqJJcbkQbEaim7OwYMt
 rmA77/UiSw6Z32isPxlbhH01XA==
X-Google-Smtp-Source: APXvYqxqQ/QcKWOfsnDzptHk6k2/M2En/laMOr9iNgc/61/5QTLgQfUBGeVvDr5O5IX99H+w3K1Vbg==
X-Received: by 2002:a5d:5450:: with SMTP id w16mr13549972wrv.128.1562058456643; 
 Tue, 02 Jul 2019 02:07:36 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id a81sm2541732wmh.3.2019.07.02.02.07.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 02:07:36 -0700 (PDT)
To: minyard@acm.org, QEMU Developers <qemu-devel@nongnu.org>
References: <20190701183100.7849-1-minyard@acm.org>
 <20190701183100.7849-3-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <89c94fcb-c88c-fc29-7239-5c5e216d58dd@redhat.com>
Date: Tue, 2 Jul 2019 11:07:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701183100.7849-3-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 2/2] ipmi: Add a UUID device property
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
Cc: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/19 8:31 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Using the UUID that qemu generates probably isn't the best thing
> to do, allow it to be passed in via properties, and use QemuUUID
> for the type.
> 
> If the UUID is not set, return an unsupported command error.  This
> way we are not providing an all-zero (or randomly generated) GUID
> to the IPMI user.  This lets the host fall back to the other
> method of using the get device id command to determind the BMC
> being accessed.

A qtest for this would be much appreciated! (for 4.2 cycle).

> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 22 ++++++++++++++--------
>  qemu-options.hx        | 10 +++++++---
>  2 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 1980536517..007e2c6588 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -221,7 +221,7 @@ struct IPMIBmcSim {
>      uint8_t restart_cause;
>  
>      uint8_t acpi_power_state[2];
> -    uint8_t uuid[16];
> +    QemuUUID uuid;
>  
>      IPMISel sel;
>      IPMISdr sdr;
> @@ -937,8 +937,19 @@ static void get_device_guid(IPMIBmcSim *ibs,
>  {
>      unsigned int i;
>  
> +    /* An uninitialized uuid is all zeros, use that to know if it is set. */
>      for (i = 0; i < 16; i++) {
> -        rsp_buffer_push(rsp, ibs->uuid[i]);
> +        if (ibs->uuid.data[i]) {
> +            goto uuid_set;
> +        }
> +    }

You can drop this for() loop and simplify as:

       if (qemu_uuid_is_null(&ibs->uuid) {

> +    /* No uuid is set, return an error. */
> +    rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
> +    return;

}

> +
> + uuid_set:
> +    for (i = 0; i < 16; i++) {

16 -> ARRAY_SIZE(ibs->uuid.data) ?

> +        rsp_buffer_push(rsp, ibs->uuid.data[i]);
>      }
>  }
>  
> @@ -1980,12 +1991,6 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
>      ibs->acpi_power_state[0] = 0;
>      ibs->acpi_power_state[1] = 0;
>  
> -    if (qemu_uuid_set) {
> -        memcpy(&ibs->uuid, &qemu_uuid, 16);
> -    } else {
> -        memset(&ibs->uuid, 0, 16);
> -    }
> -
>      ipmi_init_sensors_from_sdrs(ibs);
>      register_cmds(ibs);
>  
> @@ -2005,6 +2010,7 @@ static Property ipmi_sim_properties[] = {
>      DEFINE_PROP_UINT8("fwrev2", IPMIBmcSim, fwrev2, 0),
>      DEFINE_PROP_UINT32("mfg_id", IPMIBmcSim, mfg_id, 0),
>      DEFINE_PROP_UINT16("product_id", IPMIBmcSim, product_id, 0),
> +    DEFINE_PROP_UUID_NODEFAULT("guid", IPMIBmcSim, uuid),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 0d8beb4afd..ec56ab8f6f 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -700,7 +700,7 @@ possible drivers and properties, use @code{-device help} and
>  @code{-device @var{driver},help}.
>  
>  Some drivers are:
> -@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}]
> +@item -device ipmi-bmc-sim,id=@var{id}[,slave_addr=@var{val}][,sdrfile=@var{file}][,furareasize=@var{val}][,furdatafile=@var{file}][,guid=@var{uuid}]
>  
>  Add an IPMI BMC.  This is a simulation of a hardware management
>  interface processor that normally sits on a system.  It provides
> @@ -713,8 +713,8 @@ controllers.  If you don't know what this means, it is safe to ignore
>  it.
>  
>  @table @option
> -@item bmc=@var{id}
> -The BMC to connect to, one of ipmi-bmc-sim or ipmi-bmc-extern above.
> +@item id=@var{id}
> +The BMC id for interfaces to use this device.
>  @item slave_addr=@var{val}
>  Define slave address to use for the BMC.  The default is 0x20.
>  @item sdrfile=@var{file}
> @@ -723,6 +723,10 @@ file containing raw Sensor Data Records (SDR) data. The default is none.
>  size of a Field Replaceable Unit (FRU) area.  The default is 1024.
>  @item frudatafile=@var{file}
>  file containing raw Field Replaceable Unit (FRU) inventory data. The default is none.
> +@item guid=@var{uuid}
> +value for the GUID for the BMC, in standard UUID format.  If this is set,
> +get "Get GUID" command to the BMC will return it.  Otherwise "Get GUID"
> +will return an error.
>  @end table
>  
>  @item -device ipmi-bmc-extern,id=@var{id},chardev=@var{id}[,slave_addr=@var{val}]
> 

Using qemu_uuid_is_null:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

