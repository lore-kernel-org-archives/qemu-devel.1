Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81078C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 03:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73724206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 03:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJjgSR+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73724206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2o32-0003b3-Es
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 23:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2o2M-00030o-PS
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 23:54:50 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2o2K-0000bH-VB
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 23:54:50 -0400
Received: by mail-pg1-x542.google.com with SMTP id f5so4100258pgg.10
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 20:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=vmxj6nfyrQeB5YefZuszP+wIAmf9uqmW5iDuhIZ2zPA=;
 b=OJjgSR+KovaAf0IK0tD+v4Fh7kqWQ+5TyJQJj2ZTGU9rWIs9pQ6Jj/+yosl8CMGT0+
 8jf94F5qMqpF1utLgV5Sau7WjXsi3Hc0oUIzGxEDzupwuohWnic+8dKMZk2P6TRD7qR7
 tCiST5m7CUd8v/qvaxCNTG5Urjqn9iwIz9bd+lZc+vGLuDs5ntK5ynkG7jP3vWYuFaQx
 TUKRemqYunxDWnkT2NbCULuwEZ1TQpW4J0nwg4WWDJzuNEJn/N/Rx+tX/0FF9PmJ/G8T
 gwUeC2edhbFI1gz9JQR/NYyzObse2sVAJ9GDEWbabFT2aeQ+IPKQJmBmNIkkJVy+qPqs
 OX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vmxj6nfyrQeB5YefZuszP+wIAmf9uqmW5iDuhIZ2zPA=;
 b=WIAiJrpn1+0z61rmqYCJarIzUgCr0DmUjtsubYHGXpySvrkDuz4NvHFH3JspQqqnbR
 a+IeuLYceIehML2ZgKYTnofCoH3GWK/wcM87utyl3IoWmQuzS6rvZDBsD3tBPdGcAP8F
 ok46TXUp36Pdljxn62sxKCXHBFiekle0N77EIjhIaZsKjradGG9Is+3u+dzoCF/DoNNT
 vts3sOE4uqnZsYTUMS4N3ecOjrOHULFbhDqYe5J06lRlySN0Cwc4aI9z9r8xaB3pn5LI
 j1ZReFwULtI833YCCT/TjHiinRs2WpbCLLAdnGeFbZoqpZstZbN3vMNgH7WBh6CZlnU9
 DrCA==
X-Gm-Message-State: AOAM533h9ZazRNOipCKkT0fQLfB3vXG/bZ4P27TI7B7GCx1GKUOAX91E
 GrsYC4tQccgTXfXTfB1KAvIRQjCe+YQ=
X-Google-Smtp-Source: ABdhPJzEUztVQYiy77vTwu04s4BgVs+6S8ZVtmU5U7Peis6m5XkZOCwp1O4Wy9bs/wcoId8vptC4aQ==
X-Received: by 2002:a05:6a00:44:: with SMTP id
 i4mr9880839pfk.276.1596513286569; 
 Mon, 03 Aug 2020 20:54:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m26sm21158962pff.84.2020.08.03.20.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 20:54:45 -0700 (PDT)
Subject: Re: [PATCH] target/arm/translate.c: Delete/amend incorrect comments
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803132815.3861-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8b6b5af5-1e95-c4c5-ec28-027335ef359f@linaro.org>
Date: Mon, 3 Aug 2020 20:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803132815.3861-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/3/20 6:28 AM, Peter Maydell wrote:
> In arm_tr_init_disas_context() we have a FIXME comment that suggests
> "cpu_M0 can probably be the same as cpu_V0".  This isn't in fact
> possible: cpu_V0 is used as a temporary inside gen_iwmmxt_shift(),
> and that function is called in various places where cpu_M0 contains a
> live value (i.e.  between gen_op_iwmmxt_movq_M0_wRn() and
> gen_op_iwmmxt_movq_wRn_M0() calls).  Remove the comment.
> 
> We also have a comment on the declarations of cpu_V0/V1/M0 which
> claims they're "for efficiency".  This isn't true with modern TCG, so
> replace this comment with one which notes that they're only used with
> the iwmmxt decode.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

