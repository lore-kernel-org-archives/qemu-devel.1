Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A39C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7369220770
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 13:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOB5HICd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7369220770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECTF-0002ZK-Ig
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 09:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jECSQ-0001n4-Cg
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jECSP-0002mx-D9
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 09:40:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45500)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jECSP-0002kc-6d; Tue, 17 Mar 2020 09:40:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id t2so15666165wrx.12;
 Tue, 17 Mar 2020 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9gHz5sI1z9ZOayv0KlbJkvhXH6M2nXHRZkzOTpi8kNw=;
 b=cOB5HICdJ12suirZFoxFXDcphClMM1z7+KrZ9DKfUVkuE+WU7P6MBSm1cP+yrIFtTx
 yavT6D3fG8LHXRJEHiuE9PeEcE4G8UzQkPOKvwwST0AguAz5U0XgWC03rzDEz0f8g4+Y
 xq2k0+mACriJibfw4Fh7XNK1+b38B58E9TkULEGZXD1bOkAuWk4JCEMqW//1Fmqibjp4
 poSCbXtfLjcYIiijHcZDwWdvZY7V94T/6ku8xb2CtIL3ZKBdslRQ4PzZw9iyiToAtaNs
 l96nt/EvProTnFjIDy0Ov3J8F3LCnRfkgGzXQbx24Qhew9Lpz1LQTg5Pl9ibthXmVxO6
 gmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9gHz5sI1z9ZOayv0KlbJkvhXH6M2nXHRZkzOTpi8kNw=;
 b=NwNfjujuzkI96YZMqUrSkLDs/VXU32ilqctaw0307onnURVbVj0UXL+4zI48eoEHsY
 wbM2TNv0G/L/t5Etw6I3y/l8EEOIk1uLA3dCbHVQKdB59Xx6mdSJ/YQAI3EuNlqKZ8mY
 WI/MBesjNEttSaIgwRoeCGz1WbIETdO4IGzDfZpJXa6gsjsFeCj79g1sVajrPAwGEMFh
 ZDwUyUnhhuknURKrsUV3RGbQkrJbqtdvE+IYZxF7b2LD9J22mwQIdkqcbAbSuJdIUQvY
 QHbN7reelyDT8i71XnnmSmqbec3oNhemE+C8XCpQsQ8ltNQ1XGxSEa3vqlIUIBdpXfYl
 GejQ==
X-Gm-Message-State: ANhLgQ3+Aq1DxFeEbXPJJjDLFIM7JbC8WM83QtJYqHlz6hwuFYzjZIxW
 oEyyw0MuetM+/5aybwe1WBhEvvj3hG8/MQ95gbU=
X-Google-Smtp-Source: ADFU+vuFpxKAIWvRFkRAkeAELLidx4QrvfJu+DRzoXlK2YfkEUlUjd0uH5a7EOy9hH7IcCT7IWX8SHS/cfd8OHDnrkk=
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr6098752wrn.420.1584452430646; 
 Tue, 17 Mar 2020 06:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-25-alex.bennee@linaro.org>
 <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
In-Reply-To: <3d01f357-eeb6-7fd7-1895-feae05beca99@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 17 Mar 2020 14:40:19 +0100
Message-ID: <CAHiYmc4rPZrLkXP8D33yzvfb1Xn1CjMJHDXYA+W93R=Oe+RF6g@mail.gmail.com>
Subject: Re: [PATCH v1 24/28] tests/tcg/aarch64: add SVE iotcl test
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> > This is a fairly bare-bones test of setting the various vector sizes...

The title contains a typo "iotcl" (you meant "ioctl"), but in any case,
as I wrote in another mail, "prctl" is the right choice.

> > for SVE which will only fail if the PR_SVE_SET_VL can't reduce the
> > user-space vector length by powers of 2.
> >
> > However we will also be able to use it in a future test which
> > exercises the GDB stub.
> >

That is interesting. Could you elaborate more on future tests,
I suppose based on GDB, and their integration with this test?
(if not in the commit message, than in the response, right in
this email thread)

Thanks,
Aleksandar

> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

