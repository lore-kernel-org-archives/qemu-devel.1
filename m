Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC72C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:16:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFE06208FE
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 07:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHBy8mP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFE06208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kU2vx-0007rY-TK
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 03:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2us-0007EH-Oy; Sun, 18 Oct 2020 03:15:42 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kU2ur-0003Sm-Bu; Sun, 18 Oct 2020 03:15:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id b8so7949540wrn.0;
 Sun, 18 Oct 2020 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/gWrBmnCYPRzDH5K0e4VKLVPWF8tYeeAsskgSJxi1b0=;
 b=pHBy8mP1vPkLRMoCPfFF/ZZaWIp3Ou+9AXMKEsYO4IDXDhILeZMDa1blsfIqBOhtRY
 0HW5bdzQyyBiv0jKi5dgGindT4mZYZL1hgCuKayN3qtjcXq9ff8Mo/2mTvvqiCSA+SqR
 whb+5MpyPBUzAe5FadxBqkB2y2ytsTsVSIA25FAOGET/NpbvP9DhpIfjutDCeUP4LDNE
 0mIGIXdFDRbXxplWPvKc024Xl5nWAnGr7xAN3T3H554hJOjBzLKP/ewivfPpH7W5K/FX
 a1hDccT4+3ItQlHIlPtA93LCywsj8kJniQXmO/YXBFmt65pIHBAzgh3HPKOcRw7IoTGJ
 bs9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/gWrBmnCYPRzDH5K0e4VKLVPWF8tYeeAsskgSJxi1b0=;
 b=NUN/0U4ZsmkkUN0++cxUaRbJTW/gPYbuvht6G9bwXKLwlIBNyadQUlPMwHN1sh9s+5
 ItxU+fd4vQhvwb9wOyNkpKKvPoeRugyWWPjVQiOiUqHcXlAcLuWi6xXj2zcXJtOj4pFa
 VK3ED1KKY4t0OYcFYHKNPKnNW4IOXAsX0JCTuN2h834Q1o6Yivd+CmFNzE6kroRUX1in
 T7lst2TxMmHrlPamWS29Ix16cmsLvPvc0lsS7Qr5fLb2cE8ZVHcthOIgHlLdxbJfPvKq
 E8DvowqkoSQEf3Snn38CnnvTe4F5Qb74z1zn+BWQ0HJ9EnLvaPwWozgryokeEoPbuJCJ
 D0xQ==
X-Gm-Message-State: AOAM530UGFbVv+UFNq9nzBrC89Bzw/IKQDkXnrEa7qehDzRdO25srSev
 /MggGkSqmdjDImQZXrdIfQc=
X-Google-Smtp-Source: ABdhPJzcnyMm6pe1XegWJb0dOjpH9pv8AXjGAHa0TpPFFOA4K2H9ZyTm3DZGVQv8Xlbo4lFRAh98xA==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr13881971wrr.156.1603005338066; 
 Sun, 18 Oct 2020 00:15:38 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id p13sm11455857wmb.5.2020.10.18.00.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 00:15:37 -0700 (PDT)
Subject: Re: [PATCH 4/6] sun4u: use qdev instead of legacy m48t59_init()
 function
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <cover.1602965621.git.balaton@eik.bme.hu>
 <2b7a5594c8c41dcae0ade3354a13540f83570ab0.1602965621.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c9866686-02d5-3fe1-444f-5091b1f7dfe8@amsat.org>
Date: Sun, 18 Oct 2020 09:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <2b7a5594c8c41dcae0ade3354a13540f83570ab0.1602965621.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
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
Cc: Herve Poussineau <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/20 10:13 PM, BALATON Zoltan via wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/sparc64/sun4u.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index ad5ca2472a..a89ebed6f0 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -671,10 +671,12 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>       pci_ide_create_devs(pci_dev);
>   
>       /* Map NVRAM into I/O (ebus) space */
> -    nvram = m48t59_init(NULL, 0, 0, NVRAM_SIZE, 1968, 59);
> -    s = SYS_BUS_DEVICE(nvram);
> +    dev = qdev_new("sysbus-m48t59");
> +    s = SYS_BUS_DEVICE(dev);
> +    sysbus_realize_and_unref(s, &error_fatal);

I'd use &error_abort here (so if that ever happens, it is
easier to debug it), otherwise:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>       memory_region_add_subregion(pci_address_space_io(ebus), 0x2000,
>                                   sysbus_mmio_get_region(s, 0));
> +    nvram = NVRAM(dev);
>    
>       initrd_size = 0;
>       initrd_addr = 0;
> 

