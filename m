Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7D92086A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 13:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxNHkC8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7D92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8l2M-0008I0-Bc
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 08:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j8l1Q-0007G8-AM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j8l1P-0007DL-7Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:22:12 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j8l1P-0007Cr-2C
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 08:22:11 -0500
Received: by mail-oi1-x244.google.com with SMTP id a22so10189037oid.13
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 05:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2XcAUaTOQNOWzMmbgQ3MBenvHZtifL5/JzGKBHBsYTk=;
 b=xxNHkC8TEOna7j9xp1yD9C3Ikkbj8NfNJ4aBc0IY6lan0O0XYaEthXTOt2r3HhuyNP
 W246zcfou9Jm1XHwIKGoBtVXC+w5j/ERPSRmT8w3fBSH9/UPT8LUv+S7gJF5drR6FS6p
 8EkvOV5Qik4FUNCHE1XKiIf6puGNk+PeAzTpZzwMrWZtiTujEg/5shYEhNqgxkKyLPNa
 3z6q6f1tKaKPE++vtMNEIafae5Ni02UsTOwaAbSemJs7To6PPMBXTdDzxkQCYDjIJLYC
 eUpgXHiamnlL4auc8rIk6Otm4GefWeyRcs0panyNQT1hHmnvqL2C+9Sex0cWoaHSJZky
 EliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2XcAUaTOQNOWzMmbgQ3MBenvHZtifL5/JzGKBHBsYTk=;
 b=IUC1MLJOwqR5nUjGnFBzTvY68TBFML7TGk4qC4aJFQKYpdRGXkWkxlsnseMxpRGwNo
 HWIe/gEmiMg7cXAL8JhQtCV91H/tG7aOI2z2zuhVOSlcWZt4oRLw2tZMqpl/+HNPQE/o
 qHZ2W7JsJj/ub478KI3K2nDjDxJcIpITx/9z7L5sI+TcF8FcYjZ9epTWByzjsyLyoM1z
 nkzzxQtg9bIDMehSRZb3BTOVyyNHgkXHvnCb5Hc0o3Stpxkqm8XJP4e/FC/bag3yvzHD
 cN7Jtxatg8E0vBjKfKgdw13guYtzqL6+imOnqEIauEP5aL07a0TzSXLtl7sCyZzl+yhT
 y1gw==
X-Gm-Message-State: APjAAAU1k7OeVxtvSxXnNDZWx1iURz0Z7aKyjeEDeloXCWl1dT4TIMfQ
 dPpuIIbiuRS/AGGXVGsVbUn2Q3UUzrouuA9tTtbDpA==
X-Google-Smtp-Source: APXvYqyUEXTGLt78RL4ba0Opm+buvgoJbyiVRziZV+FLNDaLGk2hJCnrITki42aGOF86cZGwCO/FlfOXooYi7sYl0zY=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr11569695oid.98.1583155330305; 
 Mon, 02 Mar 2020 05:22:10 -0800 (PST)
MIME-Version: 1.0
References: <20200227025055.14341-1-pannengyuan@huawei.com>
In-Reply-To: <20200227025055.14341-1-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Mar 2020 13:21:58 +0000
Message-ID: <CAFEAcA9stgfbRGdn0x2q38vVS9NDyysW656+XkjfyVui3OXXQw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] delay timer_new from init to realize to fix
 memleaks.
To: Pan Nengyuan <pannengyuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Euler Robot <euler.robot@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Feb 2020 at 02:35, Pan Nengyuan <pannengyuan@huawei.com> wrote:
>
> This series delay timer_new from init into realize to avoid memleaks when=
 we call 'device_list_properties'.
> And do timer_free only in s390x_cpu_finalize because it's hotplugable. Ho=
wever, It's not valid in mos6522
> if we move timer_new from init to realize, because it's never called at a=
ll. So we also add calls to mos6522_realize()
> in mac_via_realize to make this move to be valid.
>
> v1:
>    - Delay timer_new() from init() to realize() to fix memleaks.
> v2:
>    - Similarly to other cleanups, move timer_new into realize in target/s=
390x/cpu.c (Suggested by Philippe Mathieu-Daud=C3=A9).
>    - Send these two patches as a series instead of send each as a single =
patch but with wrong subject in v1.
> v3:
>    - It's not valid in mos6522 if we move timer_new from init to realize,=
 because it's never called at all.
>      Thus, we remove null check in reset, and add calls to mos6522_realiz=
e() in mac_via_realize to make this move to be valid.
>    - split patch by device to make it more clear.

Hi; I've applied patches 2, 3, 4 and 6 to target-arm.next,
since I think those ones are OK and they're all arm related.

You've already got review comment for patch 1 (s390)
and 5 (m68k mac_via/mos6522).

thanks
-- PMM

