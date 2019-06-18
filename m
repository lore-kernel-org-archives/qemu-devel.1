Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EECC31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C0C213F2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pf+vQw9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C0C213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdFsi-0001YS-3H
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hdF5z-0001XK-Js
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hdF5y-0004yF-Ms
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:28:23 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44625)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hdF5y-0004tC-EH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:28:22 -0400
Received: by mail-pf1-x442.google.com with SMTP id t16so7756704pfe.11
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 07:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Cq3AgLqu/86OUtTSuC/NjLSmU3fYskHmfcErEuZN4w8=;
 b=pf+vQw9z/T8boiZiwobg/SFWO1f7ZEBNSrW9+x3VVu5aCQOnxnI6Fqp65/g+oSTilN
 BIbvE4HVT8DUyeiX+m2LZXoNWqjmNxwoAuJEIl/vIPvo9YD7fDeQd+eoM+SW4UXYKrZb
 xSHc58Go95lS6QWz345/6+VO7RpcSuR5hEN/X11rT4N1h8y1f56pMEdVqKYfah/hH4Pe
 XOf+hDwuEs1vmTtncm8bbEXp7BDtI1NnoT2cNlTJtVZAvN4u7CWw0CkOGSkc3EsiMQku
 0eltAJ2IDDwZsnQ5D9FsI1skwIBHiQZczM9kLi0y2nC9LrTqMRNBLH0vMv+Cb7rGF4al
 BEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Cq3AgLqu/86OUtTSuC/NjLSmU3fYskHmfcErEuZN4w8=;
 b=UqOyzA8S7a9BjSua5vqws1Xnj2Nak6tb+GuSGq5TzutwfX3IqEjOblv+fV2DB9aFvl
 ZXtzb14DqEvUHYcCnfqdD2NjyReTJodXtD3hG31ZHbqF6KrQDH/6bgoy3zgT3stlwCzi
 FgUxokemonMgoWzhYjIKlzq3cxEGvrtCjaPspKRFCk7KmWgRnZZMbhC4WCO4KeGlKx8A
 JB38mh6NqpAKGB9BmlGB3a4Kb6vx2kCdKjD5U1bivM/OwWLizas2NdF5unVB8SjlimdX
 iV5nljGp+gbjmRie+Z+q8lXsuA5iyTZDvDcgXzVPIwZJrUtNuuoRrGMhHCkeNZBpNUwL
 lYog==
X-Gm-Message-State: APjAAAU9a4Jdz5JGobeYHNoHYmAfZqjWuE+MMqWbbV6ts+RklGVyDOZk
 NbF4qPtrJtFMND/KHHLHhfuH+nBwO/g=
X-Google-Smtp-Source: APXvYqw1scy9Ohiy8f8IVYefhTdd8uNf1aUoMFy1cDYQjKHviJAF500z0b+CI12pcSZamsgWbdmxHw==
X-Received: by 2002:a17:90a:2247:: with SMTP id
 c65mr5296547pje.24.1560868099183; 
 Tue, 18 Jun 2019 07:28:19 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id j9sm15294714pff.88.2019.06.18.07.28.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jun 2019 07:28:18 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190617143533.15013-1-kbastian@mail.uni-paderborn.de>
 <20190617143533.15013-4-kbastian@mail.uni-paderborn.de>
 <b2f6e776-90e4-3809-350f-ce2bf6d69017@linaro.org>
 <9d2149ef-57f5-c4b7-220c-81483b108f24@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <82d09d30-ec46-1cf6-c9c8-192932690c6f@linaro.org>
Date: Tue, 18 Jun 2019 07:28:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9d2149ef-57f5-c4b7-220c-81483b108f24@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 3/3] target/tricore: Use translate_loop
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
Cc: david.brenken@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/19 5:06 AM, Bastian Koppelmann wrote:
>> Have a look at the end of thumb_tr_translate_insn & insn_crosses_page to see
>> how to handle this properly.
> 
> I copied it more or less from target/riscv. I guess that needs fixing as well :)

Yes, I noticed the riscv problem during review of the plugin api.  :-)


r~


