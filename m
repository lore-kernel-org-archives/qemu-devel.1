Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39773C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46A39207F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NQ4k3w8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46A39207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYtJb-0008Sj-6m
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 11:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYtI2-0007J2-A4
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:27:22 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:36064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYtI1-0001Gk-5Q
 for qemu-devel@nongnu.org; Wed, 13 May 2020 11:27:21 -0400
Received: by mail-pj1-x1041.google.com with SMTP id q24so11135588pjd.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gGl+0cqcyPGE8SPEwh3XVqA6gN6vjt/s9SipbNjudPo=;
 b=NQ4k3w8zu5zzx9KfMWT4rVFrL/IJcs+svUpIuziHgetYMcvYHZRp+/aY0tUXLA1Hia
 dtDUJTydLkXfZItEQhftbkd0dN7q3Q97AZPTsOAxPhjzSCOI51gVfEYeVGCTY3KIjbzz
 6ONxzbH/Q4NcpLAVuT+Ftxl+WDlgso7p3e1nbETNe9ZcrR8wIokRDV9pwieZZcYn2bY6
 o3sWYLnXoM3TOzgDI1pb3F09S/KbcffGEuRiquYNf/V8ye/R0JVivA1cN+S6vwr67Q6q
 7hPVG3HXZzAd1dqT/CmK6ashjutvOUTbBGcuAzV5+wmOOKoiOII1F3MZwL2jrTgV+sgm
 jWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gGl+0cqcyPGE8SPEwh3XVqA6gN6vjt/s9SipbNjudPo=;
 b=drOkIZpLgjvQBBEyzEi1IPAnDbUz46+SRV3NPO7iRARY8XV5hBTmM+KXXMgVUcJBWs
 Ffna7MTzQbaIRkxImIwsZ73MtuE4vBckc1a1ytTHERKpj9WEDozB4iNsF+2Cmq9xitTr
 tEo4S12NUScq+xPWUhqB24XCtjj0KPLf/A1O59N4pAx/70CJDHUTrjHsNmskithxS7cZ
 0q/MqV2iqQGbtyCHi+7z/UO5VBd+SeIJhGERLQCimXRlhFKkcOa+/btDmRVFPC7FpHjd
 E91OxKVXIjKdI70IKe4NjnoYtvMS/0FVeUCHSlb1Ci7iHcraeI8j5O/kbAEz5dS3qUy3
 c3Ug==
X-Gm-Message-State: AGi0Puac0g3/1wb73tZO6UU3lW/9GTwDwp6QEWmFKs1MHUzkAp9GLTbp
 C5+5Q9RO39uSpbV26iY0nCkt7g==
X-Google-Smtp-Source: APiQypKymN2vKc5VlHmhJhS3Oapax9Q6m2OqdiSujTulWYinZYOxah7jWivfWExgssgqMeDculzGUQ==
X-Received: by 2002:a17:90a:1b44:: with SMTP id
 q62mr32963239pjq.79.1589383639537; 
 Wed, 13 May 2020 08:27:19 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h26sm15176681pfk.35.2020.05.13.08.27.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 08:27:18 -0700 (PDT)
Subject: Re: [PATCH] hw/char/parallel: Convert reset handler to DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504095623.7252-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3dcbe57c-bd12-b9c1-8594-59b9d9867ad3@linaro.org>
Date: Wed, 13 May 2020 08:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504095623.7252-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 2:56 AM, Philippe Mathieu-Daudé wrote:
> As TYPE_ISA_PARALLEL inherits from TYPE_ISA_DEVICE, it also
> inherits from the DEVICE methods. Convert its reset handler
> into a proper DeviceReset method.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/char/parallel.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

