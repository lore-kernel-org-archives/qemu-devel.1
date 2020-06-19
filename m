Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 22:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9C29223BE
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 22:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlLuKIwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C29223BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmPsp-0000BX-Nh
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 18:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmPsA-00085S-8O
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 18:52:34 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmPs7-0002lI-HS
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 18:52:33 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ne5so4689604pjb.5
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=6v+vvlDT/vgxC+n8e3pvkFPZ1iJqTwyKNDRCBWHJGqQ=;
 b=XlLuKIwhnaxYJoV6kOKYTcRHWy8LNCOsvcAfQKPv/tCpo7YVEW2cIlB9Zr1Pkmg5sg
 wOY75Msu1za96I6H0f+/eY5N99VWq1t0d7ySSf+k0BACTC4cg32z7HCE4c8ztuG6fHXg
 e8A/IfTo22804R3u+xFSPHbRfxyHerMLc86q9WFHotTj5bMyQZ0csGP2QVq8JoZauwcm
 E7n7L5Gdo+K6BuFh8bgIvl3WsBoW+5mfFWfZ1Fb8I9dYjvP7CB5Z6fB8FOf7gOGFyaw3
 Upgeh0r/zLOyjL+CwH02q2eRozQWQApShaEySWJSmTllTbwMJfzFAj3XInpXpxct/2vo
 1IKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6v+vvlDT/vgxC+n8e3pvkFPZ1iJqTwyKNDRCBWHJGqQ=;
 b=MFQa2SqSfM3v0znSylsBMI5qYFcYO4rPa6kvbTppI/o0ICAeHpKzikKY3jqwD0JAPV
 eEU0QwTHpOy5sx4A1mGw/2tZ0zP5vgTfEVVBOIWgt80WYRqw9pyukx8gid4+OrK8u3Bi
 yLFKT7kFRz5rjGLTz3W3UTdlNZVtyb6cGuK6hMH7mK5W4TRmcuY+yicgOki0mIDU2YEo
 zxDDNWLGF3I/7dzG4TgKsulkTv+URamHX2t524MQ76ssCbPu++tVvzadInFl42XAx8EI
 GX8L/2zgSR5q5wOypiktEXL12VyagiFp0Pd8yNX/uKN+W4SFf7xV6nQksfbEfgc52Y0G
 dWbQ==
X-Gm-Message-State: AOAM531gyBxDc7/EwcuQ1SsvwYmuy/Prn00sSdzrVFgTRYm9nlpy9KqZ
 KymdYya35wjNKeFZRV7vMZiWk7FFeGQ=
X-Google-Smtp-Source: ABdhPJwhxbNQ6vjGRTeKcfIAY4o4azDnLTFhmJvxwNTbpqtZCPNnfp20b76dmYZsHRsyyfNWo4AwmQ==
X-Received: by 2002:a17:902:ff06:: with SMTP id
 f6mr9644890plj.22.1592607149962; 
 Fri, 19 Jun 2020 15:52:29 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h3sm5914506pgk.67.2020.06.19.15.52.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 15:52:29 -0700 (PDT)
Subject: Re: [PATCH 04/21] target/arm: Convert Neon narrowing moves to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8ed83d82-5b65-1bb5-398f-66e86e05087d@linaro.org>
Date: Fri, 19 Jun 2020 15:52:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the Neon narrowing moves VMQNV, VQMOVN, VQMOVUN in the 2-reg-misc
> group to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  9 ++++
>  target/arm/translate-neon.inc.c | 59 ++++++++++++++++++++++++
>  target/arm/translate.c          | 81 +--------------------------------
>  3 files changed, 70 insertions(+), 79 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


