Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93777206D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 11:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2ifV4+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93777206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jadpK-0001Em-P7
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 07:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jadoo-0000cu-0w
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:20:26 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jadom-00082m-G5
 for qemu-devel@nongnu.org; Mon, 18 May 2020 07:20:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id j5so11418488wrq.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kgoqVdVS03coItRDaJ9dW17iJUArwG12jVFGqiMomTU=;
 b=r2ifV4+5yAxycscMTI6XkN9HC5+FcbQOlB/47dwrSzBALW7WjM6f7/VyR9OSORcVGN
 +qwkR4a8YeBoH0ikJyljpmsJifNO0kDrjTS9XYBMnFJajzkfhWpuzjKvsY52DXtGJpWu
 W1djZ4AeI1AS0hvJMPHX/BQF2TotQyAp5+N8j+wxeNVrt6ZyuNkNaJJBlQ2jOloRNGaW
 /eZKTxbAahhjT3YO3aaJpXMb88cNVJES/P65o5J5Dgf3blBTmR+oU4G3ufeeVst5xfxx
 VFEDiUHr0RV7w8BzeE+lSxNXeKI8VqY9bUdwlzusFFCNgqNB/4T4ZqIJ7wMzLAa84A0h
 ccLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kgoqVdVS03coItRDaJ9dW17iJUArwG12jVFGqiMomTU=;
 b=TWJqizkuq/iyQwoe3iBPkmy6qshDm7XIOzZU9IuWjDVLjB/NiUibZGajkmxXPg1kix
 2UdKjXhN3R7XdoCB2hHdmw1fCGojhgFxA95fk9Vrl+ULMPYZWxABw8Pj5qj0viS1VCch
 DRSj3mcGMQnibZbk5u1Kw3qTFTvBMxodaUreHyG5v9klybssZwD5C2ErOTpgd0v5WEd3
 nCbb2cVOpq+33iTwArLHBSACT9L/vwbiLcjsq9EdUX2yMGiJZoFe5vNu00cKW+GpAlaT
 dWaupGNP0yrYTg31KMXLev+B1Kt6/q2x0IuXrv5hymdTx8u8Jw2nGLi+rLPZ10Z/HfU7
 QHkw==
X-Gm-Message-State: AOAM531r4C5MrB0yo/XcfRjfEhAXEPvDgfe4ua7XBjPp9Wh4OV3SQ4y7
 Ekp+ORmNPmLoKAJrYXvd8RY=
X-Google-Smtp-Source: ABdhPJwBKp20h777pGOqKjykfEJQabSUppbjyxejtidKjdCJ0mQTPHNyYAO6ypcsHN7hE8Fk+o/Gpw==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr19622102wrn.96.1589800822215; 
 Mon, 18 May 2020 04:20:22 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m82sm16968612wmf.3.2020.05.18.04.20.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 04:20:20 -0700 (PDT)
Subject: Re: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200517164817.5371-1-f4bug@amsat.org>
 <CAFEAcA81dq=DZO-ao80j6saWutsBD8Lka+0M_Lu77e44BdO5Tw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ee5e925-284a-9d5f-4890-b1d35eee9d7b@amsat.org>
Date: Mon, 18 May 2020 13:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA81dq=DZO-ao80j6saWutsBD8Lka+0M_Lu77e44BdO5Tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 5/18/20 11:46 AM, Peter Maydell wrote:
> On Sun, 17 May 2020 at 17:48, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Various places ignore the MemTxResult indicator of
>> transaction failed. Some cases might be justified
>> (DMA?) while other are probably bugs. To avoid
>> ignoring transaction errors, suggestion is to mark
>> functions returning MemTxResult with
>> warn_unused_result attribute.
> 
> Not necessarily a bad idea, but don't we have an awful
> lot of places that ignore the result that we'd need
> to fix first?

Yes, there are various places to fix. I wanted to have a preview first,
and not start working on this if it is later rejected. Most of the cases
are hardware specific and require studying each hardware behavior.

