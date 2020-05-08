Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A93C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5053A20725
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4ewhurJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5053A20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5TG-0000TF-DK
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5PN-0003jS-Ss
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:59:29 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX5PN-0002hM-1A
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:59:29 -0400
Received: by mail-pl1-x644.google.com with SMTP id t16so914711plo.7
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HOMmb0OB3xpv2TR8F2Rn038VKNn18AkT91a3W5PX7Sc=;
 b=T4ewhurJhTRrSVcnNjZUeXw1+PHbGnDuUXBOQTromtVpPeUEW4K9t3vdIAf0cG3Ib8
 85QymjyWYu67nxak2ApZK/FDXStyEEAdTknIIrDuPPxRKwXauoZBtDEFFyzQdTD2NkLd
 5RKcqXpX9EGkKCXAEhW3BuzRVLwUJ15EIbqiqAlFLItm1zGlGS8pVnxswQ7gq8Q4v7rL
 wHpHtZOx3UfuLKHS9nCB4YmGPzM1IEtHqCJWn6LwzafweaEYTpJmLUZc62HPogMPtCSo
 OS5GCQlZtsxHCNTqcRus/sQFa+fTFJTbe4yxzC9RC7PEy++n4dplaZQoQCDwWzWGonyK
 anYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HOMmb0OB3xpv2TR8F2Rn038VKNn18AkT91a3W5PX7Sc=;
 b=DOcYvaUhYR4O/Stl5NtZ8KylugXRFoeRFVdO6ADV6VKYHV23SXNLL1mnK7P4h8Cc2H
 b4RnA46Te+dsp71bVUhP3pZdYQbPGBK37i9Ls2broHHWkZ/de+rbz4/PcQFGgP3gPwXJ
 bFkdCCigPLvAE5lObFFg9K2qE/5p5fthd0424np88ymfnoHVj8Q/kGxKAyN8SyDQDRqw
 VdSw7KjmJ2L1LogICXkbUgAEOo/vmK9IH10C3zk/UYRaIbZ4Fp8EqYHxcEPiZziu5m03
 p3UrfLfhJAbcD718GpIU+gUnsJ/Bt8W6MLN3WO0VZsV9k4uW0SiuztcZxxGLTU8vvLt6
 RwcA==
X-Gm-Message-State: AGi0PuYqI9t2Fjf26LaF2oITUoGvtMNtUo9bHa5Z7BYHOVZSX6G15WSY
 zs1ewpd0nqnulhZvz9V5oB2fdA==
X-Google-Smtp-Source: APiQypLp3AP6E2XRsSRh0zqeQQbmuQN2BrFcfO89TYopgBqBfUMBHIcsScz9qsstG0l03fa+E3hjyw==
X-Received: by 2002:a17:90a:e38c:: with SMTP id
 b12mr7216613pjz.102.1588953566260; 
 Fri, 08 May 2020 08:59:26 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id k5sm2756865pjl.32.2020.05.08.08.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 08:59:25 -0700 (PDT)
Subject: Re: [PATCH 0/3] tcg/s390: Support host vector operations
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200508155745.8223-1-richard.henderson@linaro.org>
Message-ID: <3791ad15-2493-5e4b-57da-94f3f2f1c4f6@linaro.org>
Date: Fri, 8 May 2020 08:59:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508155745.8223-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/20 8:57 AM, Richard Henderson wrote:
> I've had this floating around on a branch for a while now
> It is able to run arm sve tests under qemu, but I have not
> been able to test it against real hardware. 

Dangit.
I hit send right as I remembered that I should mark this as:

Based-on: 20200508151055.5832-1-richard.henderson@linaro.org
("tcg vector rotate operations").


r~

