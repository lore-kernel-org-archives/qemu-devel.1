Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E400C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E206216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q84M+lnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E206216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42482 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqDg-0005ZD-Id
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:53:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqAr-0003kk-CS
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hSqAq-00063e-Gv
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:50:25 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:36800)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hSqAq-000632-5U; Mon, 20 May 2019 17:50:24 -0400
Received: by mail-lj1-x243.google.com with SMTP id z1so13931345ljb.3;
	Mon, 20 May 2019 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=x7r9XNYB2o5vMYWmRzZIat+sN5wAmUA6kVuz3xo43fs=;
	b=q84M+lnHopdfZVKExtjtdcrV1vDZiW0c0DeMXwrUcaSGUnH2O2HfQP9fPKZG1FQ4fn
	25sVYshWZd0vlShdwN0RRKqzhkfRv2/ekKrw8lDBSKfb4ntK8wFUrse5l1FuFdmom4In
	NVrFaVWwAooqXtf2CpSLF8etTDNboOUL3CV60KBcc09+ddoQBfpuv7n4NtoOmXVZ/3ig
	/fLxSmOkDDrYisABEPqk7fiDv+ZniCIqQaAiG7XXnLrFBSv4O5o3lz9OO8xEoL8Oyust
	KI8YHvQEyPb4StTpuLEnP5rXbjm54mGbcSKAzNyh5koS4HQXKL2sq+XPtdFZV5mXwpOw
	5Y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=x7r9XNYB2o5vMYWmRzZIat+sN5wAmUA6kVuz3xo43fs=;
	b=cMAR1SVAlGkk6EZID4j93rzlKmUHrroHBXVdIFPTN/PJpW6UkIxv3QscZ7h4ygY9tc
	PLUjT9jceCdmhzVIhFCjmMOTwWy6S4bLjqyZ9CT9NMKfU2PrqUXs/vr5mgHBVl1WtSaa
	IMxg59NLBkVbA1wvXspAnGwArAUPGzPzvCoKb6DbItT3/bADcOfhd/E9KhuAdp8Q+G64
	11hiaEcGCWSlFMDaDp+NaMf6T9tpeAP8UDx7NX+bkRPMHxBeQVgsenK95RP+qL5TTw/N
	m8LD+1BR+5qKN6Ptnkd47t4wlock2F7Ixh8s/hFdAT5wbiNbArXezsfZaDbUQQ3/881a
	AOCw==
X-Gm-Message-State: APjAAAXdQdBimzlWjkkEdJ9oTorWbPzDRJV22J0Rjatw65ej4AX5+q9X
	16QxjbmBjREU1EChucFi2wvsLhvcXl+qqoHzQ9Q=
X-Google-Smtp-Source: APXvYqzw2JzYet85r0nVs6V2pklo0FF45kKZQOZRg4cX2n+nnoWvIaLzM7TnV2Ta7VqUdsKNd5vbAZErhlOgCEn/QiM=
X-Received: by 2002:a2e:597:: with SMTP id 145mr11316838ljf.127.1558389023036; 
	Mon, 20 May 2019 14:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190520214342.13709-1-philmd@redhat.com>
	<20190520214342.13709-3-philmd@redhat.com>
In-Reply-To: <20190520214342.13709-3-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 May 2019 14:48:08 -0700
Message-ID: <CAKmqyKMwbwvAyQ=u0SgaphHiP_HFFnL2npSTYum+G5V60F7kBw@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/arm/exynos4: Use the IEC binary
 prefix definitions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	"qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 20, 2019 at 2:48 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> It eases code review, unit is explicit.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/arm/exynos4_boards.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
> index f0c24b7992e..f824eef0d36 100644
> --- a/hw/arm/exynos4_boards.c
> +++ b/hw/arm/exynos4_boards.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu-common.h"
> @@ -60,8 +61,8 @@ static int exynos4_board_smp_bootreg_addr[EXYNOS4_NUM_O=
F_BOARDS] =3D {
>  };
>
>  static unsigned long exynos4_board_ram_size[EXYNOS4_NUM_OF_BOARDS] =3D {
> -    [EXYNOS4_BOARD_NURI]     =3D 0x40000000,
> -    [EXYNOS4_BOARD_SMDKC210] =3D 0x40000000,
> +    [EXYNOS4_BOARD_NURI]     =3D 1 * GiB,
> +    [EXYNOS4_BOARD_SMDKC210] =3D 1 * GiB,
>  };
>
>  static struct arm_boot_info exynos4_board_binfo =3D {
> --
> 2.20.1
>
>

