Return-Path: <SRS0=AG+E=EA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C56C388F7
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 21:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76738222C3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2020 21:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX5yhQLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76738222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWnG6-0002KK-6z
	for qemu-devel@archiver.kernel.org; Sun, 25 Oct 2020 17:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWnFQ-0001n0-32; Sun, 25 Oct 2020 17:08:16 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWnFN-00013v-Tz; Sun, 25 Oct 2020 17:08:15 -0400
Received: by mail-wr1-x441.google.com with SMTP id h7so10266227wre.4;
 Sun, 25 Oct 2020 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XjWdsZH+f+a88qGHQj2wNal+Pi03yGxVzAUMhQ9x7rk=;
 b=IX5yhQLYjQhP38WpN8eqKy2+cAggioav2MjExsYa7Ku5B5Fa4CYBWvlbYySVYxV75x
 dPzufYuAxg71Qref+4t1hnpEtsVYrA27CmnaC/KVFzH3lQN08XKSeunnKmg/3b/s0NS+
 Y5Sai+eaXocLQidF3VLqQhLqbM3qfUKE+BiuVcnDjPZhYF+uNsTUEJS6YyQ1fsNmrJMl
 xla3cTiTiRl+reezm+BKp9OlE6+Le5r5IcZUYCPSvkqIeGFBdRZZh2T3gKodhwHjodIv
 VT4vHQB1zLIecRrCjyXgRV7a3J5lDYm1s/xuR+I+/YVz0W9bvRQBVU++UnJRLUAC2+Oz
 sg/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XjWdsZH+f+a88qGHQj2wNal+Pi03yGxVzAUMhQ9x7rk=;
 b=OpvT8IBw368MjP+/4j+HNsBbdjFB00yePnHBOLmwfpaiSC2sPdJRtVcSKhoaEtt9OY
 IjzD/FDcta9yncgkMShVfHTR71J9g84fGnbZEU/sJDk9UircWzb+CE9D9dr08M4qGZES
 5dS8twRdCXZLyPVNRHPXwVuZHUq8Nqbrab5EPajgyi62AtYjAAQLxQz+vossEUZAOzdO
 yervB8b3rQ9z2tOlTFcY0Y67LpcDIsGrF9BQcasEhQ30ByX9AQa4HpWzxFKACgqXkM5/
 jgesIJyB9cgWg9M2jJG3FFAPXt2AcT81p+xjHKy3Jv87aYPpXZzwb/MVkQKsIrpa/ViP
 oFuw==
X-Gm-Message-State: AOAM532r++493rNyMwmg2/KrsLZNUu+ZF07jZCfPtvFuaLY2WHP95b6G
 zd5FcV3Oc2FrYoJFBHu0hWsW50XdZTk=
X-Google-Smtp-Source: ABdhPJy+SGJoMTzm9qI4uYCEyxDfDs21j08QSdM+926hg5exTC7zuG063sIY44de5BbrlZmn+m61kA==
X-Received: by 2002:a5d:5743:: with SMTP id q3mr14101936wrw.167.1603660091692; 
 Sun, 25 Oct 2020 14:08:11 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id o186sm18111807wmb.12.2020.10.25.14.08.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2020 14:08:10 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] hw/misc: add an EMC141{3,4} device model
To: John Wang <wangzhiqiang.bj@bytedance.com>, clg@kaod.org,
 xuxiaohan@bytedance.com, yulei.sh@bytedance.com, joel@jms.id.au
References: <20201025131435.144-1-wangzhiqiang.bj@bytedance.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6793bb35-985c-be0f-bfb1-76017dafdd02@amsat.org>
Date: Sun, 25 Oct 2020 22:08:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201025131435.144-1-wangzhiqiang.bj@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/25/20 2:14 PM, John Wang wrote:
> Largely inspired by the TMP421 temperature sensor, here is a model for
> the EMC1413/EMC1414 temperature sensors.
> 
> Specs can be found here :
>    http://ww1.microchip.com/downloads/en/DeviceDoc/20005274A.pdf
> 
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
> ---
> v3:
>    - update the link to the spec
>    - Rename emc1413.c to emc141x.c
>    - Add sensors_count in EMC141XClass
>    - Make emc1413_read/write easier to review :)

Thanks for the update.

> v2:
>    - Remove DeviceInfo
>    - commit message: TMP423 -> TMP421
> ---
>   hw/arm/Kconfig      |   1 +
>   hw/misc/Kconfig     |   4 +
>   hw/misc/emc141x.c   | 347 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/misc/meson.build |   1 +
>   4 files changed, 353 insertions(+)
>   create mode 100644 hw/misc/emc141x.c
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 7d040827af..3dd651a236 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -403,6 +403,7 @@ config ASPEED_SOC
>       select SSI_M25P80
>       select TMP105
>       select TMP421
> +    select EMC141X
>       select UNIMP
>   
>   config MPS2
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 3185456110..169d087d3d 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -13,6 +13,10 @@ config TMP421
>       bool
>       depends on I2C
>   
> +config EMC141X
> +    bool
> +    depends on I2C
> +
>   config ISA_DEBUG
>       bool
>       depends on ISA_BUS
> diff --git a/hw/misc/emc141x.c b/hw/misc/emc141x.c
> new file mode 100644
> index 0000000000..a2bce74719
> --- /dev/null
> +++ b/hw/misc/emc141x.c
> @@ -0,0 +1,347 @@
> +/*
> + * SMSC EMC141X temperature sensor.
> + *
> + * Copyright (c) 2020 Bytedance Corporation
> + * Written by John Wang <wangzhiqiang.bj@bytedance.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 or
> + * (at your option) version 3 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/i2c/i2c.h"
> +#include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "qemu/module.h"
> +#include "qom/object.h"
> +
> +#define EMC1413_DEVICE_ID                0x21
> +#define EMC1414_DEVICE_ID                0x25
> +#define MANUFACTURER_ID                  0x5d
> +#define REVISION                         0x04
> +
> +#define SENSORS_COUNT_MAX    4
> +
> +struct EMC141XState {
> +    I2CSlave i2c;

The QOM style name is 'parent_obj':

        I2CSlave parent_obj;

> +    uint8_t temperature[SENSORS_COUNT_MAX];

What is the unit?

> +    uint8_t min[SENSORS_COUNT_MAX];
> +    uint8_t max[SENSORS_COUNT_MAX];

min/max what? Temperature?

What about (if the unit is milli Celsius):

        struct {
            uint8_t temp_min_mC;
            uint8_t temp_current_mC;
            uint8_t temp_max_mC;
        } sensor[SENSORS_COUNT_MAX];

Looking at the datasheet chapter 6.8 "Temperature Measurement
Results  and  Data", it isn't in milli Celsius. See below in
emc141x_get_temperature().

So maybe:

        struct {
            uint8_t raw_temp_min;
            uint8_t raw_temp_current;
            uint8_t raw_temp_max;
        } sensor[SENSORS_COUNT_MAX];

> +    uint8_t len;
> +    uint8_t data;
> +    uint8_t pointer;
> +};
> +
> +struct EMC141XClass {
> +    I2CSlaveClass parent_class;
> +    uint8_t model;
> +    unsigned sensors_count;
> +};
> +
> +#define TYPE_EMC141X "emc141x"
> +OBJECT_DECLARE_TYPE(EMC141XState, EMC141XClass, EMC141X)
> +
> +
> +/* the EMC141X registers */
> +#define EMC141X_TEMP_HIGH0               0x00
> +#define EMC141X_TEMP_HIGH1               0x01
> +#define EMC141X_TEMP_HIGH2               0x23
> +#define EMC141X_TEMP_HIGH3               0x2a
> +#define EMC141X_TEMP_MAX_HIGH0           0x05
> +#define EMC141X_TEMP_MIN_HIGH0           0x06
> +#define EMC141X_TEMP_MAX_HIGH1           0x07
> +#define EMC141X_TEMP_MIN_HIGH1           0x08
> +#define EMC141X_TEMP_MAX_HIGH2           0x15
> +#define EMC141X_TEMP_MIN_HIGH2           0x16
> +#define EMC141X_TEMP_MAX_HIGH3           0x2c
> +#define EMC141X_TEMP_MIN_HIGH3           0x2d
> +#define EMC141X_DEVICE_ID                0xfd
> +#define EMC141X_MANUFACTURER_ID          0xfe
> +#define EMC141X_REVISION                 0xff
> +
> +static void emc141x_get_temperature(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)

Nitpicking, align is off ;)

> +{
> +    EMC141XState *s = EMC141X(obj);
> +    EMC141XClass *sc = EMC141X_GET_CLASS(s);
> +    int64_t value;
> +    int tempid;

Shouldn't it be unsigned?

> +
> +    if (sscanf(name, "temperature%d", &tempid) != 1) {

Format doesn't match. Using 'unsigned' is probably easier (%u).

> +        error_setg(errp, "error reading %s: %s", name, g_strerror(errno));
> +        return;
> +    }
> +
> +    if (tempid >= sc->sensors_count || tempid < 0) {
> +        error_setg(errp, "error reading %s", name);
> +        return;
> +    }
> +
> +    value = s->temperature[tempid] * 1000;

This is not what is described in "Table 6.2: Temperature Data Format",
there is an offset and a step multiplier. Which makes me wonder how
are you testing this?
We have very simple tests for the TMP105, see tests/qtest/tmp105-test.c,
please add a similar test.

> +
> +    visit_type_int(v, name, &value, errp);
> +}
> +
...

