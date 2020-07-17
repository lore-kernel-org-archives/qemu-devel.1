Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEFDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4657F20775
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB/5vJaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4657F20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOap-0004c8-FN
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwOZf-0003sQ-B3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:30:43 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34761)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jwOZc-0003rd-Je
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:30:42 -0400
Received: by mail-ej1-x642.google.com with SMTP id y10so10372474eje.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 04:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lYD5wOidpYEYNHMfNGk0CBeq1eu5k/O3InL6WjYRGuk=;
 b=AB/5vJaqztmM7rqOBAh9pwLgjxAY0zJn4crHB5ZV6W/QPOAWj+wNBy6fEa5GIrhDL/
 nDSHuHzSG7ak+l1UdR+kmPHsqDmw5zeSaF7bfXzGN2hPJaH1WATVcB49EbQPGyZtjMIY
 9xMQ2xRdaGwHeNhEo3OBeHPpfQ+4tVOPKdTJD0oghhNrFBnUBEORJgc0A6Z0oahPi7Su
 2PivNbtPUBKuRec1Rw9Lya0Iucd4JkZsZRfope53iEhG8Ud5xZGt5CRRxp3lM7oPZGh0
 045pSTyHbuPLrj4z7ggjW2sNmsQ1cE77eGLP/glMiwVhCP30QjZf91aScdKIEc/uki/c
 HVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lYD5wOidpYEYNHMfNGk0CBeq1eu5k/O3InL6WjYRGuk=;
 b=A+0clhMTOCxxMbqnpJpR/mBTQoiUSrsmoiA2yNIgdq1jffxIyl7g9Qt5PjsEihD+n+
 RXxAQSZ6GJ4SNiXuUvjSA9IpReOAeN/PCEaUhJRK75B6iuxHaZcqtFzdLfLGGlGElW0N
 hwOXSOf6mUqD4eBIagHI8tKRYbJYa7w2IKJuINTjFuG8aMDo71c9COH/UC4KhN5x82H9
 vLeMbbtQaJ0OKAEm87IQ4I/N19jm6xKoR8j3CnHv4/5BXznZhfoPZxHcK1y7iJXtv/75
 B5itI7tHquw3vDmzCobm6D4Bc467ga6DXNs7DKeZof2omzNIVO4zrgRLp3b6ta7796yO
 C4iA==
X-Gm-Message-State: AOAM532KMf9oEcj6awRc8vlP1cunSNA/TEJjQdud/RDi9fBefXZUHEIC
 XQjgRpLhKVxZlAPBEZB4JmML8UAY9ts=
X-Google-Smtp-Source: ABdhPJx8SQZcqHfMZTyvuuFt+xCbF4y3WTt+kZ11ov1L8a+TCtiSeDAe666AncmrT111B3GSvmcRmw==
X-Received: by 2002:a17:906:f49:: with SMTP id
 h9mr6152994ejj.155.1594985437812; 
 Fri, 17 Jul 2020 04:30:37 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o14sm7679112eja.121.2020.07.17.04.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 04:30:36 -0700 (PDT)
Subject: Re: [GIT PULL] I2C updates
To: Peter Maydell <peter.maydell@linaro.org>, Corey Minyard <minyard@acm.org>
References: <20200716174900.GL3235@minyard.net>
 <CAFEAcA-UWJBpM_-G2RAe9B-WcPzBaKGZTas1njehQ7gcjsMpew@mail.gmail.com>
 <20200716222601.GM3235@minyard.net>
 <CAFEAcA_5M8MD+2s_r1jjcgDY0LX69iZRkUP1kbUQTQYEuSN1Nw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c60beae4-2de2-3355-08bc-ee442cd6b091@amsat.org>
Date: Fri, 17 Jul 2020 13:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_5M8MD+2s_r1jjcgDY0LX69iZRkUP1kbUQTQYEuSN1Nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 12:50 PM, Peter Maydell wrote:
> On Thu, 16 Jul 2020 at 23:26, Corey Minyard <minyard@acm.org> wrote:
>>
>> On Thu, Jul 16, 2020 at 09:45:41PM +0100, Peter Maydell wrote:
>>> Hi; this failed to build on x86-64 Linux (incremental build):
>>
>> Hmm, I did test this, and I just rebuilt, then rebased on the end of
>> master and rebuilt, without issue.
>>
>> It looks like the smbus code is not being included, but I don't see how
>> that can be.
> 
> I was wrong about which config failed, sorry. Incremental builds
> are fine, but the build that does "make -C builddir clean" first
> fails.
> 
> It looks like the problem is that in the created config-devices.mak
> files, CONFIG_SMBUS_EEPROM is set, but CONFIG_SMBUS is not.
> So presumably the problem is in the change
> "hw/i2c/Kconfig: Add an entry for the SMBus", or it is a more
> general issue with changes to Kconfig files not correctly
> resulting in rebuilds of config-devices.mak.

To Corey, this is likely the later (buildsys), see:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05475.html

