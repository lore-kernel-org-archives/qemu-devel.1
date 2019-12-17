Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44822C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F77520663
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 14:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UB0HLqOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F77520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihDgB-0007pB-8I
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 09:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihDfP-0007J5-Cj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihDfN-0003iP-Ve
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:17:39 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36219)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihDfN-0003iF-Oh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 09:17:37 -0500
Received: by mail-ot1-x32b.google.com with SMTP id i4so13941492otr.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UnYmmLv8uqURxotXRriFlkdaR1G27nI0mXWCCGJJ7gU=;
 b=UB0HLqOF/kn348sAx0eCNKIDN25GzKkfHuE38nqhr2FVFW9eHQ4P0k4V5ojVtahr3M
 l+xYLc4MWOlF2XWsOt1hhykdVdS+6TyukYc7o4P4+cYJghNmiQLRc5k4NK45a6wxspUU
 MqW6OaMprEp+DDLdI0lTSKvBaoAlHzRrsJRvow45MOQaN36ZgBklP2cEWVhtGGhZ2e8M
 HqWcMFKP1yaL0wUM45UMzBTSTyphwuv8Xi6qB2LNGpvAJmQ2QZ8KAyRI8t+3vA8oH2sS
 bpRozGRhcatMpzUG6L1WYq8XM5T6hhztMXJCD1kKCcdmyHZSa5mZWoWqRMzWbaScMLVe
 HXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UnYmmLv8uqURxotXRriFlkdaR1G27nI0mXWCCGJJ7gU=;
 b=HGfyGqp+Ec5Eptxq5amDNnkRPWq6TOARJ4y4QLvzCbapd3/dfbfNWyLpjTfNcPMXXi
 BQhLth8W15kWd7/xrUoUuD5hm4VVd6ltOEfyUuUnPOjbodOO0a/dbcTmCJ2XpmdbYBHM
 ApRdhrbArm9L7Yx5l9RxPwfWcwDz//LrVvVskX5DchxCxZKH2aCEPolqSWORZMD41k7l
 ukXUez6835dux9W6lFDkzn7TtId+oXWzG8632gcX4CZPFYaEIv0wszya+KC8wSaa97RR
 DxzGkuejMdUjCtkbPR0iVTiRxn+y4sYEiupcRezE8FZ/KrGmJz1dE4BFq6Ww0z/Zxe4e
 Cokw==
X-Gm-Message-State: APjAAAW1/zqcCxpXjBDgmLMuv6qcy2zlfqmq5KwLhNwUfJV64TRQ7wyN
 BE6IudPUqSfdXgSxDqX9DhYh1CPb+WnCNa/NXZ11pA==
X-Google-Smtp-Source: APXvYqx1pTkeHIkJFPsXpNmFcEz7UtN/AHQRBi3PXr+apJblG/o7+T2N6/2Dlp24NBXNW/zsUjqvPAvSeONqBjUJovo=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr36118493otp.97.1576592256742; 
 Tue, 17 Dec 2019 06:17:36 -0800 (PST)
MIME-Version: 1.0
References: <mail.3cd9c49a-989a-40c1-b627-b2197ff912ce@storage.wm.amazon.com>
 <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102016f14331e64-fc1b813a-187a-4ece-9c9e-8f78ea832fe9-000000@eu-west-1.amazonses.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 14:17:25 +0000
Message-ID: <CAFEAcA8hXW7YhfsF60-wdzOHHf5e5yO9-bNSTWti9Z5kvJn4+g@mail.gmail.com>
Subject: Re: Vote against removing the bluetooth subsystem from Quemu.
To: Andreas Scheucher <andreas.scheucher@otaya.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 14:13, Andreas Scheucher
<andreas.scheucher@otaya.cc> wrote:
> I found following note in the Qemu documentation: This option and the who=
le bluetooth subsystem is considered as deprecated. If you still use it, pl=
ease send a mail to qemu-devel@nongnu.org where you describe your usecase.

> As GPU passthrough is becoming more and more common (to run Linux / Windo=
ws / Mac OS X simultaneously on the same host to prevent multiboot) on desk=
top systems, support for the use of the host Bluetooth device in Quemu VMs =
for sure will be a common use case: https://www.reddit.com/r/VFIO/

> For me personally I just want to set up a setup supporting Windows & Linu=
x to use the first strong nVidia GPU for occasional gaming on Windows and v=
ideo editing with DaVinci Resolve under CentOs.

Hi; thanks for your response. It's not clear from your email:
do you mean that you *currently, today* have a setup which uses
QEMU's bluetooth support; or do you just mean that you have
an idea for how you would like to use it in future ? The request
for users was really aimed mostly at finding if we had
any current users, because as far as we could tell the
code we have at the moment is just broken and doesn't
work at all.

thanks
-- PMM

