Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22099C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 15:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE1920738
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 15:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyKm2S5i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE1920738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9VGm-0000Ti-3h
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 11:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9VFc-0008SU-8q
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 11:16:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9VFY-00014f-4L
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 11:16:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id a15so4536882wrh.10
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Z2DGV5tXBjwcdNLj/197HsDwn4f9qW7jUzgpXaMsYNo=;
 b=DyKm2S5iaWdVL7a5DsKzgiBab8RP5KY5yU7KjNEn2vXix2OUlcA3AaHh6CRQ2ZApSS
 KW8pfBy6RJC2lgg4oKZEPYXTyjMQuW2j3RerNKaGfcb7TphUooukiGjqg7pl4SUQjw9e
 dahknF5Lw3zR6AOOL2Mcr8nn16fZs2pSxdUsbj1Ra9nAHOs2OFDR194BtH28Utg4803q
 f2f3hiKjF0gbJhH9RpRrXcnCMQCG+abpD93/p0hQu+vRZRn/6OgSbBrsH8XtNjNzf2C/
 OvZimFkYW9qwl3WJskec7qj77vYwEl/t1OsmZDicuVQK+ZrqJvNULUjEk0SSL7R1Hf+J
 4iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Z2DGV5tXBjwcdNLj/197HsDwn4f9qW7jUzgpXaMsYNo=;
 b=b1DsmFZ9kZGA1ABmzhvEaUzk9WbpKUrwwuZnAGRVLE3uzI3Cbc43jW/rOZXc/EGYo4
 oMsl3ZU/7oiJp2BiK0ncHOamafrGDy9Wz1H9X+4VgdoBwOJYH/rX/WO6TbQVpWLABCfh
 S8u02oheA7Z3LDQiAi8CFx6VbhqVptRAHlZ8rWnbzyxCLeSESkBjYGes31ueXokVAr1d
 1Gt2/dGwnWQ05SHKl2cz4nVHBDY47Cfv7y+jCgaGpgn+78Ii22PFBva1uf82vSptGAXk
 i87Vro6qS8XgX/cCofKWKi9ADXvhA9RhrYvDHSbQHVHY24hjPyv8olaGxzM/uAwevaUl
 l0LA==
X-Gm-Message-State: AOAM531kzbjuJY4AnPqr16pq9QR9omlRpVNJAKZH+0r6mnrVj0YJT9M2
 EbC2zGAwbywpofXBXINNiBc=
X-Google-Smtp-Source: ABdhPJz9Dh+F94/YgXPtdbZyOkoeRWQPneGCI0yvTcJ05eqg70WkTtlCPZRoDj+N5Ci5jdpGwlSiYg==
X-Received: by 2002:adf:fb87:: with SMTP id a7mr7952396wrr.390.1598109362013; 
 Sat, 22 Aug 2020 08:16:02 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 5sm1138563wmz.22.2020.08.22.08.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 08:16:01 -0700 (PDT)
Subject: Re: [RFC PATCH 0/9] hw/misc: Add support for interleaved memory
 accesses
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200817161853.593247-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c21cd155-31e2-5911-f5c3-7362e0819f75@amsat.org>
Date: Sat, 22 Aug 2020 17:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817161853.593247-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 6:18 PM, Philippe Mathieu-Daudé wrote:
> This is a follow up on last year patch from Stephen Checkoway:
> "block/pflash_cfi02: Implement intereleaved flash devices"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg613077.html
> 
> Instead of making the PFLASH device more complex, I went
> implementing a generic interleaver device (that can be re-used
> for other MMIO devices, probably pointless, still useful for
> simple testing).
> 
> The series is available on [1] and is organized as:
> 
> 1/ Fix a pair of issues in memory.c as we are not exercing much
> the memory_region_[read/write]_with_attrs_accessor functions (see
> also [2]).
> 
> 2/ Allow to use qtest helpers with the 'none' machine (without any
> CPU).
> 
> 3/ Add the interleaver device
> 
> 4/ Add a device to test the interleaver device (later I'll expand
> it to other MMIO accesses, such access_with_adjusted_size, endianess
> and unaligned accesses). Let the 'none' machine create this device
> from command line.
> 
> 5/ Add qtests using 4/ to test 3/.
> 
> 6/ Add a way to display the interleaved memory (sub)regions in
> the HMP 'info mtree' command.
> 
> Based-on: <20200816173051.16274-1-f4bug@amsat.org>
> [1] https://gitlab.com/philmd/qemu/-/tree/interleaved_device-v1
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg730279.html

I followed Paolo's suggestion to use qtest_memread/qtest_memwrite to
avoid endianess swapping, and now cross-endianess works :)

Review still welcome, but I'll respin in September.

Regards,

Phil.

