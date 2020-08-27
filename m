Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF3FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0212080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 21:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYVDLljG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0212080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBPDe-0002Ub-JM
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 17:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPCj-0001d4-JO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:13:05 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBPCi-00061T-7P
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 17:13:05 -0400
Received: by mail-pf1-x441.google.com with SMTP id u20so4484601pfn.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 14:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AsOSibQAEZFLlWgfYO5tSNBQyGVEiYlzN4EsSzowJsY=;
 b=tYVDLljGfLAxAKCgNK3sEn5jmNmbcZga8vA9z5A622bN0uAAtMR+SJhZY+QeLFohX4
 muwp4FrrNy/HQkXfdL31GubB9VX1sOhJooxVq9fnGJVXiSEuM7x6JRuWqqh+NXZNehTX
 K/pfEO2LjW/JI8rFSft1MmdMzMXCtVeFURlcAGkRrIx8KHBF6//PoYlzp7taHy0qnBRP
 PqAgx91jZoB8tnFYrRaFSmdQqHKOejjr5vohB6lCZIj8O/7yHjxKpBn9hofclx2wRkEi
 msWzttOrgC2b0aZmmxJgVaTMnKcYlvk6uZgUapWWB+1wEHr7vZgPCyEyZLlVurfCrQiY
 lq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AsOSibQAEZFLlWgfYO5tSNBQyGVEiYlzN4EsSzowJsY=;
 b=Zz7mGpzJTvGyoM8IJUAw1gIIxX/1nOkDhOLBYAIXMQsdlatMwHdBz4N8T51m474cF7
 PxIunsj8Nx10hKAYed7yKulVg0wT+Ukjk7C/u6eOAWfEGAB1ETm2e9asB/EfiBVtFQVU
 0wUAxURQ5JcCDclZPv7XGSR/631tALIY8Qgw8SneasQncZjpZU7xL/BZXIUclb3+yqmH
 wWSoAWJ4acbEKNMzP67ANN7u4NTEJrKYwP85hpyf7iqwS3YbIs4AH2KgZZNIhrwDWOvk
 edYN+vNqGaMSb+l28rdy19Adb0VzN+5wkQpwDEdfi0T7F/4rY41qfxbMF9PcHDy5Aqrh
 P8Ew==
X-Gm-Message-State: AOAM533v7leoZvCxX3G+6uPp4wxNw0seabz81nylFYacIXQOtv387VxC
 hCQDd4vE8X2mFAnnzoTFbPd9MQ91lPYo/Q==
X-Google-Smtp-Source: ABdhPJwKt62/zGMaLbVfFiFuEQtIEJylMT+XasklsJIwdJPblYg/JhJvo7jLM0mGMer7ESDXn+Jf7Q==
X-Received: by 2002:a63:1a66:: with SMTP id a38mr15579710pgm.253.1598562782208; 
 Thu, 27 Aug 2020 14:13:02 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id r33sm3198726pgm.75.2020.08.27.14.13.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2020 14:13:01 -0700 (PDT)
Subject: Re: [PATCH 73/77] target/microblaze: Convert dec_stream to decodetree
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-74-richard.henderson@linaro.org>
 <20200827211037.GQ2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7862739c-58a4-f892-4d2d-231c47183dc6@linaro.org>
Date: Thu, 27 Aug 2020 14:12:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827211037.GQ2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.782,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 2:10 PM, Edgar E. Iglesias wrote:
> I think you've got a typo here, get -> put.

Oops, yes.


r~

