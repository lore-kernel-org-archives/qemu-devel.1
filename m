Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AECCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0298621D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0298621D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTaF-00006O-QM
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLTYa-0007AS-R4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLTYY-00025i-GZ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:48:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7201)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLTYX-00024u-OD
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:48:42 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA1C17EBBD
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 14:48:40 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id o128so5063764wmo.1
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cZN9s9L8r9niF23MrvL5IG8jaedcfH9gMuNiubfVR8Q=;
 b=NxCmPiu7Dbf2DjdLku0250WVenV81BJgLx1yqV6ZR1fCvbf9BHQtGW7ctKw+v72J5M
 4JMES1k9oPSWAPz42W0i/rpdd2JeXeb5cBZufotUmf0mDBR4pw3fqsCR4QsSDvoVruRH
 05sKw4H9ERP77L0ZLpVFcABmcEYrsp+nd9Ddxc32SAaOhySu3NbpAe6G1wunHULuV+os
 pmoMV9xrUWxeghMQJIKGNXDHGMu0RtMT3gNMWmxJ/yMeC7MnEqo1TDkuuDeFWsBBF9lk
 StEHNXfJ0h1KBcVw8uv5RqsNKTFsBJO26hlao0/IhOXuRUfOpZLIeDtH63ZXsUTI7J+J
 5yGw==
X-Gm-Message-State: APjAAAWwimTzxtp+9flXETl41AFPF0leLdTtXTg+07GyN7vKMCp2K/Yc
 ZrXhnIATCGtPE4OPlPFX/ujWR/qfsQ/BPxv2RbOL/zO5ZJAnzkYxA5ZTXP15eLQ+BKiZi5q6hpa
 +4CF+Nz4jsOnxzVo=
X-Received: by 2002:adf:e40c:: with SMTP id g12mr8617930wrm.216.1571410119461; 
 Fri, 18 Oct 2019 07:48:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyfBik8qlzvmojjNT0mZ5L+LQ8T6fgiFeR1TuZRqo5QKfEHaiib6wOKAm4s8biv4j5+G5vCUw==
X-Received: by 2002:adf:e40c:: with SMTP id g12mr8617903wrm.216.1571410119254; 
 Fri, 18 Oct 2019 07:48:39 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u83sm12703335wme.0.2019.10.18.07.48.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:48:38 -0700 (PDT)
Subject: Re: [PATCH 0/5] hw/arm/exynos4210: Add acceptance tests to the
 SMDKC210 board
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191005154748.21718-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6ac9df42-a928-0d45-4aa5-3155a1a3ceaa@redhat.com>
Date: Fri, 18 Oct 2019 16:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191005154748.21718-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Basse?= <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/5/19 5:47 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi all,
>=20
> Yesterday Peter Maydell asked on IRC if I had any working Exynos4
> image. I looked at some old backuped notes and could boot Guenter
> initrd with BusyBox.
> I'll use this cover letter to share my notes, they might help to
> have this board fully usable again.
>=20
> This board is listed as "Odd Fixes". Since we have it covered, I
> thought it was worthwhile to have it covered by tests to avoid
> more regressions.
>=20
> Fr=C3=A9d=C3=A9ric Basse used this board last year:
> https://fredericb.info/2018/03/emulating-exynos-4210-bootrom-in-qemu.ht=
ml
>=20
> I'll have a look a these particular commits he added:
>=20
> - https://github.com/frederic/qemu-exynos-bootrom/commit/9be5c9f2253dbc=
04ee
>=20
>     sd: add sd clock support to SDHC_CLKCON
>=20
> - https://github.com/frederic/qemu-exynos-bootrom/commit/6f045949ee2fde=
c624
>=20
>     sd: always reply to ACMD41 (SD_APP_OP_COND)
>=20
> Guenter also carries on this patch:
>=20
> - https://github.com/groeck/qemu/commit/0a80543cc910d
>=20
>    hw/timer/exynos4210_mct: Initialize timer before starting it
>=20
>    When booting a recent Linux kernel, the qemu message "Timer with per=
iod
>    zero, disabling" is seen, apparently because a timer is started befo=
re
>    being initialized.  Fix the problem by initializing the offending ti=
mer
>    before starting it.
>=20
> It might also be interesting to use Krzysztof's initramfs image:
> https://github.com/krzk/tools/blob/master/run-qemu.sh#L29
>=20
> The 1st test added works fine, however the 2nd (SD card) is not
> reliable so it is disabled. We might need to adapt the ADMA patch
> Igor sent once:
> https://patchwork.ozlabs.org/patch/181854/
>=20
> If you want to run the Avocado tests, you need these other patches
> pending review:
>=20
> - https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06439.html
>    "tests/boot_linux_console: Extract the gunzip() helper"
>=20
> - https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06438.html
>    "python/qemu/machine: Allow to use other serial consoles than defaul=
t"
>    (only for the 2nd disabled test)
>=20
> Regards,
>=20
> Phil.
>=20
> Based-on: 20190926173428.10713-16-f4bug@amsat.org
>=20
> Philippe Mathieu-Daud=C3=A9 (5):
>    tests/boot_linux_console: Add initrd test for the Exynos4210
>    hw/sd/sdhci: Add a comment to distinct the i.MX eSDHC functions
>    hw/sd/sdhci: Add dummy Samsung SDHCI controller
>    hw/arm/exynos4210: Use the Samsung s3c SDHCI controller
>    tests/boot_linux_console: Add sdcard test for the Exynos4210

Can you take patches 2-4 from this series? (C part, not Python).
All these patches have been reviewed.

Thanks,

Phil.

