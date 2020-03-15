Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F1C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:52:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40498206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdtEbdrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40498206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDc7l-00078J-6B
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDc3e-0005ui-Ud
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDc3c-00028i-Ah
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:48:34 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:33481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDc3a-00022l-Fx
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:48:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id n7so8847933pfn.0
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=n6UA6UwGYBpx07k8X+ObhKmnQvaXgHp9gw+kWS7WnRM=;
 b=jdtEbdrrrFHXE7Zu4emYynfi5C7MPLsC9pO+IlMpLz2WsBPxuFfMt7JzzUZ6XLF/OZ
 dXNzav9SiE52zYoPaA87eRb8ni02CdKI5OP4zF36jBeftiBHI0guS3sRCXYOKuI2DWP+
 Kz2X3/XIRlM7y3z2AxqAvenLxuP5bayIx21xa13PZyM5LeaZ10HWcE0zU9I+CsCQdhTi
 OiKp00CWsmRYRiBW1HyBRvIPyB1CROtWjpTsz9eUwggDiM61Db2zFHgmfYzVxnHES8Bp
 lAaCOK4QKTeZIQVxh3jjfZuGEITW4rxViVNN1Q0gKNin2NP+5jfYz445MKtGNl2OUsRb
 +FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n6UA6UwGYBpx07k8X+ObhKmnQvaXgHp9gw+kWS7WnRM=;
 b=sCQJxsbzIHnrnXiLIZekgytLUNJVzMJ3LjSVfGTusZ4hL6vC8ykglH6XxIL/Tb0gY0
 JFMYLvyfIe/hG2ZbYpPOmdJgpmSJlHTj0NiytvTExhp9gInqHZ9KeFsWVQ9Ks20FHYMJ
 uSU9pZXSz96/opd325s5g3r2ns5vpOoHstoY76s9JAwqHHYhkZ0dVXkq0GuAwSZtQnm4
 zds2/+4khahdvCflx3o2YVudq5X1m3WvY9SOss8OcXc5Qf97ftZos0fOGhtys2O5MCn/
 HHWiZtPMZHK5GATz8gNBzpIbQud12tf+QWVxt73QgNFlU+Vz0lZ0ggkRxSFvRtiaaBfo
 sy2g==
X-Gm-Message-State: ANhLgQ37msmT7MG9ChszobkH/Vqp6yaTUCg8/YnpYWGcwEtP2+PA7wT4
 yi7l8aRwrVIlWaGgrjHypLVSDQ==
X-Google-Smtp-Source: ADFU+vvWGB6vtndsXUN+b/9xYcmDYfVt7ZAGX+6YYQzZqdeEmJ0Q+SAWyWe4mIVgB5+aWL8M2KtQxw==
X-Received: by 2002:a63:6d4e:: with SMTP id i75mr23331103pgc.443.1584312508038; 
 Sun, 15 Mar 2020 15:48:28 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z8sm11226754pjq.10.2020.03.15.15.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:48:27 -0700 (PDT)
Subject: Re: [PATCH 05/13] target/rx: CPU definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200315132810.7022-1-f4bug@amsat.org>
 <20200315132810.7022-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d5fbed8-36a3-fd15-72a7-b401a417b5f1@linaro.org>
Date: Sun, 15 Mar 2020 15:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200315132810.7022-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 6:28 AM, Philippe Mathieu-Daudé wrote:
> +#define MMU_MODE0_SUFFIX _all

These have been removed.

r~

