Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A091C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:40:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F40A20774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOEsyC9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F40A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6ecb-0005Xj-Jy
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ebu-0004j6-TG
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:39:26 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54330)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6ebt-00080v-BR
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:39:26 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mt12so4814123pjb.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3mZRzk29/Em3zsA1mId6bKM5iWwy/INWoJ4Zt2VTCkw=;
 b=YOEsyC9JIRDgPoIPhWcHurvwiBX4xBIoTdGAUn7uBwiq4HU6oaJ2ef4FB4JEX7IE+N
 iz2ZlbXChkBGm/pmX+0UIWEA6ZO3M6o1MMzlflt9pP3mbHiwDNigbsP9Lhg45efD00Jk
 c6PxLkWX2BvFBbiCAtAiV1X+arRAAMz1tRmsiIFJkh4U2QG11ER8meiaxQ/PApr7bD0L
 Gm0P02CkeCX/BODLABvgrSQbEhJDPUNoei4aBE7SFEzA+Aw+AmRG8JgVvjY7gt7dNRyL
 oHEqlC9WvDA80mnAjxbw2UqZ/bSIGZT0pjIeZLZaYuvy4VsnVqtcngXpAIEzqQCgjjbm
 b/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3mZRzk29/Em3zsA1mId6bKM5iWwy/INWoJ4Zt2VTCkw=;
 b=d9YDI0piIipLGhkT0MBjcJh1cJ8UWwqe2/8jlfFyKRYK/xg8DaLui91ARrA5xLERjW
 N7Aaxn04kYvdMHQ+SAfH40nVsmltiqbBG1+jzUnN5d+jYzUp2RXeOIU5zqaQZvZAmthd
 mIQOhdsgxnUmKU7+3FCt/DBHWvo95aV5f9VQPYKIJlEzF4kvZBa864YqvFdxY6eAPqmd
 7ZNccLhLgFSRHkE+Oj0N6exXr307NfIR6vtfW1HmBqnW8TWaMy96AQISXfBEstuODJzz
 7Zlws9jFQmucVqM7FTjYEHCX3o1r6vXpMC2gEvOIAEJJ6BnwdmFn6iRg3bFRL+QVMJuh
 Jxbg==
X-Gm-Message-State: AOAM533wl1qZlEohMzMf7D5QSdE1FuVbUXx2MDVJBzjYxnO87l69nkit
 iEpdC5UlVTB5gLQ7acAXkgjRhw==
X-Google-Smtp-Source: ABdhPJwZUFzEIDvcyW8x9/gmHsmQuO63B0SCdhgRfKhKUyiOK+/CVTcgSHjXpnZkrNGAb4cv/m0CgQ==
X-Received: by 2002:a17:90b:514:: with SMTP id
 r20mr3452131pjz.82.1597430363988; 
 Fri, 14 Aug 2020 11:39:23 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q2sm10144357pfc.40.2020.08.14.11.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:39:23 -0700 (PDT)
Subject: Re: [PATCH v5 03/20] qapi/block-core.json: Fix nbd-server-start docs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07159777-56ca-4ca4-9929-84e0123f3619@linaro.org>
Date: Fri, 14 Aug 2020 11:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810195019.25427-4-peter.maydell@linaro.org>
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 12:50 PM, Peter Maydell wrote:
> Commit eed8b6917832 added some new text to the nbd-server-start
> documentation in the wrong place.  Since this is after the 'Returns:'
> line it's parsed as if it were part of the documentation of the
> "Returns:' information.  Move it up to join the rest of the
> "documentation of the type as a whole" doc text.
> 
> This doesn't look odd in the current HTML rendering, but the
> new QAPI-to-rST handling will complain about the indent level
> of the lines not matching up with the 'Returns:' line.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


