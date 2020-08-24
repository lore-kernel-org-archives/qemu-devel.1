Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D592C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A482078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPvTI3u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A482078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAEId-0002Jc-4T
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAEHd-0001j2-AL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:21:17 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:45580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAEHb-0003AH-NV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:21:17 -0400
Received: by mail-ed1-x541.google.com with SMTP id di22so8400250edb.12
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2DSY9LxI4LrHoalgSGkJ/BeHmNyn6l8uUx13JEKQeXo=;
 b=UPvTI3u7/i1W+EhMEA00UDVpQkAPFiSh3sIOnJFy4gsSF79iiSD+1HrE5iRiljjaN6
 NLZAbCqXSwF0+MxdNkw1fnkj07MrxicUzuLkzdJ9NFxtQnp9y+K6CLyaSctFm2NGCiK5
 Y+vqYak+rOLPJdvWSLcyt5jB1hkh10pPAij6y9Q/ypgfmdDmI9ZMMEMlwjoxhMCLmEmr
 5BTWB4qKSIjqqKVtXrlVXajt9Jgt62tmOjbQHLiysF7P19H1heEau+OL1W6/Azh1quWR
 7PwslStyFoOda6Hs2K0S4ZMJgET1LjInmIlctnubseBDvbtvOgGChJ4hsiKZhAlKbbfw
 nxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2DSY9LxI4LrHoalgSGkJ/BeHmNyn6l8uUx13JEKQeXo=;
 b=MLnnymCy5LwpMiAz+NBCdA4nM8WOJWHbmFDCMbcpbydYm3xRWNzTxw+dIcx0LWwwu+
 zeqp96bym0QZtUp0Vhpo64gzeF3G6FcYO1F8SCwRWXMFca0aZjYKkdBtfe0+wtOItiFb
 frP6FJskgIfUUkcEwicYE/IFT3Zj/TYccl9mv+I6n0vkaIbVWj55B44BMu9+XIY3wGfZ
 YbTGZqBTATo3LhjnHcaTAC/nt9j/NMsFv3HQX7XnEYqGvLpm4AewLpb7BahfWJJCx/x0
 GtSKUiBNzwmqB6OtS92HxJ/oAbyu9ojxaXQ9k0uykR6R/H5Z2mS5tf4k6NwF4fgPbcR2
 Stug==
X-Gm-Message-State: AOAM5312HofyTEFpqYrE51x5cOVw4/J6Rkg395rfbdz6XrATxraB5ckZ
 0q0mN02i2r98LnsSzbCeo7xrdIvae7ktLB3GhUJdaA==
X-Google-Smtp-Source: ABdhPJylIFDsLu4ieTiJhXv14F8TUmbHB3stDboVmDiB+uKkOzfk65tdDXbIhlhUrqC/GT3rf6NEj121tUWkRXpJUuQ=
X-Received: by 2002:a50:da44:: with SMTP id a4mr6048556edk.36.1598282471979;
 Mon, 24 Aug 2020 08:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200812111223.7787-1-f4bug@amsat.org>
In-Reply-To: <20200812111223.7787-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:21:00 +0100
Message-ID: <CAFEAcA-mgTYGEaHPHe1Dx3aUcvXgNNuSFoSURyJzCijenxS_vw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Clarify HCR_EL2 ARMCPRegInfo type
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 12:12, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> In commit ce4afed839 ("target/arm: Implement AArch32 HCR and HCR2")
> the HCR_EL2 register has been changed from type NO_RAW (no underlying
> state and does not support raw access for state saving/loading) to
> type CONST (TCG can assume the value to be constant), removing the
> read/write accessors.
> We forgot to remove the previous type ARM_CP_NO_RAW. This is not
> really a problem since the field is overwritten. However it makes
> code review confuse, so remove it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

