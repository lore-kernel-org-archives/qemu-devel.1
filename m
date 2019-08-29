Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71313C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:17:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8F82077B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="baqePqJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8F82077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MAd-0002b5-Qo
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i3M7i-0001h9-8H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i3M7h-0001p8-1t
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:14:06 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i3M7g-0001oi-Qg
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:14:04 -0400
Received: by mail-pf1-x441.google.com with SMTP id v12so2249236pfn.10
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iYifk+HRFD8aS3YVejlvyfBxGYeLFZzQYEwO4lbL8wY=;
 b=baqePqJapcaKaGglUQyox0IuQG296DCeC62fB1B1JTiqn/qafWpXFa1VUj0mvhwKWT
 wgTZKhZJ8f1NMB6q7bCcZTbDj4IeXBFPrFpK4P0sbNBxSd93FkLLOjlrXWfo0jQQfro6
 ul8lSK7ezOnmdeNeiNXpBYIXifKH/nBlZK0pYf4iWFGRUqY8RLZuzGQvCUIYcoWLX7wA
 IyxQ/Cj8heZ+lb5MIpn+neRMfgq4WUA8Hu4q5hX7t1N9CqvF126sctQz+e5x35XPjHX2
 NL06coQw8Smf/WCNhV5U2SCFhK1lACf9SAXYGj4scBdaLQZI/Mv1YmedDelQRFQrqGcw
 wnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iYifk+HRFD8aS3YVejlvyfBxGYeLFZzQYEwO4lbL8wY=;
 b=Y7H5VOBZFQoCriX3k6QNMtqYgyDstmj96x+oCri0Ud2gDPDFwYYH1qqXbeAZOxTAIF
 BUcUya6X64PpdT4NZe4N20bR6VlX7EKSFXEksuChQc7ebh6XfhPQ9UUNga5/PlVIjq2S
 Z1BP6im/Kck04laG/VXAsY2n7FNtQuCMbcNHLSPa7yZ5/9gVfSfWPdH0JfkTzxmxcw8X
 fawFrGI+Gq/XQUNIVXkXIvdbaf9iXb88l5NEKz8en4958aJtJy6mleXcfSsNH4sS9V4j
 cuTXS5hGHT12693xddbOCx6ZkurSwxt/PO3TDm+tXMcwVuHvH1kAioYbJbBDEDfmc6Wu
 cfrA==
X-Gm-Message-State: APjAAAU++wzhs5wUuwGk5f23or4Z8/GLiHlgr6MOd31uQxGglfh4NFTH
 TxcmSyTvbMr2VCYQswVe2pZJJw==
X-Google-Smtp-Source: APXvYqwqzi2kZMLq3zE+ggw5X5H1QO6syQzRiGIg+dwr4ish5fKTPGjTMl/65td1enRGEUze0tpekA==
X-Received: by 2002:a65:568d:: with SMTP id v13mr8510536pgs.229.1567091643579; 
 Thu, 29 Aug 2019 08:14:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e19sm3688193pfh.114.2019.08.29.08.14.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Aug 2019 08:14:02 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair Francis <alistair23@gmail.com>
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <CAKmqyKMDmaABGWyLZD2R-4J8=jM6hry6Bfmu498+UZzQtxsTMA@mail.gmail.com>
 <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <dbea4015-fcfa-e223-cb6a-bf5dee270912@linaro.org>
Date: Thu, 29 Aug 2019 08:14:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <af15b620-1350-aa1a-0f02-2a46518f0ef2@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/29/19 5:00 AM, liuzhiwei wrote:
> Maybe there is some better test method or some forced test cases in QEMU. Could
> you give me some advice for testing?

If you have hardware, or another simulator, RISU is very good
for testing these sorts of things.

See https://git.linaro.org/people/pmaydell/risu.git

You'll need to write new support for RISC-V, but it's not hard
and we can help out with that.


r~

