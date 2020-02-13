Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD561C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A572073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDJFbqgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A572073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2F47-0004dq-Jm
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2F3A-0003ln-Iz
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2F39-0007Xm-DR
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:01:04 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2F39-0007XT-8W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:01:03 -0500
Received: by mail-oi1-x241.google.com with SMTP id l136so5854006oig.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3D+BOc9yngWvSSbXBA6JOzlerIO/fYcLBPTETkaebEw=;
 b=lDJFbqgg7jQsSiojonamh1KVfRY9eg6vFs/kB2Bebhzacrmew3ERepPDXsD1IUbUfq
 jv5L+4t2GPifVX4J77vPCVNO8n33HRSB7rRQ3d7Zppai7k+E+MuaLz+uV4bKPA8fdIgB
 wJeZYfar84qA4DRYx2MGxdQBk047LL2QacLtmOdXnwq1NJo9XVR6vmyolowtSePQg8Dj
 Mz8lsTpUFlgjBXhANaZtxUsMQT1HRmVJAWtkdUNvyiVmfMal1vsDQmpnrg3RmCij/a9P
 7KncaYA2YdtyQ8LP4wWrNrTA0WDOfnYY+fhffjDaDGt2KD81qD0R1mexYfq1CGk03V/k
 h+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3D+BOc9yngWvSSbXBA6JOzlerIO/fYcLBPTETkaebEw=;
 b=rSM2MyblU2CNEZ+2ApfWgimqVw592vzU3HI4EC60NDF9hWwAcEaoBG6adRBt8ko+Jr
 f6az8sMKhWFVwQVs74sudblBRF3oV7N73L/oKjIePa87cB6cfiZBQGVH+ziQxFnJXLpb
 YG8bLAiKaJhGU7ejnzeFUg7+2w07a7utejd/PAV5oE0AxxG+vvRZX4w+5ElwAPcO20/y
 pC3ZA36CbOjYrPGV5e5hpVXoWGYMiXaBaVi3DcWaJHG6EnMnNRixbDw7VhZD0MqxriO9
 PpzxZG26hfYQjJ060khm9C03h4FhbYjn2Up7xyazoYIJ1n97ePyj6A7nD/OLv3PPrIqA
 vDgw==
X-Gm-Message-State: APjAAAUx7ggr0ttZ0+TlJk/2YWfCzJp59J7uqpwkoILAtXBRWeYOEWPn
 W6qs0rsgmV09bUMQwb6Xy7f3Zfh2hiDSrVUtR9JevA==
X-Google-Smtp-Source: APXvYqywHczTdsET139V7S8AhJLuj+qWen3TIfkjV/zGRT7VRvtSfqaDUXP2L4RbXPtaUY4ErH9g3JE2NIEv0rNZEVg=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr2872492oic.48.1581602462453; 
 Thu, 13 Feb 2020 06:01:02 -0800 (PST)
MIME-Version: 1.0
References: <20200208165645.15657-1-f4bug@amsat.org>
In-Reply-To: <20200208165645.15657-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 14:00:51 +0000
Message-ID: <CAFEAcA9dcRvkZOVDYyk9GqPLK0OTEQM_8g1ZtUMjSGv39E4aFw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] hw/arm/raspi: Dynamically create machines based
 on the board revision
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 8 Feb 2020 at 16:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi,
>
> This series is a preparatory to easily add the raspi0/raspi1/raspi4
> boards (see [1]).
>
> Igor has been working in his "refactor main RAM allocation to use
> hostmem backend" series, and now v4 [2] is almost reviewed.
>
> His raspi patch [3] clashes with my work, Since it is easier for
> him to apply his on top of mine, I am sending these patches first.
>
> Since v2:
> - Split of bigger series (30 patches was scary)
> - addressed Zoltan review comments
>
> Phil.
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg677145.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675738.html
> [3] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675752.html
> Supersedes: <20200206011756.2413-1-f4bug@amsat.org>

I had one or two minor comments but I'm happy if we address
those in follow-up patches.

Applied to target-arm.next with the commit message tweak for
patch 13 suggested by Igor.

thanks
-- PMM

