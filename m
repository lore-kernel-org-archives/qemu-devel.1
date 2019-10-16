Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C7FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:33:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDA3F2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="FALOGVTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDA3F2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKhYL-00049g-Oa
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 07:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iKhQG-00063v-3N
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iKhQF-0003nZ-6C
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 07:24:56 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37870)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iKhQD-0003n6-6j; Wed, 16 Oct 2019 07:24:53 -0400
Received: by mail-qk1-x744.google.com with SMTP id u184so22373274qkd.4;
 Wed, 16 Oct 2019 04:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ezbudHyz+ciaLuc8AlZnUmQoDFo0/hkA2HkcuRJ623o=;
 b=FALOGVTVO2eaiS9HFLoXHHIsVVyOhxgs/SSzjOWuKS3L1xyYQIOrSXkGmQ8hx0LPQ/
 TMNBiTuuM//5Buri6xaws0AwERSbaUi1D/B3jhqox+ne++cObsYDrNIlgi7kFjIpPydx
 4li9tgFAzovFdrZHo+KTxECfMfyuzMJdvElak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ezbudHyz+ciaLuc8AlZnUmQoDFo0/hkA2HkcuRJ623o=;
 b=I+C/dKIjRFuyl4fY4WScIcFTN7UG0CwUJSa4bJ37yOpctq2CPgkxxLl8PRtjYIXmAd
 QPR6FOHvjmre2IPh3gBFnPdpPQtWlcBBskPzaICkyUXvnISMb2IYa2C+DH5ccJrkMgK9
 oSuYHaTMrqJ6/9B6rn3qNICbbr2a/0Qs4wNAekXbufrgl1l1PKWUxEaycsz01XT4Emxi
 nn+Qiv86GWQbSn5SFqAVA/ZhvGwtqXeAduJuZsYSXRmoJ/PlilC7swSahksmxLcRC/nK
 fdRPzGb/fMGpNXWz6jyLd2jHrLzSsKFz6x32qzY6FiRQ9SPh1tTGOHazveUlqSDeK6UH
 P4Jg==
X-Gm-Message-State: APjAAAXUtLCL396XF+Eb3VltQAt+T1hY8y0PFDoAUIBt9Ej57t2a1Crm
 TX+6LVGfywydq27UjpoD7dC3h0tbFHTlFvtCycY=
X-Google-Smtp-Source: APXvYqzOkwRT5F6dWdiqkrcynmKxddNB1TuHiJIDIZ3ih3u9zyEA8uMlPGpPWWEF3A13XuY1xhlhzOQi4lsr5DUtzzQ=
X-Received: by 2002:ae9:e30d:: with SMTP id v13mr39741353qkf.208.1571225092489; 
 Wed, 16 Oct 2019 04:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20191016085035.12136-1-clg@kaod.org>
 <20191016085035.12136-4-clg@kaod.org>
In-Reply-To: <20191016085035.12136-4-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 16 Oct 2019 11:24:40 +0000
Message-ID: <CACPK8XcUv+wj3Jv02YGrLW49nSWcW_h_7h+TUL6SEqpnwZb1kA@mail.gmail.com>
Subject: Re: [PATCH 3/5] aspeed: Add a DRAM memory region at the SoC level
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Eddie James <eajames@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 at 08:50, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Currently, we link the DRAM memory region to the FMC model (for DMAs)
> through a property alias at the SoC level. The I2C model will need a
> similar region for DMA support, add a DRAM region property at the SoC
> level for both model to use.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

