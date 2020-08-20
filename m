Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC2FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3691222BEA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsSGccGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3691222BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kMk-00059I-7L
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8kM1-0004Rm-9A; Thu, 20 Aug 2020 09:11:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8kLz-0007r5-1G; Thu, 20 Aug 2020 09:11:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id d190so1540260wmd.4;
 Thu, 20 Aug 2020 06:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o24q7nEogcRj4IMnZ1uXXN0U56ac22AEmgTqbDO5ecQ=;
 b=IsSGccGWUXk2ES240BqSmVxzrI4iNYXwBqGJuJpBEQ7B6Y3Bx36Os3rcIXecfRU248
 fIaTPx3S1im5ef54RtlgIQnHT9cCvJAmMYd+sxvihWsrPXsCuzjw59+7UlqxEJ9rEQSV
 Tl1nkUNk4tbtbTdi8Xsab9FvYFc5XkVD698nkdeClfE2lKfN16tZltklHEBNzC0GJMEk
 OHilmxzyNFfV/YPf2fsz0ncqi/GJNh0BLXu19B+yltN1hWzsYjUypBHmpbRwQDpXp0bk
 jxhX6tA5WNfv6ab4dC15EsiN021j/RjTvA+85bLqFqlXW0euOm4qtkcU2I1EnWL9rVKH
 Fe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o24q7nEogcRj4IMnZ1uXXN0U56ac22AEmgTqbDO5ecQ=;
 b=Pd5TE4dDvl58jl/m9EV1agQ4piaKzQuQljgQqsmkdg/5RtGptIhJm5cskIbZgT7/tQ
 YBo4RSdCj+EmuoFDmWqsB4qsnztSV5/ZasR9avjRDxQSrj12teg8I+CzgEuckXWVWMYZ
 pziWXqfaCFqDPM9XDt2vIxL7V8FVNxuigbLobx0Sygzay98lRCHZjE1aTGEqw5xjCFR2
 T6S7yefH49Xyv40/d3wC7G7RswuZkBBIbDMcjfDeOk2oDZmvMxX5B+/f57sU5eQq8vlm
 Aia4ApGmQTW4VKw306Q2SzIzv2fHvFXqIiNp+Fuhx/8bliWN5JAeQTNrGllQj2CI2sxg
 weHQ==
X-Gm-Message-State: AOAM532Z0hFjiJZ1YgSVYZuqWNheOL4bOS25sEvJvUAx3ssNMfUCgked
 yMtpouKe6QRp4DHEEbfoYPM=
X-Google-Smtp-Source: ABdhPJw+sgwJVtC+mQ/boy5N4Cg6CJfmhcgBKpQ1MudEhuunKvEVQM68xBQOq6qXL4aZbQW5iMPgBg==
X-Received: by 2002:a7b:c40a:: with SMTP id k10mr3313355wmi.127.1597929097252; 
 Thu, 20 Aug 2020 06:11:37 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l11sm3943430wme.11.2020.08.20.06.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 06:11:36 -0700 (PDT)
Subject: Re: [PATCH v2 04/58] pl110: Rename pl110_version enum values
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-5-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cf45b32c-6acd-2bf5-be24-cebd9a0cdb8f@amsat.org>
Date: Thu, 20 Aug 2020 15:11:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820001236.1284548-5-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 2:11 AM, Eduardo Habkost wrote:
> The PL110 enum value name will conflict with the PL110 type cast
> checker, when we replace the existing macro with an inline
> function.  Add a VERSION_ prefix to all pl110_version enum
> values, to avoid conflicts.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Fixed typo on commit message
> * Rename all enum values to VERSION_* (Philippe Mathieu-Daudé)
> 
> ---
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/display/pl110.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

