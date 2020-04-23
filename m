Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF09C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:05:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 985982077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 14:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cardinalpeak-com.20150623.gappssmtp.com header.i=@cardinalpeak-com.20150623.gappssmtp.com header.b="fl3O8ctx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985982077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cardinalpeak.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRcTW-0007rP-NH
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 10:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dchristian@cardinalpeak.com>) id 1jRbzE-0003ca-MK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dchristian@cardinalpeak.com>) id 1jRbzE-0006qJ-4K
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:33:52 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129]:36397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dchristian@cardinalpeak.com>)
 id 1jRbzD-0006hp-Kg
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 09:33:51 -0400
Received: by mail-lf1-x129.google.com with SMTP id w145so4771406lff.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 06:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cardinalpeak-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=+I4rrNom2aBCICQIS2qgXOAkXonODvEb3O5YBdkDnW8=;
 b=fl3O8ctxAxSDWXTTyGcFUzM9Qz3PNX7b2cx8yNnpGFOzurkwZlgG+glqAKBbDDseeC
 7Pmc2r5PXuj0pVdzL1OXO2IzZiqx3J+3D6miB6HjYHDrcwwKbAhDEsoIt8NQur2ZoT6t
 GJioZE5PRzY11nXUlHezlVv64grbFObmDV/CvvkNsx4gehwyjCz9eAVMr+/nZMdJ9whz
 Hl3l8ZsxuKPp/tYVe+xxTEH/jBw4YFG6mTGK7sBziECnKWYoojnvanIyEicFOBTCaSLb
 oInsobBAEgoZUpcv5UDH7mOaepRkTlUca7VncGzqbOsdIVYC4420OeBnX9jjWW8hBZ4i
 kcLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=+I4rrNom2aBCICQIS2qgXOAkXonODvEb3O5YBdkDnW8=;
 b=aW9t3jRBDukJ9XmHL0k8CiSm64HYgvkqJk4ySgVvdA2jeGqE+vBQaXt0NI0Q/+798u
 WxuW3LVjtAOAz2j80I6tk4H+dNHKzmvS3U+Th4e9JaId+8BQ13G07RDBzZR2dxOAdFn+
 mzWPOr2SsAnEsV02mOAlOaA0i2GAQx32QEwDRlm++GRWJ8zIYSbMc19AT+39uAJ0jZCU
 qeRyEapsE5w/ec16j1oowGh9W4ZyCntwd4bIaBCXA2pqOuJ50aqQ8G4DX+kS5oIVO/nD
 CZrAFK6WD5I8itznzBnb1IOPwRA5g+L66ez6WYKuaDtMm3fmNgwnsky3XiB5lWUxTX1Z
 Ck6w==
X-Gm-Message-State: AGi0Pua+m8nLSIva4EeBZW82NUY3OCfPsFYfOBoQhGMqJzlh3hdqjxL9
 U5nAtJmYZzcKcz6TDmbtwNTNE6vF0kejbMCTgtbIdu9E
X-Google-Smtp-Source: APiQypJaUsB4o4ostPG3t7AJqAgyLAJSHNQ5UH63Dy/y6gwNfeCj1adxMXG5MDWlzI+ujWE1ZQg6W0Y5lqbKt0DTshM=
X-Received: by 2002:ac2:4546:: with SMTP id j6mr2490313lfm.203.1587648828509; 
 Thu, 23 Apr 2020 06:33:48 -0700 (PDT)
MIME-Version: 1.0
From: Dan Christian <dchristian@cardinalpeak.com>
Date: Thu, 23 Apr 2020 07:33:37 -0600
Message-ID: <CADxL6wUGWZO0U=G7UTAebG57m6tG58hoMf_-TCC+0qReUB0G6w@mail.gmail.com>
Subject: Need BT support in qemu for Zephyr
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000073d2ed05a3f54ca2"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=dchristian@cardinalpeak.com; helo=mail-lf1-x129.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::129
X-Mailman-Approved-At: Thu, 23 Apr 2020 10:03:55 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000073d2ed05a3f54ca2
Content-Type: text/plain; charset="UTF-8"

There was a note about BT support being deprecated.

Having it makes developing/testing Zephyr
<https://github.com/zephyrproject-rtos/zephyr> bluetooth vastly easier.

I hope it will be retained.

Thanks,
Dan

--00000000000073d2ed05a3f54ca2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There was a note about BT support being deprecated.<div><b=
r></div><div>Having it makes developing/testing <a href=3D"https://github.c=
om/zephyrproject-rtos/zephyr">Zephyr</a>=C2=A0bluetooth vastly easier.</div=
><div><br></div><div>I hope it will be retained.</div><div><br></div><div>T=
hanks,</div><div>Dan</div><div><br></div></div>

--00000000000073d2ed05a3f54ca2--

