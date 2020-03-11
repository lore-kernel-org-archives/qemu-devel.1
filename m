Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7E1C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E05C2192A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQyCP723"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E05C2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBusO-0004jP-Pr
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 02:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54108)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jBurZ-0003Rh-Ia
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jBurY-0000eo-Jc
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:05 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jBurY-0000cb-Cq
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 02:29:04 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a16so482447pju.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 23:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9tldt3nOApB6xY9/JK1jmqspr0xb2Zx2bndjF11lqr4=;
 b=lQyCP723A5sHW7BW8H/ED70Vm+DMZZWWEIRL5bBOioeaim3FyswVOakeoo+q2X/x2E
 y8utjq5CHt0vLIpiPQzN5s8jMB8eLi4jpaTfr8qoXJQ+xuKnHKss2m8GPxw4G8+mtP2A
 5W08XusL8HT8fwj6x4dBSl+3wL6kRTMxoNIbxK4sSu3FezWwKNnPKcnKoNbHnn7Bw4hd
 1yFiRM40wPTin86PS5SGjCGt59McOSJxRfYsjG5XkiOAvq3TepZERWxDekeFRR441CVf
 TBNYXc2FT6C4bRzPEdT1SujFpuJ4is8XDhiwR03WvcuRGwVbFvml339GvGird+/k62dX
 uRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9tldt3nOApB6xY9/JK1jmqspr0xb2Zx2bndjF11lqr4=;
 b=OaufotouCA0IBBkAzcSqZ6Md2CubI3BISPup0Xw+A8fpg5OjPnLJIUjUE2/3aduxIc
 K9pyMS2bzz5v8RYBI3z3EplFm2NmdbO2tkM6nZ2IGasJogslcc10gthWR1mu9e6SysbQ
 rq7p7BhNtAU8DUWiJmU1PBkOIdZAAtRpcrYMWtYVeDMmccFzp6ECZdU75r8CHaI21u2I
 DWVBIw158IVpdqj1n7WD7u5L0WHNyLgUI6qW5/mq1f3poup5qIkAQOoUhV3wRFrZs4ES
 XX6ckGIWe38R/ZXCPvUtm4ZlOuXpAASDM0zEfjRWB7m5f2Gw2TGeUJoRa357II6ITsJL
 j8QA==
X-Gm-Message-State: ANhLgQ3gSutVlqXGCwNkL2L/Uq8gQDfROQbeExGHftAxb7IP7xmu/gaW
 kLfrB+EZV/B43f7uYcI6Z6D3Zw==
X-Google-Smtp-Source: ADFU+vvPvEVMt7JgSoorsZSJxgmxeXJRqA0AL4Fh5uZn+KkSAiUgyZec0aNeGBISqHLJqAX1SandUg==
X-Received: by 2002:a17:902:d207:: with SMTP id
 t7mr1645914ply.91.1583908143461; 
 Tue, 10 Mar 2020 23:29:03 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 nh4sm4096836pjb.39.2020.03.10.23.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 23:29:02 -0700 (PDT)
Subject: Re: [PATCH v4 14/18] Makefile: Remove redundant Texinfo related rules
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6a36663-5369-9551-c9de-bb60ea7fed97@linaro.org>
Date: Tue, 10 Mar 2020 23:27:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309154405.13548-15-peter.maydell@linaro.org>
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
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/9/20 8:44 AM, Peter Maydell wrote:
> We now don't build anything from Texinfo, so we can remove
> some redundant Makefile pattern rules and the rule for
> generating the version.texi file that used to be included
> from many Texinfo source files.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  Makefile  | 31 +------------------------------
>  rules.mak | 14 +-------------
>  2 files changed, 2 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

