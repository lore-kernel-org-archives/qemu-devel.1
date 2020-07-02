Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14827C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AE52084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V9G/Gare"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AE52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3kr-0001mW-3w
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3jl-0000jk-Et
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:15:05 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3jj-0006kj-6G
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 14:15:05 -0400
Received: by mail-pj1-x1042.google.com with SMTP id gc9so6282839pjb.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V5/9y/Mf3uH8PSixJpL8KlaxaNHC27kDSwx3p67PBoo=;
 b=V9G/Garelc5XGyFa06TFEmD05Kl4YLmpAsqu+lBtlyXQfID0EfpPSfRrwMXPvZq0Cd
 84LPlFi22/pooVKWz/AowaRMCysnra/sQYH1Ka0NW7A//evCIXfayXN2TNdps/a3kZpy
 5D6IVyf2gdeXHrGmcx3R9JiYSPxcNwUuVL4tIn3gKsf+EIiLHHD0RQ62LmXQo+y0gY3q
 DuAv1T10oLKItNSS1OKmlZh6Dn4WgSYbRhreJcGssGLrMBpDeBIH+2kjtGyD1n5OZNBQ
 3YhtE7actsuxCihjRw3bNZDEycviF1gPBqw2YFhw2TKSvT/NWIPFbrG0BMgERdpXShj/
 3SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V5/9y/Mf3uH8PSixJpL8KlaxaNHC27kDSwx3p67PBoo=;
 b=GkGti49JcGqvSrt+tRpyMoQBLhezFGYwP70eJ3MEEei/R39v9VrUWSLGsVcbQ5M6Y8
 n4nOeWmwnjLNNOwRXtP3on9Cb5SBXdvGTf6RbmJDVVew4ePvDqMyKmJgRO+kFR0/QsrH
 XBmDjX29ObilHyLdEbzUeZcOVmYrQmMuB1+sBx0kNwMsw9AjrVRWz0GoYWNEwK4/YMYj
 krKQJFcX7ebWmaVeO0I38vTEKXC7RQdu/OiArniI/SCjpjpVkQ2G0zOWUpyKHLoKrjOf
 qPyralblGq4DUglXNregGKyVxAgc7Op+qAhWrO3qdB+HHh+S5TRLYBqfNjYUlqPqbLSy
 ZaSg==
X-Gm-Message-State: AOAM5314Pkw8FfqnyzY5XzjmvVGai64DNWYVdKhd6z1W+xL3esHOq/1C
 jtKbX3ue62NRrT4TWntiH8Icig==
X-Google-Smtp-Source: ABdhPJxNj3/52tht6iW+rmH6amX4QcizgMa2MvOer4t6xJP/UlMChpcTs0CVb/PTjq6dBa4/k66fEw==
X-Received: by 2002:a17:90b:f16:: with SMTP id
 br22mr18966074pjb.170.1593713701306; 
 Thu, 02 Jul 2020 11:15:01 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f6sm10446130pfe.174.2020.07.02.11.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 11:15:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] target/nios2: in line the semantics of DISAS_UPDATE
 with other targets
To: Wentong Wu <wentong.wu@intel.com>, qemu-devel@nongnu.org
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-2-wentong.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5fbd61be-a4bc-a6e3-7b6b-1d542751650d@linaro.org>
Date: Thu, 2 Jul 2020 11:14:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629160535.3910-2-wentong.wu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, marex@denx.de, crwulff@gmail.com,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 9:05 AM, Wentong Wu wrote:
> In line the semantics of DISAS_UPDATE on nios2 target with other targets
> which is to explicitly write the PC back into the cpu state before doing
> a tcg_gen_exit_tb().
> 
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  target/nios2/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Or simply remove it as unused, now that you've replaced the existing users with
DISAS_NORETURN.


r~

