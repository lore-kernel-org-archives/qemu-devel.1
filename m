Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C16C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 845B3206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T5SMAR+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 845B3206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZBhC-0005AS-OF
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZBg7-00047t-67
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:05:27 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:33298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZBg5-0001ZH-S2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:05:26 -0400
Received: by mail-ot1-x32f.google.com with SMTP id v17so2030887ote.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HbeeO/BTGyvvjWbZiSyGfUxAZ3Hjc8dAPRDWFG1ndi0=;
 b=T5SMAR+Xk0B/raCyvqQdLfTuhN/gdBYcLsytGVePaj55xweWnW8Z1vMu5cr1791Jj0
 er8BkFsJHZ+BDpWa5oY7lL0m+GR0liTFc/K3IS965ogP+35FqPwv6RXzyzZh9AfHJx5M
 QzcmL2CCj8jzlUc7P4WGQrm2XdEiAgY60lEd61uX+429ahH30OWz3fGeyqF8TVORiiLe
 96Dg2u7MgeDBlQzqIPTxeRFDPm2d5PEoSf1/iZ3ThXiGKjTnuQRswmqSJXyl2SlrJ2ON
 gEWCjBKtcMBX2HPW+FxDJmrpXt+e+ZMv80mTaTreMrNms0BfUzcquuRmIwX+nW0u/VlW
 NNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HbeeO/BTGyvvjWbZiSyGfUxAZ3Hjc8dAPRDWFG1ndi0=;
 b=JZmrBq9D6/TN3Uz17HNTrOfokevstRkrtjTRw8PbzYWWhEIdX/5681RJMak812I72R
 Slj6uv1a6+ixq5DeICxcu/Pmj1nsREbd4LwtazVU4+UrZCKIdrI23vp9L33b1HE74aS0
 RiXIhucw6OwUu/wHXu9DY8RzAG5r8urW4ft9YEZNWUkW+2fnQg6LPDiqfGZ/n3rmfWNF
 YZ7IXDu+svwnULffTlrP35FhrFJTa94qZYu2Ljb9b/wtrq22XunJFG3x49+LWDpfFoqV
 2J45tmVRa8J6D2U8uHaWacxQd63vaR6TbXw7CEOFXovklp9T8i/Rf/fkYEu4AuchFAjv
 J8Cg==
X-Gm-Message-State: AOAM531KDXqX8nHBx0p/JvG9SHDCWH2XyugtqmIai7RuK8iSG7l5w6Xm
 hAXZ3f7Ld7lVAMY8PG1ZL9jL9N8kxdGbKdf3KOjHCQ==
X-Google-Smtp-Source: ABdhPJzDZ1xdMNBlb3/RZbUFR2M1DAdNQ9sa6PYKXLZWTJs4miDg2gJeKo5HE2Uem4nRYTiwvN9OalBa+2wBx8N4PYg=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr857222oth.221.1589454324467;
 Thu, 14 May 2020 04:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200506173035.2154053-1-patrick@stwcx.xyz>
 <20200506183219.2166987-1-patrick@stwcx.xyz>
In-Reply-To: <20200506183219.2166987-1-patrick@stwcx.xyz>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 May 2020 12:05:13 +0100
Message-ID: <CAFEAcA87XxQTdAHLRzF7cuuqbbWVN=+UOGO7jOVrWv0S=g12Gw@mail.gmail.com>
Subject: Re: [PATCH v3] aspeed: Add support for the sonorapass-bmc board
To: Patrick Williams <patrick@stwcx.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Amithash Prasad <amithash@fb.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Vijay Khemka <vijaykhemka@fb.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 6 May 2020 at 19:32, Patrick Williams <patrick@stwcx.xyz> wrote:
>
> Sonora Pass is a 2 socket x86 motherboard designed by Facebook
> and supported by OpenBMC.  Strapping configuration was obtained
> from hardware and i2c configuration is based on dts found at:
>
> https://github.com/facebook/openbmc-linux/blob/1633c87b8ba7c162095787c988=
979b748ba65dc8/arch/arm/boot/dts/aspeed-bmc-facebook-sonorapass.dts
>
> Booted a test image of http://github.com/facebook/openbmc to login
> prompt.
>
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> Reviewed-by: Amithash Prasad <amithash@fb.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>



Applied to target-arm.next, thanks.

-- PMM

