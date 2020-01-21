Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F129BC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF69F21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esA150ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF69F21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itpHx-0005VU-UW
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itpH9-0004wj-Rt
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itpH6-0000cx-BC
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:52:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29372
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itpH6-0000cc-7s
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579596759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbN+Vpoha1itMQp+hrPAY/DVqbvgsc26vw7XNW9KU7E=;
 b=esA150ro9ucmnwXWTOvtc15esCzfdEqrmgNbLxFwSrUFsalXtTMGYVmtLsL80AZqq5Xmul
 emfKEof10uIBNr8LD4UrbyMn2sbaCeYRcTuAv4Ir2MBxVJwbcG+E54MfeQcMB6kTu1k76P
 ydCm6Y+bajaiAL/73Dc5ezR9uwnCyH4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-rCK4UyVkO1CLuFoHev8R5Q-1; Tue, 21 Jan 2020 03:52:38 -0500
Received: by mail-wr1-f69.google.com with SMTP id u18so1001716wrn.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 00:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=edEY1ReFPmWoxoOPXjtICaZFRSIvbKLZn+dFKDtLj50=;
 b=mWrJAn4pwxhZXbTJHgQnti4H63cINKVwoCo9+zM5JQQ3aaUoQvpfSZuAHoEHHijrrk
 K8ajqCrqrNRYPDQEKH6ezsHVFdaYYyNur/nFjedfjwWULMvAd+HsdqXDXXKHTAvy3H+C
 PuMgJSkJHKitODgWKxJn+jbNm/f74aGUYV4jmN4OsKG/oD/p0KUwXbJFIro8lkfmmli0
 mozHg7ARcqDSqcNX/HAsNqkoOElrUtG6vQzs6Xt4VsqTfpS5fUSyZtrF1avaf4hoIk3b
 y1NIi3ji5AINytoxBrfoqjnBlM6oN5duKySP6adB/X8sJrJpZ3igcM/IGffbTFhGEiks
 iKrw==
X-Gm-Message-State: APjAAAXzKm8QAy2ft9j56PH2DVEK2+BffQD2l6lzRJjXdzoiQCdE82oJ
 Xa6wQyFCppQirkH2/pmP8udIyF4bRhv1G41m2VKDLeiwBr1PTXMHx3FsYRsDfGPgdFaLhRAlIIB
 IACwudA9V2hUo6Wc=
X-Received: by 2002:a5d:458d:: with SMTP id p13mr3979163wrq.314.1579596757025; 
 Tue, 21 Jan 2020 00:52:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzE+nPVGqfeUe4eWYGdJe18kmvcbSW1CXWVQGGIXLzY/rbCgbcbjTV1rN4fUXrWTISNDXlLXQ==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr3979136wrq.314.1579596756629; 
 Tue, 21 Jan 2020 00:52:36 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id v14sm51045886wrm.28.2020.01.21.00.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 00:52:36 -0800 (PST)
Subject: Re: [PATCH 2/2] aspeed/scu: Implement chip ID register
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20200121013302.43839-1-joel@jms.id.au>
 <20200121013302.43839-3-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d20e112d-edf9-d8d8-fa6c-e93aac4dcec3@redhat.com>
Date: Tue, 21 Jan 2020 09:52:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121013302.43839-3-joel@jms.id.au>
Content-Language: en-US
X-MC-Unique: rCK4UyVkO1CLuFoHev8R5Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 2:33 AM, Joel Stanley wrote:
> This returns a fixed but non-zero value for the chip id.
>=20
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/misc/aspeed_scu.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 7108cad8c6a7..19d1780a40da 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -77,6 +77,8 @@
>   #define CPU2_BASE_SEG4       TO_REG(0x110)
>   #define CPU2_BASE_SEG5       TO_REG(0x114)
>   #define CPU2_CACHE_CTRL      TO_REG(0x118)
> +#define CHIP_ID0             TO_REG(0x150)
> +#define CHIP_ID1             TO_REG(0x154)
>   #define UART_HPLL_CLK        TO_REG(0x160)
>   #define PCIE_CTRL            TO_REG(0x180)
>   #define BMC_MMIO_CTRL        TO_REG(0x184)
> @@ -115,6 +117,8 @@
>   #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
>   #define AST2600_RNG_CTRL          TO_REG(0x524)
>   #define AST2600_RNG_DATA          TO_REG(0x540)
> +#define AST2600_CHIP_ID0          TO_REG(0x5B0)
> +#define AST2600_CHIP_ID1          TO_REG(0x5B4)
>  =20
>   #define AST2600_CLK TO_REG(0x40)
>  =20
> @@ -182,6 +186,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR=
_REGS] =3D {
>        [CPU2_BASE_SEG1]  =3D 0x80000000U,
>        [CPU2_BASE_SEG4]  =3D 0x1E600000U,
>        [CPU2_BASE_SEG5]  =3D 0xC0000000U,
> +     [CHIP_ID0]        =3D 0x1234ABCDU,
> +     [CHIP_ID1]        =3D 0x88884444U,
>        [UART_HPLL_CLK]   =3D 0x00001903U,
>        [PCIE_CTRL]       =3D 0x0000007BU,
>        [BMC_DEV_ID]      =3D 0x00002402U
> @@ -307,6 +313,8 @@ static void aspeed_ast2500_scu_write(void *opaque, hw=
addr offset,
>       case RNG_DATA:
>       case FREE_CNTR4:
>       case FREE_CNTR4_EXT:
> +    case CHIP_ID0:
> +    case CHIP_ID1:
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Write to read-only offset 0x%" HWADDR_PRIx "=
\n",
>                         __func__, offset);
> @@ -620,6 +628,8 @@ static void aspeed_ast2600_scu_write(void *opaque, hw=
addr offset,
>       case AST2600_RNG_DATA:
>       case AST2600_SILICON_REV:
>       case AST2600_SILICON_REV2:
> +    case AST2600_CHIP_ID0:
> +    case AST2600_CHIP_ID1:
>           /* Add read only registers here */
>           qemu_log_mask(LOG_GUEST_ERROR,
>                         "%s: Write to read-only offset 0x%" HWADDR_PRIx "=
\n",
> @@ -648,6 +658,9 @@ static const uint32_t ast2600_a0_resets[ASPEED_AST260=
0_SCU_NR_REGS] =3D {
>       [AST2600_CLK_STOP_CTRL2]    =3D 0xFFF0FFF0,
>       [AST2600_SDRAM_HANDSHAKE]   =3D 0x00000040,  /* SoC completed DRAM =
init */
>       [AST2600_HPLL_PARAM]        =3D 0x1000405F,
> +    [AST2600_CHIP_ID0]          =3D 0x1234ABCD,
> +    [AST2600_CHIP_ID1]          =3D 0x88884444,

Since this doesn't match the datasheet, can you add a comment /*=20
Arbitrary non-zero value */?

With it:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
>   };
>  =20
>   static void aspeed_ast2600_scu_reset(DeviceState *dev)
>=20


