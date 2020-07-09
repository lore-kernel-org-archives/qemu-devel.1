Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9E7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746D3207DA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 19:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5/fEET4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746D3207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbqj-0003g1-ND
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 15:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbpx-00036h-To
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:04:01 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:35991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbpw-0003qr-BH
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 15:04:01 -0400
Received: by mail-oo1-xc44.google.com with SMTP id z127so545591ooa.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 12:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4KilTC9iLGIGPk+lqxRO0Srirg34En2SnOqSV4mFp28=;
 b=x5/fEET41wS3OHXK/fV0y+sKgHliKCwF3ZBpLXOG2hnhi+Hl7LVkyPghFqC1tHE2y3
 b4lcaYNjxk9WfS1cCAVUzDj2stJJfOR1Gb9dOO6BMLw8NsFe+rdNcXNDNTQQe216cCRL
 7RaTEx/LRC0DXClRtcGrOwcMD49C3aABaBDLjoSd1iWQGKuVhlTyAoONlfM5nciTESxY
 ilsS6F84Autw/lr0+r5GbA5mIDD4nAISqt0IL24MTaLfEmCyFj/etgDzjovAELipwN+G
 PWdj3yOXFDAtKwN1U+bZxHg0Cus9jQqhFIVgukXcp7QQnoH66Ycf3U5eA23x2nNVA+EY
 KBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4KilTC9iLGIGPk+lqxRO0Srirg34En2SnOqSV4mFp28=;
 b=B6JQymMQd4V0G20cwlQVwZWysmFQvaCmW1sJl5hjQVa0Hee3ud72dVeQUZevhJaNXr
 XskvHqdss4vIGsnXWpqQrX2YN2P3kiYsZOcJGJHxJJ/S21Kl7i3zkaMCaxn6rN/RF/07
 ENsvRouSj+iCUwVmWGqTglVbnmtaeICrOzHNyHE/r61uMEg6PpayB0Hd3STeXSwQEZgy
 1O3fnoT682AkHlf9RSq1kodi33whZqOAakxt+liFRqQ9gFHytrmZvjW89k1kk8kvAW1j
 tjKDz/rsFIUmUVMmq35sz18PBDvhIXn7zUkLUavGxX+zeNKsgKNCrDln/YDhIeHPsosW
 b0cA==
X-Gm-Message-State: AOAM531SaRAr/sliJVW6UpuSGZIAEDHUihlmpznncEgmNHhNMngCbsoY
 5dl7yCM6o7Uf/Z/y0fZpKMqnmEMeI0sS6nB1h0MI5g==
X-Google-Smtp-Source: ABdhPJyVBDoy9dXO79EW71ygaSiDSjiKqo0E9TGgOPOCiFVfVlHPs9X0O4FoyyLTTkAPBfnO04FMZggm9WlQu5KKt1Y=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr55958729oop.20.1594321439306; 
 Thu, 09 Jul 2020 12:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200703201911.26573-1-f4bug@amsat.org>
 <20200703201911.26573-5-f4bug@amsat.org>
In-Reply-To: <20200703201911.26573-5-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 20:03:48 +0100
Message-ID: <CAFEAcA9Bzer-jiPy4jqpc3ycp=d-wdd=LQcdhT8eCxqMQWG-Mw@mail.gmail.com>
Subject: Re: [PATCH 04/18] hw/arm/armv7m: Mark the device with no migratable
 fields
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc44.google.com
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 21:19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> This device doesn't have fields to migrate. Be explicit
> by using vmstate_qdev_no_state_to_migrate.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/armv7m.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 3308211e9c..3f78fccc12 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -366,6 +366,7 @@ static void bitband_class_init(ObjectClass *klass, vo=
id *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>
>      dc->realize =3D bitband_realize;
> +    dc->vmsd =3D vmstate_qdev_no_state_to_migrate;
>      device_class_set_props(dc, bitband_properties);
>  }

The commit message implies that this is changing the
TYPE_ARMV7M device, but it's actually affecting TYPE_BITBAND.
Code change looks good.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

