Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CBEC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B38522243F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 09:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5OF3hc2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B38522243F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXLtY-0005EH-U4
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 04:03:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXLsO-0004VQ-4U
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXLsM-0007xY-M7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:02:15 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51603)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXLsM-0007vn-E8
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 04:02:14 -0500
Received: by mail-wm1-x343.google.com with SMTP id q70so6103338wme.1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 01:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eZYWen690pA3/Ibz8XELozgezg4kk+oalLXKfOMLFBA=;
 b=f5OF3hc2wZXLGkh7LbcnXPqT7OHEKjClcn69hwNcLOtyDsCQp1dWiIsTtPThlovn4f
 aWBuYFLqMlstdWJrw2IbgYb7F08+oy2TUslstU7h5zK3t+6McyI3FkjKTqYxaYY1u3un
 LgDFbHLaoZ6VfFNomkHcKgMI0k812OKmwpYCqTgeKg8yoTiQWHv3PoHtBY0DCZf7UYc/
 lkVS4Rnw5HVZlY6SqU+EhFtRD20EHXAubq+p8O5ygtyxGu4ExajA3Xsi14smrR8JO7l5
 Ygj8Eata1+Af9hWkXDIdpTdgMA5iRv5ngJ5Z05YpdMX8T9da8fmYOSPWZFroP0ibORvF
 iI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eZYWen690pA3/Ibz8XELozgezg4kk+oalLXKfOMLFBA=;
 b=DEo92xae1VsSQN06Ithd/mA28VHuOM5daieUruGM2EAL09v0eEtnirq0Wr1PkrhSTC
 7Yg8h1fvxvXHeyZQhHnln0PV/2zbOwrbiAfqRdD9KmAlg7GseAIuqlHtx1MStrqUWyEu
 BeFoP6oxKmmak6C8iYdU2ZJ+UiDiY0RZSVT2hru2M9RXeZ8YOh31oCxvLMgj86nfUmqS
 e3VgvU0BkT5Dd+XaDUNrC8dQD6AehHKkoPQTko5lgmwdVCfvEpH3GbHUoXtIr0kWHOGy
 0z4i7vg9d7grEDrUC697koaqwjeH1aZFwg+RsukNhy7jSZFkew3/Vy5PRPOedJMNXhrh
 X3Cw==
X-Gm-Message-State: APjAAAVzh8EXKXKMwNdSs2biTr2HACPPOjiWUSuoMSHEw9geMd6ao5T+
 Y/7JJA44Y3MaxgrIQSw/HMTyGni8vK08Lw==
X-Google-Smtp-Source: APXvYqxWtVBqcUDmvKJAQemVjkKMbmQIbXgSW8EoM2Z4Q2uqgXGUoX64rSdNCdO8HMO/xnnLG4gryQ==
X-Received: by 2002:a1c:64d4:: with SMTP id y203mr1883377wmb.27.1574240532419; 
 Wed, 20 Nov 2019 01:02:12 -0800 (PST)
Received: from [192.168.8.102] (253.red-37-10-245.dynamicip.rima-tde.net.
 [37.10.245.253])
 by smtp.gmail.com with ESMTPSA id d202sm5523831wmd.47.2019.11.20.01.02.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Nov 2019 01:02:11 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Laurent Vivier <laurent@vivier.eu>, Taylor Simpson
 <tsimpson@quicinc.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
 <BYAPR02MB4886E559B9286FE580C28556DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <98464579-194a-2b96-5cb9-3b7a7d9e680d@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <42954e4f-11cd-6c95-e74c-9dbec2f90d56@linaro.org>
Date: Wed, 20 Nov 2019 10:02:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <98464579-194a-2b96-5cb9-3b7a7d9e680d@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

On 11/20/19 9:33 AM, Laurent Vivier wrote:
> Le 20/11/2019 à 05:48, Taylor Simpson a écrit :
>> For the general DEBUG_HEX messages, I think the trace infrastructure isn't quite what I'm looking for.
>>
>> Here's a sample of what it prints
>> Start packet: pc = 0x4002f0
>> Packet committed: pc = 0x4002f0
>> Regs written
>>         r18 = -69420 (0xfffef0d4)
>>         r19 = -69412 (0xfffef0dc)
>> Stores
>>         memd[0xfffef0b0] = 0 (0x0000000000000000)
>> Next PC = 0x4002f8
>> Exec counters: pkt = 17, insn = 24, hvx = 0

For something like this, I'd keep DEBUG_HEX.

>>     if (qemu_loglevel_maks(CPU_LOG_EXEC)) {

CPU_LOG_EXEC already has a specific structure, listing
the TranslationBlocks that are executed.  It shouldn't
be hijacked for something else.

If you really want a runtime flag for this, we should
add a new CPU_LOG_* flag.


r~

