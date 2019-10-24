Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CDFCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D9E2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 14:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5GanjIO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D9E2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNdfs-0006hU-Iu
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 10:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdRt-00069X-PH
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdRs-0007Qk-Ls
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 09:46:45 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43462)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iNdRp-0007PJ-DU; Thu, 24 Oct 2019 09:46:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id c2so20929845wrr.10;
 Thu, 24 Oct 2019 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PiDWom4c6Rr19xjKo+tDaPEyShkwqoaa566oCfkTRBc=;
 b=h5GanjIO9zPlA1t592GgK6fTFpU2eeeqqXkKndNs44bPaFKvGw+uhnt9s4nkK25bS1
 fwx6J1k6MCozAJiqNWVvQ0CQ9TNCSOiyToDnnMpmEwgIykcZHNr+Ym3x4t+/KcPLrI4C
 0mz3RklnfKRU5/tXeT/rtzzdeH4sI+i/z9C6m9Da9OAZnY5ld1Zl4VmPu5Elfbx2yiMT
 z+tVUMvZSegTFJ6/liSGky0VKtPi6zd/YGSj2re4Xkz53/ov/BNeYzYqdqNljEKYrPRE
 vzv583/Ry6HzYgV6StucTuP6FnM9rPuYRDyofL5w64zhHrp+Wvqs6Shb7AOPMDc143ph
 vXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PiDWom4c6Rr19xjKo+tDaPEyShkwqoaa566oCfkTRBc=;
 b=De1QP5PfwhuOg/dQ3dhKzqjCDOE2/Y51iYLY9GaBC4BBorZZsJdV9do4uh3mASZEGE
 4B6VNM/MS3Osllg/nF38jcExNnK5mv7MmS6+qN2g4cSPhN3tDkyL/gGt9XFM9oeYBJMe
 kWPBHYIhKLqvck2pArIBo9EWVexkgnJXqfsdDz4HtctqTWMtWnmtTzC29ZylWug6Wp7W
 iobchBgZAnePfMingpPQ4CHSlRbZiNqPBMdqfrCK3q+jZi+R15z4khNGSb9TaoXpH/dP
 LW0e3lVqM+4+bM8j7c6VWbHn8s2xBPbq8l8jLaE14+vJKEBvYfF6LmgWh1uHI2uQWZR8
 WIew==
X-Gm-Message-State: APjAAAU2c/Fb+DtVyZuSH0LS7WrLMtBYkSb8YBe9VbZCKdr9FLrBmnmH
 q6QbsCnuQYmZRD8bke5MWfs=
X-Google-Smtp-Source: APXvYqyZygIrnPWNcqTxtHDhw0Px1SfZgZWv3ufvbhgsPWY1BNRQ6kvVxuQ2HSqtNzWadrptpRcuIg==
X-Received: by 2002:adf:e441:: with SMTP id t1mr3767830wrm.395.1571924800186; 
 Thu, 24 Oct 2019 06:46:40 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id y13sm37094271wrg.8.2019.10.24.06.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 06:46:38 -0700 (PDT)
Subject: Re: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer, improve address
 space, run U-boot
To: Peter Maydell <peter.maydell@linaro.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
 <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ad1b559-13c4-ed2c-f82b-e6a516219e57@amsat.org>
Date: Thu, 24 Oct 2019 15:46:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Rob Herring <robh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 3:42 PM, Peter Maydell wrote:
> On Sun, 20 Oct 2019 at 00:47, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> Since v2:
>> - fixed issue in videocore address space
>> - allow to start with some cores OFF (to boot firmwares)
>> - add proof-of-concept test for '-smp cores=1' and U-boot
>> - fixed my email setup
>>
>> Previous cover:
>>
>> Hi,
>>
>> Some patches from v1 are already merged. This v2 addresses the
>> review comment from v1, and add patches to clean the memory
>> space when using multiple cores.
>>
>> Laurent, if you test U-Boot with this patchset again, do you mind
>> replying with a "Tested-by:" tag?
>>
>> The next patchset is probably about the interrupt controller blocks,
>> then will come another one about the MBox/Properties.
>>
>> The last patch is unrelated to the series, but since I cleaned this
>> for the raspi and the highbank is the only board with the same issue,
>> I included the patch in this series.
> 
> I'm going to apply 1-10 and 14 to target-arm.next.
> (I've reviewed 10, and the rest have been reviewed.)

Thanks!

Do you mind amending this to patch #3
"hw/timer/bcm2835: Add the BCM2835 SYS_timer"
or should I respin (or resend it alone)?

-- >8 --
diff --git a/hw/timer/bcm2835_systmr.c b/hw/timer/bcm2835_systmr.c
index 49b40b55f9..3387a6214a 100644
--- a/hw/timer/bcm2835_systmr.c
+++ b/hw/timer/bcm2835_systmr.c
@@ -115,10 +115,7 @@ static void bcm2835_systmr_reset(DeviceState *dev)
  {
      BCM2835SystemTimerState *s = BCM2835_SYSTIMER(dev);

-    s->reg.status = 0;
-    for (size_t i = 0; i < ARRAY_SIZE(s->reg.compare); i++) {
-        s->reg.compare[i] = 0;
-    }
+    memset(&s->reg, 0, sizeof(s->reg));
  }

---

Thanks,

Phil.

