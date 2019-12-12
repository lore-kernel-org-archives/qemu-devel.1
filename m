Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474E1C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B89F21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YQzJ/qUY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B89F21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifGOP-0008Rd-6V
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifGNk-00080Y-Gv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:47:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifGNj-0004XV-J2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:47:20 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:44321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifGNj-0004VK-BQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:47:19 -0500
Received: by mail-pj1-x1042.google.com with SMTP id w5so476862pjh.11
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bmarqO1plC3fKJtO3kqi2xmiPTvovvFC18tmAR5wJGg=;
 b=YQzJ/qUYAz2NAQFQjEpgGAoxHORIZfJQt585ZKFzW1eQr2vGAWPLpYv3IzWmox/2Ca
 /vyrFbp5FJsfWTIriPQPmhkBpE9QMUCwfxcCWquM/qBVmCifPzWHalUIW067TWXh4f5T
 JtDiFvqsTfkxGjGmkpKicvazFAGrbVYs5UDQoyZUGdTMJ5O7Gj2FC8AjtMnVBvdse46X
 eaqiGtsXq5cgX26yCEjRiox01DG0Q9bO8Ggp6BSDC4nGjDZU5FIpH00bvPtQU4R6OLX/
 dyDwCKmq4xFn19Kqur3SxJ4Q7A9I7Ay9t5RHftSceKWiKs7rqNIA4n9M8uOoLk+Qo/xW
 lOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bmarqO1plC3fKJtO3kqi2xmiPTvovvFC18tmAR5wJGg=;
 b=f1OgQJeAkECp5RixNZbIjUdBXjc+P8lxQSn+0KTN6NTut4StSD6dmtaPAm0fO6Cc15
 B1FzDW9gBcCFpUpB1aUEqCn5EHO4pDyPdyuEicCSqnOV4V/dbRnc2+RHdA+er582WAwu
 ygwVvIRdMNTcjJH6g9sh9MxNV+HkhZOYYESgbM6wobp18ybPNI6SIsFSOoOtNZurgi3m
 gvgwsauFSG7qg6dJVRtXzldmUgLRZdsVuVwywqpreivxCOBg+8Jh7KkkBfItDYTpxT1G
 NyfVUYpCFCzQsVEUwVXVZ4sXoMTenb9wapgbB7MsGsjgjl+BQx9eaXZ66q83Upp19eFu
 lpMg==
X-Gm-Message-State: APjAAAWqLiy2nxFnr7fb5Rk4XFPCFKru6HW2JmmVswpNzbn7Q4GsT7U2
 5mgEjoEyKxNr3yYgUJ0xWb3PFA==
X-Google-Smtp-Source: APXvYqxBPPPbGnPVbwCIphaqkiXEjLQz3xgRcSz+m8cifrjaGOXfTUNupM03llR6sXp4yXd745SZxw==
X-Received: by 2002:a17:90a:8685:: with SMTP id
 p5mr7837360pjn.92.1576126038282; 
 Wed, 11 Dec 2019 20:47:18 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a10sm4844919pgm.81.2019.12.11.20.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 20:47:17 -0800 (PST)
Subject: Re: [PATCH v2 03/18] tcg: move qemu_tcg_configure to
 accel/tcg/tcg-all.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
 <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <71e3c89a-e62a-2ba4-8a63-b4868d7f3356@linaro.org>
Date: Wed, 11 Dec 2019 20:47:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 7:01 AM, Paolo Bonzini wrote:
> Move everything related to mttcg_enabled in accel/tcg/tcg-all.c,
> which will make even more sense when "thread" becomes a QOM property.
> 
> For now, initializing mttcg_enabled in the instance_init function
> prepares for the next patch, which will only invoke qemu_tcg_configure
> when the command line includes a -accel option.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/tcg/tcg-all.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cpus.c              | 72 ---------------------------------------------
>  2 files changed, 85 insertions(+), 72 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

