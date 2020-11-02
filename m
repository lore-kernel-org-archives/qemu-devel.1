Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF800C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597CA2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="So3w0U5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597CA2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZded-0000fW-5V
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdP9-0006EN-0Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:14:03 -0500
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35968)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdP6-0006rP-8m
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:14:02 -0500
Received: by mail-ed1-x544.google.com with SMTP id l16so15133559eds.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dZIWI5JAmVyE/Zg7mnv1he/B+pFzgzRP2f5+f8UXVeE=;
 b=So3w0U5fdpsvZFRA6cgiFLFi6x9VbPjm4i/7SXgRkSW0Aw+a9NSZ+W+soDw5UFFDnv
 f0SwCTO8QF+XSRqbviEaz0Rc4q98b4i7Ji+c9mRY/Vg9aV7c3WxN3SDYxNYqjnqkwwHI
 opUNk23qAjuG3ck/3B6c79f+nNk8X0B+d+bdAKbF1ODPgbzyK8gyQM6CEI+3i2d7OQyF
 azvUjUvJL+FHSiPrg/AXUAiLaTg3izo3mCow24sycv5jdBbEOleSo2aHWAVZbn2TxgDA
 x7R1Ybc02IoMVYgcuy/4SSw+LD/IDtjFDx78kK3+R0clZPq+t5ARO8zn3iFMy8QAT+5i
 9vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dZIWI5JAmVyE/Zg7mnv1he/B+pFzgzRP2f5+f8UXVeE=;
 b=TjJ8ipwLhdncTc0x2LJI5QGwJTOZYaKefzKtPTbPEf3W2JZ58tC+5EnzokSKDDVVzk
 OFwGwc2xHnKTHUngfny2s5MAxemE5WuqrMHayEqhmqlJV1Lgf0gAdjDqNGcuPgtCrIGu
 fwUeS3Q0c3JSgrZbi3VN5FObq8qgFUIxN1+CfBde7DmSPGMxtPMXlSPxVLrC9tKyzzh8
 tKu0HjnF0mAFZKUnwhmgsOlPBkaUwqX/Ud6ZnJfEm0YTSJ7kLNV7LFvlG7aRrW3X84MK
 gn57hD0dmBs3l/yiWiMQnGcsbCTG7cs/MjDade77sHrPa5YZIGNnYC3vTtJAKBoM7UGS
 Q/AQ==
X-Gm-Message-State: AOAM53397y5PVuSNnDA/JsP94o+qwQ1SMKeoy+SD5i56epiTxsKe5ZSu
 oxau9jnSjnY3R18zT4wrPYRWV+0YF6yG6bXt867m2g==
X-Google-Smtp-Source: ABdhPJwJIMbZRp0ir24DaBRGKV+QrMJHzVlq0/S83AX6PnW8nYD8S14HeKDUCQKCZ8tcHwoBuRhhVkSt5cvlh8Snd88=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr17185489edr.44.1604337238390; 
 Mon, 02 Nov 2020 09:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
 <20201023210637.351238-5-hskinnemoen@google.com>
 <CAFEAcA8YvmFA7=7+CGVpubVScuKPdy+OQdmJdfMD+Fmk+Hb0SA@mail.gmail.com>
 <CAFQmdRZOKLb6=NJoeY9U3eYq3rbG_OWGFDDZdGTf8vjVOA11TQ@mail.gmail.com>
In-Reply-To: <CAFQmdRZOKLb6=NJoeY9U3eYq3rbG_OWGFDDZdGTf8vjVOA11TQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 17:13:47 +0000
Message-ID: <CAFEAcA-KxvtQGsH9yT9FrVnAu4cDWjMzPx_vGoBueGYhB8sziA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/misc: Add npcm7xx random number generator
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Patrick Venture <venture@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Hao Wu <wuhaotsh@google.com>,
 CS20 KFTing <kfting@nuvoton.com>, qemu-arm <qemu-arm@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 16:50, Havard Skinnemoen <hskinnemoen@google.com> wrote:
> But none of this is really specific to the RNG test, so I can remove
> it if you prefer for consistency.

I would prefer us to be consistent. If you want to propose
don't-stop-on-asserts then we should set that consistently
at some higher level of the test suite, not in every
individual test.

thanks
-- PMM

