Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D99C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E19E20768
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 21:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1xnXIzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E19E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq11I-00043X-El
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 17:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jq10S-0003Bh-B4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:08:00 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jq10P-0001aC-Uy
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 17:08:00 -0400
Received: by mail-oi1-x244.google.com with SMTP id s21so15597562oic.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=P0sC1303DHIgqwmSuo2kDjh0PYJIAmblyh0uELq49Ls=;
 b=m1xnXIzFEfNO3XnhH4rzYQFRmXS4kn4ilZ7d/2XaTk0UMtVfdiltD2yaqjEq5GeFda
 jFVe4ADCstF5Pnnp3eQ0wxCao3yx4MK3plOQIXU5MxwXXzmzFbceeaGH0XYjooFeqHlh
 F9SWSccmGJYsPhDOMfvn71qXREYn2kpImM7AoaMQRB7HSvFSorCblj0BLk+u/xOcxVrL
 agchxgK3iXTNXDsKA7dfhTu9xPtOS2gbixMVfM7CNCC8HG203vo86NpMvHIrnvvj1abW
 gN/lmrslk0NQetaUX5P7+OP/NzbtsRdN3wMR4XlQEVPkDNcvSS2Wx9M2grTTRNEFQW5G
 2ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=P0sC1303DHIgqwmSuo2kDjh0PYJIAmblyh0uELq49Ls=;
 b=XLEHfXIQfKbOGzXogWTXS44Aztd2hyRvgdacEcPBt1jwfH38WQMc87buD1lEwO+MEf
 XQpjI8Gpc3mxVpGEf9NdFyprdShuv3iI5RzF0Qhs5tnFDFxU5y96C/TQN2ZRo78BUN1x
 zv8psOanNtmwgtMHS9eb5l11EGdkY1ZEM3Kt7su6/7+0tbWLPUuqHSNe61aJXru17/Hr
 Vt6dcHoo0qEzcVec3iLgsR0JvqHkkeP56AIFj383gUSHzqwoOO2tAH1spqlORuA7eWYx
 r5ehfIIfQc1TroVmVqdT3LcnAi/xzqYeaTbnKJXBE0+7gdk/EacUA9p7W0qJdSX9lbVp
 uxUg==
X-Gm-Message-State: AOAM531EnV4KaHISXo3/CiGFW4Qne6v5usvO0147HcXuviASfLM5Fx0k
 8YYrf9M+1XVuvs7PYvte+/ZA9xlWhVpTDQGl0A+hLQ==
X-Google-Smtp-Source: ABdhPJy4Oc1F10pMyyfALI7KBCbmjZPuo4L8JBBf2rUNdNCT/pp4TI3T3jmJtbf1gb0UFxjLFkz7yANm56QhGEsSBX4=
X-Received: by 2002:aca:2819:: with SMTP id 25mr7850835oix.48.1593464876587;
 Mon, 29 Jun 2020 14:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200629074704.23028-1-f4bug@amsat.org>
In-Reply-To: <20200629074704.23028-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 22:07:45 +0100
Message-ID: <CAFEAcA_uAJzddqVfttgZ9PjNfbrjt3q1=HaTwRNPs+=smrDkjg@mail.gmail.com>
Subject: Re: [PATCH] hw/misc/pca9552: Add missing TypeInfo::class_size field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 08:47, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> When adding the generic PCA955xClass in commit 736132e455, we
> forgot to set the class_size field. Fill it now to avoid:

Thanks; I've applied this to master since it fixes a memory
corruption that affects all arm targets and I'm not otherwise
planning an arm pullreq for a bit.

-- PMM

