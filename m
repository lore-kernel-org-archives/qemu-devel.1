Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF61C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A8FC20791
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPI4Q1MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8FC20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6gQ-0007nk-9L
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX6CY-00049t-Eq
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:22:35 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX6CU-0000ay-2s
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:22:34 -0400
Received: by mail-ej1-x642.google.com with SMTP id qh17so14765974ejb.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vxAv0lWoZx8C5WFTT6h0MSryuJV3P7Oh2D8vRQwO2kI=;
 b=UPI4Q1MBnMT52SoAnYtuQIUZqhJm3/7kRo7HTBvXsa+HOYgzcYneyanCv/dRS2iir9
 iOwJ7gURdOqNU+UMZZh4kRrlYGXTka/WehLQBbhBAU6RRP+LlY8grkFM5mhz0z8aC3JQ
 f7PW0FyNEDcnTpvgwKp9D0Mgxw4rmvEsE2p4Net7JNA6E+vmXnUo9NWVB2mE1YmnArVr
 6ot8fmErY6Bb2ljXgRCzcK+qIUKQZv94OMWHDPRthex57FgCN1fQyW552am9bI9z485v
 N0a7TaZV3dlNHuQY+4TTl+cqtD8e8zbOsm5Noz4zMq/A0dg/tzTcTzVBz769cCBqJbXD
 aVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vxAv0lWoZx8C5WFTT6h0MSryuJV3P7Oh2D8vRQwO2kI=;
 b=GVlpW+Brw1Lxhz8Vao5+7i06zCNoRy9fG6dU5of4KMlNbOOK5tCvRqREmi5gC8Mc7T
 FRCC2nVzJ322iLTHoPJ1q6u7hAAa/zvRBnLmUnE28814KhgB/wCCyecLL71gGShk8ftn
 KoNgqCRCuOlYl1mOZOQ/j1ClHCm2QsxPKO6UGHuYGbnoFth7hqApFiaz1spp4Ede7e6r
 uE7eKuaFda5skKDDhRl0RxLMe+Bb2pISXmZV7Hh5xi31X1SVWc7LhhjRXBFaWF1NYZjK
 WWZ0wPG/NDul9aIybEF6fEknY9G9PW+IMgA76Wof2QXkVJ07qyt8mzoPG3L+LZ9WCQ58
 o+Cg==
X-Gm-Message-State: AOAM532hx28iqW1hBjsypdsW2ZQtCQejqs+6T1g//OxOWBdqBOmwSA06
 Q/s906Mrtt6kq1AeYLw+067LExUm1Sy6jLHqy/He1g==
X-Google-Smtp-Source: ABdhPJyedP9nXgvG5n4TwqIDF41sDyqy60siuzsmSdlhFHuCh/g7EsV1zL1+LjNNpv/o3X4ZonxcWC8zlmeIfUsEsjs=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr17396696ejf.56.1603732946895; 
 Mon, 26 Oct 2020 10:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201024170127.3592182-1-f4bug@amsat.org>
In-Reply-To: <20201024170127.3592182-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 17:22:15 +0000
Message-ID: <CAFEAcA_-HXBcS4qEcJ56uKv0-9jUetMDHz3-2=SqS_GssA758Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] hw/arm: Add raspi Zero, 1A+ and 3A+ machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Luc Michel <luc@lmichel.fr>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 24 Oct 2020 at 18:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Add the raspi0/1/3A+ machines.
>
> All series reviewed :)
>
> Since v3:
> - Addressed Igor's review comment and added his R-b tag
>
> Since v2:
> - Rebased
> - Addressed Igor comment
> - Added Luc R-b
> - Added model 3A+
>
> Since v1:
> - Use more specific machine names



Applied to target-arm.next, thanks.

-- PMM

