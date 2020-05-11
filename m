Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F43C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E237620714
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzDUNRbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E237620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBT1-0003OS-2p
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYBRZ-0001i1-TK
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:38:17 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:35220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYBRY-0001ct-C2
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:38:17 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ms17so8055675pjb.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 09:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=+/vgPwcDENgntB+ynmCq9hgCDYeMvyd4G6CNUg+VgBY=;
 b=lzDUNRbUKQmAEEA/WriPykkREFJfzy+iPpbLeCMl3AUHeX3SCUHtimHD8aUTGvOUJJ
 niv/sA8KQLiNqR8hgIiQg/J+8nLLozRhNw50gnlgj6Ow9Uc8tXzrF7UOcqBD8ehQQVIM
 bSlQhR3NBbwyZCuk43lIWkav8scXn/+MY58YXAWQjHLWrtyLCuMfzCwoUWWpgGkYmeeg
 0tu6vJzUBCXC/NlyGgDqIJujT0NyHhvzlXOLeekYr2ckUk+iWmnx7j8f4VwtQaF7nXjL
 bz0bksx+MNCx/FqjIxpnMbaTE/H/8cipjiRIMNsBTBraujJgemCJ1Z/1BXHUAHjvOeYz
 24yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+/vgPwcDENgntB+ynmCq9hgCDYeMvyd4G6CNUg+VgBY=;
 b=DeCZqcuahxGJluK4hpwJS3Z0MHKKvgr5mV99NIDZDXTNctfojL79/AOmoHP7qpg+1N
 VhPQgD+cwahE/eIBKJzK+zrkz8Siuq4iXvZN+fYPLjMllk63zSLj2ruHLLzy3Xsgk2cu
 1pcfDy1EslPElGurA5+98PnDqFjgtPvtTRazt9hrSpnXK5QJBlRS4G2xIuIeKTh/pn1b
 V2A+VYvDg/qlPAo/GeIhf4pRZF4WqPkCcxTdibkgGhCQ1v2tZCz7Gqnig0wQP0j2QvHX
 oCq4QdansitY2W7nGZ/V0Kw/lNkrWLP+UvBIq5rIa+eQL3B79rxXpqcUkrTakdRVB7/2
 AO9g==
X-Gm-Message-State: AGi0PuZh/Ll6e/Wsw7D6Y5P+ct5Ylk9aSNhIi2WrQl5BK/2LK18rTfAi
 z7SkUfn/lAZ2N5fpRSIOriaenpu1iqs=
X-Google-Smtp-Source: APiQypKB3Qr3V7lt5Y+c1Rk/Pn7uAZAp/NOcO5ZM/ovorBkgmZYuDitzGV/bINzxpN79+fl1eFX5hw==
X-Received: by 2002:a17:90a:8c83:: with SMTP id
 b3mr23432102pjo.141.1589215094409; 
 Mon, 11 May 2020 09:38:14 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id y8sm9877300pfg.216.2020.05.11.09.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 09:38:13 -0700 (PDT)
Subject: Re: [PATCH 0/3] tcg/s390: Support host vector operations
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200508155745.8223-1-richard.henderson@linaro.org>
 <9c9ce42c-f283-67a5-194a-7d973ce9a3d2@redhat.com>
 <253a16ad-a964-31ed-32f7-b0eb87287249@redhat.com>
 <b93bbbfd-e363-9c40-b2d7-d2f901cc1874@linaro.org>
 <51cf0f04-8c3f-9783-da6c-38b29ed2597f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <59e505fa-6cc9-2ce5-7413-61fa70f1570e@linaro.org>
Date: Mon, 11 May 2020 09:38:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <51cf0f04-8c3f-9783-da6c-38b29ed2597f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 8:34 AM, David Hildenbrand wrote:
> Yes, compiles with that. Where are the arm sve tests located, so I can
> run them? (are they in tests/tcg?)

Ah, they're risu files.  I'll find somewhere to share them.


r~

