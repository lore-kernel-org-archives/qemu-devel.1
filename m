Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FC1C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B5D2073E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 18:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKetyWwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B5D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k07nq-00023u-RS
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 14:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k07n3-0001Ss-Ef
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:23:57 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k07n0-0002QW-8p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 14:23:57 -0400
Received: by mail-oi1-x243.google.com with SMTP id s144so5222047oie.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ISGC9/eZOktdkhNGYcXuKAL592CTulxLxrQTaJooBts=;
 b=QKetyWwElItI/GQg7aAqA0XHxieunvsJAp+ER7pM/dAxhI4XSHPde72afKsu8CQ106
 G/nro3g/DB65Op8tdGMo40zKdNP+Y1qeL3OdeKUUlZQsHmo/W/xcMYpoGa5O2J4YH2rY
 p5OwQRkCHIzZYINWkwIBcLvLgJ3PcrrImrYOdpiP0WjIPRQhb1rPkPi1YbsRPDC8z+/V
 4DHTBAg2TuTo3IHZWdBl0cr/VDU1ILUGYBjo86r2t74sgLx5afCcT0QkrUV9EQNgGvE9
 PUZeoURSvo239gd1AbdEXfnzQ5O24D0q5d9A5mAXItTK/oOK8EEGj0rxgu0yChwNhptU
 7VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ISGC9/eZOktdkhNGYcXuKAL592CTulxLxrQTaJooBts=;
 b=Pq/KbgerxFwv1v7PXK3GXJ398Go58CUcDdAX5EccqEpElHAMSth64ct9t0HxhVJrqz
 vdCf5UcIjdMK/xy1n4/rdMiLfL8ybntZ7INqYRQYPWdBT7AfK852wK3IQvQJDULQOwNK
 Xh1clwpPqueTFKtqnDk15tJQC1GPsNXCLHjCw27WHk3b1JHryUSoHA44i414qI2QFGF4
 BCyn22blS5qRUz+w3unq0QFCBG2fXzaA3WtYtLtx4xtNyn+ByfVirPaop9fiYKq23ndc
 vNhS44hV4FUWFVUzygCYukVryMFYjOqtxBODlT/P7FiNpKQ7MFWR36+YTdamJeOq84XS
 cZSw==
X-Gm-Message-State: AOAM530qNndiXxj1Cjj7EtngEv5SufuQghO4nOXyPHmI9UDkOYqQOLvw
 qOhsZovdhyQ+CngMPdefe+Nq4tcVVcgBvMJgdBX9FQ==
X-Google-Smtp-Source: ABdhPJxwbuoeKLYWpq07Rli1/BSd4A+PvTrXUhl4m6cglzQKx52RaM7Vi0VQzhW9D4I1PbiTiA/y/RPOSh9N8kRfFuk=
X-Received: by 2002:aca:2819:: with SMTP id 25mr485548oix.48.1595874232957;
 Mon, 27 Jul 2020 11:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200727162617.26227-1-peter.maydell@linaro.org>
 <e549c6d3-9fbb-ec47-f6c3-c84e4c625647@amsat.org>
 <4743e83e-d893-c719-5fe0-ce105c0650f8@amsat.org>
In-Reply-To: <4743e83e-d893-c719-5fe0-ce105c0650f8@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 19:23:41 +0100
Message-ID: <CAFEAcA_g2NwSAHiCbAOpNmQ0PLAyw1=n=0ogYZ8pQxqgqfin7Q@mail.gmail.com>
Subject: Re: [PATCH for-5.1] hw/arm/netduino2,
 netduinoplus2: Set system_clock_scale
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 19:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> $ qemu-system-arm -M microbit
> qemu-system-arm: can not use systick with 'system_clock_scale =3D 0'

Yes, that's the other one on my list to do next (need to find
out what frequency it runs at though).

Good idea to have an automatic check for system_clock_scale
being set, but failure to do that is a bug in the board
code, so we might as well assert() it.

-- PMM

