Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDDC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 12:32:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5150F21481
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 12:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hx9mshQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5150F21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJc26-0005qn-5c
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 08:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJc0n-0005G1-E4; Sat, 19 Sep 2020 08:30:41 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJc0l-0006Yk-Me; Sat, 19 Sep 2020 08:30:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id z4so8173574wrr.4;
 Sat, 19 Sep 2020 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PscmLFzXHDm/w1ZGBCLgyQqfbpOX+ZiYSHSp27dfx3U=;
 b=hx9mshQewbDDf+e4eki5hMeXjwLw5WtsVxt/g7GsUK+lLh+Sw3D/Ik5qJJq71oG6iv
 eXvOxvEbrkeXW24FfibbnL8qn8O1t9Yru6oJ9Y8c4t8TuO1AiTNeVZn9mJdAuf46zfL7
 0gUespuI21XioGxcIi/GplsJBdhqkrZeMptGE4TMgy2jkJ25jYLRaTC0gS6NQbhAQJK5
 9loGqadHrNN7eqmdd3G6AyZncc0axPNAmeLe/Ps1jwzrKEhKJFOxeKEJoDCQGc8lS50s
 hfqVmOpvUzvT6a2+IiUibISPU+Lbh3aCY8jghHg8gnLrib6rEgBbpwTPc/70vHaHK4ED
 pE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PscmLFzXHDm/w1ZGBCLgyQqfbpOX+ZiYSHSp27dfx3U=;
 b=Zmxx0+XWTlpFU2wOfWoZsM5O9YPvz3x5lVmmiP16txuNyu10F9pYAIFss27dHOGJPc
 61B1DVoDjS0XgmTDfc9iwm+rU/WXygVzDgb6a0M8hm0zNnLB7BSOA5CEkXiq/tyqW+cL
 QLLrcY7xwzgt5luzf2YxKdrk2HWRPe120xWE8/KyL4XyTv+YbROMMR+IoVJCDZz50UxP
 cNCRWXkbtwtIkHe/bqr79FqYz76Nx67SzkClza5MhNNyfCgl641TgaayDt+PLIdziAdC
 3m1cWdL5UImXhm5GQwK3M+uwtRikz/mEOC/C1Uv8GLddq1NX5gZnh7T/2eX6Y/kBQh/g
 E1Ww==
X-Gm-Message-State: AOAM530/XHY06Xctm1SdR+J17CEM4bBuJoq/punn1J85UjHsjkMMQlEQ
 5rO53CzrvysuHbd0DXTYJIg=
X-Google-Smtp-Source: ABdhPJwQgWN9A/qyITqGNkp8pQPYFlDczYEcWTSUoc39DFI3WwYOlvP+LB/rWiyido6795GcXf010w==
X-Received: by 2002:adf:ec90:: with SMTP id z16mr41082408wrn.145.1600518637105; 
 Sat, 19 Sep 2020 05:30:37 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 76sm11166018wma.42.2020.09.19.05.30.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Sep 2020 05:30:36 -0700 (PDT)
Subject: Re: [PATCH v6 0/7] hw/misc: Add LED device
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3783cc00-8ec6-6174-dad6-331177b95724@amsat.org>
Date: Sat, 19 Sep 2020 14:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200912134041.946260-1-f4bug@amsat.org>
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/12/20 3:40 PM, Philippe Mathieu-Daudé wrote:
> Hello,
> 
> These patches are part of the GSoC unselected 'QEMU visualizer'
> project.
> 
> This series introduce a LED device that can be easily connected
> to a GPIO output.
[...]
> Philippe Mathieu-Daud=C3=A9 (7):
>   hw/misc/led: Add a LED device
>   hw/misc/led: Allow connecting from GPIO output
>   hw/misc/led: Emit a trace event when LED intensity has changed
>   hw/arm/aspeed: Add the 3 front LEDs drived by the PCA9552 #1
>   hw/misc/mps2-fpgaio: Use the LED device
>   hw/misc/mps2-scc: Use the LED device
>   hw/arm/tosa: Replace fprintf() calls by LED devices

This series is now fully reviewed.

Peter, since so far only ARM boards use the LED device,
do you mind queuing it via your ARM tree?

Alternatively I can ask Paolo or send a pull request
myself is both of you think it is out of the scope of
your maintenance area.

Thanks,

Phil.

