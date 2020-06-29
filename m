Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493ACC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15D7F206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpi61gGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15D7F206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq1Py-0007WP-9Q
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jq1MA-0003tW-Np; Mon, 29 Jun 2020 17:30:26 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1jq1M9-000567-0x; Mon, 29 Jun 2020 17:30:26 -0400
Received: by mail-ot1-x342.google.com with SMTP id n24so14558054otr.13;
 Mon, 29 Jun 2020 14:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=B66j+rKnQarXai1h5Y0W9zZJrWfgDomU4kabiLcDpkk=;
 b=kpi61gGhHEf+wZ+vfBqmClkBZzbsp33FxYtHd580uZ9xdYSOSRh1y048pz0dz0OsXn
 i8u3UOWRYo4HMo84EiF4rNn68KJV3AEuxO3SrgROlECcujhKtXZO6Gf1h2OIDcEZeUoD
 TeKt3kksykvurWQtHi3oYRkW/NhWyllEXkIjwR6RZXM7sNhE0dRS9eA6TJQ+3Wod2GLs
 TmBtT+5gUFYSsN1XAX7aUbGtwIm/Bh7azabY+j3wNWZ5eLsK0ULGkZdGh2YqIeYIHi3R
 /8Q8f6lTbh/8P/+RfIetJbyoeV58i43EK739nEY3gyFjMPMEf8g+/PMYxFxBJky33NrQ
 ERDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=B66j+rKnQarXai1h5Y0W9zZJrWfgDomU4kabiLcDpkk=;
 b=fyF/gExJ8oOUuklWgizSErOCq8rG82qYAJXqowA6fJIBPv1MQrPOtVHnLaW9oE43He
 fNvYr3orOUmfpQdNORpU+hIVY9PhdNAxlpO1ujXm39op+DGX4n2/D6+2rSlCVOUP7hkV
 IY8XxEuCSRDYHynitWbpbmRbe2pZeaJ+NDnbOUrMJBHsSHpN0SUYFvNEhIp+jNp3Pt4h
 N2x2R4A8X2+xcnQmbEvT5SeUaMsOJCbZ0bEoypw0he1cGD2WeDvCAuA7k2bOVmn9fhvB
 YPY1sRgZlWwHKjxOCPP8Ll/HT1KrXFTV3RjU7+iBTIuaWcujwNeo4F93xupFd8xQjwRf
 L3FQ==
X-Gm-Message-State: AOAM531FvrqYCzhXMkn3KOMEIRySC79kDeLchvTR54ErWWkOJRgVJx/G
 /bRupjGTglIz/hoFJtb29Q==
X-Google-Smtp-Source: ABdhPJw/jdWfBmQTOsylcIEPhUw82TWHZlUNu1IE6pL4Rc2Arc3UGWPiUm/sOCz+9Ougj4ByVxeUKQ==
X-Received: by 2002:a9d:7f8d:: with SMTP id t13mr2821489otp.67.1593466223114; 
 Mon, 29 Jun 2020 14:30:23 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id y7sm261637oov.26.2020.06.29.14.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 14:30:22 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:9993:aaf8:7c5:309c])
 by serve.minyard.net (Postfix) with ESMTPSA id B433C18003B;
 Mon, 29 Jun 2020 21:30:21 +0000 (UTC)
Date: Mon, 29 Jun 2020 16:30:20 -0500
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 5/5] hw/i2c: Document the I2C qdev helpers
Message-ID: <20200629213020.GU3235@minyard.net>
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-6-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629173821.22037-6-f4bug@amsat.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=tcminyard@gmail.com; helo=mail-ot1-x342.google.com
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
Reply-To: minyard@acm.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 29, 2020 at 07:38:21PM +0200, Philippe Mathieu-Daudé wrote:
> In commit d88c42ff2c we added new prototype but neglected to
> add their documentation. Fix that.

Reviewed-by: Corey Minyard <cminyard@mvista.com>

> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/i2c/i2c.h | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/include/hw/i2c/i2c.h b/include/hw/i2c/i2c.h
> index c533058998..fcc61e509b 100644
> --- a/include/hw/i2c/i2c.h
> +++ b/include/hw/i2c/i2c.h
> @@ -79,8 +79,56 @@ int i2c_send_recv(I2CBus *bus, uint8_t *data, bool send);
>  int i2c_send(I2CBus *bus, uint8_t data);
>  uint8_t i2c_recv(I2CBus *bus);
>  
> +/**
> + * Create an I2C slave device on the heap.
> + * @name: a device type name
> + * @addr: I2C address of the slave when put on a bus
> + *
> + * This only initializes the device state structure and allows
> + * properties to be set. Type @name must exist. The device still
> + * needs to be realized. See qdev-core.h.
> + */
>  I2CSlave *i2c_slave_new(const char *name, uint8_t addr);
> +
> +/**
> + * Create an I2C slave device on the heap.
> + * @bus: I2C bus to put it on
> + * @name: I2C slave device type name
> + * @addr: I2C address of the slave when put on a bus
> + *
> + * Create the device state structure, initialize it, put it on the
> + * specified @bus, and drop the reference to it (the device is realized).
> + * Any error aborts the process.
> + */
>  I2CSlave *i2c_slave_create_simple(I2CBus *bus, const char *name, uint8_t addr);
> +
> +/**
> + * i2c_slave_realize_and_unref: realize and unref an I2C slave device
> + * @dev: I2C slave device to realize
> + * @bus: I2C bus to put it on
> + * @addr: I2C address of the slave on the bus
> + * @errp: error pointer
> + *
> + * Call 'realize' on @dev, put it on the specified @bus, and drop the
> + * reference to it. Errors are reported via @errp and by returning
> + * false.
> + *
> + * This function is useful if you have created @dev via qdev_new(),
> + * i2c_slave_new() or i2c_slave_try_new() (which take a reference to
> + * the device it returns to you), so that you can set properties on it
> + * before realizing it. If you don't need to set properties then
> + * i2c_slave_create_simple() is probably better (as it does the create,
> + * init and realize in one step).
> + *
> + * If you are embedding the I2C slave into another QOM device and
> + * initialized it via some variant on object_initialize_child() then
> + * do not use this function, because that family of functions arrange
> + * for the only reference to the child device to be held by the parent
> + * via the child<> property, and so the reference-count-drop done here
> + * would be incorrect.  (Instead you would want i2c_slave_realize(),
> + * which doesn't currently exist but would be trivial to create if we
> + * had any code that wanted it.)
> + */
>  bool i2c_slave_realize_and_unref(I2CSlave *dev, I2CBus *bus, Error **errp);
>  
>  /* lm832x.c */
> -- 
> 2.21.3
> 
> 

