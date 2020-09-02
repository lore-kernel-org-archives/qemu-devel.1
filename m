Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E845C433E6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:14:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A422072A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udksriK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A422072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDNu5-0007fX-0L
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDNt0-0005qb-KU; Wed, 02 Sep 2020 04:12:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDNsy-0002SW-Pn; Wed, 02 Sep 2020 04:12:54 -0400
Received: by mail-wm1-x344.google.com with SMTP id a9so3552430wmm.2;
 Wed, 02 Sep 2020 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=NVAu4IgjHrAW7yeiqZPWfFjmny0bQNdZCkn7QST/VYk=;
 b=udksriK4Yfvx+QAgR9ghyQRJkY3Wy5XaLLKmaATcIuWoueW8loXAAATHhHL6zN9YlZ
 m0aymmAlazZ9Hf7tV/l/fmndEfT+VDA4WzUP47Mve1NukJQAhAIivhnPxV/99KdyRNOI
 YgFP6ge3fff39aDkQyHsWjb5/v73YniF8viR1/ItrvPtSQVIyK2bFA2acPs16wf+TcPJ
 23ziN2ZnCt8LNkKaQaHPapukKUhwFljVgRphFQ9hJ+NBwV6VuBM4Aq5OvKP4mTHrXPPA
 kgH2C+F7LfYOkf+AL2EuUcvMgGC82IX0kJ4LJ02nQziOloOFchFAIyJubh9xTFq71LM4
 ok3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NVAu4IgjHrAW7yeiqZPWfFjmny0bQNdZCkn7QST/VYk=;
 b=TSoDDUw93MFonvhuO1S0lW6xAVu+PdYEM8vv1hOC3dkFAmi+PdgGhuoRkwo2p3D+pA
 S1JA1YbsalR4rrSvumN2/PgT3WqszVdE64BeUcxUCkYmpB+ZhytsvSpP2ofHOSR37fqu
 0/elrLXu/s08yMT8AGvd89iSYxoBAtJmTsfqTZ6jex22N19B5Q6eSVuwN388klkKU6+r
 DCR0h8KUOv5pWvnX1RY6f1FZBXyOjg69ygRsLUt2/oKSjYlDwHlwJdhoiMG6YHiZJqHP
 ui9fGq5WLyT2q5aIwkheB4qnvISR0q0SP8Afz2JTo+iYlQ8C+ZOJo0/qmfRJc1Ya1WJn
 9yfg==
X-Gm-Message-State: AOAM5308gyHWEtJc5eaUkVC7UQFjm2zWZJou2lSANim4ogg7f2xE1oUz
 7zVKlGW1dqZT/PPBHqOCq5Q=
X-Google-Smtp-Source: ABdhPJwMEClSi4RPyTTwKYzXkM90Nxk26p2D4jIorgG3AcakStpQwkKoTCvn7OacAeIcfE9voHPVjw==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr5207199wmj.132.1599034370044; 
 Wed, 02 Sep 2020 01:12:50 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id b2sm5422042wmh.47.2020.09.02.01.12.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 01:12:49 -0700 (PDT)
Subject: Re: [PATCH 3/5] hw/ppc/ppc4xx_pci: Use ARRAY_SIZE() instead of magic
 value
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
References: <20200901104043.91383-1-f4bug@amsat.org>
 <20200901104043.91383-4-f4bug@amsat.org>
 <0ffcf77e-9b1a-24e6-c763-4a94614b1549@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12a81a52-bf78-d50f-1314-2349aec45d18@amsat.org>
Date: Wed, 2 Sep 2020 10:12:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0ffcf77e-9b1a-24e6-c763-4a94614b1549@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.13,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-trivial@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 8:53 AM, Cédric Le Goater wrote:
> On 9/1/20 12:40 PM, Philippe Mathieu-Daudé wrote:
>> Replace the magic '4' by ARRAY_SIZE(s->irq) which is more explicit.
> 
> We could also define the 'irq' array with PCI_NUM_PINS instead of 4.

Good idea, thanks!

> 
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
>> ---
>>  hw/ppc/ppc4xx_pci.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
>> index 3ea47df71fe..cd3f192a138 100644
>> --- a/hw/ppc/ppc4xx_pci.c
>> +++ b/hw/ppc/ppc4xx_pci.c
>> @@ -320,7 +320,8 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
>>  
>>      b = pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
>>                                ppc4xx_pci_map_irq, s->irq, get_system_memory(),
>> -                              get_system_io(), 0, 4, TYPE_PCI_BUS);
>> +                              get_system_io(), 0, ARRAY_SIZE(s->irq),
>> +                              TYPE_PCI_BUS);
>>      h->bus = b;
>>  
>>      pci_create_simple(b, 0, "ppc4xx-host-bridge");
>>
> 

