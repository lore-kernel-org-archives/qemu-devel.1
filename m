Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2BCC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B09A72078E
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 09:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9dlBYMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09A72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPivh-0001QT-PL
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 05:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPiuY-0000Rz-0D; Tue, 06 Oct 2020 05:05:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPiuU-00064e-60; Tue, 06 Oct 2020 05:05:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id j2so12547448wrx.7;
 Tue, 06 Oct 2020 02:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WZepGlMPJlVNOljb8JHNaBnOB89f2qn5cTwdEoDE8fI=;
 b=r9dlBYMwS4h0jBI/2ww50/DoRCBDhjiqaA1N+D6ffkQebY34ycqJtYCKQ0kUOORtvf
 Ht4XgZMLdYvMmg+oryBmJJatej/uTMljfI1yItm7a3adMXAzvt7znobrBIo8eLax+Wgr
 exRVasT8pHfV/ww+QdhqGahcung8H2s+CZUD/XQ1yUL9AR9HHZpeBN0e/cFGdiDYuic1
 1jzZJgKwZ1UqCgImlg4HUkO06DrQnWjdbOf5EEDDkq1g0BycSn9JY/OZb9i4ZMglSvLW
 Ku9S0n1RpGvJf9TgdDkszdg1yD60O/ptk4Bfy1MawvfLJj/VTLsaSybIgYj3teY/VvGk
 Vqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WZepGlMPJlVNOljb8JHNaBnOB89f2qn5cTwdEoDE8fI=;
 b=WQxr528DVEAaqM6O5LsKAKau1Jfx9RFnfCpYbJSsZKIkaPQvgoNGYs6397Y468ROWD
 nBqvsHQNP1Dlwf3QZbjpVdi4LzlpefRRKfpRRMnnqzhVU+g8XPla4ISWeWcRlasEGL/I
 i5PxQoj1tvDKSmr0eJylCfw1SkYhU8iIktnatuWTzKlHftFInOkMjPVGbXYy2r5U23AT
 9Ta/kV+Jlqo4IVPOupMnA5AhK4PAtTCnm6Y+SwURClYdtaPbWy3wv1NfW+lg84eKWaHx
 fc0Otv621V50q28ltqXf3wgbWmz32r7NHykYMFxA9GD6ZADMYiZc8F8MaL28chmxpI2H
 4G+g==
X-Gm-Message-State: AOAM531XbBSl4NjYck07KyripjYPY5fywPVqmJMMgRisTf9oWQERtL0T
 z5jTkMQZsiZUQ4W0bLzeBw8=
X-Google-Smtp-Source: ABdhPJzaB39KHzAzYqkRY69HvCl4xWSyMHX6RGThAwvMeCyUE/FnEYmTsayaJ2sEvyxEvdddGrIytQ==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr2647089wrn.188.1601975123677; 
 Tue, 06 Oct 2020 02:05:23 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id v3sm677085wre.17.2020.10.06.02.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 02:05:23 -0700 (PDT)
Subject: Re: [PATCH v2 15/15] hw/arm/bcm2835_peripherals: connect the UART
 clock
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-16-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5fcdd0f1-400c-c906-6f39-059e0f4bfb2a@amsat.org>
Date: Tue, 6 Oct 2020 11:05:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201005195612.1999165-16-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:56 PM, Luc Michel wrote:
> Connect the 'uart-out' clock from the CPRMAN to the PL011 instance.
> 
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>  hw/arm/bcm2835_peripherals.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

