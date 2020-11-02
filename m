Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF40C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E9720715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 11:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o4r3yRh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E9720715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZY9O-0003Bo-0N
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 06:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZY8h-0002fO-EP
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:36:43 -0500
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:36227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZY8f-00043B-TG
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 06:36:43 -0500
Received: by mail-ej1-x642.google.com with SMTP id o21so11407144ejb.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 03:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5Bq73EWlkdB6KKvewluwtnuT7qQVmTu5Re/ZsXBEA+w=;
 b=o4r3yRh1teoXPaD/2LfY76xu3KlCPj59nuC0Wrfzt4kC8RmfXw0K+NSxKr6pLDcyeM
 Sy/0EQZq3XhMnMBvL/W8mdAPaOSNUljJ+g6rJotIpm2BY9wVTUfSOoAVqh3Gn8Xafksk
 Jbya9yvfm1kBKTB19gS4f7Yz/JQcfUitAlxf0XzHJKsad4Yr1xdcxfqo48PdFA95n26+
 rJwNPzX0RWHxfvAguMVDNcIPaS3se/69A13J1h6lc51P87+8yD7ldgvUzZ4an4zfHMYp
 e1/lNAAnZxmtLVcZhlkjLeSBcpsK1iimUHo9d2rwn2DAb4JXDBx8+7lKHAAoO8x57cIK
 ocpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5Bq73EWlkdB6KKvewluwtnuT7qQVmTu5Re/ZsXBEA+w=;
 b=BF04SgpRFfDjtEuZ6wsKzzhx5cVmGPfiqxeqkfgt7EVAgktn7WzsSJkNqH8zj7NhP/
 9ene/1ync3BAhwtQ+hy6BYLHx4Iu+X5GPfg3pM6K78dQloOut7H/VXLeRqCYFd3fS9D+
 Ji2OR/VFEUktawP4PNsakNbTNITYUH922X3cZ955dZYCknt4kjgR/tvSc4PvnKmu4PUB
 gVI9ShTzOD86qVbpP5w5UZ/PbnAHp0wNbc2SyVtRThOJbTiXyTGX3GVa+kSConip8oRu
 8C82YRJpSYH1R0t1lt8tnSkGJ2uwOUUbBXwSGOgj/JPD3cxr+cgdh8w6j+CzQhrnTwej
 JRSA==
X-Gm-Message-State: AOAM532rigKpENFXL9dST8OFKh5AFUg+LuLMLuHie9hs5UgaibMSkLTP
 X9gPHwPZmHrc6VORjMH837Jo0WYW/lOEytVZmBdtJg==
X-Google-Smtp-Source: ABdhPJyoJbhDT7FAk1kLtpotYAwTe4Y3We3rLkl/hqQCCLTZ8BXBYb6xSSSIjPnoctwZFlYIKndwHi3BYzuvAr3MVHI=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr15679846ejf.56.1604317000326; 
 Mon, 02 Nov 2020 03:36:40 -0800 (PST)
MIME-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
 <20201023210637.351238-5-hskinnemoen@google.com>
In-Reply-To: <20201023210637.351238-5-hskinnemoen@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 11:36:29 +0000
Message-ID: <CAFEAcA8YvmFA7=7+CGVpubVScuKPdy+OQdmJdfMD+Fmk+Hb0SA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] hw/misc: Add npcm7xx random number generator
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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

On Fri, 23 Oct 2020 at 22:06, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> The RNG module returns a byte of randomness when the Data Valid bit is
> set.
>
> This implementation ignores the prescaler setting, and loads a new value
> into RNGD every time RNGCS is read while the RNG is enabled and random
> data is available.
>
> A qtest featuring some simple randomness tests is included.

> +int main(int argc, char **argv)
> +{
> +    int ret;
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_set_nonfatal_assertions();

While I was looking at this test case I noticed that it
calls g_test_set_nonfatal_assertions(). Why does it do that?
In our entire set of tests, only the npcm7xx test cases call
that function, and they don't explain why they're a special
case that needs to do so.

thanks
-- PMM

