Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C320320774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pL1JxFoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C320320774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ghS-0004Ec-0v
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ggH-0003NZ-20
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:52:05 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ggE-0005ys-Rv
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:52:04 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mt12so4965107pjb.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SEWhB+e+M6t6fmRNlQLnhNsBVvEGhKIXduG69Ba9W+s=;
 b=pL1JxFoSqNwv0qwnsZBmFQH+twJ78oP54mHCtZlbHSaX3DARxSsOlBfGiGyas0jRe7
 TwK9b/Z2f8Zex+vh528Rj3d0YrCOpXYUCO4TZG0Rt37jY75q79FQp6XBDfQHTAStyPoS
 qOvoOZwOqmbJ32xYB/MI7Im1Xmp+mp8w0OpnOEVt81/ZmNRmo+s5WIDZlaEgeeMOaVXz
 rTC19qSYnc6za2zcYDZsK/tAzBKOo7sERdI/REgCSC8tFA7PFGrjVhIfmEdLRPdkvZhv
 27xNXjJZIr5aH/rm7XoZynbatxTI39x52acHI4FAQ0KQW2G68uBnZ/XuVJLpXKvalFBl
 nxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SEWhB+e+M6t6fmRNlQLnhNsBVvEGhKIXduG69Ba9W+s=;
 b=aYOuFkvTY/gyi2GhIij6a5aKv5nvTXkWCFqb/0U9/TLee8959HdgJqXLRJtuk4//+M
 Lyh2gWY0mlsB6isiU6tMgVajTHx9Y2QB0i+ABVTZkryXv1i1sSyn1tOROqa4yV4iCQx2
 eNCUriGH9jVbv6Aeyf7G+KxHlzjysBqNj/WcBkOmu4e/hPKRNbpE1RtVUWgvMiDes734
 tbZOIZIx7X1xVVWC3LPhGQl6jTRiVk4Y6m10GS8LuhVHAAFFlK6osgN3+d353rN48v9M
 n0HxX5OcqTuoZ7qHLwbDaNZXxWZIv5g2shMsDoUA4Zyn/FkRe574tI5p9oYyYgn6sj0A
 j1rQ==
X-Gm-Message-State: AOAM531pfZ97IbTE7S0G6+nZUr/KmOQu1glZzp/hpeILHz8mS0ETw6dR
 7dlj4mYzlfUAb1ZkALIHKla6Bg==
X-Google-Smtp-Source: ABdhPJz4aBxbiAT8W6uVLUy5Gtan79uuDmzzHmpkRY4Romdeb4iiDcgFygxs5fWUZsyRqu3bCOWfpA==
X-Received: by 2002:a17:90a:fc90:: with SMTP id
 ci16mr3545478pjb.229.1597438321087; 
 Fri, 14 Aug 2020 13:52:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r7sm10251105pfl.186.2020.08.14.13.51.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:52:00 -0700 (PDT)
Subject: Re: [PATCH v5 09/14] cpus: cleanup now unneeded includes
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-10-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6d05e67b-5044-af14-b111-6519f42ec070@linaro.org>
Date: Fri, 14 Aug 2020 13:51:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-10-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  softmmu/cpus.c | 7 -------
>  1 file changed, 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

