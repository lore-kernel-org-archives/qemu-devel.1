Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C5C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DBAA20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kTTuInR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DBAA20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDubz-0007ZB-FH
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41783)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuWe-0007gR-MP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDuWd-0006RC-L3
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:31:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDuWd-0006I9-DF
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:31:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id b72so10406018pfb.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YDThJG+zzbkaeauug25aTrE2t9ITnVdBY3IX0bwOn/E=;
 b=kTTuInR6gjJffzKwLEk6Apxiykc9X+b7iCNRQDLpMv3BD0lsqF7BeeG1kGm4hxkWkP
 9BgRGVQQ7gCljFZimjO/khll57QjYqtngjqPsqtmvWYiFDLr2Si9w8XyzPC3YSkyGjid
 zzv96jLegrMzAZrzZJf/de9B/BxNvRog2O0Z5D0lyUHrrrJ4RLqqiZtOxDtYpNdJKxmU
 0MZOQzPN1TCVvXVE8vQTa80+revmIX7h9My/wztuj9J5LhTT8995td/d4jb7vPfsclCf
 ZdGfrjEe71A4n3sOnSOlLuksln8LxS166+qQMzYy+Aeg5XOw2AxKJ1B0+akmVg0YpgQe
 kTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YDThJG+zzbkaeauug25aTrE2t9ITnVdBY3IX0bwOn/E=;
 b=rKVfkLukJTcXZJ1vz5l78oGDGGe/2BXL96c6EfExJD3mMTjvlWFivqil4JekDr9RFg
 dDRjCgAFSzRpavkZsm8BWUbHCLhOyn2yXkp/FLwH8wCICRV1bCQNW8Oypa6WuP3eivvm
 Vw09cWXrB6dIg1cqnuS+GoI/oepE9S5inlQ+8wJVMS5MxXVLgSgKpThVzB6iKYAm2ox0
 YFt9EcHlyy2TGgOUi42wKQL7zpo+IaU1IplhaxFcjfOjrI55Srammhf3kY3eSyDAyaDq
 HkHykbqBIiuzzfVpvJ26HoZjUfSqJIWptW2/yNrLZUqzhllLXxqqzP5SoGlJIzq+cGDG
 xbwg==
X-Gm-Message-State: ANhLgQ3JFw1RYGtkJfIjXh7QuWodFQrPP+wjwX/DBPaKttgmhwJ4Sjum
 7fBfFjXAT5ELzoPwMRF7ufSmog==
X-Google-Smtp-Source: ADFU+vvLO6lqqRI8YLWBlaQ1frA/n8p9gTHrdJC8pEdLIoDrDWTZWAYEHpyLa1wQdNo9nc2P/VWAIA==
X-Received: by 2002:a63:34c8:: with SMTP id b191mr1162080pga.220.1584383502350; 
 Mon, 16 Mar 2020 11:31:42 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f68sm491647pje.0.2020.03.16.11.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 11:31:41 -0700 (PDT)
Subject: Re: [PATCH 07/11] accel/Kconfig: Add the TCG selector
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-8-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d08d0c77-d20d-b1df-6e98-fac3a6eedcbd@linaro.org>
Date: Mon, 16 Mar 2020 11:31:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316120049.11225-8-philmd@redhat.com>
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 5:00 AM, Philippe Mathieu-Daudé wrote:
> Expose the CONFIG_TCG selector to let minikconf.py uses it.
> 
> When building with --disable-tcg build, this helps to deselect
> devices that are TCG-dependent.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  Makefile      | 1 +
>  accel/Kconfig | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

