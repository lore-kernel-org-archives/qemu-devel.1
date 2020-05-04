Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F4CC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9578A206E6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 08:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9If51tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9578A206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVWw9-0007nZ-Nc
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 04:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWva-0007Cx-1X; Mon, 04 May 2020 04:58:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38859)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVWvY-0000IT-Mi; Mon, 04 May 2020 04:58:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id g12so8070438wmh.3;
 Mon, 04 May 2020 01:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AIZAfd/NLH4pG3YM3+4odsqFl2M83fx647r3uMWVaXM=;
 b=Q9If51tWSmmILbtxnVhXsBRHB+/yY3Bqq6F0XBLo1gfIe3k4f9lo0029FeOu4ZahJg
 gMlv3OIcPRIldR+zWryrAfifEuqcS6DT/EUbetZE0/p2jRyu24hdPquTBD7QHobxHI37
 H7NUyOHMliMAYdiyh5pwywTQi8QwVLQQcN89xX9hsiouWwJVBsPSMjsrLkKdHvZpFfoh
 Zv4KY3Ab3iItaT/jqoeqOz9pc61WVJTe4OGh7mLjrucWu0YnFE0MYU4+E7GH8ngvUDvv
 RwKhlmMYXwg3XGw03yvflBCZ/yiy7arscBSicvC1NeEFbnMYRTlFI6nQxS3V6VE89aTa
 yNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AIZAfd/NLH4pG3YM3+4odsqFl2M83fx647r3uMWVaXM=;
 b=QwwOZwcR0wWsi5hYFZq7W/9T8mBpG3eBHL3+73jL7Svyd+Qt6dRcqWfmN0xIS0nuKG
 bFqin2Cn40hsPe19w31EMGDb9llgfDId40OITYiTtbSUhp/a66fQh7vrKzm8YI/dfiti
 ege1FX6+5qtOWw5iyWrYFTQayk+5YMd0p66RqGhY1AU8v6u5ipmjmtoa7rm04mZmPur+
 WK/l4DBVoL7U7q++hxhHVcAe3O4JpbkqoVtgmYTgUsCx83CcIkjzUVw4RHq3bgpADtVl
 ndStJm+fGwKL8AvjvT/2cTO8auaThRGw1FQhSbsYoyKYJcZH6TlkSJ1xENx1qePSULIB
 5Jqg==
X-Gm-Message-State: AGi0PuZXqAa3DKZ5gTJfoWkQe1+gEBNnNUhrWefCwDPQsioF7razbJ5A
 ndsujmpsc2glUKnQMX3RQzG+cfui
X-Google-Smtp-Source: APiQypK1vfE5TXCLneNZ576LK9iqrOlDmtuvhEdFIMdmnwFxL8ScdqszNYLmb5UWdZGHdlYpG23aOw==
X-Received: by 2002:a05:600c:244:: with SMTP id 4mr13428466wmj.0.1588582694154; 
 Mon, 04 May 2020 01:58:14 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id c83sm13765097wmd.23.2020.05.04.01.58.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 01:58:13 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Update Keith Busch's email address
To: Keith Busch <kbusch@kernel.org>
References: <20200421122236.24867-1-f4bug@amsat.org>
 <20200422164531.GA14788@redsun51.ssa.fujisawa.hgst.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd5be7a9-3ad2-c535-cc68-0565cf5ed3ef@amsat.org>
Date: Mon, 4 May 2020 10:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422164531.GA14788@redsun51.ssa.fujisawa.hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+block +trivial to raise the odds to get this patch merged.

On 4/22/20 6:45 PM, Keith Busch wrote:
> On Tue, Apr 21, 2020 at 02:22:36PM +0200, Philippe Mathieu-Daudé wrote:
>> keith.busch@intel.com address is being rejected.
>> Replace by the email address Keith is actively using.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Thank you for sending the correction.
> 
> Acked-by: Keith Busch <kbusch@kernel.org>
> 

