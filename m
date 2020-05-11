Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11920C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23B820720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ICg2Bn+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23B820720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5xe-00066d-1b
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5wX-00051V-NH
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:45:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:40215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5wW-0000Fj-AD
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:45:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id i27so7120609ota.7
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OwN6h8cya5X49/nSuJcvJ6u0elsZNdW9pQzkzZsOhbM=;
 b=ICg2Bn+wU2NdqbZeGk15rfoXq7Ouj3hLdtP3+0X5++eP3kqMgt7eK0Ge9as6BZMJ2z
 IaRNZm46CfIZzsky6qCE+acLvRUt9kOa8bvlEFTb2Ohzuw6xOCx5fzL7BoLI/dEv5lIj
 2Cpvf1wZywX1+i4dp/stv/eROtW3pNl7y6WzCzIfs6GC7NWhjcO1jwN5sE9rX9uT6zV9
 BAe32bRIffY3KD0+403m01euVaDvnGjnzW/1xrZwg40hfZaHQaWZuSvC0jbTyuMfChVh
 jwlNbl7qkEGFi5wQV6Gv1F0OJ3vLZHyf/iGClhyEyylRBoOURMYIyUaUiGxXCcuiHcMY
 QxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OwN6h8cya5X49/nSuJcvJ6u0elsZNdW9pQzkzZsOhbM=;
 b=NBuytY2NECCoQWXmbeWh/x034GMDxElyVuJk1hvwVQ5xHkQYvedHEwuzZXvOQA5G2p
 ATxe3xPawaO+kigoZ7p1a7OxU+bgd9Em2keSJE/0V+aGXQOVprBMC5pWOrc8K+5j65n5
 iF0K5fqNyw+RFRLj6xh/5WEv0KWhy4osau9syJf+h57Zzfhn9UDWloQ0at86sOnXH7a9
 yjp26xhZRSGUXvaxzaN+Blbs5zKY0tG9j4+bBToI9tw8YGE3IlRlVSNJWlA/e7Uzl0sx
 T13cAVltHUFocrA9fovr6XB5B6R2sWKTgwTsa8OHGUX7NpkfcJVv0XG4eIb098kguqZI
 LHtQ==
X-Gm-Message-State: AGi0Pub2/v0+b7XnPkA/nGquFKA6Kr5yLNJOVjI2MTJ75eD+t1VrMd1p
 IzzwZuXzjfqBsRXjERU66G3ofGjALBCTIyj3uHLUaw==
X-Google-Smtp-Source: APiQypLKQs/M38WHSIWCwOjgXJ9tKRgtjt5JWqeVTONoj08tkP5BgUASrTsJ26B+wC9gOsYyTCQyG3xpywBoE1ei4sc=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr11919432otj.91.1589193950984; 
 Mon, 11 May 2020 03:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200504072822.18799-1-f4bug@amsat.org>
In-Reply-To: <20200504072822.18799-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:45:40 +0100
Message-ID: <CAFEAcA99uztOyAODdb=oGo7XM45dj-uWY6yiMW2LBACQH5=GUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] hw/arm/nrf51: Extend tracing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 4 May 2020 at 08:28, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Few patches while playing with the Zephyr Project.
>
> - better display of unimplemented peripheral accesses,
> - better display of timers use.
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/arm/nrf51: Add NRF51_PERIPHERAL_SIZE definition
>   hw/arm/nrf51_soc: Mark some peripherals as unimplemented
>   hw/timer/nrf51_timer: Display timer ID in trace events
>   hw/timer/nrf51_timer: Add trace event of counter value update

Hi; I've put patches 1, 3 and 4 into target-arm.next as they
have been reviewed and are independent of the unimp-peripherals
patch.

thanks
-- PMM

