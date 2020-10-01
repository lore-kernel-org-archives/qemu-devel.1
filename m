Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39248C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51DC20754
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 13:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DSO8DQrU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51DC20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNyZR-0006SX-Sq
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 09:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNyYX-0005Gu-0O
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:23:33 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:35826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNyYS-00083n-Le
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 09:23:32 -0400
Received: by mail-ed1-x544.google.com with SMTP id i1so5633073edv.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 06:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zHI7qboARHi2tlyI9AxH6Bx8et5hE//AielLo6Qqjm4=;
 b=DSO8DQrUKUw6pgx+IPySfNOV1U6OT5rS+NMWrdIteLpEYdhlQ1UpWadouU6ElPEhLg
 HG+9MMbv9juU7SXFfLphijUsccAeH5nrRSm/a0oqNzJiZSGZ6Wbcd+5N/Asc5GhDOc9K
 1c2t3LQbLqdY22vahUAkuRyn2twU70W0UojAYTl74y9lnKoTEB3a3RabY1x8l7UU0hAO
 vbnxxtF8ct2qXqirEg12KznxRHRjkdq0E2nOYZ+KYEuZOpoSMzKKNHxjWs0x23mpKajC
 NqosmLURAJicwQBiHSoYVQxphOjYyejZgepyjjjrrsmEBx1CTK8dAUoHHXatQTFSS946
 s4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zHI7qboARHi2tlyI9AxH6Bx8et5hE//AielLo6Qqjm4=;
 b=V+E8y0cFeSqju9Zo9VtHgMbO+428g45jmigepWQFaLDFeoh8+nAJ/iA25R+ODxsRrY
 PBDEp/MjqSMVaWsIgONa2jgFYUHcQIzDCk9dmutfvyKhGeaBA6w2E30Cj5PMG9elHzY6
 G01lZWWHptkkedV0KZNKSlcXCa+kkygVkfdmAO8sBx9cY5Jokix9vvW9M0l3pO3jWFmN
 xFSzLpK6qhf23q5sm1BvKomVtpEupp8QD7HkLzj7lxVztXBW1D8QJJ7aWwUR2Bi55zFM
 GoHnRp0ZhnOc80Et6mpXBwxnkorgIHY233mYyjSc3vjP2A6O9bKOHOM+1JIml6WRxFch
 MP7w==
X-Gm-Message-State: AOAM530VDk+mM6+mj4Wpt1buV9/aEaUE/RpsL5/xOiuipvPSuU6jDBuU
 gSTCWr1aiFI98quAo3QwVrxYJvr8zVCGVhxqdHQdRA==
X-Google-Smtp-Source: ABdhPJwiA7H5tabiPyPIgZ4HParTHnTdt1s4QCk77drszlavvBYTH2dUWn5Vu17Qsy1pkfTwykezSnyN4uSSpx+VIvk=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr7952006edw.251.1601558607227; 
 Thu, 01 Oct 2020 06:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200921034729.432931-1-f4bug@amsat.org>
In-Reply-To: <20200921034729.432931-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2020 14:23:16 +0100
Message-ID: <CAFEAcA8HjeRE_ZfHzfZR0rM8m2e1kqPwtbKtb9ukkMTuN6vR_Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/raspi: Remove
 ignore_memory_transaction_failures on the raspi2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Luc Michel <luc.michel@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Sep 2020 at 04:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Patch 1 and 3 are review, patch 2 is new and trivial.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/arm/raspi: Define various blocks base addresses
>   hw/arm/bcm2835: Add more unimplemented peripherals
>   hw/arm/raspi: Remove ignore_memory_transaction_failures on the raspi2
>



Applied to target-arm.next, thanks.

-- PMM

