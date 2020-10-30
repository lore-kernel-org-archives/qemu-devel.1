Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762FBC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B4162076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPzgU1Q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B4162076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUaJ-0002DX-D0
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYUYT-00019n-0i
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:34:57 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:46504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYUYQ-0000p5-Om
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:34:56 -0400
Received: by mail-ej1-x642.google.com with SMTP id t25so8589255ejd.13
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G7JfKGJGCmQ6dccOnGzetPbHmR3VObzYH/qAOt3oHR4=;
 b=jPzgU1Q1Z5a+vf6vJWUUlfJxGxNjj+ue7LffW1KRY6VKK8wAdDNckO/SynYevkvr6A
 kJxJpU/uLHF7THMdRnFqggx/DRI+jaQgD9xnjUq2qGOHfKbYfSUG5ccuRlhuVDyfPAFs
 SDfrGI78J4x90N/9vbcUteZfLK3hAZjwneBXgWX6Eb2jASBCVpWajOeI2J2ORzZelPrp
 0NwdGSu5ORKi/CqHoqxT1alYmeqwlEBeGyr45N7WxJQck/tNwjM90fVXe7VFNxSj8jI9
 0ujnkew1DaI3cDk/SySq9s7iN6edF1LE60WZkYIkvSS8Nb4nLQux8mH1uA1HReJOF3JC
 aHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G7JfKGJGCmQ6dccOnGzetPbHmR3VObzYH/qAOt3oHR4=;
 b=LbL8Tj+J9u0Kg0h9fOC0KhOYs8vxX5M7DhdhFjaw2+pt84MF8uRaUDAR9TGxr+vhF/
 LpZnXiBlg/H9idBdAG2Mc8Pak4W9lDmjKeDqF2oeRzGr/Vpgf81uHk0bViA038kxlowD
 x08hBGvdJc/0IpXums5aZePSdBI/YVBXVAVpp/DCY3NcmcSSO6wSaSjxiZHu1Daz8eem
 Ae28Dix3QPySYriGM5sFlw3vsB1ukdbQ+97obwlxMh+bYazS8JquYTrrOzhSbofndvue
 YbkacSfMowvx0fA3P2Rc92Lp19zlxGnyXEYKZhzq/QOuo2pr9x8A97ICottv/T74mg96
 myJg==
X-Gm-Message-State: AOAM533PeWTwRk8Bd1zAW4jVz4gIcBu94vj7m9fQyBeq6biZzUUkMcDs
 /Qa0xCSP/ycDg3WV5/AQbYqHzh5j9OKF2yHx9+IXBw==
X-Google-Smtp-Source: ABdhPJxo+1UpeySYok0MUbhqLMSOtSKBJjIYosZdSlVnPTKFxOZvCrty0z2VeQW4bjkY8EHAPDx4bql7+9hHcmqpFq8=
X-Received: by 2002:a17:906:3a97:: with SMTP id
 y23mr2497066ejd.250.1604064892894; 
 Fri, 30 Oct 2020 06:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201023210637.351238-1-hskinnemoen@google.com>
 <20201023210637.351238-5-hskinnemoen@google.com>
In-Reply-To: <20201023210637.351238-5-hskinnemoen@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 13:34:41 +0000
Message-ID: <CAFEAcA_w5j47qz+L02H10UbmyxwD4sxHPu8h2mAinME08Mjkqw@mail.gmail.com>
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
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

I've just seen some intermittent failures on the rng tests
in this patch:

PASS 1 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/enable_disable
PASS 2 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/rosel
**
ERROR:../../tests/qtest/npcm7xx_rng-test.c:190:test_continuous_monobit:
assertion failed (calc_monobit_p(buf, sizeof(buf)) > 0.01):
(0.00800994233 > 0.01)

(on OSX)

and (on x86-64 Linux):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/home/petmay01/li
naro/qemu-for-merges/tests/dbus-vmstate-daemon.sh
QTEST_QEMU_BINARY=./qemu-system-arm tests/qtest/npcm7xx_rng-test --tap
-k
PASS 1 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/enable_disable
PASS 2 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/rosel
PASS 3 qtest-arm/npcm7xx_rng-test /arm/npcm7xx_rng/continuous/monobit
**
ERROR:../../tests/qtest/npcm7xx_rng-test.c:211:test_continuous_runs:
assertion failed (calc_runs_p(buf.l, sizeof(buf) * BITS_PER_BYTE) >
0.01): (0.00198053202 > 0.01)


Are these just "we got a bit unlucky in the values we got from
the RNG" ?

If so, we probably need to disable these tests from the set
that we run in "make check" -- we can't really have "there's
a non-zero chance that the test fails" tests in our CI loop...

thanks
-- PMM

