Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB76C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B8422269
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czT65d5W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B8422269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXIG-00010x-Nf
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXGS-0007ib-1g; Mon, 19 Oct 2020 11:40:00 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXGQ-0006Fz-Dd; Mon, 19 Oct 2020 11:39:59 -0400
Received: by mail-wr1-x441.google.com with SMTP id e17so190983wru.12;
 Mon, 19 Oct 2020 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zdyr844xvL+wDLFT7d+Qen1OAAOtQswtTVaQZshu3pQ=;
 b=czT65d5WMkxapxkfaGBCAHjXMuhXtCOIXAiH1PERO9TFTvhhfcdzUvbDgn+vc0j2II
 UECpxm6GT9V4hRYraJc6zKNQfXARq7oqQyJW1u9rKHxNaFgvOjy41iONG3zLJOxhkSFm
 7kBICRL+xRYE9HYJZ5rLjHrUiGHNryMEdY0upHckgT24CgSU/D8XjfpojsGI9yAwYdxi
 HOionN1cMI0Gg4+/oPnndAG2qRYUjkvGvFzDDsXwq+es+jfHNt37c5HmUv4JN6EJ6/1a
 87pANw0JuIqrA9cpOfZ2YUzjORlYMawvnEA1wZcJtgMVBBhUKD9NOVSsaSVtD1eJztcE
 2lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zdyr844xvL+wDLFT7d+Qen1OAAOtQswtTVaQZshu3pQ=;
 b=SHqVL6axXuB0eremjYn6yHUQg3OUi7RnaA4TMXr9tLPEINVfF2omhceHWpFTzdblCJ
 4a+nXUsweR1epwAPEqCFhUpn5vs5imATUTafrDXr9XpcnRLTVGIRA3uAfCwhUCGrQs22
 fVTj6CvPFPYKaqqAbQgfJLMLr1C65iAUagPuQW0wpP4ZiZO8c8aEKRvoGfwWL3mE35S5
 JIHStIz4iBQganZtrPM6tyh5apGETWiWdom89+RzaLcGq/1z8ZumKQK7xum/ehi9e3y1
 4QZfI986OO+2pB+nllobFZGNE/cHbwFE9Pmdx2k6johlM137/yhEXkxBeBW6uk+ye4rj
 hacA==
X-Gm-Message-State: AOAM530NFnlWzsdntHtoQjiM5RDhZFvhcwOOHRBP3l1/XWN4w3aHDzpe
 0OhQ2cbmTtmCLeN4BPRqUBU=
X-Google-Smtp-Source: ABdhPJwqR9mwgmsC4+7e+fTs9eUpUbrES05z+nb4Dxxuo6xuNM0y/LoFktE6/oaKm9x0ngpZY7z49w==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr193171wrw.18.1603121996515;
 Mon, 19 Oct 2020 08:39:56 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x65sm533422wmg.1.2020.10.19.08.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 08:39:55 -0700 (PDT)
Subject: Re: [PATCH v2 13/15] hw/misc/bcm2835_cprman: add sane reset values to
 the registers
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-14-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <63f92fe1-e786-4b24-64a2-18c5a3d78e47@amsat.org>
Date: Mon, 19 Oct 2020 17:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201005195612.1999165-14-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 9:56 PM, Luc Michel wrote:
> Those reset values have been extracted from a Raspberry Pi 3 model B
> v1.2, using the 2020-08-20 version of raspios. The dump was done using
> the debugfs interface of the CPRMAN driver in Linux (under
> '/sys/kernel/debug/clk'). Each exposed clock tree stage (PLLs, channels
> and muxes) can be observed by reading the 'regdump' file (e.g.
> 'plla/regdump').
> 
> Those values are set by the Raspberry Pi firmware at boot time (Linux
> expects them to be set when it boots up).
> 
> Some stages are not exposed by the Linux driver (e.g. the PLL B). For
> those, the reset values are unknown and left to 0 which implies a
> disabled output.
> 
> Once booted in QEMU, the final clock tree is very similar to the one
> visible on real hardware. The differences come from some unimplemented
> devices for which the driver simply disable the corresponding clock.
> 
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>   include/hw/misc/bcm2835_cprman_internals.h | 269 +++++++++++++++++++++
>   hw/misc/bcm2835_cprman.c                   |  31 +++
>   2 files changed, 300 insertions(+)

I haven't verified the dumped values with real hardware,
but for the rest this patch shouldn't introduce regression,
and it helps to boot up to Linux kernel 5.7, so:

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

