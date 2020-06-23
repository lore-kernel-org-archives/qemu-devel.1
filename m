Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE2AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:08:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0032072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfS36JJT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0032072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jngml-0006rN-In
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jngll-0005Yn-TZ; Tue, 23 Jun 2020 07:07:13 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnglk-00087j-2G; Tue, 23 Jun 2020 07:07:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id q5so7674676wru.6;
 Tue, 23 Jun 2020 04:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MIB4wGWnrxzNvDMpgsQ3/CQS8HsCRBZ2iK7yUj4UOr8=;
 b=kfS36JJTCnFpF9e71LLgv1K90BcJeBdKLxhgPXPYDxhqHV1Ycou7PK0SNpRL9kfL3I
 bTg7rH5MkvnQCVoHHA4QP8ryxrQXhcQSFOaFc+EnAMWlJT3ftX50lDdQ1jVZ2YQ3vbbj
 MjkWlnVduB95IyeGbM8HR8MuVRDSUsgVGCks68/KcKHmZUsIRjVi/I6DwksI9V5AM4rW
 /vZvb36PdI1GCrah2rAEOstc+9DK3Rpz+R67s6osrhaIBSIuEty+Um6GEoYgwUY8LuuC
 6Hg2cxrSmzN914W8LdXhUCoOQuwQG/sopZjtx1JR5nn9MCYz+wZ19t9vM1QfcU582GVM
 IBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MIB4wGWnrxzNvDMpgsQ3/CQS8HsCRBZ2iK7yUj4UOr8=;
 b=meJhGSN04/3p05eW78N5bg0qbZan7EOtUhsyRei6YekPmb3XNDAZKyQpYK1UnQk3qm
 4OEL5YCsEl4HaVHFc7OK9EDWW7Wij1wbouZTW/BnKZ3WSANrimwH2aMykyGqJ/fLYrMZ
 BUlaB686q1yttg8hwyK866a8HDQXNpxiZfuPSAnR4TwUYq09U8HpjDUgz+yugmNTNgIt
 HcuCS15FLI7KReALXlqOKX8Tcj+kODGHlfClf2OgaUqcG8gApghzLd4H0KfiYlcytNaE
 +Z6ctSi+sDKSMyawZcx5PpeDcKqEgoHMZzGoMMgCPaj4Bzc+FV3RD5Rhd+B/ir7n4D8H
 xfMw==
X-Gm-Message-State: AOAM531KWv4oECK71kQK+TKo5sut2AeH/qfW7AKMylxjs6ArmkAUanSa
 DOdL15DjjLGT77roD/oMYZcxnqno
X-Google-Smtp-Source: ABdhPJxQ8WeoqEMLLN6egpomSyqvvV9BqzD0kZV8rzAoMBraOc6P+zU1VBrzqB6QGd8I2hLEpxa11Q==
X-Received: by 2002:a05:6000:4e:: with SMTP id
 k14mr11732785wrx.157.1592910430300; 
 Tue, 23 Jun 2020 04:07:10 -0700 (PDT)
Received: from [192.168.1.41] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id i19sm15975270wrb.56.2020.06.23.04.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 04:07:09 -0700 (PDT)
Subject: Re: [PATCH v6 1/9] hw/i2c/core: Add i2c_try_create_slave() and
 i2c_realize_and_unref()
To: qemu-devel@nongnu.org
References: <20200623072723.6324-1-f4bug@amsat.org>
 <20200623072723.6324-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ab054e7d-a78f-8b38-f4d6-93cda08e1a62@amsat.org>
Date: Tue, 23 Jun 2020 13:07:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200623072723.6324-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/23/20 9:27 AM, Philippe Mathieu-Daudé wrote:
> Extract i2c_try_create_slave() and i2c_realize_and_unref()
> from i2c_create_slave().
> We can now set properties on a I2CSlave before it is realized.
> 
> This is in line with the recent qdev/QOM changes merged
> in commit 6675a653d2e.
> 
> Reviewed-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

Collecting Markus review on v5:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg07060.html

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Cc: Markus Armbruster <armbru@redhat.com>
> ---
>  include/hw/i2c/i2c.h |  2 ++
>  hw/i2c/core.c        | 18 ++++++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index 4117211565..d6e3d85faf 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -80,6 +80,8 @@ int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
>  
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr);
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr);
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp);
>  
>  /* lm832x.c */
>  void lm832x_key_event(DeviceState *dev, int key, int state);
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index 1aac457a2a..acf34a12d6 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -267,13 +267,27 @@ const VMStateDescription vmstate_i2c_slave = {
>      }
>  };
>  
> -DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> +DeviceState *i2c_try_create_slave(const char *name, uint8_t addr)
>  {
>      DeviceState *dev;
>  
>      dev = qdev_new(name);
>      qdev_prop_set_uint8(dev, "address", addr);
> -    qdev_realize_and_unref(dev, &bus->qbus, &error_fatal);
> +    return dev;
> +}
> +
> +bool i2c_realize_and_unref(DeviceState *dev, I2CBus *bus, Error **errp)
> +{
> +    return qdev_realize_and_unref(dev, &bus->qbus, errp);
> +}
> +
> +DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t addr)
> +{
> +    DeviceState *dev;
> +
> +    dev = i2c_try_create_slave(name, addr);
> +    i2c_realize_and_unref(dev, bus, &error_fatal);
> +
>      return dev;
>  }
>  
> 

