Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F3AC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E24021775
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCpKtmrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E24021775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTTH-0005lm-0T
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTRR-0004Mc-OR
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:46:34 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:42870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTRP-0007hF-Qd
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:46:33 -0400
Received: by mail-ej1-x642.google.com with SMTP id h24so7403799ejg.9
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=W93pR4c85urxJqc43xX67bIFtgRTfAcBdk2OKlxXVxo=;
 b=zCpKtmrGMZZPbJpJN1BZk5o3L6fMcuclqaOkFMs8PNPo21tUwFToen+jZwUKPD1obA
 o2ipJDW14hoZJxg+QV7gVXcdLV6Q+nBR7J7F6MtdUcluyIzD3Xrxo+NqXNNR9drAx9lM
 4pUnHhBgjXNZaduqcDc1rUgcchNd7pUY1BRFkytntrSYL0PzpoxZIXWk/cjjuLZy0PxY
 vthQAg5hrLvRMWorcPhcdDsXXuarsmDsAuzqGG28iSXA/ANRi/xr4KL0WIJobi60LHbZ
 2l0SnQI5IOR7w/VNOg/o14t6TkuUCWMdbwntxsSe1ZOt+4Bqx+KwO5bfUoOeVHBb1EPq
 NPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=W93pR4c85urxJqc43xX67bIFtgRTfAcBdk2OKlxXVxo=;
 b=t8STv2atkL7JlSHN2tIOkAdgVeSFcrxYtm03P8ABS7uLVWRX1Vd/qjQsPeQ/bghevI
 74Z46F6RbtGt3JGdcu7YE40aqOO12fS5mlpgrGjCFLpVe4gQKWZ25+et2e3npJelU7G+
 KxYDYo6XJX6e514JThqzqZm5wyMCjneglXOV8W50ausIPyGwDgCevOYy0Q6AXleUWc44
 9A1sXOfzhJCxVvIholcTw9JmqG3guNE4erNIC/36DW5R/DGTC0wwv4b+vOCs0QPlXg40
 k9ohKbgzoCE8ktKhF/9mcTTg8UlGPwUY25ZkwaLQPTNdO/xsHbiDPHDwucmuCoHy8faE
 e5UQ==
X-Gm-Message-State: AOAM532Al1n93UVR7MyNBRFDK8OMD2dR066l8qr4Rd9zcWMe0NlODLrp
 piQd9UrHbvM/SG4pGwXcchFD1PGBalCba/ZMZzmD9g==
X-Google-Smtp-Source: ABdhPJxDT+DVazu705V399eq9nXWzqSModRVAUf7ouFdyzQoXRh576ZZHRIFcYG2osJXBMOkwqNoSWvng/U+kyJ3rGY=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr7944728ejk.407.1602153990555; 
 Thu, 08 Oct 2020 03:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201002080935.1660005-1-f4bug@amsat.org>
In-Reply-To: <20201002080935.1660005-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 11:46:19 +0100
Message-ID: <CAFEAcA8uGrkJg35xiDmZBnqbTDLmA_DfeBypZLkjWTx2dANphA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/fsl-imx25: Fix a typo
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 09:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/fsl-imx25.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
> index 971f35dd16..c1603b2ac2 100644
> --- a/include/hw/arm/fsl-imx25.h
> +++ b/include/hw/arm/fsl-imx25.h
> @@ -179,7 +179,7 @@ struct FslIMX25State {
>   * 0xBB00_0000 0xBB00_0FFF 4 Kbytes     NAND flash main area buffer
>   * 0xBB00_1000 0xBB00_11FF 512 B        NAND flash spare area buffer
>   * 0xBB00_1200 0xBB00_1DFF 3 Kbytes     Reserved
> - * 0xBB00_1E00 0xBB00_1FFF 512 B        NAND flash control regisers
> + * 0xBB00_1E00 0xBB00_1FFF 512 B        NAND flash control registers
>   * 0xBB01_2000 0xBFFF_FFFF 96 Mbytes (minus 8 Kbytes) Reserved
>   * 0xC000_0000 0xFFFF_FFFF 1024 Mbytes  Reserved
>   */



Applied to target-arm.next, thanks.

-- PMM

