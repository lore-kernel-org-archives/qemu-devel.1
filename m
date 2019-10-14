Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE47C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32512084D
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYb8Cu+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32512084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJr6J-0001eS-MD
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 23:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJr5Z-0001FI-Fd
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJr5Y-0000hH-E9
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:32:05 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:35308)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJr5Y-0000fg-7N
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:32:04 -0400
Received: by mail-pg1-x52a.google.com with SMTP id p30so9248868pgl.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y2hMuMqekgjrgg68x5Z1hlWWUfQ6/DRb/V+2giJEc9A=;
 b=jYb8Cu+/al3uXT5+xE05vzZLCYdm8uv+gJJiEgo27bzuFD4fTD7UELtfJU05yLFfZq
 b1nDrhKFV40weK/VdGlDkirT2QxtlGNdXnsdsxHyRDMzNTxCFPv1ccfVDN7dcTSreYL6
 KCQuZ3l1HIZKYKJtluTRaHyTxcS/5Wgv43K4RO4o7Owmz4yqGKvpjhVepwctz2yC6HQz
 RFtTm91VFxhVfREEtMY0Cq+cfg59RJDYDSSEsYv03+6pLzx1Xhb4+SZfldjf44qId1ID
 IlzpvOSXrsSbsvCp9ViMGbKReomNBhgVzXmytAeFWjezoO1cVavS2PXRUDfiUzEY8xLX
 TLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y2hMuMqekgjrgg68x5Z1hlWWUfQ6/DRb/V+2giJEc9A=;
 b=MMviXOqSzG7PPTHXeztwUuLeyudoT5ZqjWG8waMaUWZw4Z1yNh/08RQ8G5oMIy3V7b
 77+vP5dAbkG/aZGBe77KnOCsqyQ21DVw6F7cOkRykWuc72bhgPhKKBUjklvG63vOygSI
 bdvi8d41UZ6qOKUuWkkT2XJ/9EMaUZy9FbsFso/m9zquKLlVks2nJQLY6C+KeA2zyMWW
 FzUoHDgA90pUhfdhd4FJ2jERDmAXQlNZ3+HnjwwLLISGUvE3cHnapRlQksI3NPu0PDuf
 yONRZ9zpGe4sDkXmKrNc/PmaCtRXx5hMlVhgjU0oMmo2Mamnc4NYhGsmFG1Ub/JY40ko
 BnRg==
X-Gm-Message-State: APjAAAVImhvt7X51nLqztzXr5hnD3IM60Wphi+TcP2nfl0039jpLFoi3
 d3f5Hj3YQF5XorCb0GlDM0dJNQ==
X-Google-Smtp-Source: APXvYqz+K+Zo2+AaZFPlI5i+1sgYhFiJDujn8X1twKgXPUj6Zls5r2qjeGReIIZ0KsrAUf2LjgXDqQ==
X-Received: by 2002:a62:38d5:: with SMTP id
 f204mr12480504pfa.100.1571023922266; 
 Sun, 13 Oct 2019 20:32:02 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z13sm19613521pfq.121.2019.10.13.20.32.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 13 Oct 2019 20:32:01 -0700 (PDT)
Subject: Re: [PATCH v7 00/22] tcg/ppc: Add vector opcodes
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190930202125.21064-1-richard.henderson@linaro.org>
 <20191014002501.GL4080@umbus.fritz.box>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dddc5aaf-6572-3cbe-4028-976a2be1e519@linaro.org>
Date: Sun, 13 Oct 2019 20:31:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014002501.GL4080@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52a
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 amarkovic@wavecomp.com, hsp.cat7@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/19 5:25 PM, David Gibson wrote:
> 
> Uh.. do you want me to merge this?  Probably best to CC me if you
> do.. otherwise I'm likely to miss it.

No thanks, it's now in a tcg pull request.


r~

