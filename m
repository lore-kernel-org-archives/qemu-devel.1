Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366EACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9EC2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9L6aHsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9EC2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMtzP-0006W3-IE
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59880)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtrr-0005l8-8C
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMtrq-00012r-24
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:06:31 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33924)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMtro-0000zh-QL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:06:29 -0400
Received: by mail-io1-xd42.google.com with SMTP id q1so20324524ion.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a1wBe3lyQqhBm3Tp9rzRkxx4ysHQSccZ1HHlopvQIzk=;
 b=D9L6aHspB6jWau/6264gkuHedDFsFVTJSw9C6UY1K4MeZl0fBET3ZFZr/+wDbfOTuV
 qCzmoP4bHYV3wyrnu4GcmqsYQF8hkC6eIF7X0NVQ9JKcGPSdGEgECQx3rdV430oNONh6
 wIxmDzVqFdNeJghLhadQFpnh39C9pm2SWd6QrWidhmAiQXFTuA3jpaXDOQs4xD4h6U69
 XDAqOrFCPUnPUo5b/tSxHD2nyhA+ryBIlBF/WXfQZM8jsuJCPNXxn2Vy2u/44k8a4H/F
 hmf56XeyIIW8MZbDjrjF3x4nW8m3IvVFG6eUNvWufz+l9FN7LfeziQNDPkx7D1jaYe+O
 CmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a1wBe3lyQqhBm3Tp9rzRkxx4ysHQSccZ1HHlopvQIzk=;
 b=hJtfe8aPa+ZyPfKBBGaPbMf3i/WoH9j9aY3zluLBCviEoefWr2FaBk7DitxG6lMVGi
 ZEssWiwnVzR0EdXAJGghO3M4tHs9smJVTq+1tdaN0DmDFIqeDz48babIb/qki6zNETNv
 lfopawY71/AwjvcNwCjTip3+5+Ftlh098ge9QaT02R20NkDQVaNs7wyITmHOkzQNf3D3
 HBMNpzft9sfP3dlHGlRvfehys/J4xTAL1DyuNbSfE5sBhdcAX+4W0flAqJAsAMTbW7q3
 SREnZEtjX+Q9U08RKPQvULMhhrSiOewjrILuHErXrANTxstZvo7P/3q89AUbBxgMRbBX
 eybA==
X-Gm-Message-State: APjAAAWqZ0yqjyAGUad72yRxyW8qva8nXZyhU57XdiorxTOFqwXJVn2Z
 ArnOuyIxPcZTFb2XtTmiF9xfDodYmo9NeRh8l6dmeg==
X-Google-Smtp-Source: APXvYqzxAhpVbm6h3FDW/rdsy/7JIdLidDl17CFvER2ADRhGAKbLtxjUw0qK9B60dfmh+XsuKX6g3wzn3fTFkN/eeCw=
X-Received: by 2002:a02:7f57:: with SMTP id r84mr3723672jac.69.1571749574568; 
 Tue, 22 Oct 2019 06:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191021190653.9511-1-philmd@redhat.com>
In-Reply-To: <20191021190653.9511-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 14:06:02 +0100
Message-ID: <CAFEAcA-85Yd+qCFa8CoWayYsd9F9C+NmZksMnhx=dAsjt+BUjg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/arm: Create the RAM in the board
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
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
Cc: Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 20:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> This series contains the ARM patches extracted from the
> "Let the machine be the owner of the system memory" series [1]
> reviewed by Richard.
>
> These are cleanups moving the creation of the system ram at
> the board level. The other series will enforce
> memory_region_allocate_system_memory() get called with a
> MachineState argument, this preliminary cleanup is required.
>
> Regard,
>
> Phil.
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg05085.html
>
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/arm/xilinx_zynq: Use the IEC binary prefix definitions
>   hw/arm/mps2: Use the IEC binary prefix definitions
>   hw/arm/collie: Create the RAM in the board
>   hw/arm/omap2: Create the RAM in the board
>   hw/arm/omap1: Create the RAM in the board
>   hw/arm/digic4: Inline digic4_board_setup_ram() function



Applied to target-arm.next, thanks.

-- PMM

