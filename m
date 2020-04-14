Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FCC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE202054F
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rq2K9Coh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE202054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOq8-00041M-Si
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jOOnh-0000ip-Me
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jOOnf-0004TV-Ku
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:52:41 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:55409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jON8e-0004hq-9p
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 11:06:12 -0400
Received: by mail-pj1-x102f.google.com with SMTP id a32so5384858pje.5
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=ZHTV2WAGvbF7tJ+l/IrMW+tHpCU+yNyy79gnHM9pP7I=;
 b=Rq2K9Coh0hxmHbkr+4Adrrnm4uwbvuQ1+tAWbzd1NW3EuppmAnl+65wQZYqjSd/xTQ
 HSWS1I4MCZtgZzWpPEbtZt9LbASKprcseMrrZwEQ8W9aRcjlL/3KrasEeci45M8uy6J+
 RID8kDpnVz+8+xOQvjyWiclELQ5bAztrohuqhD/5g6N8CF8c5EknTR5WnLHn7OtFjkVN
 8jJH/q7XHmbt900h0BG7ZbNMxdWttNxcE0WsXeXAayRVMcKT/H1ir6EvGraUMYVytmDa
 MiOzAU9Mo8zruhJdOaESRnQZotYEXyAuTxrGa6Nls+UywrHGnUdzTqE+6xG22OnPrm73
 zyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZHTV2WAGvbF7tJ+l/IrMW+tHpCU+yNyy79gnHM9pP7I=;
 b=HyryGJcSdooFyvSkyZtVdmWbapCqArO2um4ujD41PMAGq3Odj7ST3WB+BuQSTHxOH7
 BUJOukn3mz8ilzylOeK7vB50MaLz3kHgd6qYqNqRd8ojBH3EMIssOCcyMp7f8JgenckC
 8XDC133oSqEmGOuxuPOx034KDAYb+7qQ3SqRYoEzOMd0qH3QBdW1uXWG+66P04eYbNOY
 fp9PcKh0E42FiL6DKVA6jlcBxXC4qtweHEvcW96L49WE4t/5AQoOyYo3ltzjTHyqv1RV
 jp78pIhztHySwywl4VHGuEJyJdM1y0wDkU9mVinB76xwPkR+OfAFdYKMjZbWW4YHx3wJ
 nrbg==
X-Gm-Message-State: AGi0PubEQS95vebPiByzSAf0T1oyXZIZc7OqJ2VZK0rSLG0r9nkCcvM4
 6cPKnl1Z9tilgXXxH+uO3rMAWtnuIMA=
X-Google-Smtp-Source: APiQypJnNkSaiDGANi2bP3LEJUOoVKvEc8AGLsnUGzKTFm8z15JPnhuVQ+po74kIAfrW6j+XqpHUHQ==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr411004plp.70.1586876770808; 
 Tue, 14 Apr 2020 08:06:10 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id c14sm10570278pgi.54.2020.04.14.08.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 08:06:09 -0700 (PDT)
Subject: Re: [PATCH] .gitignore: include common build sub-directories
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200413162902.7985-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c137f5b3-3e93-e497-e2d2-16ced7d2fb42@linaro.org>
Date: Tue, 14 Apr 2020 08:06:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200413162902.7985-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102f
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

On 4/13/20 9:29 AM, Alex Bennée wrote:
> As out-of-tree builds become more common (or rather building in a
> subdir) we can add a lot of load to "git ls-files" as it hunts down
> sub-directories that are irrelevant to the source tree. This is
> especially annoying if you have a prompt that attempts to summarise
> the current git status on command completion.

Not a fan.  Why do we encourage putting the build directory in tree anyway?
IMO any out-of-tree build really should be OUT of tree.

My build directories are always siblings of the source directory in the parent
directory.


r~

