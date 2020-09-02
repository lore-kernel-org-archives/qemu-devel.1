Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0F7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:13:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B1A20773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV6IvJmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B1A20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVOM-0000Ly-9h
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVNo-0008NF-Hq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:13:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVNn-0001UR-0a
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:13:12 -0400
Received: by mail-wr1-x444.google.com with SMTP id g4so14993wrs.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5wSMg2pk0WxZOPo9UKMga+TfGUCkeJ7ROpEAYYt8TTI=;
 b=QV6IvJmBoHQPIsFZ4k4mk6kfqJp50dmVqPt0e3MSHW3FS5B5AS7uvviI46UqKv2tlD
 YMMOmhRE16U9ZjXheQU42D+ck1Ji2QJ0X/U7N+DjOP9UihuK4QQC878PCDO4agdzWCr7
 lBaJNvDRFYmq+EmFkXh47vH/aj46KHl0ghKCeUCCaR3MP5kID+t1d5ILwdhehJGZQTsT
 C+MXpNpf9PMDlf4N0tkd9xzHHRJ5HTnBs57VNE3hWDc5Zdy3228I6hlsWffgOZLIyGzj
 xaCHcsFb9TguqyiwNgHwnA8VfeKlgDdFVNQpZGg5NoD7Ly5ab85EMyFjTHacNrIcAWHE
 oMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5wSMg2pk0WxZOPo9UKMga+TfGUCkeJ7ROpEAYYt8TTI=;
 b=LCIuOCuU/Ug8dWlplU5r0ftkMcpL+vSRC1G1foDQHAkyl+HFw1b/9eJuN1hvP85aYy
 Fq6c2dhNV/oUFMBM0H5djmnO51ct/hwwLXB+BDmz4sSJro+1fIpDF1fuq9lnQT0bMHVR
 Gi3au/FXPC2e4CCpQ+Lmfd4TvfMJ2UblBk5G3WIetRWJXZepXsqGXAmTa2xOHttFrXqM
 hEOl1dQ7++3HaXOc+QxHt32/4fFQmrTVR6Fht5cwpBJPcM71nfp1XwNX3VcgGa6XocH9
 yCQpaKfxgWP2mxsglOOScX47wqOClcl4COK6FhlMynPjOGjnnJpM1B0KKhkl9ME53WWC
 epog==
X-Gm-Message-State: AOAM532GADfj/ePOz2uzHqPzTJgHsMlccrGQYig6RnM9Ux03lq88r+z+
 uLo0kzKaTRFovqw06TOaAE0=
X-Google-Smtp-Source: ABdhPJw5jWFTrQQp0j1dO5v6e1nk8wOJA8+l8u6NE8JIEAfe18LGmUHfB2XqrGLoMoAO2bluTp3XjQ==
X-Received: by 2002:adf:8481:: with SMTP id 1mr2706116wrg.231.1599063189522;
 Wed, 02 Sep 2020 09:13:09 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q8sm163245wrx.79.2020.09.02.09.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 09:13:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/core: Move hw_error() out of cpus.c
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
 <20200901112323.94969-3-f4bug@amsat.org>
 <6e4fd230-1515-f82e-67f4-87494898c6cd@redhat.com>
 <3d1b6cc7-5101-9885-8288-fa1a66037c1f@linaro.org>
 <514f8742-e817-556f-0029-ba0ef9ac5509@amsat.org>
 <0ed6327b-9966-3704-2a56-471a72b4c282@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <446e062d-b09f-170d-b1d3-72c3f4780d51@amsat.org>
Date: Wed, 2 Sep 2020 18:13:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0ed6327b-9966-3704-2a56-471a72b4c282@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 9/2/20 6:02 PM, Thomas Huth wrote:
> On 02/09/2020 17.59, Philippe Mathieu-Daudé wrote:
>> On 9/2/20 5:38 PM, Richard Henderson wrote:
>>> On 9/1/20 11:37 PM, Thomas Huth wrote:
>>>> - Move the function as "static inline" into the header file
>>>>   instead - it's not so big, so an inline function should be
>>>>   ok here.
>>>
>>> stdarg and inline do not mix.
>>>
>>>> - Add a big fat warning comment to the header that this
>>>>   function should not be used for new code anymore.
>>>
>>> But certainly this.
>>
>> Will do, but this has been proven to not work well...
> 
> ... or add a warning to checkpatch.pl ?

This certainly works better :)

> 
>  Thomas
> 
> 

