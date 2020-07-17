Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7626C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:06:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753B0206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 18:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G8DH5DEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753B0206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwUl0-0005oK-Pz
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 14:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUkB-0005I4-PR
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:05:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwUk9-0008GD-GZ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:05:59 -0400
Received: by mail-pl1-x642.google.com with SMTP id d1so5785392plr.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 11:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/KNkJ0b06AQanAhQZG8kIp2EXobC6+wDVPvXKsYYcqc=;
 b=G8DH5DEVKzqhFCyq4WT1lur5ZJvAIz8lxbvXh1BBiDfBaIpNjv3y0cjghJTY8Rra/3
 FDaJX62FkqOe0qzsrStD3AttYrHLp2yrbqb0KX/S8psoSIdHIGi5upXPPC9WVgGvnt+q
 CdGkuDbMowbrVkrDYVJbDDMwrxIWtq7XwQOzPykODjcwMI0J502Zr6hlFgs/Ab/2G2eH
 fWTI0lxicvlw1IcvtJpp1CoqGAqWEdBxo7Om48o3Te4GHYpo+19FG7LY11v/yW5Vfd8r
 C0qBu4jg7lSzTJTnYLp36SJZoyv1e2BOcXm9zLoLGvytI5H6pqL/Shu2GxMXSj5sHwP2
 4i3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/KNkJ0b06AQanAhQZG8kIp2EXobC6+wDVPvXKsYYcqc=;
 b=XSW/1XXb2FGyoJ3g0J8W6zPGLQQ2raMI1Te88s5e+FXG6bQryzsDrluWjqjOlB2Kxl
 IyiRY26Fy0d/lsemQ72GQAgVAZ5UJdjtEU3eLO8TSVPR3fvXzhws3/rWzofu6PZGA6ba
 0LC1njsp0mgFV8QotdPeLihH+BCM1iW0/DL3foLy/li4bMFdmmkLpPaoKLp+JHtGXnPD
 K9h3+0P6/lnntURahTvSLrSptcuy6/8D05ENXUUtEAgYXjzpe/cqqJbKv/kzuEngMfDp
 vs3F4XdNF1J7qBlusPScgs8CfE833Ds960JXjyXZ92+KLwiJSs+W3EKLdNgVp7rYOKCS
 5gBg==
X-Gm-Message-State: AOAM533yNpFsF/cBHtdY82+w1ODqRe33lq8prcPg8ZrXULe82Z4t+KPt
 I3YU5zcu8JwuYpUldoKnru/yhw==
X-Google-Smtp-Source: ABdhPJzKVIZdSMgDfAThHIlzDb7Bt2x9dN71ikgHZw2WZR3TONd1zQV+ExlSNUkrnOApVwDStLqaYA==
X-Received: by 2002:a17:90b:1b4e:: with SMTP id
 nv14mr11452848pjb.30.1595009155767; 
 Fri, 17 Jul 2020 11:05:55 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 q20sm7999810pfn.111.2020.07.17.11.05.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 11:05:55 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] util: add qemu_get_host_physmem utility function
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c575e03a-1655-c317-abf7-40a7449eaf0e@linaro.org>
Date: Fri, 17 Jul 2020 11:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717105139.25293-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Stefan Weil <sw@weilnetz.de>,
 f4bug@amsat.org, Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 3:51 AM, Alex Bennée wrote:
> +size_t qemu_get_host_physmem(void)
> +{
> +#ifdef _SC_PHYS_PAGES
> +    long pages = sysconf(_SC_PHYS_PAGES);
> +    if (pages > 0) {
> +        return pages * qemu_real_host_page_size;
> +    }
> +#endif
> +    return 0;
> +}

Is it worth examining our own RLIMIT_{AS,DATA} as well?

I suppose that's not usually what is tweaked in the example of a ram-limited
container...


r~

