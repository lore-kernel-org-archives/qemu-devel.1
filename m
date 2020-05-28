Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B8E2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 09:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjf9uqkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B8E2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeEpE-0005fh-8H
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 05:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeEoZ-0004nR-5Y
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:27:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40124)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jeEoY-0006nK-9j
 for qemu-devel@nongnu.org; Thu, 28 May 2020 05:27:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j16so14669754wrb.7
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:from:cc:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=1qhYvGuZTQPD8o2QnUs5/dW5vtW/qmlZCwg44sTW0J8=;
 b=Pjf9uqkV4SRKfNaVTy9TFtQyheOdddMWMmcP7Tf2L+0apCbPPNwDu7DhAZSArTBiDW
 pWuZC9fIUiakeBJT+yMCx8F1TkoeWJ6DyE3SP9UoQSO31g9dxDiDsMJmA5GvIFoKcDY/
 Y0POFVrtMBigDXMZhX35HX01SsvYS1+xgeZWHZzH/1yuUndPCXHQrexmtrZhjCGyzvy1
 hE6zGgNsYeGDrpJoCsGu4m/5y5hRoD1RbhVg3QPzZoEwXpvYhhi0XrgdbFkuy9IJ9xMi
 guSOD6ggZsamk9hK2vSTGOkxCM+Q6G5/wK6g5f2Q+YmYZehGn1KdbhrZGgureXMOW0Fw
 3z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:from:cc:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=1qhYvGuZTQPD8o2QnUs5/dW5vtW/qmlZCwg44sTW0J8=;
 b=F5p9tcQrOmYnfLYF7IbAee5u9Vnk6f09lfRh4O1FSHFdh1snBDAMnEN9h7qkReEYXB
 nwz5ygkN0Fz3nHlKt3Zt1rsMVjE9Xl0+TSbL8JaxO0OnLIK54+5UVOL0hu4WApa560nv
 y44Q1reMnKOjQMyCZldVdRhkTkliOZyaHvIOESREGb90DQQrxYUrghL7E74Mdwi9GIfh
 kxpjYGqcgSBFENVA6Td+OepZj3P2rdYH+6A7ocbDEshmMHGruLdXMwZs2m89/IA2U+u5
 EwwJBMTOd9wAyFUgynWRxJu3Vav7ef4980uyIaORyToL+K5TtHELhxMHr/TmCtN66FhI
 504w==
X-Gm-Message-State: AOAM532Rp7EmwUS9DwHPbEB1WO52Y/JvHBUPTfdWUy2v+dPbuGUJJYm3
 9fcTBqWu+BNh1xoJ7Dup7G5BlFRE
X-Google-Smtp-Source: ABdhPJzWN/uC5EVJrYA/QRHOchweh37Oa+SuALa32Fsr+BwvYPYGjlISTFIhnDRAPUsYeSYGQPHVzA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id
 l8mr2731990wrx.148.1590658019641; 
 Thu, 28 May 2020 02:26:59 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id t129sm1100728wmf.41.2020.05.28.02.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2020 02:26:58 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Oleinik, Alexander"
 <alxndr@bu.edu>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Subject: How to fuzz devices that use timers?
Message-ID: <93600c7c-ccd5-01b9-36d1-5631bfb63b7e@amsat.org>
Date: Thu, 28 May 2020 11:26:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Some devices use timers (QEMUTimer) to emulate hardware precise timings.
i.e. with a flash device, the guest orders erasing it, the physical
erasure takes some time - let say 200ms - and upon completion a bit is
set in a register, and an interruption is eventually raised.
When not multi-tasking, a guest usually poll the register until bit set.

While fuzzing, a payload schedule triggers an erase, then (if we don't
reset the device) thousands of payloads are tested in vain until the
device is ready to process further requests. It is then hard to
understand the patterns used (in 200ms libFuzzer tried ~5000 I/O
other accesses). Even if we can reproduce the pattern with proper
timings, it is also hard to reproduce.

Since we run the fuzzer with the QTest accelerator, my first idea was to
check for 'if (qtest_enabled())' in the timer code, and directly expire
a timer instead of scheduling it. This way we can test reproducers.
However various tests require/verify precise timing, so this would break
various qtests.

Second idea was to add a fuzzer_enabled() method, and check it. But then
I noticed some devices use timers the other way, they start a timer and
wait an event to happen in a correct amount of time, else the timer kick
and error bit is set (this is the watchdog style). If I modify the
timers to directly expire checking fuzzer_enabled(), then these devices
enter failure mode directly without processing further requests.

So I guess I have to go thru each device and check for fuzzer_enabled()
where appropriate...
Any clever ideas?

Thanks

Phil.

