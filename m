Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E037DC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4855220723
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 00:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L/4LdNIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4855220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK9kE-0000HR-77
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 20:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9iE-0007op-Su
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:29:46 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK9iC-0005GV-Rt
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 20:29:46 -0400
Received: by mail-pf1-x442.google.com with SMTP id z19so7739319pfn.8
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 17:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=t9Pmofu/6WbqSY/v17Cn5AxpT8BxL6blRlpDZEBlUYU=;
 b=L/4LdNIJ5JNKYngBH7pFupXMrVRXrmNfmj3uN5LW6kcEcTSDVN6abQORzsGIuDzQ8A
 ItS4yAJCluen3UIRc7Lqfxi8wk2b74B9xzkvIcS8N566txnYEM5buAMT1mqdaGKQw/+h
 eJdbthc8Z5/6EyU7xxYs4uRIhmmKeN4sGTrtRR83jtoNQ5ZTjciTxCBmvQkBqgw0B+H+
 11SYdFwDPYj6rfmt0Fe6zHG0gg1+NliHQicOqgivQpZc4PzkTN5wta/SlX7fwWCl5s/z
 ApnISEgYzI5aECy/bPAenMmHstCFMENC94lfLSaSEuCFAuJP8NFWTLoCi22PMcK4SNx2
 GVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t9Pmofu/6WbqSY/v17Cn5AxpT8BxL6blRlpDZEBlUYU=;
 b=P7dvzgJB/3mgc4gKUyei24qffsP1MWj+7ev6KQNkWy3xq8A2aBhUx5599X4qg8qVtN
 yXkPP1QRNQorJ5ETbeFzw3qpPCPSDVQecQ5QXRlOD9Vw3j6RoW/E3sSDMSTag/Z8wFgR
 swlka6DxHQaV5UtacmbWuMMC8GhTo4+9bJnReYx9wLGQtXL53ey1FN0EpZo/SwznC6EP
 R9bRMG28uWPAIIZq1NyVtCh1tt0Io67e4Y9uPZH3sjQ0lssigb6a6cqmICCgTp0UC5zA
 2AoDCXY5f/LxiWolGHPo0rqxejI41evKbnz+MUW5PeLHh2zCQ0pFrXOdfl45HNKHIY6p
 FOvQ==
X-Gm-Message-State: AOAM5316/IdDzyFSz5EHL9spKgCvW992NdICsoX7t5DKDIVUq76DonRM
 s4JqTQuVQidzBMbK5vVX+JxYzGRSmkQDPg==
X-Google-Smtp-Source: ABdhPJxcHHOkQe2zDNV3w1EQY2+muxrY6OoSBFXfg24+BUapxUpA87Vva0+qBwCC7+57G1Y9K8Nblw==
X-Received: by 2002:aa7:8e54:0:b029:142:2501:34d2 with SMTP id
 d20-20020aa78e540000b0290142250134d2mr24711620pfr.43.1600648182840; 
 Sun, 20 Sep 2020 17:29:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i73sm10424505pfe.67.2020.09.20.17.29.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 17:29:42 -0700 (PDT)
Subject: Re: [PATCH 8/9] default-configs/targets: remove useless lines
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920130708.1156310-1-pbonzini@redhat.com>
 <20200920130708.1156310-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3e7c8af9-f110-13d2-b522-f5cff6490f16@linaro.org>
Date: Sun, 20 Sep 2020 17:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920130708.1156310-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
> Some lines are only meaningful for user-mode targets, remove them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

This seems like it could be folded with the previous.


r~

