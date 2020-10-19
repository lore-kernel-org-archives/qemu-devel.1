Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800AAC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74052223C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 23:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXchbvji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74052223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUeoy-0003Dc-PD
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 19:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUemP-0001B7-F1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:41:30 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:39373)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUemM-0002x6-Aj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 19:41:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id e15so28649pfh.6
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dmcIylvRW0RIkEQJdZPT7p0luDVtrc+Yev19FlNzkVo=;
 b=gXchbvjiFrvkHZxciPUrX7llKlnrMjgVb8ScQQU5MlNSkrThEnu8M8pHh/nRJoRT7H
 qajJtjfZaKwtFUrLf1MEWkIXYNHPg6OFvqldOqsarbJ0KfGnE0b0Muevu0I84YGJqTzQ
 mrv7j1D/z23kJJrNe7auP0EYl1cSC+mi+KeURCyXy5OmqzTqgXXD67o7HE07EbqY8gbq
 qavGAalS/f85FPhwDU2U5fJveB4PLMcHCTSJnVzbAVfkwgDHIT8iQUd2dZ+424gW/Jrg
 y6qBoy2LJnLnrIl5vAR+AMvuDEazKTFc2Buj1vNreW1fbNjfqMT2DLNtIb4j/nQopcPL
 MmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dmcIylvRW0RIkEQJdZPT7p0luDVtrc+Yev19FlNzkVo=;
 b=LOeVk0dDKv1XjD+vmmoRctMTMvw8Uj8PE0xdE7W4CHAK1lM2XtGM/EwCmZz3XGC6wf
 eeruuNNAhd6smDKmAUJ6UHke9598RYocCTDUbHOAABbcVB5pdJrst1lI5K7qjuWw/5ad
 HvjIJbn6kl+WTKnEXOtTFcWzGLogVy5duqIaM9XGWd5cMyQysXmEsA/FXbU1pTeABHIR
 fGwkcn5dn632lHJXiCRUzT5qr78JpYkko3gFP5xm6+YbPOCeBXHElYJMBQXmqe34G38d
 ZHsvh2NP7xgyEmyG7t7lbHf6iivnAFVtIr9xqrrUWjLffjyBed1EUwV/KfnhIQyg+Y+r
 9sOQ==
X-Gm-Message-State: AOAM533mIIj8WcxaVwwCwfr0Yio78X6JbKJi088is5Oc2LLFo35P738q
 IpkWmiMVIN7nkQf/ItrXsT1LYY9kbzMDng==
X-Google-Smtp-Source: ABdhPJxYqRYMyf2kvC8TKfNQiV8mO6nvDBORsgV3lUXwws7VSOk0DRB2sWF9hmR4igfbfQdHlUD8zg==
X-Received: by 2002:a63:d90d:: with SMTP id r13mr223765pgg.99.1603150880769;
 Mon, 19 Oct 2020 16:41:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w2sm575837pgi.56.2020.10.19.16.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 16:41:20 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] tcg: add const hints for code pointers
To: Joelle van Dyne <j@getutm.app>
References: <20201019013928.72770-1-j@getutm.app>
 <20201019013928.72770-6-j@getutm.app>
 <11912dd5-2740-1d7c-c691-1174fa7ef390@linaro.org>
 <CA+E+eSBdg6ZMXOD2LQQfuv5DPBuah45SpwM8bL-Jn-c+FdKs9Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a317a7d7-fd35-156e-ae2d-ab3fb59c82a6@linaro.org>
Date: Mon, 19 Oct 2020 16:41:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+E+eSBdg6ZMXOD2LQQfuv5DPBuah45SpwM8bL-Jn-c+FdKs9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 4:36 PM, Joelle van Dyne wrote:
> Seems like I missed a few. Sorry about that. Will fix.

I'll keep looking, Just In Case.  ;-)

>>      s->code_gen_epilogue = tb_ret_addr = s->code_ptr;

In this case, just splitting the chained assignment to two statements is
sufficient to fix.


r~


