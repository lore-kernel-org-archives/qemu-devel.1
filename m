Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3817CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78CE20758
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjr/Db3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78CE20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDp12-0005Sa-VO
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDp03-00048s-Og; Thu, 03 Sep 2020 09:09:59 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDp01-0004iS-T1; Thu, 03 Sep 2020 09:09:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id x14so3128482wrl.12;
 Thu, 03 Sep 2020 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=++YBUQGHuD0NlMHODvxPgNO5t6PQzHc2DpVEYelMUHA=;
 b=rjr/Db3rB0Ais42lAzoyxeDMSX6RI4SQzbxZgMeT5lG6iU1ohJ3luCgQSCkiwD+H5E
 3MMr44pkoPwu/mr+UX77UEXaHf8TChL4AEX37lxVlHTCcQyAny5hRrJnbBjEYzJ0vQNf
 2XjcInCmouSZtokIob6NI652wqxotB1OM+yoWBp/rZhjMBY9diC5WwDyqB7rZH58FiZ6
 FMXA8GhbA/gf14Ee5apyF7gLFWBtAFShcMOrfDjxMfzTcoPJziUNGteFZC+/ZkqR2tTs
 BW87MFkq6LAqHpBHxW3aI4FFKHuKH9a0LqaKRIZMEwFEUjTmTSe9U5ld/jiRM+OaApsU
 XipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=++YBUQGHuD0NlMHODvxPgNO5t6PQzHc2DpVEYelMUHA=;
 b=UaBbMWOi5/gkNtG5ws0rDUY5ncaPx7pZbL8pwiIvxtvKEaP/i3lTieRPmvfkn0GOvJ
 Mwea23ly7Yna7JRVG9UgQBs/zVUSnOLdSTrdkPotLRKMolYkmk/ORb2wZ/Hp35IQAS9U
 lZl6UjwoDmBI0ssLYXy5mJsJ+Tv8f/EkPKqQjodNoLe1RwNB6CE4S4/wn8uFDC0odmbk
 lqSrd8Ouk8xHgbAb/Q9Fbc/eNjnCjO+l7eyjxvq8hylnC66oU4kSUg3+8/gpnVUtoLtu
 70KXeUgRP/gheHq2ewbbYkDpiwOjoXeVfMIlgU9gV2NpAh5/GuU2jX5PdViFJcrgoJz+
 WDag==
X-Gm-Message-State: AOAM5322ACgcVF/vtxj0rNeb8IA0zPilRFar9RShUoEdMwwcmi+t+4my
 hgeKfqacPI4C/T07mzocuJCY6J5M7/8=
X-Google-Smtp-Source: ABdhPJwKDu+IM+PuwUIR422BcWnWjvj9VKDnbQHg+0v33ABa6V3JXOqYlf1JkRfqklYaK+3I5YirPw==
X-Received: by 2002:adf:81e6:: with SMTP id 93mr2419447wra.412.1599138595599; 
 Thu, 03 Sep 2020 06:09:55 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id v2sm4787682wrn.44.2020.09.03.06.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 06:09:54 -0700 (PDT)
Subject: Re: [PATCH] hw/ide: check null block pointer before blk_drain
To: P J P <ppandit@redhat.com>
References: <20200827114428.1850912-1-ppandit@redhat.com>
 <CAAdtpL6o7_Cvnui+dsaobNaY93Noj7fcLWYx37mEGd3kTBv56Q@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009031631370.2047119@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a9de0e0e-273e-ece6-7e5a-4ea26c536c33@amsat.org>
Date: Thu, 3 Sep 2020 15:09:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2009031631370.2047119@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
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
Cc: John Snow <jsnow@redhat.com>, Ruhr-University <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 1:05 PM, P J P wrote:
> +-- On Mon, 31 Aug 2020, Philippe Mathieu-Daudé wrote --+
> | > +++ b/hw/ide/core.c
> | > @@ -718,7 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
> | > -    if (s->bus->dma->aiocb) {
> | > +    if (s->blk && s->bus->dma->aiocb) {
> | 
> | But s->blk mustn't be null here... IMHO we should assert() here and add a
> | check earlier.
> 
> ===
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index f76f7e5234..8105187f49 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -718,6 +718,7 @@ void ide_cancel_dma_sync(IDEState *s)
>       * whole DMA operation will be submitted to disk with a single
>       * aio operation with preadv/pwritev.
>       */
> +    assert(s->blk);
>      if (s->bus->dma->aiocb) {
>          trace_ide_cancel_dma_sync_remaining();
>          blk_drain(s->blk);
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index b50091b615..51bb9c9abc 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -295,8 +295,11 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>      /* Ignore writes to SSBM if it keeps the old value */
>      if ((val & BM_CMD_START) != (bm->cmd & BM_CMD_START)) {
>          if (!(val & BM_CMD_START)) {
> -            ide_cancel_dma_sync(idebus_active_if(bm->bus));
> -            bm->status &= ~BM_STATUS_DMAING;
> +            IDEState *s = idebus_active_if(bm->bus);
> +            if (s->blk) {
> +                ide_cancel_dma_sync(s);
> +                bm->status &= ~BM_STATUS_DMAING;

If you don't clear this bit the guest might keep retrying (looping).

> +            }
>          } else {
>              bm->cur_addr = bm->addr;
>              if (!(bm->status & BM_STATUS_DMAING)) {
> ===
> 
> 
> Does it look okay?
> 
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
> 

