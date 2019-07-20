Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D9C76186
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 21:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEA42082F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 21:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQVpZWme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEA42082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoxHV-0007i1-UB
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 17:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoxHM-0007Ju-AZ
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoxHL-00019o-Gr
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:52:32 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44982)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoxHL-00019D-9w
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:52:31 -0400
Received: by mail-pf1-x442.google.com with SMTP id t16so15618391pfe.11
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IPm9Swq8QARMf2ewL/0kA+yoI7ylw97LY4staBmRKgw=;
 b=AQVpZWmeVY934q15e17AfcMlErZ+E6tE0EXrhLlG8iKIdizE3dmYI4nrzeoeHIejMi
 1/xGZzpKah7nvMfmlDkdnww2p9shyyaQxomjyIrhNuuCOm84NjaGF1UIEqCJQEjdxGet
 QhdUkA0MOQ4Cw3QQ0KhQCpgGW/R0mKbUJLzqC3y1Un7Bkkjqw6NGNdjWLg+agBPySKvE
 k4uKnqyrr/LRGuTSfNNA0wxiVlOES5KX1Awzu6gDl/TNtvtTwiKSMNcuSicMqhGcTRQe
 Z26fDWGg3Ut7odxvMZgXfHHvm4NXcUlRLoHSGHjxwQnRhHOCzqe+BUrEN6mYBWTv/Eij
 KCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IPm9Swq8QARMf2ewL/0kA+yoI7ylw97LY4staBmRKgw=;
 b=bQ/LG8qch3xxxo6khJ4JkjQcNKHtTGnf1k3QFxqxXuEONDPFi0Blzu591VNDR/wfI0
 orB+uAHWhc25BMTaasu0WHNNQrmkq+xnTqB1AjRMrAIVt4A4dIogasUpy1gKK5npsWly
 WQTpbbI6jcZJp8XbRHKSJvWNAEtF9oIgSICCcFIChZHoZf12n6DEJL3YK5lQ9AoCmZ+m
 sBERNdMti2oQHotEStYNRACtK2ERCq3373tHiCtznbcA3BOdoDHWtqysQ4KjOctWAlNR
 zB3jwFCJUXvtlzxs4IZMqfa7EqFvEhbUpHn6Mc8AVwuef3SEVz23kKGUfFjEwP3apz7l
 f8qA==
X-Gm-Message-State: APjAAAXBjV5aIuIDK7gUZdv7v/kWP5Tijfn6qjhgd7FeMTI4gEfNG/M3
 Gr2FLKD5ZRvPHpnStfvngs1tBg==
X-Google-Smtp-Source: APXvYqxGCdQMHkpBHigbSOJc6n61koJ1GykVh4lG6a97zJR7XG5BOSJ7g7KO/Hp3s5gZXFsd7B7t1A==
X-Received: by 2002:a17:90a:ad41:: with SMTP id
 w1mr65882871pjv.52.1563659549760; 
 Sat, 20 Jul 2019 14:52:29 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id b36sm57766974pjc.16.2019.07.20.14.52.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 14:52:28 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-15-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ff998de5-034d-ec56-92dc-96c0f81aa1f7@linaro.org>
Date: Sat, 20 Jul 2019 14:52:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-15-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [RISU PATCH v3 14/18] x86.risu: add SSSE3
 instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> Add SSSE3 instructions to the x86 configuration file.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  x86.risu | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

