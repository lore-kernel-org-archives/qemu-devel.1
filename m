Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF9C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 13:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACB9224699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 13:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HP42IC1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACB9224699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isoCs-0007oy-Sl
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 08:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42011)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1isoBi-00071x-W5
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 08:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1isoBg-0001XT-D5
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 08:30:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1isoBg-0001X9-AM
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 08:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579354251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lf+UtRNOGS38Pwon3ps7Xnso3KHgL4d4xeGT+ZIesCc=;
 b=HP42IC1uPxI3dq1tpqG4KnOV7ulqtIcuAGKJPrM6NeI+pkPowMWkKUv/B6W8R5nPC57obe
 9DotAxR3CFLXmzsZaJ0E+xVMf2NnRa5NG5EJvlFFTW0JPuSMIQGQEfZfGEaDH1kFprdwt2
 Mcl1L3UGWDgVsd+2ECmR/MfW0kvEod0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-89VRmMybMbWWCryUOPm8Yg-1; Sat, 18 Jan 2020 08:30:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C51107ACC4;
 Sat, 18 Jan 2020 13:30:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-131.ams2.redhat.com
 [10.36.116.131])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9990384BC9;
 Sat, 18 Jan 2020 13:30:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2611F1138600; Sat, 18 Jan 2020 14:30:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Move the OMAP section inside the ARM
 Machines one
References: <20200118085509.30182-1-philmd@redhat.com>
 <20200118085509.30182-3-philmd@redhat.com>
Date: Sat, 18 Jan 2020 14:30:45 +0100
In-Reply-To: <20200118085509.30182-3-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 18 Jan 2020 09:55:09
 +0100")
Message-ID: <87pnfgq4ca.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 89VRmMybMbWWCryUOPm8Yg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Add the Siemens SX1 (OMAP310) machines with the other ARM machines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52fbc18566..e2c148d8d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -560,6 +560,13 @@ F: include/hw/arm/digic.h
>  F: hw/*/digic*
>  F: include/hw/*/digic*
> =20
> +OMAP
> +M: Peter Maydell <peter.maydell@linaro.org>
> +L: qemu-arm@nongnu.org
> +S: Maintained
> +F: hw/*/omap*
> +F: include/hw/arm/omap.h
> +
>  Gumstix
>  M: Peter Maydell <peter.maydell@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> @@ -1404,13 +1411,6 @@ F: include/hw/block/fdc.h
>  F: tests/qtest/fdc-test.c
>  T: git https://github.com/jnsnow/qemu.git ide
> =20
> -OMAP
> -M: Peter Maydell <peter.maydell@linaro.org>
> -L: qemu-arm@nongnu.org
> -S: Maintained
> -F: hw/*/omap*
> -F: include/hw/arm/omap.h
> -
>  IPack
>  M: Alberto Garcia <berto@igalia.com>
>  S: Odd Fixes

Commit message says "add", patch seems to merely move an existing
entry.  What am I missing?


