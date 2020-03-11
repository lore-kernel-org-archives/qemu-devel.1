Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C669C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D5720873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4Mv0iXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D5720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBuYF-0001qo-Et
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuWt-0000Gd-EL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBuWs-0002U5-AH
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:07:43 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:40261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBuWs-0002Pu-3w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:07:42 -0400
Received: by mail-pg1-x544.google.com with SMTP id t24so582559pgj.7
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ynVFDAVHRMXzjhTETbeEqT6drJLSieuhSrJ0R347rog=;
 b=F4Mv0iXApd7DbZnymDbmN0rUL5urML6hx3qvbUx5XO5rMSqi0uV0KnVVqIE5Liaszb
 Jy8+yGtdljSPKdtN3Aruv/Fa3HfUCn4CApkbC6WRxjngEXQYTjEGXtNeJgYyj8ul+A9N
 /HyBiOw3Sf3+TOS/p2qdEVZ4QjwpaWz4G8L4yh8+gJC+MlsFVWlEnW3ZvrXoLynPijoE
 6thlmsFlKQIHwxaeWbhbtEVg/5h/O5eTb21TOZwdRWVl9elWLelttbjBDImYAVN7P49Y
 8uDF13zihPWW6AhbKvJZX3ML9omirFOh95s7Ui/iWDhePFf/p3l5CUDOKzGHiOHPY05G
 NLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ynVFDAVHRMXzjhTETbeEqT6drJLSieuhSrJ0R347rog=;
 b=IFADKI8EACoSZA6IWdln2ICRK3OdgZlZI83xID/p5gFl97Gd3G2sTWwdydgYKnJCye
 qMQM8C6Qx7DwZZdsCJhxqaadPqbsiLwmmpT0hHuxJtdkDuedWBXKCZtdf61ON31prqO2
 pc7UC4t/jejaQU3hCnUomoCbdYGy6P7UAvorqBtkqIY3BsDpJ2Wf04vqbyUU53Mrvqvs
 GQCCljklmikXKDB5prVnX5Th9vAP9Y5tM4ODixf/kkM8PSuOg7ba8oL6J/HwsXSGEy+f
 QxWUeH+wuBPBb9twOFIsZtDNAxrmWvnrcursX327ZQnv1Km8CWZW2TtFEsY/w1lPdm4E
 0XDw==
X-Gm-Message-State: ANhLgQ27abLJJDIpLUGU7Xr6WPbWreSB/FzgFcC/FmjE3/1lz/tMVe1u
 W3wLckPKUD7ZD1hQiFAMcUDyJw==
X-Google-Smtp-Source: ADFU+vspIq432Rs1HnAQfAqFg2BhHfNA7szsNtCcgbDnhD70Cfrd1RBC5CNTAfxn4X6vnvNH8yHnnQ==
X-Received: by 2002:aa7:80d8:: with SMTP id a24mr1336751pfn.140.1583906861007; 
 Tue, 10 Mar 2020 23:07:41 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 h12sm33638758pfk.124.2020.03.10.23.07.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:07:40 -0700 (PDT)
Subject: Re: [PATCH v4 05/18] scripts/qapi: Move doc-comment whitespace
 stripping to doc.py
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0284e957-1cbd-83f1-e734-1c213e83c044@linaro.org>
Date: Tue, 10 Mar 2020 23:07:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:43 AM, Peter Maydell wrote:
> As we accumulate lines from doc comments when parsing the JSON, the
> QAPIDoc class generally strips leading and trailing whitespace using
> line.strip() when it calls _append_freeform().  This is fine for
> texinfo, but for rST leading whitespace is significant.  We'd like to
> move to having the text in doc comments be rST format rather than a
> custom syntax, so move the removal of leading whitespace from the
> QAPIDoc class to the texinfo-specific processing code in
> texi_format() in qapi/doc.py.
> 
> (Trailing whitespace will always be stripped by the rstrip() in
> Section::append regardless.)
> 
> In a followup commit we will make the whitespace in the lines of doc
> comment sections more consistently follow the input source.
> 
> There is no change to the generated .texi files before and after this
> commit.
> 
> Because the qapi-schema test checks the exact values of the
> documentation comments against a reference, we need to update that
> reference to match the new whitespace.  In the first four places this
> is now correctly checking that we did put in the amount of whitespace
> to pass a rST-formatted list to the backend; in the last two places
> the extra whitespace is 'wrong' and will go away again in the
> following commit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New in v2: update doc-good.out as noted in final para of commit msg
> ---
>  scripts/qapi/doc.py            |  1 +
>  scripts/qapi/parser.py         | 12 ++++--------
>  tests/qapi-schema/doc-good.out | 12 ++++++------
>  3 files changed, 11 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

