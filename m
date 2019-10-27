Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C413CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 06:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CA821726
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 06:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=voltagex-org.20150623.gappssmtp.com header.i=@voltagex-org.20150623.gappssmtp.com header.b="fOMTwYmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA821726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=voltagex.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iObwN-0005xG-VL
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 02:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <voltagex@voltagex.org>) id 1iObvZ-0004Kz-Qp
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 02:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <voltagex@voltagex.org>) id 1iObvY-0004au-IP
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 02:21:25 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32]:41250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <voltagex@voltagex.org>)
 id 1iObvY-0004Zg-60
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 02:21:24 -0400
Received: by mail-vk1-xa32.google.com with SMTP id 70so1359053vkz.8
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 23:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=voltagex-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=UI9MyIklaNmDns7ObHuI4EPHEYGjo6fcb/9KkPxzUeM=;
 b=fOMTwYmi5Fm4+0BYlgEgzHr4eXuza60b7/a/kYWn8dMpcASPy6A3XsMMt4q4J5C+PB
 7jVoOw082wKpLk4wGD3TKcQz/gGs5L6NONX4dsCBCHR5K/GkyUfVIYv+cAd7v3wJMkzX
 0Pgeaiv72P0Zf4gByNF/LzcFQupYhLNWGJ09u/Z1USBMwe4ObCsrOOsinCMyfmLXdBy6
 PseICcoyiIga/bXUtbQUuTSHmTZmvqlIetZgvyOy0sHPloCVECt1kAHfxb06Fix5z06q
 gOCxTSmsP4OC0UmVmthoMAs7lh5cdjStdqqXQbTVfcLkiKUW/kmgvZK3HpjyhtjtbvVn
 qkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UI9MyIklaNmDns7ObHuI4EPHEYGjo6fcb/9KkPxzUeM=;
 b=MuEt9RZ1KrNeJDorAkzXeAEWNSLFv8HSW9mUB4Y3iJZXokYG0rTS4krjF3WEsMUQQv
 1GWDrW6Z/pZHCMwoy80dz+O70Y8OrCDgy2rkE6Jt64KVRKbwIUB0jQ5W3azGLRnoQmW0
 HeOymjsmkwupUwmQiZb0T1/GGJ/oOnV/KI7bYenvA3hBL4CCQR71GeOtYRNkbJKh1oOV
 gStTudtW34Ur1L2smLfb4vNEeBGBBF6+JHUYDP2dHJWtFf72hZNiYoUDNgxbbxXm9UcU
 B2kO3mdpzCq3XwkG21sY1jVZNi9bwiSj1Yc5bWIay8+0bl7TRZd4YvRTrm5wIkV8/6Ue
 riYA==
X-Gm-Message-State: APjAAAW2Piq4RB4iCfLFWYD/YNY2alEKN80kK/fLLWk6SlBSIbcYhLQb
 TfxHpiFpCGcOFph8//LrV2mk38AjC2y6oDNBm42bYd/Pl5Y=
X-Google-Smtp-Source: APXvYqwiX7h4Nt6q2ImQc4jT98d1xT6UcIWp/OTp9E7Nh+d6kVn2kS0NMgls6xyYLIPoovpQHF1vMF8gSlW8+VhvbLU=
X-Received: by 2002:ac5:cb62:: with SMTP id l2mr5978972vkn.32.1572157282678;
 Sat, 26 Oct 2019 23:21:22 -0700 (PDT)
MIME-Version: 1.0
From: Adam Baxter <voltagex@voltagex.org>
Date: Sun, 27 Oct 2019 17:21:11 +1100
Message-ID: <CAChFQ9ThQ72G=7yQsB1eWdJW-4spSTD2oV7qdO-KYrThem=rVQ@mail.gmail.com>
Subject: qemu-img still misbehaving on Windows
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005d8fb20595de6497"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a32
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

--0000000000005d8fb20595de6497
Content-Type: text/plain; charset="UTF-8"

Hi,
I've attached some example files to
https://bugs.launchpad.net/qemu/+bug/1759522 - the bug still exists in qemu
4.1.0.

Thanks,
Adam

--0000000000005d8fb20595de6497
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I&#39;ve attached some example files to=
 <a href=3D"https://bugs.launchpad.net/qemu/+bug/1759522">https://bugs.laun=
chpad.net/qemu/+bug/1759522</a> - the bug still exists in qemu 4.1.0.</div>=
<div><br></div><div>Thanks,</div><div>Adam<br></div></div>

--0000000000005d8fb20595de6497--

