Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5112C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED3F520874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhvpQeLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED3F520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRhy-0007o7-NV
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTRgF-0006VV-LE; Fri, 16 Oct 2020 11:30:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTRgA-0000x5-6g; Fri, 16 Oct 2020 11:30:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so3406723wme.1;
 Fri, 16 Oct 2020 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=y5g+BH7DVSD2irXW2waBxyDNrN/jBd+UOdq2bgeeu4U=;
 b=lhvpQeLPwMk/DuRRcOEth+fBHDHmX0oPPGWJAraIYlKqEXyfrjXSYXvfe2vrkBndzF
 SKAsEwAgeHMFmkTK9ndFtNTiksXrWQnIsVTN3XERCohZjF65LBQRLIk4nPc7j1f94NSH
 nfeEXchH9JcuxoZDOmNwprWxDe/d5rXNp3MeN0cm45gIh5FwqLrjW5IKHilqkS75z+WG
 jXNd+Z1kkftITeyKyZnsgtC0KRV+UsAIvrB1Lr7mtv2jpleUA07560jkACII6y6d5X52
 IooTNElSsbqN+PY631vmU84LjBVmGTUS2PP6Hmow4m5BESUHlnF5RVRYWrz8iME7yPow
 oEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=y5g+BH7DVSD2irXW2waBxyDNrN/jBd+UOdq2bgeeu4U=;
 b=To/LOWIEIwuReLSzJLAjYP8sEj6pFMaUrsBOfw+qWK/RpfoB5ri0/p2O3jVe8VoqYc
 QXp8NAqAWkHvqfX/miTCAKDfS9X4Lm1RqyG9bezlsmMcYUHEkxSeClJNOaCofcbHoqKa
 922A6fvp2Yf+0D231xC7dQf9q1V9C2ZCIYSkaYGsSjHX4iwDGMhYVzfRDhnryUzLi9f0
 LxfxIDpfN8T/H2dwdc2APYSo7TOo6+4oVG7+hERh1PeB3Ay/RNR/e6VMISd2wgYAdwkm
 74nCM/NklVQ4NQo8ahTXy3VpopsKS9WRMgallcyM2oYfMZvgzLdCV01rqTKCPkopAJHs
 uD1w==
X-Gm-Message-State: AOAM532kRRNrgK989ea4ystkAFZy8VFw74BzlMyVH49EzKr90ZnkJRYK
 ZySsNHahsWoglYskP3THzX0=
X-Google-Smtp-Source: ABdhPJyg1REd++MumCdf/6ZPVmNT70LOccWPt4/EuKuYu6aPrs/S+VO7YnxTJhFvmf6GBo5nrgvAjA==
X-Received: by 2002:a05:600c:2707:: with SMTP id
 7mr4480318wmm.147.1602862199181; 
 Fri, 16 Oct 2020 08:29:59 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id e25sm4354147wra.71.2020.10.16.08.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 08:29:58 -0700 (PDT)
Subject: Re: [PATCH v6 0/7] hw/misc: Add LED device
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20200912134041.946260-1-f4bug@amsat.org>
 <3783cc00-8ec6-6174-dad6-331177b95724@amsat.org>
Message-ID: <22a8256e-3d1d-832e-b8ac-e05e9e91f07e@amsat.org>
Date: Fri, 16 Oct 2020 17:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3783cc00-8ec6-6174-dad6-331177b95724@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cédric,

On 9/19/20 2:30 PM, Philippe Mathieu-Daudé wrote:
> On 9/12/20 3:40 PM, Philippe Mathieu-Daudé wrote:
>> Hello,
>>
>> These patches are part of the GSoC unselected 'QEMU visualizer'
>> project.
>>
>> This series introduce a LED device that can be easily connected
>> to a GPIO output.
> [...]
>> Philippe Mathieu-Daud=C3=A9 (7):
>>    hw/misc/led: Add a LED device
>>    hw/misc/led: Allow connecting from GPIO output
>>    hw/misc/led: Emit a trace event when LED intensity has changed
>>    hw/arm/aspeed: Add the 3 front LEDs drived by the PCA9552 #1
>>    hw/misc/mps2-fpgaio: Use the LED device
>>    hw/misc/mps2-scc: Use the LED device
>>    hw/arm/tosa: Replace fprintf() calls by LED devices
> 
> This series is now fully reviewed.

Since the Aspeed board is the main user, do you mind
taking this series via your aspeed tree?

> 
> Peter, since so far only ARM boards use the LED device,
> do you mind queuing it via your ARM tree?
> 
> Alternatively I can ask Paolo or send a pull request
> myself is both of you think it is out of the scope of
> your maintenance area.
> 
> Thanks,
> 
> Phil.
> 

