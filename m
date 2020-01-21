Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDCDC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC55724653
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFNR7WK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC55724653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu0EF-000201-52
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 15:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iu0DK-0001OQ-Lz
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iu0DF-0003zQ-N2
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:33:30 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iu0DF-0003yo-Fe
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:33:25 -0500
Received: by mail-pj1-x1041.google.com with SMTP id a6so1930558pjh.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 12:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rzDLu7zzlZJnzKHfhJAvf16GOv2j5NaOBBqz7W88CkI=;
 b=jFNR7WK+75cPMJ3VueEspfOUg0lXT5StodWw4aX5RnXWPx7bmG291gyCzYXd8pWn+k
 wlWNACozyvFsTfUgAn+egwgNGE1VYtrSaCuv7vhNEDC1uTsUA8Q8aWcKDY08TJdeNP65
 60q7U+KiB1ef6ngrfsai4ye8YiC28BDPH/WXqETzjMN3G/I0JuPo54VBsCBOfih0MCsc
 us3W/2wfq4ltc5hscpChCn/aAG/fNJifHsKwP7jZ6pNMMsN0BRsBUj8tA9EWWPffcPe7
 CjgugxyVjUksDO+w83NDLhvrx7ij+h699XaNKgHo1IcI/qN889PRq9uYrrm/rDGZ3BWG
 ckJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rzDLu7zzlZJnzKHfhJAvf16GOv2j5NaOBBqz7W88CkI=;
 b=nubkI3+nVAWc5Y/2UlWMenc72E4n3R8iUzJ5pocLCLnKowzs55kWO+dXO7YHo8/00s
 3gUyD2Qh4ZgFPcvJiSqZGMLACkfXgjbWv5WMp9sO/uptdbH5bwdO6bvfKzjci6+7SiLp
 T4UIw+v7ZjIjw6440rb5/bWHq8wySNxD7xCpOYpbtJ59u3LvEZIwbHkl3VV1UZHF9l6j
 OOgKff35Yrx8dsTIMqC40DWWWj2Wc1zjD8IGNR/Rhb7PW92hHPS0GQO18kZ8MZb6lD3z
 lWDI/iL276yB/IX19mxVLEMsmBWcnQGRPIqhJw0TL2omDcjK53e7hOqKfqWHXez824Oo
 1x6A==
X-Gm-Message-State: APjAAAWBONwwyVCBFKZ+ZV0mZF4wfeI32n7qpMsnUXz0QP8KnDVxAYXJ
 1FnNDtiqqfYGKbFjmsh4jlpZSQ==
X-Google-Smtp-Source: APXvYqyThtsjNVW7qPlKH1KL/YuouJwUMJilRIWw2aQiPpzsQJJUEs7Ey3Whrqr9zu1gnj5FzE2Q1g==
X-Received: by 2002:a17:902:a5c2:: with SMTP id
 t2mr7183042plq.86.1579638803952; 
 Tue, 21 Jan 2020 12:33:23 -0800 (PST)
Received: from [10.5.50.117] (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id i8sm44875926pfa.109.2020.01.21.12.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 12:33:23 -0800 (PST)
Subject: Re: [PATCH 1/5] hxtool: Support SRST/ERST directives
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200121191033.28195-1-peter.maydell@linaro.org>
 <20200121191033.28195-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc15214d-664b-b6e8-87b4-80b1de4be821@linaro.org>
Date: Tue, 21 Jan 2020 10:33:19 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200121191033.28195-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 9:10 AM, Peter Maydell wrote:
> We want to add support for including rST document fragments
> in our .hx files, in the same way we currently have texinfo
> fragments. These will be delimited by SRST and ERST directives,
> in the same way the texinfo is delimited by STEXI/ETEXI.
> The rST fragments will not be extracted by the hxtool
> script, but by a different mechanism, so all we need to
> do in hxtool is have it ignore all the text inside a
> SRST/ERST section, with suitable error-checking for
> mismatched rST-vs-texi fragment delimiters.
> 
> The resulting effective state machine has only three states:
>  * flag = 0, rstflag = 0 : reading section for C output
>  * flag = 1, rstflag = 0 : reading texi fragment
>  * flag = 0, rstflag = 1 : reading rST fragment
> and flag = 1, rstflag = 1 is not possible. Using two
> variables makes the parallel between the rST handling and
> the texi handling clearer; in any case all this code will
> be deleted once we've converted entirely to rST.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  scripts/hxtool | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

