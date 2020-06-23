Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4C0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A47B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMEvhro3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A47B20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngjZ-000496-B9
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngir-0003bC-60; Tue, 23 Jun 2020 07:04:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngip-000683-Dq; Tue, 23 Jun 2020 07:04:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id k6so7591329wrn.3;
 Tue, 23 Jun 2020 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ie7ZjNr3QlOFBcrFKMUjZuJLoJQ64iApva3SwELQhc8=;
 b=CMEvhro3DkSqeKade+nFhO1/2J769Qka70VlIA3ut1gRgDOvJc2RVxOdzUXpqbknLH
 qfjsl/dDrvoMxq+GMuTCvN5FgqY0NR0NYrv+9UejwolfOrWvb36zhGoPBr1cRlGhIQvy
 8+bmsB59dCScGEqBwwT7YEMUIerH+6oxTPxvC3aUldXpfguGt0O1VYrk1HFKgNQzEd5P
 lgV5BP6Z1UbSaTZSxhTlryFPXDpmGtpEFWsZH9qj7o9zwZUFbV0RY8pt9ab10MaH2KZI
 anrG3fM9MhBSTQuwmzwCmpdw+OEbDJAEibfJhiLTs7JhOpLAwZZgoMtDcArWfPmhcZNh
 CpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ie7ZjNr3QlOFBcrFKMUjZuJLoJQ64iApva3SwELQhc8=;
 b=TNECVTPpT0MjLaCc8AgtUJv3YftdQuaOJMjWAqj94BqPeRxbhWFT6p1IDuo/H+GIji
 60ITQPPwNLZ5jb2+BOIH020krSHAHpElWfIKxy/noh4aqHsas4Vtp3KkqhgbQ69AyQ7D
 QWIw9wnwAHRAa89l6YPPYrMS3WRRGotUHtkmpB95DHPnkF2wwrsUG+WHBpXR/KAYFgXZ
 ceWYDjuFbrWne/xfDLCj9HvXXIDpHQRLQepIgvlycEYgMjwA+vGRZgiIJZJvBqoCzIVl
 6m2jHoTaebKl4eDm7Vd69TEs/LCZQtYGl1v6VWdil6AutQUBaavHGCmIdx8j5NYElqLh
 WosA==
X-Gm-Message-State: AOAM531GW+8aj9yzqEmp4VGCMOrrGferQEng/o5j4/tOl6eWpE6H6qzS
 z6CHkDk1RNg3Qvi6cYv1JdI=
X-Google-Smtp-Source: ABdhPJxl+e/9sOe+YnoTQCYtcG/bj8eA5eGP5scCUjHeThCNxSsBPdkEcvUGddZdpdXZjagVGtouhQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr24171693wrn.408.1592910249347; 
 Tue, 23 Jun 2020 04:04:09 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z1sm13624133wru.30.2020.06.23.04.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 04:04:08 -0700 (PDT)
Subject: Re: [PATCH v5 1/9] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
To: Markus Armbruster <armbru@redhat.com>
References: <20200622183428.12255-1-f4bug@amsat.org>
 <20200622183428.12255-2-f4bug@amsat.org> <875zbimcs6.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fbecc71b-3f1d-0c6f-83eb-e10b408c85e2@amsat.org>
Date: Tue, 23 Jun 2020 13:04:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875zbimcs6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 10:01 AM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> Extract i2c_try_create_slave() and i2c_realize_and_unref()
>> from i2c_create_slave().
>> We can now set properties on a I2CSlave before it is realized.
>>
>> This is in line with the recent qdev/QOM changes merged
>> in commit 6675a653d2e.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> Cc: Markus Armbruster <armbru@redhat.com>
>> ---
>>  include/hw/i2c/i2c.h |  2 ++
>>  hw/i2c/core.c        | 18 ++++++++++++++++--
>>  2 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
>> index 4117211565..d6e3d85faf 100644
>> --- a/include/hw/i2c/i2c.h
>> +++ b/include/hw/i2c/i2c.h
>> @@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
>>  uint8_t i2c_recv(I2CBus *bus);
>>  
>>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
>> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
>> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>>  
>>  /* lm832x.c */
>>  void lm832x_key_event(DeviceState *dev, int key, int state);
>> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
>> index 1aac457a2a..acf34a12d6 100644
>> --- a/hw/i2c/core.c
>> +++ b/hw/i2c/core.c
>> @@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave = {
>>      }
>>  };
>>  
>> -DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>>  {
>>      DeviceState *dev;
>>  
>>      dev = qdev_new(name);
>>      qdev_prop_set_uint8(dev, "address", addr);
>> -    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
>> +    return dev;
>> +}
>> +
>> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
>> +{
>> +    return qdev_realize_and_unref(dev, &bus->qbus, errp);
>> +}
>> +
>> +DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
>> +{
>> +    DeviceState *dev;
>> +
>> +    dev = i2c_try_create_slave(name, addr);
>> +    i2c_realize_and_unref(dev, bus, &error_fatal);
>> +
>>      return dev;
>>  }
> 
> We use "create_simple" names for functions that allocate, initialize,
> configure and realize device objects: pci_create_simple(),
> isa_create_simple(), usb_create_simple().  Calling this one
> i2c_create_slave() is okay with me.  I'd prefer
> i2c_slave_create_simple(), though.
> 
> We use "new" names for functions that allocate and initialize device
> objects: pci_new(), isa_new(), usb_new().  Let's call this one
> i2c_slave_new().
> 
> Your use of "realize_and_unref" matches existing names elsewhere:
> pci_realize_and_unref(), isa_realize_and_unref(),
> usb_realize_and_unref().  However, the other two i2c functions are
> called i2c_slave_FOO(), not i2c_FOO().  You could name this one
> i2c_slave_realize_and_unref().  Another path to consistency: drop the
> slave_ from all three names.
> 
> Ideally with my naming suggestions considered:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

If you don't mind, as this series is already fully reviewed,
I'll correct/improve on top of it.

Thanks!

Phil.

