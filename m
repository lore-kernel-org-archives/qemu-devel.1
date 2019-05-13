Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A97C04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:07:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10AAF2146F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdIO+6AS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10AAF2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAfd-0006no-5W
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:07:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQAbE-0003DN-8t
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQATu-0003dv-K4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:55:04 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:35620)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQATs-0003d1-Ps
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:55:01 -0400
Received: by mail-ot1-x32d.google.com with SMTP id n14so4664960otk.2
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=lANA2A4KU2VF9Qo8bQhqs9WDxzYC3cC60ozvv/Pjl20=;
	b=QdIO+6ASw2ItWygJTwCWopXoRHehykjkVIkjrJpWWs2IysvgoHJStspmTL9IPrm/lm
	e6smslRtsunM5jcXsZDDQVi1TtzpCnhFdtiDT/ndQzJLtaO5LT1n35//ztScHgD8XgDu
	komaL4Rp+b51FS8l0VnCTByTWewrVtCk5akVL6BrcfWMC4Tkhy+jwXTrHCOHDFTv3X1v
	tbqNbVG4/VhnZvCx8pCd/RQVk+4dZ9H61+kt1e1pzjlTC3uRPmfDxUqSJ8e/elADYibc
	iRDZZ/MR4jWTb4Cgjc5vCn0TSE2hVeLx4TXJ5RWjIsX2rx5k8SMfVFZ+0bRhKUVlHr9f
	zP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=lANA2A4KU2VF9Qo8bQhqs9WDxzYC3cC60ozvv/Pjl20=;
	b=gP1AaqCjSAKY54irVUZMOEafvJ9WKxJW2Nm8YHPDDC4XOK1ywDQV+VEdam3adCnHpY
	QXuNayyRq/uda7evSsubNunlCC1HAwYV/eexXdiR1x1GjtG+TQCABb19tzpvonI4PlaY
	rFFEwfvhz1YQSQ9A2l2CtreqhZDfK/Bm1B5ZOIUh9UcJN03VaTCtFZHS5nOa+ej48Q6c
	6YAEQTnUcmhId8NaU15dCl4DjJsjyVoJu0ke/03+jfLww/jBtpVCdXdaA+evVrFnyyDF
	5HMRaHOziCEwr1YSIXjcfnuCBR49rL5hBgD+AYZhE/JuL3WxpA5QLJEpEcR/WcZlCQBO
	5cuA==
X-Gm-Message-State: APjAAAUOtsyyP0OVGI/afoaTRxXDRQ97M6+Wi3bk18Pg0PYhZu8BAZ7H
	RGPC67aXWEzesPyR44m6t3QLgl25ENAnY9/6WMYjug==
X-Google-Smtp-Source: APXvYqypt/66aOG43o/2Va8ASjGrtpfrdqooVuK3G5w132sQ+uVPWQuweCX3sWKm760o4Poelhcw6QiOlAhSdlz6BmY=
X-Received: by 2002:a9d:2002:: with SMTP id n2mr13351812ota.363.1557752099541; 
	Mon, 13 May 2019 05:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190513065310.10263-1-kraxel@redhat.com>
In-Reply-To: <20190513065310.10263-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 13:54:48 +0100
Message-ID: <CAFEAcA9CFFx6M1f93NV631RSd7gt3H32PPWJz_5qJAyfcy_fMQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 0/7] Input 20190513 v2 patches
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 at 08:13, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 812b835fb4d23dd108b2f9802158472d50b73579:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-05-07' into staging (2019-05-09 16:31:12 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/input-20190513-v2-pull-request
>
> for you to fetch changes up to 503591cb6c28c3ddbe38ea50cab2f0dd3d6cd929:
>
>   virtio-input: fix Kconfig dependency and Makefile (2019-05-13 08:49:30 +0200)
>
> ----------------------------------------------------------------
> input: add vhost-user-input, virtio-input fixes.
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

