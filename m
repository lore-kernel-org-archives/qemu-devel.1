Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:55:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12D8216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c3eulFtu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12D8216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0ZVw-0006aV-0U
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 18:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZV9-00066z-V4
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i0ZV8-0007Wr-R2
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:54:47 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44896)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i0ZV8-0007VD-Ko
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:54:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id i18so2208434pgl.11
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WKhtbppY+BpGJS68TkUTw8poDxVdFdb1j2Zax1nkBAU=;
 b=c3eulFtuX7l9mBWPctHnGAXyQU//gA9Fnfq8MOk3r28oR6HXp8h9ifHfgHL33FNFyT
 UQvV/Sago+PKcPO027mFo9ooY+Y00RwlUU0WKV8tJ4KGrx06BJvDqB9srAq5CJQkVclW
 esXK79dTxO2GRyugDhk7mXC7C4X8x4JAFgAk5Sc46SSZh4gvecmnFSD4CfA9wKTou7v7
 7btt9+9K3ydW/g1rq4ItHJPvlI+HwmQefGCDu7EBPNwMhj+yycLOMoR+hWqPpj+5D99c
 cuBoGOpLvMIHzLh3mmT89dvYOB+c4XZsAihGd14ym45B/N1tBUpww47KhqAPQgp7EEjZ
 iESg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WKhtbppY+BpGJS68TkUTw8poDxVdFdb1j2Zax1nkBAU=;
 b=MpwtXzTIvm2zYhzPb3lmPvpNK2YEz7qNeLS1JI0qocNf+tlAP/uZuurMt7MEKQd5Pc
 MeoNR1HwZj+03N6yJ6ZysJ+GfquV0CgT5soqcegBmlKaeF+cU7/Bie/K8AfwUjbDcgYI
 hYcQhgOs3gxdO7N2OjE/dO2zyUFMFPlcLwddvMuV5iHy8aXDnamKjDGTeUuY6cEivy7X
 883i+jZkV8ZnyxE1eiOdg8o2evBhxFlx9kO0Bo1F9sR4oGXEHSY7LbH5HWU576YDweHL
 h7x2dQ6DCxtIAlZzFD7T0+CVDcUD6TzkGnsixoe5aSbIHZMQQXz/QRiptq9fsm0PjX5W
 jbUg==
X-Gm-Message-State: APjAAAVk2Opx8KRcqsBI9aFumiy1vO8+A4R3u5/c7GgFhvUZD9O9SN/L
 r0CKVQVHMQUtxLl/1qWWT5f7nzHJ1EM=
X-Google-Smtp-Source: APXvYqw+9Fky40mvqnY3z9+cqGyYehptgo00IG3Wj7kqGX+wH7KK0tLHtIq83Ps7xQU51cEqsOzOfw==
X-Received: by 2002:a17:90a:170c:: with SMTP id
 z12mr2300488pjd.119.1566428085266; 
 Wed, 21 Aug 2019 15:54:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o67sm23738910pfb.39.2019.08.21.15.54.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Aug 2019 15:54:44 -0700 (PDT)
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
 <20190821122315.18015-6-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c02681ba-2d5a-3d5c-f44f-69024cac5620@linaro.org>
Date: Wed, 21 Aug 2019 15:54:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821122315.18015-6-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/tricore: Fix
 tricore_tr_translate_insn
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

On 8/21/19 5:23 AM, Bastian Koppelmann wrote:
> we now fetch 2 bytes first, check whether we have a 32 bit insn, and only then
> fetch another 2 bytes. We also make sure that a 16 bit insn that still fits
> into the current page does not end up in the next page.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/tricore/translate.c | 47 +++++++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

