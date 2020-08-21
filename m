Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007CAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9D720702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 00:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyxXE2Bc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9D720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8vLO-0004no-3A
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 20:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k8vKb-0004It-Dv; Thu, 20 Aug 2020 20:54:57 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40645)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k8vKZ-00061f-Bh; Thu, 20 Aug 2020 20:54:57 -0400
Received: by mail-yb1-xb41.google.com with SMTP id q3so160223ybp.7;
 Thu, 20 Aug 2020 17:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vJOtVSgLoQutxKLPgkqm2IVLNnuXBR9Av55x7zvQEPM=;
 b=AyxXE2BcaeGF/bAful6u4uNJqculvaLB8fM++csPZtSlGJG6he8arSd98OYCI5MlDe
 A2NWOGY+9SNiqSqDzyRdwvV2+XxsFBncSMEQ8iAWFDIQwnG3aDdSPQ0cn8OqLFH5vPC8
 aV8xg3tXI3XhFOmgK7pQaO5d4p/wBKhvJODbcGCBvBToJJtsZjkZ/386z7iiV2ZYj8pQ
 wshbVssvMrRBKdbjDLlxepw0iJ1IyEWwiaEKq2bwtgOVrWHjL+RYQJzMzxKZMw5p3L6H
 jtKF8VAzYRz/rkCoXnOfXR7GAHoTehzPZz80ilwozxu2dl+s8nC7TFKenlICLyQ/BH0O
 2fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vJOtVSgLoQutxKLPgkqm2IVLNnuXBR9Av55x7zvQEPM=;
 b=t2THSIgqV+ei/RXdHyugEuyE/97y6QL8asBmLJVthOGSpeEjXTS7ahDzED48WDQQOX
 TZ5VSaazLXsbYNMYu+N+2OX8fskjURZV660/VIOTCTslqxjyCrP6BofCeYpvt6hdxHZP
 hVMcX/vxCnPrNzKMn0hyAJKTMgyt3DWu7iBxwFm4bMk3bytX5czdkxJK+XsF4Waoj0F4
 enhugPnjOTF6DXuZGjP2FBAuPZ6ZN/d7MapgEf3h20OHWFYpo9FCEWzctcmol2BWMcSm
 PWIEBaMji2/+vBSII+Z2rj2gLmlVlqu+VPUpvLDgOxbUACYECCbp9dcdGfIwkMqrR3/N
 n4Vw==
X-Gm-Message-State: AOAM533sD/WdQgNk/ziL9hjDUyRbfIICaNKdJ7oWMsD/1/YsI9PE0q8r
 u/my17XHZYrmYqCdmCUoGJwf4XAkumx+bjbCMEs=
X-Google-Smtp-Source: ABdhPJwbdDKpmt9y2MuXxO/SNlRh6DNA9/g2cxafZUApleKBueWmTH32WoYfsHYfVxO/dyOS6YURssy50MpfrstSTPE=
X-Received: by 2002:a25:f20d:: with SMTP id i13mr570776ybe.152.1597971293123; 
 Thu, 20 Aug 2020 17:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <1597658633-12802-1-git-send-email-bin.meng@windriver.com>
 <d57faf7d-3cfa-55ac-649b-59ca06dd11a8@amsat.org>
In-Reply-To: <d57faf7d-3cfa-55ac-649b-59ca06dd11a8@amsat.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 21 Aug 2020 08:54:42 +0800
Message-ID: <CAEUhbmW02-fc=+ccWSn5bXGN+d7cCZNg1m2Z7wx3smN_YubWiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/sd: Add Cadence SDHCI emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On Fri, Aug 21, 2020 at 2:04 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> Hi Sai Pavan, you said you were interested to test the first 2
> patches. FYI I plan to queue them and send the pull request tomorrow
> or Saturday the latest.

Have you got a chance to review the v2 of 3rd patch?

"hw/sd: Add Cadence SDHCI emulation"

Regards,
Bin

