Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BCEC73C66
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 02:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6871620C01
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 02:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apdr3z8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6871620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmqqp-0000D0-JN
	for qemu-devel@archiver.kernel.org; Sun, 14 Jul 2019 22:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60578)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hmqqe-0008EC-6t
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 22:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hmqqc-00020K-6d
 for qemu-devel@nongnu.org; Sun, 14 Jul 2019 22:36:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46489)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hmqqX-0001yH-TU; Sun, 14 Jul 2019 22:36:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id c73so6681133pfb.13;
 Sun, 14 Jul 2019 19:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=YkKJL6KE7wRWUE2QVBwjSYI4/EogbW9lXJJC12v8RVk=;
 b=Apdr3z8Avkdsrvsu/CwN/ZsupsmMmo2CoG2xkBo9AOyZuIUTbba6Nc7dtYrf811ED+
 Eq0Sp+1uQHmraztFT8RfS9zZkVDscUGR2k38ChILgKBXBVKwy94zni1g2OjZC5adDF4y
 i6zVE2ap2/KfhlF+EsWlvamfeEXTNMRs9w8HzhrI76VN+OJVvZAROWL5fe+V5MCaZ7HN
 sNNm3t49Mo5zqrKouhWjMRWFmp+0NVST1ElQxh7WS1aXBFdYHpo01AN2PEV6l8ao8gre
 kdejqg37bsn2jGpt8bJ0UZmrDKfmpL1ozK2RnCl4zttEcHuNBGlx7DYJk/1B/eALsGkX
 H1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=YkKJL6KE7wRWUE2QVBwjSYI4/EogbW9lXJJC12v8RVk=;
 b=NePAEzUBw+wq8T/bqM7dBmNMDFjTy+oSijh19LOpo5Vs03+d1B3RPRzOfTN5QqDCES
 cdv8hUsf2x2B0Ge1OBAqDmXgfG3kwbSeMJqfkrdCLSYHIT/XGNZmCUsCIZfabwLbP9uB
 shusITrxn7UAAEaX8DviqKXeQD+8I5XqlFISAquHZRU3SB7WbyUvIsTG+RLtDknR0SOr
 BgqHsTOtDizlJdf1VxpDmI2B8g06/XWICQTPPVcQBxM9zSNmKI8zcTNt17vUA4mlZYHS
 yzULmm4cfUaAJhJ57dT1gWe2T3nB2l+e6ibMXWur3Il1bGaK5sEdqCUsdQx1b+5+Yk5v
 HSWA==
X-Gm-Message-State: APjAAAXEDCESnlixSLQJjr8fqF8YFuYXfdzOet17i3nRd4yur2ZZXXEo
 QQh398kjok9fggV2lNOopQA=
X-Google-Smtp-Source: APXvYqzsgnMRQXQbmDovGkj5hjgP/CqKUQ8gTCk+y/oouWa58L5JNjRIES6HCf+V+nyfWlbvAKSjLA==
X-Received: by 2002:a63:1d0e:: with SMTP id d14mr24334512pgd.324.1563158167990; 
 Sun, 14 Jul 2019 19:36:07 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id d8sm10987917pgh.45.2019.07.14.19.36.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 19:36:07 -0700 (PDT)
Message-ID: <587f2424881cbb5a5cc927d220f64375d6414cc0.camel@gmail.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
Date: Mon, 15 Jul 2019 12:36:02 +1000
In-Reply-To: <63f23f7c-a096-438d-9ad7-7e6ffae879c1@www.fastmail.com>
References: <20190618085154.21498-1-rashmica.g@gmail.com>
 <20190618085154.21498-2-rashmica.g@gmail.com>
 <63f23f7c-a096-438d-9ad7-7e6ffae879c1@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/gpio: Add basic Aspeed GPIO model
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
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sorry for the late reply! I agree with most of your feedback and will
send out
a v2 shortly with those changes. I have a few replies below

[snip]

> > +static const struct AspeedGPIO gpios[0x1f0] = {
> > +    /* Set ABCD */
> > +    [GPIO_ABCD_DATA_VALUE] = {0, read_data_value,
> > _write_data_value},
> 
> Maybe there would be less tedium (and risk of minor bugs) here if we
> add
> a table for looking up the read/write callbacks from a type, and just
> stash
> the type in struct AspeedGPIO (or a pointer to the corresponding type
> ops),
> e.g:
> 
> enum gpio_property { gpio_direction = 0, gpio_int_enable, ... };
> 
> struct aspeed_gpio_reg_ops {
>     int (*read)(...);
>     int (*write)(...);
> };
> 
> struct aspeed_gpio_reg_ops gpio_reg_ops[] = {
>     [gpio_direction]  = { .read = read_direction, .write =
> write_direction };
>     ...
> };
> 
> Then we have:
> 
> static const struct AspeedGPIO gpios[...] = {
>      [GPIO_ABCD_DIRECTION] = { .set = 0, .type = gpio_direction },
>      ...
> };
> 
> Not wedded to the idea, just thinking out loud. What do you think?
> 

I'm not a huge fan of the extra indirection. It is less error prone but
is this a place that is likely to be updated regularly?


> > +    [GPIO_ABCD_DIRECTION] = {0, read_direction, _write_direction},
> > +    [GPIO_ABCD_INT_ENABLE] = {0, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_ABCD_INT_SENS_0] = {0, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_ABCD_INT_SENS_1] = {0, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_ABCD_INT_SENS_2] = {0, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_ABCD_INT_STATUS] = {0, read_int_status,
> > _write_int_status},
> > +    [GPIO_ABCD_RESET_TOLERANT] = {0, read_reset_tol,
> > _write_reset_tol},
> > +    [GPIO_ABCD_DEBOUNCE_1] = {0, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_ABCD_DEBOUNCE_2] = {0, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_ABCD_COMMAND_SRC_0] = {0, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_ABCD_COMMAND_SRC_1] = {0, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_ABCD_DATA_READ] = {0, read_data, NULL},
> > +    [GPIO_ABCD_INPUT_MASK] = {0, read_input_mask,
> > _write_input_mask},
> > +    /* Set EFGH */
> > +    [GPIO_EFGH_DATA_VALUE] = {1, read_data_value,
> > _write_data_value},
> > +    [GPIO_EFGH_DIRECTION] = {1, read_direction, _write_direction
> > },
> > +    [GPIO_EFGH_INT_ENABLE] = {1, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_EFGH_INT_SENS_0] = {1, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_EFGH_INT_SENS_1] = {1, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_EFGH_INT_SENS_2] = {1, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_EFGH_INT_STATUS] = {1, read_int_status,
> > _write_int_status},
> > +    [GPIO_EFGH_RESET_TOL] = {1,
> > read_reset_tol,   _write_reset_tol},
> > +    [GPIO_EFGH_DEBOUNCE_1] = {1,
> > read_debounce_1,  _write_debounce_1},
> > +    [GPIO_EFGH_DEBOUNCE_2] = {1,
> > read_debounce_2,  _write_debounce_2},
> > +    [GPIO_EFGH_COMMAND_SRC_0] = {1, read_cmd_source_0,  
> > _write_cmd_source_0},
> > +    [GPIO_EFGH_COMMAND_SRC_1] = {1, read_cmd_source_1,  
> > _write_cmd_source_1},
> > +    [GPIO_EFGH_DATA_READ] = {1, read_data, NULL},
> > +    [GPIO_EFGH_INPUT_MASK] = {1,
> > read_input_mask,  _write_input_mask},
> > +    /* Set IJKL */
> > +    [GPIO_IJKL_DATA_VALUE] = {2, read_data_value,
> > _write_data_value},
> > +    [GPIO_IJKL_DIRECTION] = {2, read_direction, _write_direction},
> > +    [GPIO_IJKL_INT_ENABLE] = {2, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_IJKL_INT_SENS_0] = {2, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_IJKL_INT_SENS_1] = {2, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_IJKL_INT_SENS_2] = {2, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_IJKL_INT_STATUS] = {2, read_int_status,
> > _write_int_status},
> > +    [GPIO_IJKL_RESET_TOLERANT] = {2, read_reset_tol,
> > _write_reset_tol},
> > +    [GPIO_IJKL_DEBOUNCE_1] = {2, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_IJKL_DEBOUNCE_2] = {2, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_IJKL_COMMAND_SRC_0] = {2, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_IJKL_COMMAND_SRC_1] = {2, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_IJKL_DATA_READ] = {2, read_data, NULL},
> > +    [GPIO_IJKL_INPUT_MASK] = {2, read_input_mask,
> > _write_input_mask},
> > +    /* Set MNOP */
> > +    [GPIO_MNOP_DATA_VALUE] = {3, read_data_value,
> > _write_data_value},
> > +    [GPIO_MNOP_DIRECTION] = {3, read_direction, _write_direction},
> > +    [GPIO_MNOP_INT_ENABLE] = {3, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_MNOP_INT_SENS_0] = {3, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_MNOP_INT_SENS_1] = {3, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_MNOP_INT_SENS_2] = {3, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_MNOP_INT_STATUS] = {3, read_int_status,
> > _write_int_status},
> > +    [GPIO_MNOP_RESET_TOLERANT] = {3, read_reset_tol,  
> > _write_reset_tol},
> > +    [GPIO_MNOP_DEBOUNCE_1] = {3, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_MNOP_DEBOUNCE_2] = {3, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_MNOP_COMMAND_SRC_0] = {3, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_MNOP_COMMAND_SRC_1] = {3, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_MNOP_DATA_READ] = {3, read_data, NULL},
> > +    [GPIO_MNOP_INPUT_MASK] = {3, read_input_mask,
> > _write_input_mask},
> > +    /* Set QRST */
> > +    [GPIO_QRST_DATA_VALUE] = {4, read_data_value,
> > _write_data_value},
> > +    [GPIO_QRST_DIRECTION] = {4, read_direction, _write_direction},
> > +    [GPIO_QRST_INT_ENABLE] = {4, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_QRST_INT_SENS_0] = {4, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_QRST_INT_SENS_1] = {4, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_QRST_INT_SENS_2] = {4, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_QRST_INT_STATUS] = {4, read_int_status,
> > _write_int_status},
> > +    [GPIO_QRST_RESET_TOLERANT] = {4, read_reset_tol,
> > _write_reset_tol},
> > +    [GPIO_QRST_DEBOUNCE_1] = {4, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_QRST_DEBOUNCE_2] = {4, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_QRST_COMMAND_SRC_0] = {4, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_QRST_COMMAND_SRC_1] = {4, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_QRST_DATA_READ] = {4, read_data, NULL},
> > +    [GPIO_QRST_INPUT_MASK] = {4,
> > read_input_mask,  _write_input_mask},
> > +    /* Set UVWX */
> > +    [GPIO_UVWX_DATA_VALUE] = {5, read_data_value,
> > _write_data_value},
> > +    [GPIO_UWVX_DIRECTION] = {5, read_direction, _write_direction},
> > +    [GPIO_UVWX_INT_ENABLE] = {5, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_UVWX_INT_SENS_0] = {5, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_UVWX_INT_SENS_1] = {5, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_UVWX_INT_SENS_2] = {5, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_UVWX_INT_STATUS] = {5, read_int_status,
> > _write_int_status},
> > +    [GPIO_UVWX_RESET_TOLERANT] = {5, read_reset_tol,
> > _write_reset_tol},
> > +    [GPIO_UVWX_DEBOUNCE_1] = {5, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_UVWX_DEBOUNCE_2] = {5, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_UVWX_COMMAND_SRC_0] = {5, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_UVWX_COMMAND_SRC_1] = {5, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_UVWX_DATA_READ] = {5, read_data, NULL},
> > +    [GPIO_UVWX_INPUT_MASK] = {5, read_input_mask,
> > _write_input_mask},
> > +    /* Set YZAAAB */
> > +    [GPIO_YZAAAB_DATA_VALUE] = {6, read_data_value,
> > _write_data_value},
> > +    [GPIO_YZAAAB_DIRECTION] = {6, read_direction,
> > _write_direction},
> > +    [GPIO_YZAAAB_INT_ENABLE] = {6, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_YZAAAB_INT_SENS_0] = {6, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_YZAAAB_INT_SENS_1] = {6, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_YZAAAB_INT_SENS_2] = {6, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_YZAAAB_INT_STATUS] = {6, read_int_status,
> > _write_int_status},
> > +    [GPIO_YZAAAB_RESET_TOLERANT] = {6, read_reset_tol, 
> > _write_reset_tol},
> > +    [GPIO_YZAAAB_DEBOUNCE_1] = {6, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_YZAAAB_DEBOUNCE_2] = {6, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_YZAAAB_COMMAND_SRC_0] = {6, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_YZAAAB_COMMAND_SRC_1] = {6, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_YZAAAB_DATA_READ] = {6, read_data, NULL},
> > +    [GPIO_YZAAAB_INPUT_MASK] = {6, read_input_mask,
> > _write_input_mask},
> > +    /* Set AC */
> > +    [GPIO_AC_DATA_VALUE] = {7, read_data_value,
> > _write_data_value},
> > +    [GPIO_AC_DIRECTION] = {7, read_direction, _write_direction},
> > +    [GPIO_AC_INT_ENABLE] = {7, read_int_enable,
> > _write_int_enable},
> > +    [GPIO_AC_INT_SENS_0] = {7, read_int_sens_0,
> > _write_int_sens_0},
> > +    [GPIO_AC_INT_SENS_1] = {7, read_int_sens_1,
> > _write_int_sens_1},
> > +    [GPIO_AC_INT_SENS_2] = {7, read_int_sens_2,
> > _write_int_sens_2},
> > +    [GPIO_AC_INT_STATUS] = {7, read_int_status,
> > _write_int_status},
> > +    [GPIO_AC_RESET_TOLERANT] = {7, read_reset_tol,
> > _write_reset_tol},
> > +    [GPIO_AC_DEBOUNCE_1] = {7, read_debounce_1,
> > _write_debounce_1},
> > +    [GPIO_AC_DEBOUNCE_2] = {7, read_debounce_2,
> > _write_debounce_2},
> > +    [GPIO_AC_COMMAND_SRC_0] = {7, read_cmd_source_0, 
> > _write_cmd_source_0},
> > +    [GPIO_AC_COMMAND_SRC_1] = {7, read_cmd_source_1, 
> > _write_cmd_source_1},
> > +    [GPIO_AC_DATA_READ] = {7, read_data, NULL},
> > +    [GPIO_AC_INPUT_MASK] = {7,
> > read_input_mask,     _write_input_mask},
> > +    /* Debounce registers */
> > +    [GPIO_DEBOUNCE_TIME_1] = {-1, NULL, NULL},
> > +};
> > +
> > +static uint64_t aspeed_gpio_read(void *opaque, hwaddr offset,
> > uint32_t 
> > size)
> > +{
> > +    AspeedGPIOState *s = ASPEED_GPIO(opaque);
> > +    uint32_t val = 0;
> > +
> > +    if (size != 4) {
> > +        return 0;
> > +    }
> > +
> > +    if (gpios[offset].get == NULL) {
> 
> With the AST2600 we might need to make gpios class-specific rather
> than
> a static global to the compilation unit (to deal with the 1.8V GPIO
> registers
> later in the address-space). Not sure though, haven't thought about
> it for
> more than this paragraph.


Yup, I agree. Still trying to sort out a nice way to deal with the
AST2600 differences so I figured I'd leave it like this for now? 

> 
> > +        qemu_log_mask(LOG_GUEST_ERROR, "no getter for offset
> > %lx", 
> > offset);
> 
> Really this is a model error. We should only encounter it if we
> haven't
> completely described the controller. So maybe it should be an assert
> or some kind of non-guest warning?
>

I don't think this is quite true. There are values in the gpio memory
space
that do not have a register associated with them, ie registers with
offsets 0x138 and 0x140 exist, but there is no 0x13c. So if the
kernel tries to access this address, this isn't really a gpio model
error? 


> > +        return 0;
> > +    }
> > +
> > +    val = gpios[offset].get(&s->sets[gpios[offset].set_idx]);
> 
> The indexing here is starting to get a bit hard to follow. I think we
> could
> improve readability by introducing some locals, and rewriting in
> terms
> of those:
> 
> const struct AspeedGPIO *reg = &gpios[offset];
> const struct GPIORegs *set = &s->sets[gpio.set_idx];
> 
> if (!reg.get) {
>     ...
> }
> 
> val = reg.get(set);
> 
> I think it makes the relationship of the structs a bit clearer too,
> and I think
> it also suggests we could improve the names:
> 
> s/struct AspeedGPIO/struct AspeedGPIOReg/
> s/struct GPIORegs/struct GPIOProperties/
> 

I agree with the local variables, and renaming AspeedGPIO-
>AspeedGPIOReg
but I think GPIOSet makes more sense than GPIOProperties.



> GPIOProperties clashes a bit with GPIOSetProperties though, so maybe
> we
> need to think of a better name for that too?
> 
> > +    return (uint64_t) val;
> > +}
> > +
> > +static void aspeed_gpio_write(void *opaque, hwaddr offset,
> > uint64_t 
> > data,
> > +static GPIOSetProperties ast2400_set_props[] = {
	
[snip]

> > +    [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
> > +    [1] = {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
> > +    [2] = {0xffffffff,  0xffffffff,  {"I", "J", "K", "L"} },
> > +    [3] = {0xffffffff,  0xffffffff,  {"M", "N", "O", "P"} },
> > +    [4] = {0xffffffff,  0xffffffff,  {"Q", "R", "S", "T"} },
> > +    [5] = {0xffffffff,  0x0000ffff,  {"U", "V", "W", "X"} },
> > +    [6] = {0x0000000f,  0x0fffff0f,  {"Y", "Z", "AA", "AB"} },
> > +};
> > +
> > +static GPIOSetProperties ast2500_set_props[] = {
> > +    [0] = {0xffffffff,  0xffffffff,  {"A", "B", "C", "D"} },
> > +    [1] = {0xffffffff,  0xffffffff,  {"E", "F", "G", "H"} },
> > +    [2] = {0xffffffff,  0xffffffff,  {"I", "J", "K", "L"} },
> > +    [3] = {0xffffffff,  0xffffffff,  {"M", "N", "O", "P"} },
> > +    [4] = {0xffffffff,  0xffffffff,  {"Q", "R", "S", "T"} },
> > +    [5] = {0xffffffff,  0x0000ffff,  {"U", "V", "W", "X"} },
> > +    [6] = {0xffffff0f,  0x0fffff0f,  {"Y", "Z", "AA", "AB"} },
> > +    [7] = {0x000000ff,  0x000000ff,  {"AC"} },
> > +};
> > +
> > +static AspeedGPIOController controllers[] = {
> > +    {
> > +        .name           = TYPE_ASPEED_GPIO "-ast2500",
> > +        .props          = ast2500_set_props,
> > +        .nr_gpio_pins   = 228,
> > +        .nr_gpio_sets   = 8,
> > +        .gap            = 220,
> > +    }, {
> > +        .name           = TYPE_ASPEED_GPIO "-ast2400",
> > +        .props          = ast2400_set_props,
> > +        .nr_gpio_pins   = 216,
> > +        .nr_gpio_sets   = 7,
> > +        .gap            = 196,
> > +    }
> > +};
> > +
> > +static const TypeInfo aspeed_gpio_info = {
> > +    .name = TYPE_ASPEED_GPIO,
> > +    .parent = TYPE_SYS_BUS_DEVICE,
> > +    .instance_size = sizeof(AspeedGPIOState),
> > +    .class_size     = sizeof(AspeedGPIOClass),
> > +    .instance_init = aspeed_gpio_init,
> > +    .abstract       = true,
> > +};
> > +
> > +static void aspeed_gpio_register_types(void)
> > +{
> > +    int i;
> > +
> > +    type_register_static(&aspeed_gpio_info);
> > +    for (i = 0; i < ARRAY_SIZE(controllers); i++) {
> > +        TypeInfo t = {
> > +            .name = controllers[i].name,
> > +            .parent = TYPE_ASPEED_GPIO,
> > +            .class_init = aspeed_gpio_class_init,
> > +            .class_data = (void *)&controllers[i],
> > +        };
> > +        type_register(&t);
> > +    };
> 
> I think we want separate classes for the 2400 and 2500, especially
> with
> the 2600 on the way.

I thought this was defining seperate classes that just happen to have
the same init function? I don't fully grasp classes in qemu yet, so
likely to be wrong :) 



