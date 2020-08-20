Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33FAC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B01C22BEA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 13:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nicbVlxv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B01C22BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8kO8-00064E-KT
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 09:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8kNY-0005eP-7y
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:13:16 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k8kNW-0007zK-Fc
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 09:13:15 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so1538440wmi.5
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 06:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dAiaBTcQBScglthLE5aTo5EZyEhH20hpg0WB2C/l+wk=;
 b=nicbVlxvETJ9d4bq1e7/EfrzFD/Gnr3+T7Mro8IqrOFATvy4lLsHRJ8uabl/yjaz81
 Pz5hxrK9yBWPGdRbvxcSY54dZLVy5SiFxRWbcv+p8xJkET4ccFXdKIkJ7khGu3ThRYMV
 o+y6KYT7EbfyIN9TBg6giriRAk1gplsm3t7y1pu3PJXkNuCV5QDAcOn0awGSMJswIpBS
 l+MXnjm0S/GIoTi6aPGZEjVRnt9jtHHPwJZ1Y/Mdnc4Wa5OhF+7UNCyEO0Lt9DnT0cZm
 dxcocLYObSlnNM1e8tnIT5kKb4okng2ErQcywrRBACJY18793tlV36GDv98K9lu2rOIO
 ir8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dAiaBTcQBScglthLE5aTo5EZyEhH20hpg0WB2C/l+wk=;
 b=R+cXphYxYIFfy3KIYv73MtHYMd0yuuMnhb/0AGo1pxe5vGe8GH6XcKwWshdlErFYKx
 Ma6aL2kDTHcPd29+ayhZmUOHu+Ej9jyVv2J6tZgBZSXI1jUyG/EdSvhRaowSe+EYGWFm
 pensvQcYUt+DNE7Uti8YjruFnhLn64aWtHmF8mTdeteITlk/Kp4suRG7FQWXhp/U7cju
 D7PKKhZv/U5WHF1b5YoM+OyhFrMij40XGBwZBNqTc71uSpnToEB9Zv6MAxT69tNDT9yh
 4dGKZeXidnhQ78SR1WqstnKIAznfJKj1zy0sugRt+5hMrznL6sEPbjfzpT2sGr2ctFVq
 /KrQ==
X-Gm-Message-State: AOAM531DGdpkaa8aqiMdEPWFJZxJAS3AOky/hnMFM+YjGi/6ZYbQETzm
 7KffFj2WyNnk2+cuhYuciamJwTq9khk=
X-Google-Smtp-Source: ABdhPJwb5dSL5Aciyci65k1C+jrs4mmhjw0qEVJMc87I4E6bdTJ0DRBKTIaM4hVjnrtM74Kgj6a0iA==
X-Received: by 2002:a1c:e288:: with SMTP id z130mr1896763wmg.32.1597929192946; 
 Thu, 20 Aug 2020 06:13:12 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id h189sm4443295wme.17.2020.08.20.06.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 06:13:12 -0700 (PDT)
Subject: Re: [PATCH v2 36/58] piix: Move QOM macros to header
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200820001236.1284548-1-ehabkost@redhat.com>
 <20200820001236.1284548-37-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20ea6093-90cf-56bd-33c1-6ce31a4360a5@amsat.org>
Date: Thu, 20 Aug 2020 15:13:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200820001236.1284548-37-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/20 2:12 AM, Eduardo Habkost wrote:
> This will make future conversion to OBJECT_DECLARE* easier.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v1 -> v2: new patch in series v2
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: "Hervé Poussineau" <hpoussin@reactos.org>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/southbridge/piix.h | 4 ++++
>  hw/isa/piix3.c                | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

