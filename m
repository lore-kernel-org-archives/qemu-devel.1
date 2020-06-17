Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABED5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:42:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1022082E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 03:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lv68FOAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1022082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlOy5-0000e3-JB
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 23:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlOxM-0008L7-0F; Tue, 16 Jun 2020 23:41:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35554)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlOxK-0001VK-Hi; Tue, 16 Jun 2020 23:41:43 -0400
Received: by mail-wr1-x441.google.com with SMTP id x14so743943wrp.2;
 Tue, 16 Jun 2020 20:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KxDZh0WuOU2HG0S8wMTnkiMKD5a3XwC8J4IknpGT+RY=;
 b=Lv68FOAjRKEaCbgT9CR5Sm41GbSARzGiBYwUj16IvNlhZZlubVocqgYUqGdVw2JR58
 0JKQZzegRgOMl6jGHJOjQfmaR1Uj9yyOHHsdXtNrguBCmiF6MlRstGxTZ9Z6fhsXRq47
 YWKapKA7pveFusT4UUkI0FeF1pcXrSTHVTgb+rNocWn+qpBmp0KzX5VgSaWWTaUp7fYV
 BRuB7i3uYj2x5tb6QOT8yPBEd7ZWRgc8CfAIyxw4bMrB9V3UHsjVouuBaJb6r0wd3SJc
 /j0WSjpYSCFveDe3iz+4FJ3rt2IS+PAHkeJYUCsxjqnQxZBEPVqaHtHUINLSdxtKcD6a
 ligw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KxDZh0WuOU2HG0S8wMTnkiMKD5a3XwC8J4IknpGT+RY=;
 b=TsHcqVB9sLhMJr52W3egkYMRJeo/n2qzD+XYFQs4+NAx+gjawi3JI5ZkSNXaZ0wXb0
 KbkXS9smOTpmeYHei1UNcK+RjCTpGW/Zd6ENjXJGF3z5JDA5IyU1JJhCRP3lkFoQwu1W
 hZLsjU5iAu9L6leVCdMbNZADFkRwN64ta6iNDaVhrR9gCQgNLerrsdCg4X2hKlGQItpD
 gXGSCqJ8IYNeQjJgnLXL/9TQERVX5mBaIWCWTJ0/zq17QQlT11+6yi5jboYcxypS4Vhq
 y2Ddvgu6azGq++L+RdM5Dx/eusUGBJeuCjDh6DrAus3bxtwxO0fa6pbi5+3k1wcC90G7
 RF1g==
X-Gm-Message-State: AOAM531H11zxoLkBKJ+5nv4y2BAhvSy7NXSD8E0CA/rlMsg5G8pOf18Z
 Ysub042TG4Vr44S/IpnRH9g=
X-Google-Smtp-Source: ABdhPJxgX1DJbY5NZCbFyNd0xfMF2Gg2sDxh7hSmHd5jMSY8By++/0KS2t8mca367qhEVsum1ThDpQ==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr5993012wrv.174.1592365300209; 
 Tue, 16 Jun 2020 20:41:40 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id t8sm6283529wmi.46.2020.06.16.20.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 20:41:39 -0700 (PDT)
Subject: Re: [PATCH 7/7] hw/watchdog/wdt_aspeed: Reduce timer precision to
 micro-second
To: Andrew Jeffery <andrew@aj.id.au>,
 Cameron Esfahani via <qemu-devel@nongnu.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
 <20200616075121.12837-8-f4bug@amsat.org>
 <914f089d-e81e-4b01-bd70-4702d8b39724@www.fastmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ad812821-8b06-bb82-d336-ffb1e7c14839@amsat.org>
Date: Wed, 17 Jun 2020 05:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <914f089d-e81e-4b01-bd70-4702d8b39724@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Andrew,

On 6/17/20 3:18 AM, Andrew Jeffery wrote:
> On Tue, 16 Jun 2020, at 17:21, Philippe Mathieu-Daudé wrote:
>> The current implementation uses nano-second precision, while
>> the watchdog can not be more precise than a micro-second.
> 
> What's the basis for this assertion? It's true for the AST2500 and AST2600, but 
> the AST2400 can run the watchdog from either a 1MHz clock source or the APB 
> clock (which must be at least 16.5MHz on palmetto). The reset state on the
> AST2400 configures the watchdog for the APB clock rate.
> 
> The Linux driver will eventually configure the watchdog for 1MHz mode
> regardless so perhaps the AST2400 reset state is a bit of a corner case, but
> I feel the assertion should be watered down a bit?

What about this description?

"The current implementation uses nano-second precision, but
 is not more precise than micro-second precision.
 Simplify by using a micro-second based timer.
 Rename the timer 'timer_us' to have the unit explicit."

> 
> Andrew
> 

