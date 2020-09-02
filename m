Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BA4C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE6B206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poLvpDIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE6B206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVko-0001Dz-Cv
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVjj-0008Pu-Dk
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:35:51 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDVjd-0004x7-Ox
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:35:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id g4so90638wrs.5
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:from:subject:autocrypt:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=qm1I50KANTLSnSZ0H9q1yOrDKIpPRPGAGKPgFwvSwG4=;
 b=poLvpDIPwrIQZjEwec5uX6bXIRvrayhxuTw7Heaw4FA+H0CAavTc2gAD509vBqTMiP
 jkTyYRFtS1R7ByhElggLuH20jk0S6/lBgNrhf+MjiCeYzR/8jDdF5dG5K8e3D1V9Jjeq
 fZg8Ps2trfqNGBFKO/kCGe0kV1Q7n7aWOQI8N9yYqInqF59owpbUwpoRab/4kDvfPfoV
 AG97EWzC2CovrkLM0fV+vHMplT/P9xgG3lzHTxgQn8JtRCvEIbcLVnfv/ON/i903rMpP
 ehXINB9rYXTeBT2QCY8XGo9scWn1KHJD9abAwSDB1XQiRWxPPp+jE7bHWFfr4Z17EJEW
 qo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:from:subject:autocrypt:cc:message-id
 :date:user-agent:mime-version:content-language
 :content-transfer-encoding;
 bh=qm1I50KANTLSnSZ0H9q1yOrDKIpPRPGAGKPgFwvSwG4=;
 b=U7su97zOa8Y2XxRyLYTlBf3GMD1Xo7t4+um1gm4Nx/Wdq5v2bVUBrhFTwJF/wKNtw+
 Go/Q/G1MJWh+7rJaZiWozQdWBvWTXQHPtxsACExt240DkudtNiHoeVlie5gfYgr4a7wI
 oGIzfxKgtrUYwVPQqDyt3uIh0Tf/h5vrqBoPEZx7vhUL3dKrTF2G31XoD8ixlRR5ezdY
 2MPDwIs7mXT2I6MlMR9QgApq+oJFZZPDUlv5+6yaOVTRGxXZi8SxlC0MAZnoQeD/swiO
 FPIvlDVP34pSfmq47lrMUgKKKGTE55o53TGP44koczT4ndiiVWM8Es/ZOXGYErGG56QF
 gntQ==
X-Gm-Message-State: AOAM532h+rFdQHaIWqPuRqeuxx0CdveNLsWvh/bCtP8YqN+tOGX40eAt
 /gtKqcmMAmp/Xzia0NDNwjs=
X-Google-Smtp-Source: ABdhPJwh5i9DtBNxns3RxVE71ZJkQfS+uWM7+d5RrwKh370YH9S/t/oydi9MjWZDqg3MKhRDUk80nA==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr7605546wrt.23.1599064544067; 
 Wed, 02 Sep 2020 09:35:44 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id r13sm250546wrj.83.2020.09.02.09.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 09:35:42 -0700 (PDT)
To: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Subject: hw/clock: What clock rate for virt machines?
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <bbdacc80-a321-5f06-e430-973a38e7e037@amsat.org>
Date: Wed, 2 Sep 2020 18:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Peter said "'clock' is basically meaningless for virt machines",

I understand and agree. But how to make that explicit/obvious in
the code, when a device expects a clock frequency/period?

Should we use 0/UINT_MAX for this case? Use an explicit definition?

  #define CLOCK_MEANINGLESS_FREQUENCY_HZ UINT_MAX

Or maybe simpler:

  #define CLOCK_MEANINGLESS_VALUE 0

But the special 0 value could be used to describe a stopped clock.

See for example hw/riscv/virt.c, it uses the following (confusing
to me) in virt_machine_init():

   serial_mm_init(system_memory, memmap[VIRT_UART0].base,
       0, qdev_get_gpio_in(DEVICE(mmio_plic), UART0_IRQ), 399193,
       serial_hd(0), DEVICE_LITTLE_ENDIAN);

Thanks,

Phil.

