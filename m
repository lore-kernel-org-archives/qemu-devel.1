Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2FDC04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB7E321775
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFsSJIXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB7E321775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTTH-0005nX-UF
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTQt-0003ng-Sy
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:45:59 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:34828)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTQs-0007cd-Ae
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:45:59 -0400
Received: by mail-ej1-x642.google.com with SMTP id u21so7432054eja.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BYOGOL7O3px4ZkEMIR838II1qZBk9jZVy+ztlVyqirs=;
 b=yFsSJIXgxSXoIPHtWmIpgguNrU+6OBjQJI5LIak2fC7B4gOhG4640NYG2Cmeysk9Ql
 0v62GlOgc5NcXJPhM/bXlPKeVTrE0LlzX+aVTm2O2lE/KCJSv98axfpb1l8gVKlauGBE
 vZLoZDAJk3uZ2gxOlADqlEXUpeNdLhIwbfjFjvr8FhOZf1Ue+CSD+TRT6nL+QT1RlYCj
 uFrrKc7x6jWLa00CAdPbwztAEQdwMfBsbZgGE6mJnnF0KDNPfDc0VmN5EEp9d2HVATna
 AsOsCLSKR8ZN03p8sVuk05S5ZBRSPz9lNM7KUa33ksjY108n49Ri4G3oqO2Mzw1nnHSI
 2piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BYOGOL7O3px4ZkEMIR838II1qZBk9jZVy+ztlVyqirs=;
 b=JQpxk/hf+V1OH3zei+jXWjZs8FIzZ5mi/GD+7UmkI0DEAOB8aBqvoi8uSHwBr0hEtO
 DMn+RKRqGHr3EWOpqIrD/TrTMDg7h3JK2WOT3J8BaPk6H+rh46pLapvHII1VU8WGblqq
 77Fcj1hCHR8ppkzV8ZaFneR+Ww1vhxN/Sl4nqBlUbpZ/NfdGTffXW454WJjnuwRtpblZ
 sNGecpoL5QPOird8jDFb7fvs37kK47qOJj1FOI/9Ro37i3hWNsTakBxcalyXngi/DQcd
 JJV6O/nk9VLaINePRJN++F+XcsT6mSlqFVwS/x7GEIva/1QkjmQOQ5A41YxZn5WvBdh8
 WIBA==
X-Gm-Message-State: AOAM5313DdI5XaNUImQhJFvVOpKEsnPB0vIaD8g+m05QRby/JVG7+fTX
 nEWDwG0ohLO/5eys5Uflhnmmm3H8A4x0rpO8s75tcA==
X-Google-Smtp-Source: ABdhPJwrS9QXDJ4ACSko3Rusxx/eosQEw1MiggCio6RErAlF9Q2mt8FwgM9ozeoynSDCnTOjaZfzZ35+kdGeDTazC1k=
X-Received: by 2002:a17:906:ce21:: with SMTP id
 sd1mr8276487ejb.4.1602153956716; 
 Thu, 08 Oct 2020 03:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200919132435.310527-1-f4bug@amsat.org>
 <e35e3c67-2f45-c1e2-b8ea-6f3512829fe4@amsat.org>
In-Reply-To: <e35e3c67-2f45-c1e2-b8ea-6f3512829fe4@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 11:45:45 +0100
Message-ID: <CAFEAcA-Qb4znbRtHBWvp2pUJwJdhfzRywYsOPdEgsqdf=YxSgA@mail.gmail.com>
Subject: Re: [PATCH] hw/ssi/npcm7xx_fiu: Fix handling of unsigned integer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Tyrone Ting <kfting@nuvoton.com>, Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 at 08:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi Peter,
>
> Can you take this patch via your qemu-arm tree?

Sure.

Applied to target-arm.next, thanks.

-- PMM

