Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3031C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E273523119
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz4cIVIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E273523119
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3gSL-00054H-P0
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 10:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3gR2-0004Mx-B4; Thu, 06 Aug 2020 09:59:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:36001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3gR0-0005e4-W2; Thu, 06 Aug 2020 09:59:56 -0400
Received: by mail-wr1-x430.google.com with SMTP id 88so44075620wrh.3;
 Thu, 06 Aug 2020 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MTSUUlOpj4xpO1gZOSJB9I5hMOIw0BjlgQX4+Z19ZEY=;
 b=Fz4cIVIbowcvzmNimlMUPF8FGnbIIIKMW9p4kSaBc+M2zKgUKq7FW+K9UqvAfdodzh
 nK6M0QFhZLF10DQyIqMRpsntc5FxFC/tSL1ab1rykq/4SywTnBktq7V0a9/tdCsWCnde
 IeSmrW9fZpc21xhCzWm4YUghORDUnOPYV/hBGepcZ3lGQL+uDRUUDAK8SgmgkcdBPZbK
 GNxXckKSA9U4N+yLtr1CeQyIAEifRgF7dWTrGBsA8HvknjxDaucW1AK/gM0nkKbTDX3x
 kUrDBh5/lgWHU/uq9h6xnqKmBoXqhxB3yQlJKb0kWbFDn9kCMerCUOf50s+len6UqV01
 qJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MTSUUlOpj4xpO1gZOSJB9I5hMOIw0BjlgQX4+Z19ZEY=;
 b=Jrbom01FlLz1E7UAF9YuB/0XhkaUX0QYhWhL8qVk8GOZ/5apiNJe/D8NcbhE7bFmns
 pg7xUqcMA6sT5CsLk8wXyI59V9dePYv2vaZLdQhrkx4iRxvuN+WlJUcOkrSUHFeBme1H
 RvnhELjJ6TCW4dx5SjTWJDkZxW0whtFchuwmRfVHMoIrwVP/PGzuVlOtREyxWljeHQno
 47MCsTT15pkLfw5cKOEN/U8iLKFhF1I33guSQ7GXxYxnndc2ECvu5GM9lrrvUA20zjcS
 ChSPUhKsl/ohAefCAufqeYsLa6kOojGI3k3QIruRL5YcoHl1OL+4Fmkl9jN7TV/cPvGs
 Pfgw==
X-Gm-Message-State: AOAM531Qtkh0SBUlD7bOlBolQDDMr9qSO3m9lUXAeyoebLhugmaEFC/g
 8IcGEQHb5z/cy+PyqMngssZkRnP4
X-Google-Smtp-Source: ABdhPJxRy/B0UX2UC+3Jl1sw8HKAnb7vfyMx5tGdfv2cCt972zwSwh5ZR7vIEHo+YEwycUWP0fcyHg==
X-Received: by 2002:a5d:610a:: with SMTP id v10mr7426243wrt.8.1596722392644;
 Thu, 06 Aug 2020 06:59:52 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g188sm7492178wma.5.2020.08.06.06.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 06:59:52 -0700 (PDT)
Subject: Re: [PATCH-for-5.2] Revert "mailmap: Update philmd email address"
To: qemu-devel@nongnu.org
References: <20200806135832.2319-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb226ab5-f76f-2e8c-71e9-94799583ac75@amsat.org>
Date: Thu, 6 Aug 2020 15:59:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200806135832.2319-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:58 PM, Philippe Mathieu-Daudé wrote:
> This mailmap entry does not work as I expected. I am receiving
> emails related to my hobbyist contributions in my work mailbox
> and I get distracted :) Remove the entry to keep things separated.
> 
> This reverts commit 289371239153b24cb7bd96b6948c6b40b4627a9b.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

FWIW to respect the stricter .mailmap rules:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .mailmap | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 81c2ce0937..2d97a14af3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -54,7 +54,6 @@ Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
>  Paul Burton <pburton@wavecomp.com> <paul.burton@imgtec.com>
>  Paul Burton <pburton@wavecomp.com> <paul@archlinuxmips.org>
> -Philippe Mathieu-Daudé <philmd@redhat.com> <f4bug@amsat.org>
>  Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
>  Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>  
> 


