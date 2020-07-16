Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC3FC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E497820787
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 20:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QkaSLAar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E497820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwAm7-0006O0-6V
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 16:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAlQ-0005xL-5N
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:45:56 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:35512)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jwAlO-0006lo-7Z
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 16:45:55 -0400
Received: by mail-oi1-x22f.google.com with SMTP id k4so6216861oik.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=sw/VvXClaFYYO8XzzFjkPL5mDoi/5dWNns559Bxki8I=;
 b=QkaSLAarU0AdNhX73p2owpjo40gDKcQDWAHKf2/NfZ+VfQEsytD+jDprHdxdinXWET
 fAhihcM5kZjcz8DX74hFCSehNYM5ZDJD8G2JaCS9eyPrwuktXhR6ae7cZqChY7pwGV1F
 o/TakudlsXuUiZOvIfeC0djHIQYZxsc0JrRmplkIw1RGNfutG3SSlBK4DPWInMPnLYtD
 IbNFdRzKuiXwrIWAqdEbLjdrDMocGzyXgRbVBr4Y7K9YduxXGXFdlP3VoJJJjY5V5CsX
 /I3VNQXe8WFQPVHSc5Ir0tx4DBOiYRQIk4VfBhrSni7ympOdch6xegye6idORIfS2r+7
 IoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=sw/VvXClaFYYO8XzzFjkPL5mDoi/5dWNns559Bxki8I=;
 b=A9QkNpgGiFoN1huS7E+rboJRpObQU702SgHTu7mMc8DPNjOW7tp38xQFGcKoJs00M+
 TEijReJeMD7wDrwVCTfOyYJHzLYn8ATcd4o1jybkXP3CRNQP9j4ei95fdr9n39HpRKml
 mGesTENg3IYEs/MsHV+iLYh+uelAYY5HAKQlIxOLkgk5T7BLhke7HEoFrovZ0xOaNwo8
 8HPfY7lbrH7Q0oY+RJkcljLh/5ArxTsm2xfyeD7OHzZdeu68Igod8kB1wTj+1w4keZQ4
 A7Fme07TjfLfiDtBW1oC8L9WfuqE1spBnc+b+N1w+j+TsixR1Kl2XGG5Jyma2ZWR3zWW
 wHOw==
X-Gm-Message-State: AOAM5300xxvG2qRINJtlEweWA7KNS3e2+iq63qKdx32CPZtSLt/Yd6/M
 gZPelD8zC49fjKrFwGal3cUmAS6XsZ+FTChh6n5ljA==
X-Google-Smtp-Source: ABdhPJwgjvKhpEjNKSQXucaqmfhzzgyaAkxJI6fDw+/s+KJPNsD2wbxr061JhufevtQNR37+3FkfKbYe0KWIr5XsvaU=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4921959oix.48.1594932352698;
 Thu, 16 Jul 2020 13:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200716174900.GL3235@minyard.net>
In-Reply-To: <20200716174900.GL3235@minyard.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 21:45:41 +0100
Message-ID: <CAFEAcA-UWJBpM_-G2RAe9B-WcPzBaKGZTas1njehQ7gcjsMpew@mail.gmail.com>
Subject: Re: [GIT PULL] I2C updates
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 16 Jul 2020 at 18:49, Corey Minyard <minyard@acm.org> wrote:
>
> The following changes since commit 45db94cc90c286a9965a285ba19450f448760a=
09:
>
>   Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-20200=
707' into staging (2020-07-10 16:43:40 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cminyard/qemu.git tags/for-qemu-i2c-5
>
> for you to fetch changes up to 73d5f22ecbb76dfc785876779d47787084ff0f42:
>
>   hw/i2c: Document the I2C qdev helpers (2020-07-16 12:30:54 -0500)
>
> ----------------------------------------------------------------
> Minor changes to:
>
> Add an SMBus config entry
>
> Cleanup/simplify/document some I2C interfaces
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (6):
>       hw/i2c/Kconfig: Add an entry for the SMBus
>       hw/i2c/aspeed_i2c: Simplify aspeed_i2c_get_bus()
>       hw/i2c: Rename i2c_try_create_slave() as i2c_slave_new()
>       hw/i2c: Rename i2c_realize_and_unref() as i2c_slave_realize_and_unr=
ef()
>       hw/i2c: Rename i2c_create_slave() as i2c_slave_create_simple()
>       hw/i2c: Document the I2C qdev helpers

Hi; this failed to build on x86-64 Linux (incremental build):

  LINK    i386-softmmu/qemu-system-i386
../hw/i2c/smbus_eeprom.o: In function `smbus_eeprom_vmstate_needed':
/home/petmay01/linaro/qemu-for-merges/hw/i2c/smbus_eeprom.c:94:
undefined reference to `smbus_vmstate_needed'
../hw/i2c/smbus_eeprom.o:(.data.rel+0x50): undefined reference to
`vmstate_smbus_device'
../hw/i2c/pm_smbus.o: In function `smb_transaction':
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:93: undefined
reference to `smbus_quick_command'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:97: undefined
reference to `smbus_receive_byte'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:100: undefined
reference to `smbus_send_byte'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:105: undefined
reference to `smbus_read_byte'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:108: undefined
reference to `smbus_write_byte'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:114: undefined
reference to `smbus_read_word'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:117: undefined
reference to `smbus_write_word'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:149: undefined
reference to `smbus_read_block'
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:174: undefined
reference to `smbus_write_block'
../hw/i2c/pm_smbus.o: In function `smb_ioport_writeb':
/home/petmay01/linaro/qemu-for-merges/hw/i2c/pm_smbus.c:290: undefined
reference to `smbus_write_block'
../hw/ipmi/smbus_ipmi.o:(.data.rel+0x50): undefined reference to
`vmstate_smbus_device'
collect2: error: ld returned 1 exit status

(similarly for other qemu-system-* binary links)

thanks
-- PMM

