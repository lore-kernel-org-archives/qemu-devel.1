Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E06C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:35:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E12F2073C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1qvsYpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E12F2073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnjS-0005w9-7g
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibniQ-0004s3-Ly
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:34:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibniP-0005c2-Et
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:34:22 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:44362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibniP-0005b7-7M
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:34:21 -0500
Received: by mail-il1-x144.google.com with SMTP id z12so24345078iln.11
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yWx/sBpLVO3XZKtiD0Otn7MVG0ze2/ppcE5uUV2W2Ns=;
 b=u1qvsYpyp4OZju2Gl0iBTjdd38gaBQNK971DlKXb0RifqrI5Mxeycmn9xvIZECeF0E
 KVRSlnCe66vW7su6GM6qAR0XURQqecrxBMhab8RH9accCeGcngdWcskXvAQ6URUPPK25
 bnBoHkZXlXoGi5fLZlptTeDYCk880OxIL1+t1udfWKILGOZiyClzN3ChiQxvhkXGXMIG
 0+TzhH8lEnK+qsqmyGKhP3rUY15tCU7pGrsu05V6D3ikQMLbWlu+1jf/j24UdLShsclR
 cjQgacQtX9A3z+BBOLwJmwpuMM5jKSaHXbm6MuHW/GuaPRUykQ0Qmb1o98TKq38BIsuM
 Aayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yWx/sBpLVO3XZKtiD0Otn7MVG0ze2/ppcE5uUV2W2Ns=;
 b=D0pj5i9m8QFnlnlhAJyMRTkJIGJh+uXtxtkHj+MOCpC/RbUI0dZZ8fUBuBqHNkTrkP
 he+rfXdwq4+ehnjK9gl5vbJ9OEEwVMIMB83uSbci9mM7wRZoHHopp8g32pmcABAD8iXt
 mQJY9fB+9WlVXdIYfswC6q9XxxwlXsTYHJz7n87gBgKv5S6ZVQB02zJPPM0zLyLarj0s
 yvGW0MNotVkKPHviCTQPiElwQRtt0UhzJvokcgVMxq2DrD2mlHbaIYk7OPhQKy+aZCPU
 ieLZWnG/aYspMlHMTyZYUNbe+GHiFw9OGs1QqrKDxtOh8yO9F06n/MUuAXrDK4TxYBFb
 Krfw==
X-Gm-Message-State: APjAAAWR6grBXafrfzdoNnPa5yzoZ1OAb1Co9JnVHU9z2yxRShpjZIyq
 eOgy3AdoAByFubNP7don0bhoympbym9R+xxMsJyvoA==
X-Google-Smtp-Source: APXvYqwNg5yYZGrgVw+hKzqyGiThnJXCrskDZLq+NX1JMfu1seuV6QgmDe/nYzTtN4IMXDa7IftCzAcbx/qmslpqLaA=
X-Received: by 2002:a92:3d49:: with SMTP id k70mr15076543ila.246.1575300858807; 
 Mon, 02 Dec 2019 07:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20190904125531.27545-1-damien.hedde@greensocs.com>
 <20190904125531.27545-10-damien.hedde@greensocs.com>
In-Reply-To: <20190904125531.27545-10-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 15:34:07 +0000
Message-ID: <CAFEAcA96yu6Uttsi6eZokjyxE8At18ADF+Q6c7Na2ArvdLME+Q@mail.gmail.com>
Subject: Re: [PATCH v6 9/9] hw/arm/xilinx_zynq: connect uart clocks to slcr
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Sep 2019 at 13:56, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Add the connection between the slcr's output clocks and the uarts inputs.
>
> Also add the main board clock 'ps_clk', which is hard-coded to 33.33MHz
> (the default frequency). This clock is used to feed the slcr's input
> clock.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Nothing obviously wrong in the body of the patch, but as with
7 and 8, review from a Xilinx person would be helpful.

/* board base frequency: 33.333333 MHz */
#define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)

This is interesting, because it's not an integer... I'll come back
to this topic in a reply to the cover letter in a moment.

thanks
-- PMM

