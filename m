Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A4FC34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBE6020722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Xd1UjH3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE6020722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yvT-0007ta-0E
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:12:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yrE-00043H-N1
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yrD-00059Q-LZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:07:56 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33906)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3yrB-00058V-HD; Tue, 18 Feb 2020 04:07:53 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 21EF196EF0;
 Tue, 18 Feb 2020 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582016872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcbrpJn7ZNHEBPmVPSCnoiPsS8wYKfqB/hJ7sXmcHNo=;
 b=Xd1UjH3AELoJcIJyYOoMfQGKbNiMwKPv1w1MEvc/sUgBbMlZySRb+WEiJ9lnEUNQxYg4yB
 KcS/ZZqIlMmzp9W7eLXH0P4CFdwfmyNHA+M8t7Oy78OuLts+SM4wgLzA84X8jAnn568jla
 oAFpuD/n/N4gcs5oXzeuomah30LAsBo=
Subject: Re: [PATCH v2 01/13] hw/arm/raspi: Remove
 ignore_memory_transaction_failures on the raspi2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-2-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <043ba4f7-4973-7c55-cc4d-84bb18a778aa@greensocs.com>
Date: Tue, 18 Feb 2020 10:07:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582016872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcbrpJn7ZNHEBPmVPSCnoiPsS8wYKfqB/hJ7sXmcHNo=;
 b=AtNeMtYjUdDuQ5f1//Rt8jMDPBZe8TVA2KFGL4fQyxTPuPcqM0cSHJWw+TL7VCjcvQ8+X8
 xSsgiGh7Vymbk1Aqo7vmA5ZPMEXW6JbM+eLkVKkdS1RxfvuVwhiqJqzChViEi+1aW1Rykn
 xVyx82hfu4/dajarBCfF92TL3Z1J5A0=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582016872; a=rsa-sha256; cv=none;
 b=t+DEneg9wQZsm97k2+/GhQdGRi7hJvz78pwI1BuM5nW3ZiRlmkLaP+pV8IeNtLAiR36q3O
 96Jr7dek1OLvwKhlEOWgFR/4FGn5n9xKVSXmOn+jcVlltUlcLIgfDYoVqm0oTbNeb9ikzr
 Tz21qX4syr07NZx8k+iblayQbPxJL38=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit 1c3db49d39 added the raspi3, which uses the same peripherals
> than the raspi2 (but with different ARM cores). The raspi3 was
> introduced without the ignore_memory_transaction_failures flag.
> Almost 2 years later, the machine is usable running U-Boot and
> Linux.
> In commit 00cbd5bd74 we mapped a lot of unimplemented devices,
> commit d442d95f added thermal block and commit 0e5bbd7406 the
> system timer.
> As we are happy with the raspi3, let's remove this flag on the
> raspi2.
>=20
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/raspi.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 90ad9b8115..221356933e 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -324,9 +324,6 @@ static void raspi_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->no_cdrom =3D 1;
>      mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D cores_count=
(board_rev);
>      mc->default_ram_size =3D board_ram_size(board_rev);
> -    if (board_version(board_rev) =3D=3D 2) {
> -        mc->ignore_memory_transaction_failures =3D true;
> -    }
>  };
> =20
>  static const TypeInfo raspi_machine_types[] =3D {
>=20

