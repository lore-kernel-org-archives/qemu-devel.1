Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76955C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD8822365
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nc/y1LmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD8822365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLEN-0008LC-Fm
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLCY-0006PU-Ny
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:42:30 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvLCX-0001MU-9V
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 09:42:30 -0400
Received: by mail-pl1-x643.google.com with SMTP id w17so7034104ply.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oNRvZqnotmfgiTQwVx2eaB/jGXOxlLMDWnznhPdG1TY=;
 b=Nc/y1LmQFgjqwIiY2bki5oWcFn9odzLaLc2QL4xfGEKMMxAE9DcGYTDm5FM/QW49kg
 Fc8gr0r4rfwtloOZ/nq6ZFTh0bx3N1H30L3dVf0m1JMKoO9I9LD6Kz84mG4hcoPAW1ie
 8kPB4/wrYv0111jIhPIMEmhm3npC+C9nKxYT81twjQbxp+T8ML4ePB73OqpS9a6qJIG+
 ySDtEEtVcyQwDQy8rooTuUdH63mGWiLpsfRmagCDE5KNOt6jes7F2TtEdOEOJ+UGHJw2
 5H3JQLZBsGbmrJWKQ5oF/4AWqJa+Z8vI86yMehBc+kB8vea+K7fU2AsTFxBjGhLtfmoU
 Yakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oNRvZqnotmfgiTQwVx2eaB/jGXOxlLMDWnznhPdG1TY=;
 b=pYWo6XiZrull8ODRRFBkXdCKV5OGHQxsMz/SGC9XQTpLua8TDRiWbTDgXArG6+Sgbc
 RlfxrKLGUVdEA5WAp/swvQnLbPmJ00cPPZyN7QEVVYY8o1VrfANRdlnRtbJeAwR/JxdN
 EwwVH7NA9FzoP1rT/xfMAMCZ/xgsd7X6Q+MEK3YpwQBh3UYskyf/FI+aooTesvssTfcN
 a1ACZ7VWFV2a8cbsSNE9/rRLcihH7eJRfdAhDRk6BMsbBbJ8IeAzlAF3QmLd1VmtZXAE
 BGbxg44XgTTOO4CxypeVX2tXZzS6B8N/tIWOhY+jk3Xss2eV9IBvkiAvVpVQjAj8wuZo
 mKmA==
X-Gm-Message-State: AOAM531JH+cpryZn8McsBj4dHjzb3Zrwtk4pcQdjAk0BhCx/2FUQY1R2
 KcLV08avWW0IXCOXDaPqxgnc+A==
X-Google-Smtp-Source: ABdhPJxk1GqHvL9SiCzGxjzQHQxEmIgSEH7Gp4kownvzdR5kOnyP+mK0ZdfBTlXQov39bgnYOosCPQ==
X-Received: by 2002:a17:90a:1fcb:: with SMTP id z11mr637498pjz.1.1594734147790; 
 Tue, 14 Jul 2020 06:42:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z62sm16846063pfb.47.2020.07.14.06.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:42:26 -0700 (PDT)
Subject: Re: [PATCH] scsi: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594600425-22997-1-git-send-email-wang.yi59@zte.com.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b349c14d-f4f2-8653-6b3f-51754c7bc35f@linaro.org>
Date: Tue, 14 Jul 2020 06:42:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594600425-22997-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: xue.zhihong@zte.com.cn, qemu-trivial <qemu-trivial@nongnu.org>,
 wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 5:33 PM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  scsi/utils.c | 4 ----
>  1 file changed, 4 deletions(-)

Cc: qemu-trivial
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

