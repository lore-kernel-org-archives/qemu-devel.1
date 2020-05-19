Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3C4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42F32072C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0aa1j7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42F32072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbA84-00034O-3x
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbA0J-0000IV-H0
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:42:27 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbA0H-0000T9-RI
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:42:27 -0400
Received: by mail-pf1-x441.google.com with SMTP id x15so528194pfa.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nw6O/vTT+E8Mxtuq9SAx4g0rj9wiZLc+1sIiGwNLVkA=;
 b=R0aa1j7WkOY2GiiHQX+/mXzmvb7PlqA7REwJ59dpfjz0wH2HVMoyX9Z0ndpUXuHK+Q
 /KWjZVitCqxCcveFVsyxWV/sYCuTwTijV4RL0JGZw0XPgKjWOIk9VSRBh85osFWB+J3l
 VEW0UhmXn8xZjsfK5tcyIClZCOuoWjOk7wfU90bTbt7qKEqmgAOa77runt4l+R/G7DjO
 wMcjHx4kk5DG2nnI5DTJJ315ZiO9WjO454KIehB4oV1uxZHA8X+PNwX0RkayewQP9NxS
 rRzQZfo1I5kYj7kBiNKCFK4uKoR+szMThqGoiMiQ6+lE45SnogQFl+oZUYcCqbxT5RVQ
 IPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nw6O/vTT+E8Mxtuq9SAx4g0rj9wiZLc+1sIiGwNLVkA=;
 b=qD/ra91tzlYzftvqm4TRlrqwA1hW8dlLpXvNbMFkj0Q6L55yqQ/8NbJ+PbtDx+OGFr
 dvVwVWtGu+072LXpCc5W4wsFc3q1eX1b0vpIsVbV+Dvz9qZD+moeT3HyucrlfgYU7fH7
 9gWP5lyoVlm9cNk3UdQRA3laOiezFy3ibkjQN1wUv6zWs7+z6944WPuuVrnPCM8vwpK6
 cK8Anh7Re5LZAc02u3E/d6InZl/JHybMZchs++EUj6KjSI7Q6u+C3en4IYC0Iw3kvP2s
 vr2PA+FWZuRLwZFxm4hc6LQCScljrKEtPa/xb2DdD2YfL9fKr8agsdWhog6DHbCYzArb
 NaDA==
X-Gm-Message-State: AOAM5327K80xYQ/t7YGkOs/rwL7/fkPOm9+1G6H7xBK8gcGEByiXAtrS
 Awl9GXEWDt9xUCmManm5KH96RA==
X-Google-Smtp-Source: ABdhPJxnavV4hRyjr6rJbh9w41mz0XHfZeDzrjVDcsA4BK6TEInttraXpc0uqBFmOxNqZ+dmpunDBw==
X-Received: by 2002:a65:614b:: with SMTP id o11mr1059106pgv.443.1589924544588; 
 Tue, 19 May 2020 14:42:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s102sm379040pjb.57.2020.05.19.14.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 14:42:23 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] Makefile: Allow target-specific optional Kconfig
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200515170804.5707-1-philmd@redhat.com>
 <20200515170804.5707-10-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <81f9e132-1709-e67b-9cac-8d7707ad47e3@linaro.org>
Date: Tue, 19 May 2020 14:42:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515170804.5707-10-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-riscv@nongnu.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 10:08 AM, Philippe Mathieu-Daudé wrote:
> Allow use of target-specific Kconfig file.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


