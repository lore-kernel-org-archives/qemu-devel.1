Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88398C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EAAA20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7zYrTyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAAA20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVFQ-0006gM-EW
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVAr-0007Lc-Eg
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:59:49 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42230)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVAp-0006v9-Pf
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 11:59:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id c18so5792643wrm.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iEV+28A3Rq+lASdMIR4e5bMpbrVo9E10KgNghCo3754=;
 b=Z7zYrTyA3ssr/7wnrgiJKAApyBVBQK6IKSkIEe6UcTG3O00cd7ZaTctxyNwSybK5ta
 PaM/KchXnIeBe814yh6c1sxwdBdQnJvkU8mrRo/jgconu+F7Yi0dLimOQJvw9ZslC2E/
 4WweYHtZQNaG1UEwUBmxpSwKRF+AnM1taOWcK5FHRnhZ+MbtEanJAi+i1L+WmLBWRHLJ
 S0vR3ae2dMA3nguAZgyqyasJ7t3m+ze+nb2eLTfJ3YIkD9bL+wh6tn2bwzh3A2E3/jFu
 6rBIOZVLnFVNX7F0TIa50TF7NF6GHfP53EP2UvJ2BFnubfCIAcLM7AfmhADDnVg1Kpvs
 Og/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iEV+28A3Rq+lASdMIR4e5bMpbrVo9E10KgNghCo3754=;
 b=Wo4tYGK1XHVN+v9WsHjBwjUcoKTLTLhC8KULEp9GaBvKQ0rttszesHPYl3BHe++CAU
 oPV5ulkUR+0Ht9s61cBjDuoUPDh1fswijz9OCO5jrGocopWjaObjAmO+fgJw5k8jGio3
 jxXUIRcD7I2891USFP3j/Gb66KNYf5Mx6E6WJ8bgzLLc3HVsFdmLi52MB8NYruM0O3bX
 VKa2jegaIXiztTw+Bp8hcga/n14s6Hg4c2kPBZPvBN+Wyu1VlHf3wRmA4jit/Zd1jLnj
 VnVL72pWWWpihdskhGwXhKaQ7vnlJnRV30kZV2iVOajSptfi4Yxfcr/08dIbhkGGA4jW
 VgBw==
X-Gm-Message-State: AOAM530nRJoBuWdRMbSZwsaoLUlYn1+fPXwUSZyxu9oB6tvUb4ldBQxd
 BEoJ7r3a/21h7ZyGAl0i03M=
X-Google-Smtp-Source: ABdhPJw0kB9yiZw0qqUV0r4ijl0vwBlze+XA20BCOBBV8Hzdv6cQLtteuA0YY/I1bKNRun/w0d+xcw==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr7684464wrr.167.1599062386170; 
 Wed, 02 Sep 2020 08:59:46 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id c4sm105777wrp.85.2020.09.02.08.59.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 08:59:45 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/core: Move hw_error() out of cpus.c
To: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-3-f4bug@amsat.org>
 <6e4fd230-1515-f82e-67f4-87494898c6cd@redhat.com>
 <3d1b6cc7-5101-9885-8288-fa1a66037c1f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <514f8742-e817-556f-0029-ba0ef9ac5509@amsat.org>
Date: Wed, 2 Sep 2020 17:59:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <3d1b6cc7-5101-9885-8288-fa1a66037c1f@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 5:38 PM, Richard Henderson wrote:
> On 9/1/20 11:37 PM, Thomas Huth wrote:
>> - Move the function as "static inline" into the header file
>>   instead - it's not so big, so an inline function should be
>>   ok here.
> 
> stdarg and inline do not mix.
> 
>> - Add a big fat warning comment to the header that this
>>   function should not be used for new code anymore.
> 
> But certainly this.

Will do, but this has been proven to not work well...

> 
> 
> r~
> 

