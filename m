Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA21CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF282070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lp7KW+xR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF282070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuPW-0006wJ-3s
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNu7c-0003kG-7N
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNu7b-00082K-6l
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:34:56 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33306)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNu7b-00081w-03
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:34:55 -0400
Received: by mail-ot1-x344.google.com with SMTP id u13so1360306ote.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XP//ryC5zdvWs+33gGGnpYah1Dow+rivue6x0IfqQuQ=;
 b=lp7KW+xRYk4T5+j8gUO0S7NXqcQ2uAct/CDr+DUJQ+5FQiXCJc+45lzUsoUufLtfFr
 uWdkrAe2Q/xrOM23gVMOkYzaN0dZ+knqXPvWXmOFrQTZvO2QE3chRbt04BuAtrH+MNiX
 cc0l0QkWYL02dOQ00fVyGBhNPjHft2QIyMTpAvo7Hhg1iwWRNFdDNNyVS+98PUV+KKXU
 CQUtwP7xH0HLFQrx4Sqyc1d8MqJR0o7aHzr/2rv52vWF/MQvE9Ov3vPQCZBeVXNAW/3P
 +wQAzXtALS63A5dmGD6lq+vagCG0SJcwpaE72TgLwLwCmhlxDlJOtL2TrNW4WjkPN1+Y
 aD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XP//ryC5zdvWs+33gGGnpYah1Dow+rivue6x0IfqQuQ=;
 b=SexCsZqAgYYWXzS43qmjZQv27BsoUUgJmtll0w36sJKZsJG+qxu5+175KocbPSWqsq
 2+qmJvdCeeuq+AyJMvWerDU3x7Eq57Pc2CQCuDSFTto8LZNwNIe96edSb31iOE0lJCPW
 oeZpSdpTSbSCnPWwcvyvoNkmBkK2XPNee82twpn4qEkj+utH3kWfBSY+LHXHA4V4ZOhA
 ksFN7wOt2R4tOZy7FrUo5QWZwayzOpwhqweD1Uz6paqYaBeDBQ/a4fxvmoZdftqQRMkZ
 uySRedB4LrdbaE/GR5mKpymQ1/FUdaw7f+Kz5LESiuTjoo7zGLAWBO8nhtDpr9jRU6y6
 XrjQ==
X-Gm-Message-State: APjAAAWI1vTaMuQMlL3ukUU9agrtB/wrpsaXCLSrx2Uu1KwfQVWXYLqM
 F0SH/X+A6p2Do30sdVZDDcK9RLXhbTcwFpWOmuc+wQ==
X-Google-Smtp-Source: APXvYqwLxf1k08ZHjGcIqi0dVBvgPbqTR4ZL3ikmiCRLHCMyAhlc32eODjGXYiYWONlDZOkSkCCGCOZut5bCGDYBV4k=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr1622740otd.232.1571988894396; 
 Fri, 25 Oct 2019 00:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191019234715.25750-1-f4bug@amsat.org>
 <CAFEAcA_WTyJ2AWZfKQSipFmn46ztG1XTL9sE9P2QDD7ob-FKFg@mail.gmail.com>
 <CAFEAcA-0qg+VbE6VQpdCAX5g6=GzZG18j_FoiamHR8YrKHrmFg@mail.gmail.com>
 <345d8200-6b8d-2708-ef16-c34698a5bd9f@amsat.org>
In-Reply-To: <345d8200-6b8d-2708-ef16-c34698a5bd9f@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 08:34:42 +0100
Message-ID: <CAFEAcA_Xnc=barPvVe5=+KFdo5ibJdmuqRkX21zZ4a9n4q5Wbw@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] hw/arm/raspi: Add thermal/timer, improve address
 space, run U-boot
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Rob Herring <robh@kernel.org>, Matthias Brugger <mbrugger@suse.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 qemu-arm <qemu-arm@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 20:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> In my patches I stop using system_memory, each CPU use its
> own AS view on the GPU AXI bus.

That seems an odd thing to do  -- is there really no
common baseline view of the physical address space
that the CPUs all share ?

thanks
-- PMM

