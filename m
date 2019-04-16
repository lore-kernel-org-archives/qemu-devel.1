Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 22:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 653F22073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 22:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqtdICag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653F22073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43633 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGWYp-0007cJ-EH
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 18:28:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGWXz-0007KO-Go
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGWXx-0005gU-8B
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:27:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38649)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGWXv-0005eX-VU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:27:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id e80so1750076ote.5
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=1Cb9TYEDwspChYr592GhQ77iVlLvf6ykAuCajVbUDPI=;
	b=GqtdICag5HCYhvb2mBnBmc074AzuzLr/QwOaxIs5g2ihSzmQM8Rw1u0s2FXP7GG1Dh
	ZZ9YTouyWH1H3qAsgo0/vvVbhv4YgGaghZIuAykMZZTNZ+IuxIWseMwHxg/4sKlGAvuz
	uAcVPxQk6ouM+CxScBpE+gYqgNLNt/2odaGyv6hrYD/aD4CQuNpWsLQPkZqPbROR/rjo
	2erCAlPqSawcW/pdw/Zi5WTqADSdE0q3S76Wh79Mr0GxfSIeND/MsmoR05ejNRlpjL6s
	n9fmK8v2SrUn+YEqdb7UYLE9pQ1GgThaj+2N2QH0xTUsdAOsO3nGXjW3FjDEuxNVhVXZ
	ORFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=1Cb9TYEDwspChYr592GhQ77iVlLvf6ykAuCajVbUDPI=;
	b=rO5cziEIa326M1nTvpykxxbmryrc7XrSNKhqW4Sd7g8WsaScC5yZur95hmW60Bi1Hk
	5FK8OO72LggxZenAdoR253S17hyiZfmyNN/lWKPad5a7foJYyzXZxHnKnkg5M8N8C0Tl
	vqY1BskiTRtfbsQPFZ9QnvTBfHwm4J49tci9Dp30Zol1tyJp4/5WNk8ldiPx4ixOD5Nn
	GO2VQS5c+NFZQn31MeuAN3BebFyATYRpPyAYS+fkNsfr2LjtItb/mojtbPgx2afg3cdW
	OcOoSE8g8nBRpj0d4dhTYbeXg1qekN5+mr5fcV2puKYc2NcapyLhMFL8SW1K3QoGcbUj
	699A==
X-Gm-Message-State: APjAAAXNmR1hJsM32SnqFb/v+eq+vwqT4JMwR+wajCTHHwkJvRuu7PiQ
	kZSpCiNwV6ShToM25qGimo5PCiu9jiMgCXQc29kkVQ==
X-Google-Smtp-Source: APXvYqxAPHw5Co2hEyRhQW0bct+f399ilKvMqxpSFDdZi0XwRl53KZyl37OP0fzfsbXO4PSHHbsaXjNtZ1SMOoK10Cs=
X-Received: by 2002:a9d:3b44:: with SMTP id z62mr55029914otb.319.1555453638003;
	Tue, 16 Apr 2019 15:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
	<CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
	<CAFEAcA-kywfUEZARqzH=obD1p3UsAcsNneK-X0BPpoFnV-QK0A@mail.gmail.com>
	<CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
In-Reply-To: <CAFEAcA_+sf3L5ChBDKEekKb5iTTQZu4mEfF7eiTL78oMDuR16A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 23:27:06 +0100
Message-ID:
 <CAFEAcA84DLEGQduvubsKP-2NrdNkzLcihL2WusZiHReupbF1PA@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416222706.P9vhlBLkYO-bZmk-ngwGV8BrqjkKYVy9myu6vkobyMo@z>

On Tue, 16 Apr 2019 at 20:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Apr 2019 at 18:27, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Having thought a bit more I think I'd definitely like to apply
> > just patch 2 for 4.0. Could people try to test that and confirm
> > that it at least does not make the feature behave any worse?
>
> I've done a tentative merge test of patch 2, which is OK.
> I'd like to push that either today or tomorrow (uk time):
> objections?

...now pushed.

thanks
-- PMM

