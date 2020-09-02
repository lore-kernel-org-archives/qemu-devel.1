Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC8DC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:27:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4736D20829
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jv33P+4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4736D20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRrR-0000YT-Cw
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDRqW-0007xv-Bm; Wed, 02 Sep 2020 08:26:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38144)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDRqU-00036t-N8; Wed, 02 Sep 2020 08:26:36 -0400
Received: by mail-wr1-x442.google.com with SMTP id g4so4536310wrs.5;
 Wed, 02 Sep 2020 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lV4TsDfxVdncS0hihVVEcQkF+phPF2SxR9yJGcmFyyg=;
 b=Jv33P+4qkDuP388Biz1Gg2JtfkYKpjQSA+fEhRgw4Umj2HMhkmG0ahtO+oi7F/HDXu
 eS5vWRhcLxzdN+gNYE3DHhpDhpSlF70brqFi7eIRLvQIWyb5QFgpQ2znFjOewiQRcFjK
 2efCpaY/0lFNxcVKPysK4ttFhmtJsfxKh2iPPor9K2ulARt34nmfH5IixvxAlq//kMop
 T59+Hgc9B0LmskYmxOLm51j0tUMQtxkfJltW0d869xUBwpvi0D+JIBE1Sm3BO+ip/eOE
 dxqspDyuQjn1oNDIALC8NPPE+Z1t4NCfLtTtcS5/rlAQ0qFQ6kP/0HU4OvtEUCjzPDV6
 pg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lV4TsDfxVdncS0hihVVEcQkF+phPF2SxR9yJGcmFyyg=;
 b=kQwDBqoiYK2TDfLcXY99zfjNUbHQHarBlVK+vQK12AXm4ifdflUQuelYv5ZmMv53E/
 MTbbhsmYd1/HZMN4rVYI1TrlZIBLos8tqEia7lKFK80ylYw5VFczl5MQk4KskQAdlDU4
 FNX4pkQpvj2JXEc6JBNsnYIbJx67wQQ3cIyK29JIlQcQ7eruhXm21PWzyhrSTVneFfS1
 xvQqtEZapOnkTkZcJbzYWZK1aIZR7ejL8z5TTVkgIcyJ0uhBPOtzUPOn8aqHNq9Z+1sf
 zAcgzCOFPwyl9Z2EADP6CXa/FGkD3GexXYOZ1e7wnQtbg1A1BcAVECCGWcI2DDmz+xw8
 DaUw==
X-Gm-Message-State: AOAM531k1j9/txmtw5YZbZx4yWpovG6Jj9ivfKkakKl+OgXUh7/+EqcR
 y9Xd95ZNpA0cOqzklcn7+cM=
X-Google-Smtp-Source: ABdhPJztYRCQMR6qA4IarZPnlwxw+DP4y7Q/jsN0XoQPt7h5V1ahKRm4OsHqX7ZEc6qKYGNm+DqH0A==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr6921070wrw.223.1599049592875; 
 Wed, 02 Sep 2020 05:26:32 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q3sm5924110wmq.12.2020.09.02.05.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 05:26:32 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/net/opencores_eth: Trivial patches
To: qemu-devel@nongnu.org
References: <20200608091508.19838-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e472244f-d764-6cd6-70cd-86d71358b999@amsat.org>
Date: Wed, 2 Sep 2020 14:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200608091508.19838-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-0.324,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 11:15 AM, Philippe Mathieu-Daudé wrote:
> Remove unnecessary mask, use #define instead of magic.
> 
> Philippe Mathieu-Daudé (2):
>   hw/net/opencores_eth: Use definitions instead of magic values
>   hw/net/opencores_eth: Remove unnecessary address masking
> 
>  hw/net/opencores_eth.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Ping to Jason as the series is reviewed :)

