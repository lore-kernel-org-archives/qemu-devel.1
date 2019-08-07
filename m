Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981CEC32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6422522297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 17:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xeAf38Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6422522297
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvPON-00069T-LW
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 13:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvPNg-0005cR-Ot
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvPNf-0000Xo-Jf
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:05:44 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvPNf-0000WO-7u
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 13:05:43 -0400
Received: by mail-ot1-x344.google.com with SMTP id o101so107163447ota.8
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fdYLrUT287k+tJgWqDNZMrBa/YcSpTzUb+gyNVLX6M8=;
 b=xeAf38QcOgtgzKyz8qXEjeJ9Y/ta+tk1/JuzozUXR7zhpHAanM6e+3/xQXSbfe1fJw
 j+QeRAO5HFoEUvCNXIN6NUsAZjIQn8U9kelA56vyI8vygb/3qPYYguF0DR9Ih2orJgeL
 RLtewXo2fxPoJ8w7v4mx6ctErP+mt1a+6HD1kqbExI5u2vnFV80WqpI3G/pNSKwFVWIv
 a01iW5Qsc/MD/v+y8Ie0bAkFcUqghXwvVWPpLgIsoiFlVwfFv+iY4BuauQsTzCJNwnUE
 zjd2YZyM8zTPlDzZelbT8zhGvAOuQOrMkJ7/G0Dsl7H+iH+++1OpiM0HLFouuFb01dwc
 BqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fdYLrUT287k+tJgWqDNZMrBa/YcSpTzUb+gyNVLX6M8=;
 b=dsGu38E9FD9Ty2LR5TQK9AvJaLZOT9uXP2f/G+oyxVTCjqyKLRzWzNfQdy7bMiDKri
 /EoZTZF3ZZGBuWlGzRoUW+d40+SHHxi+yL0pq8g6wc0460qRsy6n23QzZZ59KVRdT5aC
 EzsKxooPFpUFhabnmFIZCKR/4VUig8QW8fqe8ufMCuq9dhYFnXuQLFvLHEuydic4PYH9
 LoSj8u3BmbtgX1gPQjOAd8gU09/Rnbi8Tmim6YiCMXC+f94lQP7PBerNQSGQwTN//HYL
 rXQCtRKvX7jw5RA/y0qrBehacfH1N9zFnAzCYcM+0PeevhWH7rUV52q7dxtwQEdpUjmM
 zHhw==
X-Gm-Message-State: APjAAAX7PWkg8WXF/I93JWKGWDp8GM52TZ0NJu8Z1VljimZK9JUY+PRD
 SkCinIG66iHgDt7TEtbK2CTYOxB7B4L3Do0fSWxWPw==
X-Google-Smtp-Source: APXvYqw2983//EmtZX+t3UroiOQBqfo/3kG0niiykKD1bogK9ULYfqgTF3jLTkPTJ2tuW06K9WizL69l36co89AlJ3I=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr9172136oti.91.1565197542250; 
 Wed, 07 Aug 2019 10:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190805142417.10433-1-aaron.hill@alertinnovation.com>
In-Reply-To: <20190805142417.10433-1-aaron.hill@alertinnovation.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 18:05:31 +0100
Message-ID: <CAFEAcA-WN_wPiG=mCSTR4N2C10TuW3cuyhN-K0xmA4AxwX3N3g@mail.gmail.com>
To: Aaron Hill <aa1ronham@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH] Set ENET_BD_BDU in I.MX FEC controller
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 15:24, Aaron Hill <aa1ronham@gmail.com> wrote:
>
> From: Aaron Hill <aa1ronham@gmail.com>
>
> This commit properly sets the ENET_BD_BDU flag once the emulated FEC cont=
roller
> has finished processing the last descriptor. This is done for both transm=
it
> and receive descriptors.
>
> This allows the QNX 7.0.0 BSP for the Sabrelite board (which can be
> found at http://blackberry.qnx.com/en/developers/bsp) to properly
> control the FEC. Without this patch, the BSP ethernet driver will never
> re-use FEC descriptors, as the unset ENET_BD_BDU flag will cause
> it to believe that the descriptors are still in use by the NIC.
>
> Note that Linux does not appear to use this field at all, and is
> unaffected by this patch.
>
> Without this patch, QNX will think that the NIC is still processing its
> transaction descriptors, and won't send any more data over the network.
>
> For reference:
>
> On page 1192 of the I.MX 6DQ reference manual revision (Rev. 5, 06/2018),
> which can be found at https://www.nxp.com/products/processors-and-microco=
ntrollers/arm-based-processors-and-mcus/i.mx-applications-processors/i.mx-6=
-processors/i.mx-6quad-processors-high-performance-3d-graphics-hd-video-arm=
-cortex-a9-core:i.MX6Q?&tab=3DDocumentation_Tab&linkline=3DApplication-Note
>
> the 'BDU' field is described as follows for the 'Enhanced transmit
> buffer descriptor':
>
> 'Last buffer descriptor update done. Indicates that the last BD data has =
been updated by
> uDMA. This field is written by the user (=3D0) and uDMA (=3D1).'
>
> The same description is used for the receive buffer descriptor.
>
> Signed-off-by: Aaron Hill <aa1ronham@gmail.com>
> ---



Hi; thanks for this patch. The data sheet's description of the
buffer descriptors was a bit confusing to me (since it describes
what we have as a "uint32_t last_buffer" as two separate 16 bit
fields) but I think this is correct given how we define ENET_BD_BDU.

I've applied it to target-arm.next ready to go in once the
4.1 release ships and we reopen trunk for new development.

thanks
-- PMM

