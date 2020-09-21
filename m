Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2B9C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78332078D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6oOoYtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78332078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK9KM-0001Wi-0v
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 20:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9JQ-0000lT-C7
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:04:08 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9JO-0002lr-O1
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:04:08 -0400
Received: by mail-pf1-x443.google.com with SMTP id x123so7693689pfc.7
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 17:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=O8pOE/Xz3g//Ehz4tyl90htww0qeCLownulbylQ4WZY=;
 b=R6oOoYtKQfu55SIYZ7TJKfdtyj9vH5PBtgmTdJQgKUyMg6HpKtMiqu4iBYPA5z+PBd
 FBzGfNSHeCyeZzS02k9VUO9lSX36w+JIv79WKqY3+ehhZ/JoRWP0t0PP63/VaiJVrYXi
 LfErPLEXkADkqr853vTfpOs4vuV2JCy1hWzy/5tc+LhW8P/biZmIbyyFAtU5PtN1vexU
 WzA9vhbnbtW+PPA9zBLgMRdlMH2bJMnxRNjVsmJXBzT8jnhWOd8PZNtec+7s4wY9o9Dj
 NUpYLRMshGZuqOBUehHreQo8BpaXAsVqON8opJLqk/BOP5CtUZ/RcZcVzyVYzXB+vXGF
 eFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O8pOE/Xz3g//Ehz4tyl90htww0qeCLownulbylQ4WZY=;
 b=BgBiT/QSSn+nqapbrgMGQW2TONaz4BJ6N5hoGOjXsEKzyG6KCvPBU6lFhvVvdZay+y
 A5Y3LIEm/4TXA0/AusRwmn7tXZ1GFYviq7anUD0AgsZUMK2ZFRw6InzXud0rsLXdOcPH
 FCDH8cXG7bZwKUxjYfsY64Sy//HPbTy82ftBjm7TbPuA+AsNbrfp0kvGH+pfsodS9dD5
 jdq8SNe2Ao9/NAvgNlnVupuC1vN1NRh4GL9qtQtxoHpQ0NuC3AOQlYTvvpcmwxKpgsoe
 s44Yc8MARqygk2PEC6uKnjzEY70inS0fo/uYZUecqt7SlaGHTJW6btWF6GURncIyORVk
 zlEA==
X-Gm-Message-State: AOAM5301PeAnpFxxoQYkW0pB1waTl7XJ0a+0GXyo2DRtrVV/hyRs9h2N
 OZg91rLQVqoSyG9f9qtDNW7qJhPtbzwVEg==
X-Google-Smtp-Source: ABdhPJzcIxNUXy6LC3I0SgChiTtXqeLFhQAnKaRU6G+DNBW9dSikIfBW8J+K7sfkc5kBTZUpvahzHQ==
X-Received: by 2002:a63:4e5e:: with SMTP id o30mr34923650pgl.254.1600646644583; 
 Sun, 20 Sep 2020 17:04:04 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e27sm10138477pfj.62.2020.09.20.17.04.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 17:04:03 -0700 (PDT)
Subject: Re: [PATCH 2/9] configure: convert accelerator variables to meson
 options
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920130708.1156310-1-pbonzini@redhat.com>
 <20200920130708.1156310-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <482ee27f-4d08-7490-ab4f-bd74a57d4757@linaro.org>
Date: Sun, 20 Sep 2020 17:04:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920130708.1156310-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 6:07 AM, Paolo Bonzini wrote:
> Prepare for moving the tests to meson.  For now they only have
> enabled/disabled as the possible values when meson is invoked,
> but "auto" will be a possibility later, when configure will only
> parse the command line options.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


