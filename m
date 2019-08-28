Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF24C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3906E22CF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vGuBL2Dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3906E22CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i35nx-0001j0-Ch
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 17:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i35mu-0001Ex-Rm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i35mt-00057r-Hm
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:47:32 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:40349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i35ms-00057b-Pn
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 17:47:31 -0400
Received: by mail-pl1-x641.google.com with SMTP id h3so562152pls.7
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rQoVG1rtUXmHb8EaSqHytkHb3hwTI/ksBdXXJjm8lvg=;
 b=vGuBL2DmZWQ7xrB4EyY6KFRYDkCDzwOUO0REy31tt4N8AMSGgOylKd2jXzrIbydyER
 BPoP/WpY6ggyhiq+0cbmrJVv2JnJKKW1zn+qnnEiNV+ake/BMnBFAsv9AoYlaEL/HPb5
 nxnD1/cjUkwV7lmmSn9+R/Xb6dJRXCjy8MiqH8AiBOuDsIpzekgg6YnJQOFb6/2uHhXl
 YAeJTD6px6P75KpbBhXaimcSnGJk5zpuBMZYkJtcMM3UjHgOSUQ94PLx2ZOy3nL2WmDZ
 nozdnCe1aH0voEtKEW5inbnz7618txClXYf1eq8aGWLM/XOCJFMydmK58csf4chIo/6h
 IgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rQoVG1rtUXmHb8EaSqHytkHb3hwTI/ksBdXXJjm8lvg=;
 b=nbSIBTJ0IG7g7YloquuFbrGgInPsBSV+vvB8h2eQf4riCa+OYgpy4CZpiwyh9+u/xE
 /hTR8AmM1oJr+TMgynINauqkyULJFTI1YY0jDlX/QRjqzxJ7J+XZ67hPMhdL7oKOCHiZ
 E8wX+U6bb6YGMmz4oe//7C2LyXtjJH5/kwKz9fruWvBmV1so2aLWc4VyLe80O2kLIPF1
 dQjkGZoeVmJmXC89uGaHo1ttTZY1VKkKbFbRVUragfyTv7axg/Ovyhff9ytjRWKnrLf3
 kRAxwEHGxxbKwEUjRVopAyEZj1lVVjHbE+Cfjm8uy+5v0OhYMllrSuxiO21GCI5fVqfy
 iHdQ==
X-Gm-Message-State: APjAAAVVqleQm3VwR6YlpSTsWLY3ENMbb0VIgA89DM0IUsPGYlrbf1de
 aLhqoYk0D4flGxoBmkolQ5Y90A==
X-Google-Smtp-Source: APXvYqx000l8j8c4n+NUsUv0NJ3wBLXO8PB7l0RfLuF161/K+2VAIZRt4ricKBhxWPMDBllSgwXHRA==
X-Received: by 2002:a17:902:d:: with SMTP id 13mr6340078pla.226.1567028849212; 
 Wed, 28 Aug 2019 14:47:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d6sm125231pgf.55.2019.08.28.14.47.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Aug 2019 14:47:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20190824213451.31118-1-richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c67a2220-3800-5ac7-1398-d1fd1615cce8@linaro.org>
Date: Wed, 28 Aug 2019 14:47:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190824213451.31118-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH 0/6] exec: Cleanup watchpoints
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
Cc: peter.maydell@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for 5/6, as yet unreviewed.


r~

On 8/24/19 2:34 PM, Richard Henderson wrote:
> As discussed with David earlier this week, the current implementation
> of watchpoints cannot work, at least reliably.  We are raising an
> exception out of the middle of the i/o access path which does not
> even attempt to unwind the guest cpu state, nor does it have the
> information required to do so.
> 
> This moves the implementation to the cputlb helpers.  This is a point
> at which we can and do raise exceptions properly.
> 
> In addition, this fixes a bug in that unaligned stores were detecting
> watchpoints in the middle of the byte-by-byte operation, which means
> that we didn't signal the watchpoint early enough to avoid state change.
> 
> 
> r~
> 
> 
> David Hildenbrand (2):
>   exec: Factor out core logic of check_watchpoint()
>   tcg: Check for watchpoints in probe_write()
> 
> Richard Henderson (4):
>   exec: Move user-only watchpoint stubs inline
>   cputlb: Fold TLB_RECHECK into TLB_INVALID_MASK
>   exec: Factor out cpu_watchpoint_address_matches
>   cputlb: Handle watchpoints via TLB_WATCHPOINT
> 
>  include/exec/cpu-all.h |   8 +-
>  include/hw/core/cpu.h  |  37 +++++++++
>  accel/tcg/cputlb.c     | 156 ++++++++++++++++++++++++--------------
>  exec.c                 | 167 +++++++++--------------------------------
>  4 files changed, 173 insertions(+), 195 deletions(-)
> 


