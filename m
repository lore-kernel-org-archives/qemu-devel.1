Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157E7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B5420774
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWyV2l4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B5420774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGkvP-0004c2-1J
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jGkua-000445-5u
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:52:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jGkuY-0002bH-Ua
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:52:11 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jGkuY-0002a5-HC
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 10:52:10 -0400
Received: by mail-pf1-x443.google.com with SMTP id d25so9362263pfn.6
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BU+olHEDMA4SWXhPhSUdr47aT74Eb79xNS9MUGXxFYI=;
 b=FWyV2l4C0eRh0krBZFBqrAkVNLPgzkOuMeTQJlVI/JBG2xfQED4mcRbESUMK5yvxqL
 sVSjiMkHSRBK51T1v7rtp06Kmy+sjcPI1QZcDpkt23lVdr647Pwex/Q+bOJ6W9mGmei1
 i9jiwFZZnFE1spRJ7Fc+7b22KFqA3sf3w6CaTd2/4e1HZiMNwvuRQ5kSwaQBD2MepQE3
 MnedyGT8Im+v83aPG3hSNUUruNoe5u4RoilYi5g4EcVe58A5eE+9ISC/xipTnPpXzaUw
 Y2koIw3aB8DvzN9RvbRnZ+Zgkgxi7eixODwHC3Z7j7KpAwfStB8yTBC16+Ks7k3a58Zx
 XUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BU+olHEDMA4SWXhPhSUdr47aT74Eb79xNS9MUGXxFYI=;
 b=GDNjg+wnCd945BX4/KA+iJgeDqA7ZGPKyLyzB6DRFW0WKBcMTWkyw6M8IMgBQsIkjT
 LtgUozL6lH1agVmVTr/GzEo2amEcGpnauPGHMnlLbz5zgKpa6sIegCOvaNjZkykex3b3
 C9hzZhBflAcEB6tPrLBZJYGxvc9jrMDsfd1IlF7SPh8YbloKegVsDTPM/jiGbMS/s+DJ
 /CAvjsMqX5uyTPUcVxofThqatYyjLL/8TBv5xI6vNkxXzgROMoa/o41NfTKEONbx7WJR
 HVHl3wcMl51zVUK1918u8QmNcuveyQC/4jNXMvbUSeK3svoD6H33vhDz6Bsdg8wdpV0N
 Q6gA==
X-Gm-Message-State: ANhLgQ1iE22fyCehomqbIVQNaR3xU5LACz3aUdw+lwUfZwrZREsLZKQt
 Xd2H00NP/7xDHWJO4Frp8sBjrg==
X-Google-Smtp-Source: ADFU+vvG7YxfYdT+qEUqfiNPI2Z6eWyn6O7L/mghIYQYPkxj5MLW45sJhOdQAOyBMkFA4A20vTMLaQ==
X-Received: by 2002:a05:6a00:8d:: with SMTP id
 c13mr31114563pfj.68.1585061528986; 
 Tue, 24 Mar 2020 07:52:08 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id k1sm15182475pgg.56.2020.03.24.07.52.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2020 07:52:08 -0700 (PDT)
Subject: Re: [PATCH v5 57/60] target/riscv: vector slide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-58-zhiwei_liu@c-sky.com>
 <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
 <88b87d58-5387-9d0d-b1a0-5705171f2e83@c-sky.com>
 <76b6c079-15b2-08f1-f8e2-570efb6cfae5@linaro.org>
 <a99c100f-4b32-810a-97d7-ee54f5f65cda@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <25b384a0-c1d7-ed5a-94a1-7912e020c8ed@linaro.org>
Date: Tue, 24 Mar 2020 07:52:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a99c100f-4b32-810a-97d7-ee54f5f65cda@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 3:51 AM, LIU Zhiwei wrote:
>> (3) It would be handy to have TCGv cpu_vl.
> Do you mean I should define cpu_vl as a global TCG varible like cpu_pc?
> So that I can check vl==0 in translation time.

Yes.

>> vslide1up.vx:
>>      Ho hum, I forgot about masking.  Some options:
>>      (1) Call a helper just as you did in your original patch.
>>      (2) Call a helper only for !vm, for vm as below.
> 
> Sorry, I don't get it why I need a helper for !vm.
> I think I can  call vslideup w/1 whether !vm or vm, then a store to vd[0].

That's right.  I didn't mean a helper specific to vslide1up, but any helper.


r~

