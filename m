Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71154C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 22:21:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34BE12068D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0AUFXrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE12068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfsnl-0003q5-EV
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 18:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfsme-00034O-Eo
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 18:19:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44759)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfsmd-0000OY-9R
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 18:19:52 -0400
Received: by mail-pf1-x442.google.com with SMTP id f3so4085585pfd.11
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 15:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AGXbaNni87x7QvMsF0bnLxlyZYPvAmgv1Z3H+9Ekfc8=;
 b=Y0AUFXrC+Thzwtm5TD4b9LVBgvT9nvOoGvbQFp/wVMj7Ehtu6rQajwh9cgJ/B0VXmg
 QhodHtjbhK++CeCkCypIu0IYgd62GUibdQNlQSRzWRoGcoeb6J0XnVoE9oeYhx0pYG0m
 vrej28w/O8wcbqTUo1M+GPTbBYJVLkLUBPt0FirhGZkQ7Ybu82TidQGmbFHJlWzvLfQz
 Yu6plfapiprg3/3NEZOxHXf051yINaASBPbdpHXC1QJue+8efHFlclUJg54GMbYXUPR7
 yV7BTuXknK51rmcVhbj8tw4fFqsAZaY36P/GiqafzDOBDJmMfPEEjovGKuBupmIj8KJQ
 C+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AGXbaNni87x7QvMsF0bnLxlyZYPvAmgv1Z3H+9Ekfc8=;
 b=sh2ssCBy1nwtMQa5WyhdkMiVyKNft8CuX4RNDaqXkT8n9/OeG4NWKKr6sGzKe2zcPM
 4KMU6nDmunHoBhec4JdpQCmHbVHf6/QTfpwx85fOneuolZCDdUJG849oFXJ1jTBfA7nd
 swvMMTRzOcP45P8576Wac76xBEZb3Bb05UUPH5zd35r1vYMJMkXV++D+lC8TmYynjq03
 3p5nEhyjHM4Y1lAdVBeytQqwIudrwIstHnm2+j/NPb5rY5XO4KgI/zelXVukOhUzzi4k
 WvGwrVHc8Z2MEa974NsqwsD6T4wdHjJ3XMAmzS0clJEbhGgMrRfHfuoIynYg87n4AW8F
 afFA==
X-Gm-Message-State: AOAM533XR8GYI7tiGztCCqjvguHM4yIxO74peNfUid0dqFMSn077w5j6
 +upsfhv8BWOt2x5KpDv8qkuUjQ==
X-Google-Smtp-Source: ABdhPJzz8CNpVrIvnDvZZY8lFjHXmmdLtQeGsjvYMt8eYQ7Eo097xjpPAfrNXROKEm7V13yOQe6Exw==
X-Received: by 2002:a63:f304:: with SMTP id l4mr21742151pgh.235.1591049986383; 
 Mon, 01 Jun 2020 15:19:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id r1sm392441pgb.37.2020.06.01.15.19.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 15:19:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] target/rx: Check for page crossings in
 use_goto_tb()
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, ysato@users.sourceforge.jp
References: <20200531134512.7923-1-ahmedkhaledkaraman@gmail.com>
 <20200531134512.7923-2-ahmedkhaledkaraman@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd8ade6a-904c-ed35-2695-8865536eb40e@linaro.org>
Date: Mon, 1 Jun 2020 15:19:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200531134512.7923-2-ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/31/20 6:45 AM, Ahmed Karaman wrote:
> Add the page crossings check in use_goto_tb(). If this check is not
> applied, a number of bugs may occasionally occur during target rx
> system mode emulation.
> Also, this check is needed in user mode related to emulation of system
> call mmap(). rx target does not currently support user mode, but it is
> better to prepare use_goto_tb() in that sense in advance.
> 
> Rename parameter dc of type DisasContext* to the more common name ctx,
> to keep consistency with other targets.
> 
> Add detailed comments.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1880763
> Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> ---
>  target/rx/translate.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Although I note that this failure is not currently visible because RX does not
have an MMU.  So there are no page permissions to change or fail.


r~


