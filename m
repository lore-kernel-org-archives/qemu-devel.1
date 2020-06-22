Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F64C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:48:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6163F20732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 14:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKpuHn+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6163F20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnNkh-0008ME-KS
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 10:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnNif-0003hP-9d
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:46:45 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnNid-0007yF-PE
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 10:46:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id q2so14528502wrv.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qi/0e/MFri87LCuOb+a8jEdahJIOH8EELnd/YUdgNnc=;
 b=FKpuHn+DzAr9dqQZq3DuTWuSeuOvSUgbXGYhjid+TzBXx+4Zrxldi9An4cQ4IROOJC
 U44yANeg/WHoz3pv/fW5dpKMdPvYvmJ2/dWGIfivpWc+5LSguzID8eQDjB9n2U72VZyE
 mLNlHBhBRtMTOhFnroGVD8hSMPf1LmQwi5aKbsHMr0ejTBPmKqvXtzS+z5K+a5HLXfbm
 xpfBMN5l79/N83MgKQq0bEnJzpDslGRqo7nk2GnA6mbrbXSJJxR5seaJBftCt9n+8q73
 coqFsbwJID2nugh14trUjbYgtAnoyWundAxM+FLBTltDnX+d+DVdjLsaO/G1kBEpWmXD
 ZFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qi/0e/MFri87LCuOb+a8jEdahJIOH8EELnd/YUdgNnc=;
 b=ak/axiGPMcsbcgja4KaJ+n/oBVHGGUXG9iYCW72DNLiUCwDNWvozSHqZvTVZbS34lX
 7Uh0YO4pDSJQPnXQkXnSxwJQGaXa08AFxxyFQ9fnx5Lt2eRI402uq8M2goqWd68QE4gg
 t2jUG1sFXtcuCDKFD4nhFhmTRa6Nh6ezcpgCs8o0tz/0Na+yyzVFODIw+yeYTF5Csgrl
 9Z9Nt85yjTBYNlvqRkwrHqcc1mpub78buD1iHtYhaqV+k6s0MB5l7a61q2VGE3/MgOJN
 e5AvzLm4zcgWm9qRPpowkUn/xMzFeZDcimqaPa+75AWL3KlI7jWgnX/xhfEwneth2zfk
 pGIQ==
X-Gm-Message-State: AOAM531o9PtHrG2b+IH91lm3xcI1ASrV/gtv+qi6v2S2icvq3y145E1W
 ayGVkQSLBLRRB/0TVCxveIA=
X-Google-Smtp-Source: ABdhPJxE6T//FchXl+coejelHUHYNdSi2rgsLpfNjDbhjy7kR/HoaMzQ2768MUm/FCS5ShZEdFoKIg==
X-Received: by 2002:adf:97d6:: with SMTP id t22mr18568338wrb.385.1592837202371; 
 Mon, 22 Jun 2020 07:46:42 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l8sm18122064wrq.15.2020.06.22.07.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2020 07:46:41 -0700 (PDT)
Subject: Re: [PATCH v1 13/18] tests/docker: check for an parameters not empty
 string
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200622143204.12921-1-alex.bennee@linaro.org>
 <20200622143204.12921-14-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1f7a40d-85bb-f8b5-cc0e-298090cb3f64@amsat.org>
Date: Mon, 22 Jun 2020 16:46:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200622143204.12921-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 4:31 PM, Alex Bennée wrote:
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/common.rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 02cd67a8c5e..b27ce17e333 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -47,7 +47,7 @@ build_qemu()
>  check_qemu()
>  {
>      # default to make check unless the caller specifies
> -    if test -z "$@"; then
> +    if [ $# == 0 ]; then
>          INVOCATION="check"
>      else
>          INVOCATION="$@"
> 

