Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2E3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B888A20786
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtQMn1FI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B888A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtCnA-0002p6-W7
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:19:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCmE-0001nQ-Lv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:18:30 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:37670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtCmD-00047n-3g
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:18:30 -0400
Received: by mail-pj1-x1042.google.com with SMTP id o22so1403600pjw.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=gX4bIcf4fqTa9rO3HtF3rEu7z7f9WQq3xbtkSq0ULQo=;
 b=DtQMn1FIdty82c6z0QqL8FoWjCzJpLFDYxVR1TdDW3Z7mwKaA7z4ErKR8BRVPuHflm
 SgVGkyLrwVpXwUSgUILzVq23FZ4pVSCmXUrfLZPkY+x4ZSVf8kLwowOR2VVw1Z27L1CS
 +3TUQOk07bRbU2lcnRu44lCPM8mbwESoKkOaSTjG5ZEnph/3biItaa+EIJAmBsk6fUPW
 Gvt2wUahblsZT1EENnm5FeHbnzg14BTMgFYHy40Ei2C/tpyTwfVyqxTGPQN63B3bgi0Z
 /nDFKYdI2eW0IAMJsa++npbm8/X+Zwn1JF8UK15HbPSgKZGEcEUhRZvEUzY7an7xIB/R
 F4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gX4bIcf4fqTa9rO3HtF3rEu7z7f9WQq3xbtkSq0ULQo=;
 b=eE6w2XunksRZaYPu4NVjUvHurQO6Jo3fACQjpdk9KpJtKBiTJX477JcMN51/RFKNDk
 W+3aL5LOkzVJGwZ6fykMqALDVOCcuNBsRZtgWPLEKbs5EKy/s50xIMLZ1vOp3PeSoy2w
 UThAK/vRVSxXorOZgZ/vSJpoQeVLa1XxVhPT+5yJXejn2qt4VY4b8KNFlv8yuc3KQOVm
 LQnzvnXFkgLcte1SwSM9SQ9ryl0LZWi1AtYdDHkhcvkAWBId0uuFzfTs17dhWgE90wIu
 j41ZL2UNZ4cnYDA0WMGfw+b3N3K69dXTc06iV5CuR0ODF8jdZop/zJIX7830tkwpx69d
 54tw==
X-Gm-Message-State: AOAM531A6NoOGuPQulJFx5UqMFrw7+RkkCNKJPoyn7mAo5vpX5QvYsqy
 G8mHNdhWqcCgygYQcMRz+6YXCv7oKZ4=
X-Google-Smtp-Source: ABdhPJycTmb1dmjJ0l6Nliyi0FRxbGNTEt8P80xSfOKPkVx7X5AUsu0daOtbng6N5xldB56ooARaNQ==
X-Received: by 2002:a17:902:b185:: with SMTP id
 s5mr6252922plr.211.1594225107264; 
 Wed, 08 Jul 2020 09:18:27 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id c125sm280345pfa.119.2020.07.08.09.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:18:26 -0700 (PDT)
Subject: Re: [PATCH 06/21] target/xtensa: rename FPU2000 translators and
 helpers
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-7-jcmvbkbc@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c87de776-3458-204e-e2ca-f8a3a9b0649c@linaro.org>
Date: Wed, 8 Jul 2020 09:18:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200706234737.32378-7-jcmvbkbc@gmail.com>
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

On 7/6/20 4:47 PM, Max Filippov wrote:
> Add _s suffix to all FPU2000 opcode translators and helpers that also
> have double-precision variant to unify naming and allow adding DFPU
> implementations. Add _fpu2k_ to the name of wur_fcr helper to make space
> for the DFPU wur_fcr helper.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/fpu_helper.c | 10 +++++-----
>  target/xtensa/helper.h     | 10 +++++-----
>  target/xtensa/translate.c  | 20 ++++++++++----------
>  3 files changed, 20 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

