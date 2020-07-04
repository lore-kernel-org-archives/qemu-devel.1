Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291EFC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CA3208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOSDEZn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CA3208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jreJS-0005qh-3q
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 05:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jreIt-0005RB-UP
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:17:48 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jreIs-0002d7-FR
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:17:47 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so35209136wrw.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:autocrypt:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zfb2gFgmH+RLTiqa1X08kpY9cxEY/KIG5YLXHv1/N1U=;
 b=BOSDEZn6kDCnFB9cCDrFcBW2ZTxIqINDN+EnwyTy9bHXYM8Y8/oCuG2IgVc2WrKjhn
 PDKuTVFZjq6SCdHuSD83Uu0HkTTG8YueA7R2JFDQ3/YTgfvVyNcv7XHURtmcsrSfWAtH
 P7kEvA9WJiCvXeFE7kUGdB0N5qLm/E8wEtAmn42kWwALrRafODQRQGmYHYD0l5ecxKec
 3FB8pehcG/j/K0RAepKc7dp8I6WXXumEHJ95rRd9RHciT8MRs2UxWexHc2hiQICABSq+
 biv2+mby16Ub21TYUjts/bbS2VXeh2O3C3XX9ElrFigEE8f2pArwhYAKWUaCkgWnrkLl
 lvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:autocrypt:cc
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=Zfb2gFgmH+RLTiqa1X08kpY9cxEY/KIG5YLXHv1/N1U=;
 b=WEhRCpDhyX3g6XiNV+tp5P2bD8e94wyFjQTNVhHU5fTsEXRHlxZIUMx7j/7h/fEoCR
 JjF9RwfOv0ZMFID2+am2tolNpUUdE8iO5xtXBpuNC1S15b4ev4E5yZFgE4ues222KSBn
 JDYI8yPi3eRYvvzJqVMGUm3QHh4gzYj/p9gx+ig5U1DWS91lCczRH1RloFaIdVoA1FmX
 qG15Toe/2AE4LWRLjd+JsIQnO0pz1FP07LzHs9zZZYBCcBehZnU0jbQmK1gBi0yMOu3+
 5BrZ23MQkI+220NowK09Z3z2d6rGSOWhAPeX6y7tu8wZczIwSSAoMIv1K2mw2Y4D5ybw
 ZpGQ==
X-Gm-Message-State: AOAM530MZXxAW5fMpAmwpYjMKkInSiDI5rNXvAP7P3P3gl3nWyC8t8Q8
 uJ1xACI01choVPw9fzC59fWTpGuheyk=
X-Google-Smtp-Source: ABdhPJwBkTbiraAB9oY28bdIm+dTfspnF0apKhZ51Vs2xGjCKlk+qG7Sy7uf7C1lx7d4xtwE0oRRTw==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr38410959wrt.136.1593854263430; 
 Sat, 04 Jul 2020 02:17:43 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v5sm16242694wre.87.2020.07.04.02.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 02:17:42 -0700 (PDT)
Subject: Re: [PULL 15/29] dwc-hsotg (dwc2) USB host controller register
 definitions
To: Paul Zimmerman <pauldzim@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20200605165007.12095-1-peter.maydell@linaro.org>
 <20200605165007.12095-16-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <7b202654-1ff8-53e0-521a-7142db0187dd@amsat.org>
Date: Sat, 4 Jul 2020 11:17:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200605165007.12095-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paul,

On 6/5/20 6:49 PM, Peter Maydell wrote:
> From: Paul Zimmerman <pauldzim@gmail.com>
> 
> Import the dwc-hsotg (dwc2) register definitions file from the
> Linux kernel. This is a copy of drivers/usb/dwc2/hw.h from the
> mainline Linux kernel, the only changes being to the header, and
> two instances of 'u32' changed to 'uint32_t' to allow it to
> compile. Checkpatch throws a boatload of errors due to the tab
> indentation, but I would rather import it as-is than reformat it.
> 
> Signed-off-by: Paul Zimmerman <pauldzim@gmail.com>
> Message-id: 20200520235349.21215-3-pauldzim@gmail.com
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/usb/dwc2-regs.h | 899 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 899 insertions(+)
>  create mode 100644 include/hw/usb/dwc2-regs.h

Can you add a section in MAINTAINERS to cover the dwc2 files you added?
Being listed as reviewer would help Gerd maintaining it, because that
way you'd get notifications if someone makes a change.

Something like:

-- >8 --
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1652,6 +1652,13 @@ M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
 F: hw/usb/dev-serial.c

+USB (DWC2)
+M: Gerd Hoffmann <kraxel@redhat.com>
+R: Paul Zimmerman <pauldzim@gmail.com>
+S: Maintained
+F: hw/usb/hcd-dwc2.*
+F: include/hw/usb/dwc2-regs.h
+
 VFIO
 M: Alex Williamson <alex.williamson@redhat.com>
 S: Supported
---

Thanks,

Phil.

