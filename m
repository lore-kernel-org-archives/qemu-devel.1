Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BE2C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A2AC20759
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a0TCaUF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2AC20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kElpO-0006lB-6Q
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 23:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEloq-000681-GW
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:58:20 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEloo-0004tx-Vi
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:58:20 -0400
Received: by mail-pj1-x1043.google.com with SMTP id gf14so4835200pjb.5
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x/K9DfBaCDVRy2Q1yPT5gqpEh6i01VW8hIjOC6nepkc=;
 b=a0TCaUF/eQ4JdzFJz7r+gYBP1303bQkxWTBNvfEI2osx3xFWMxXjqMej5hWRm1JJJ5
 nCwB71F9dycCGhv3Ir9uJGkUCVBcdTMeJ1WeC4q87YpRozA7Kk8NxGH70g2Sf1tdLW/z
 c0RFZZyP1atoS39U1hfB4DXspghoaBeE1NG9pkzn2O5G9ljmGZYhWJmVUPyK00IlIOHC
 Of8oY+b8kg9LmdRYNCQggO9EhyF7cECsZ87+CIf475eAa/nKNzb/Nx0+C3mA4NwCCqYo
 OLvtTzDK5Z0VxCI9hzntIor8B1NpA0rd3pSGtNmszBazgZTgF3EiXKhOyv13buo/ejhW
 5oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x/K9DfBaCDVRy2Q1yPT5gqpEh6i01VW8hIjOC6nepkc=;
 b=iDPw/pZ1AyKbfAJLj/nFEqfuUxsK2gQ5GFkVocPU2uRKlej+QftLL1lMuBqK45tTSm
 Rh8mgOWM+qag5LIbq5meeu59k1e1fkNuCETMJ5ysc2KlLi1FzIyXN2WaI4Km1wcEBcLA
 Eu23q/CJcGuDHeE9Lxsdp2+awSwWwYUb9hdQm+4CUDe3NsF3VEpIQGSchF1UYw5f0hZu
 kde4Rcahh/J0ttARTDnQZi41hzYlIk+1VuhCVe4XxDXOiPj650vTaICLdKA6MH7xgWd1
 6SE5i58HQyy9TBRtm+cd+4dv7PH2htuXWyp2K+E2YByfaKzvppsU8WtBI0pcw6fmjynv
 BILw==
X-Gm-Message-State: AOAM530SWs0QX+qGWIfQ5HPYoBAVzXDz4HOXJcN4qBKeXrO1wC0JE5rJ
 FbJZasRKGVZSzIMiwu4UNITokA==
X-Google-Smtp-Source: ABdhPJxp1t5Onid+4GiR8t+ZwXqqdkJrf0sgbHtL0Ooq5DoFrNiZYLX3NsrgH5pRUihuuSXJHhfItw==
X-Received: by 2002:a17:90a:bf8d:: with SMTP id
 d13mr15219470pjs.100.1599364697731; 
 Sat, 05 Sep 2020 20:58:17 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u22sm8792077pgi.85.2020.09.05.20.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:58:17 -0700 (PDT)
Subject: Re: [PATCH 06/13] dma: Let dma_memory_read() propagate MemTxResult
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-7-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f013f669-d7a7-ae06-a192-0878451dd18d@linaro.org>
Date: Sat, 5 Sep 2020 20:58:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Richard Henderson <rth@twiddle.net>,
 Laszlo Ersek <lersek@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 8:44 AM, Philippe Mathieu-Daudé wrote:
> dma_memory_rw_relaxed() returns a MemTxResult type.
> Do not discard it, return it to the caller.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/dma.h | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


