Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5497AC43467
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C828724747
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHXGLtl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C828724747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSKXs-0004hS-Oc
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 09:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKWY-0003d9-Ez; Tue, 13 Oct 2020 09:39:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSKWW-0002c9-JO; Tue, 13 Oct 2020 09:39:30 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so24084359wrp.10;
 Tue, 13 Oct 2020 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uinevQ0PiRQ2VdGwTLbrHyrt6wQbdsQhLumm8E1/Mok=;
 b=ZHXGLtl5gjcdE6apP62rU/cxYU5RFbzqyM4s6kQhwiR0kd0lIDYzveiEhP2iE0ZnVs
 stiozG1Gz5RSeHEXktnJq14muGm0fPH/MBw/QRWfIAHnKoSdkWyfJfpke8mb/yd+vPK8
 pXrssxid7B0CETtfucuelVCkUYqlhzK1p0v1DQ+mZ+r9RTpDmvwMyC3h0kZPhJIC34xF
 j7aEdX8t+NgT8mrbMQyr93YBGoNQed8bOw9ZkwEutz1rllDKXLML6ZyAo/X6DwCE7bgM
 Lw0VCC3jzlk3Ng4H1FbxO1VTLMdcuat1iiRtLbRwJX7VuSBW9666g1dLebCjPr1b2oY9
 s1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uinevQ0PiRQ2VdGwTLbrHyrt6wQbdsQhLumm8E1/Mok=;
 b=qwZNASUYukh3nLHgSKIQO4WrzInII0c8rPFwuMGIbUy2IpQAsGx29/gGRH5Q6ZphmQ
 gEgGRNCo610HrjaFyTqedLfUMQ780enkWHomKX+B4SoFthFJ7zQraDAPwMx63Y+ImS55
 NGDImTm6Iydo4Jo81i2waMc4F2O3iS8aSyLWj4vUZj8iEkc05KJkr0mtB5byGQ7dSxgu
 vRpQMOE0QFyyqWK+aSBOMzvP8zjjg7+aId+Iljd1HSoJt+2hDoG2fsScIcC58P0bcTHA
 Veac/cuKj8MlMv5tYWZ8f1h7INlmU2VWkv+gNh818veXTHLMW/DGJJ+VqicPi564D4HS
 2LTg==
X-Gm-Message-State: AOAM532SjwI/2kJo01AvUhGgJzv6PHVpFPY2TTp0Y5CT1+L0OYazXnxo
 uXDEeDZlCA1w7a8dk3Ewaqc=
X-Google-Smtp-Source: ABdhPJw869l4V3Pu8pSvF7dBZn0sPC58vwHDeNvg9s0fMdAxI8clnXSLDa3gGiot/UkTFXllkhJlIg==
X-Received: by 2002:adf:e70a:: with SMTP id c10mr35177344wrm.425.1602596366026; 
 Tue, 13 Oct 2020 06:39:26 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id u6sm1283736wmj.40.2020.10.13.06.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 06:39:25 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] uninorth: use qdev gpios for PCI IRQs
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8a15d151-51ac-8e1b-23e7-e593ae394975@amsat.org>
Date: Tue, 13 Oct 2020 15:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013114922.2946-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 1:49 PM, Mark Cave-Ayland wrote:
> Currently an object link property is used to pass a reference to the OpenPIC
> into the PCI host bridge so that pci_unin_init_irqs() can connect the PCI
> IRQs to the PIC itself.
> 
> This can be simplified by defining the PCI IRQs as qdev gpios and then wiring
> up the PCI IRQs to the PIC in the New World machine init function.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/pci-host/uninorth.c         | 45 +++++++---------------------------
>   hw/ppc/mac_newworld.c          | 24 ++++++++++++------
>   include/hw/pci-host/uninorth.h |  2 --
>   3 files changed, 25 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

