Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D37C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8A92073B
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 03:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVo+gufD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8A92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEldK-00073J-Op
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 23:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElcc-0005kf-0u
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:45:42 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kElca-0003TP-4a
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 23:45:41 -0400
Received: by mail-pl1-x644.google.com with SMTP id bh1so2907856plb.12
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 20:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sqV4CD4eex60oNmdNWf1e1AwXEdP6cBcia6Vzz+jO5E=;
 b=QVo+gufDG2jzGWRcdXAGVaO5SXsQMtipPj1Ao4UXveAVaoRHkv6938p2sVVajcBdTi
 mZqoDkpdWWjjpf8uVvMLHq0LikLyEdtiAVGZ3+cf7nf2vOyY+z8bwOYQYv0+jd2xuCB1
 yqYLWptjwM7vIBYTQm/FyzpW4i8PUIZmRj7Quodjn1Amd3LGmv9vekfyT9n2rE/PeW+I
 dXTyH/S6ijyqLdakWHh7B+AMXdAWknUFRockSVE7KEgX/+twr7tLq5H52cLou3N6wfMh
 O84BbhArIKOL/Ge/1NfjpS5ZRhABJye3ztiq6qLeCcuBboXwjUB99HCjnxuQZwGbRgyv
 Lbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sqV4CD4eex60oNmdNWf1e1AwXEdP6cBcia6Vzz+jO5E=;
 b=rx0AbSARD1hA2uiJkBOo022n2ER0XNqIzAAcKTFUWNosTNCrrXDt0ZqrL04UkpUlw+
 h6x6WqJWSlAoPO7IVbD/MWw60TgT2rQWqby4MO+zt8uZoIxx1E+UZcTjbDb4x6aKVmo/
 B/XQjFL+fOAmdXZ/q81MGn5BKbipGitNfXjcTxamijw+0mATQiNHv2GO60Z64a/UXNSK
 YFdjQFrTvAx4hG+wm3g6ioc7JEyHVjZXlxeSGKMB0A8WTJIEn6CENNyFgQ33LkC71ECO
 zpckhr4Y/4yXp2OFWCVL3d98bLOf4l8R+PFwMZZjDx75Gh/Z118XKWaQ3KKb8PTlKhgp
 oaZw==
X-Gm-Message-State: AOAM533PBv0KGjlHOuC8ZFG5Xfs805wQkQszF2byxy9lJ9+BztIelXog
 CTDjk6v3s9H3KbSrTuvYIvbtdw==
X-Google-Smtp-Source: ABdhPJz4wmUGlV++LTdLnBjoaRCEO2CMkd8TjkB3kRSM3ACHVYoOQ5byD+BMgqHUDm+QTaY6o7KBVA==
X-Received: by 2002:a17:90a:b387:: with SMTP id
 e7mr15257956pjr.228.1599363938641; 
 Sat, 05 Sep 2020 20:45:38 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id mp3sm8652571pjb.33.2020.09.05.20.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Sep 2020 20:45:37 -0700 (PDT)
Subject: Re: [PATCH 01/13] pci: pass along the return value of dma_memory_rw
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20200904154439.643272-1-philmd@redhat.com>
 <20200904154439.643272-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f4bf011d-18c2-21a7-8e6a-0ad554a52dba@linaro.org>
Date: Sat, 5 Sep 2020 20:45:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904154439.643272-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Keith Busch <kbusch@kernel.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 8:44 AM, Philippe Mathieu-Daudé wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Some might actually care about the return value of dma_memory_rw. So
> let us pass it along instead of ignoring it.
> 
> There are no existing users of the return value, so this patch should be
> safe.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Message-Id: <20191011070141.188713-2-its@irrelevant.dk>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/hw/pci/pci.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


