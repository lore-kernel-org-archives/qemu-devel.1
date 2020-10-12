Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B614CC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1581F2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="upGvzAnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1581F2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRyI3-0006Ut-4A
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRy7I-0004oY-Ct
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:43:56 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRy7G-0008Qz-Mm
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 09:43:56 -0400
Received: by mail-ed1-x542.google.com with SMTP id x1so16990540eds.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 06:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=s0bN5sJuFOp9u6T3ynvKwBCLRMeAQ1tWBzQTPfoDhkM=;
 b=upGvzAnQ68nAdVyQ1fJqtgTN+PzWX4kKSDR0osI4UwsdXIj+OUoXX5rXwtZEf6hWW9
 sTQ9QtOTooDFvaApWEzkpw8e75A1HmA4isMDJlrvi13Fw1qyMkU7LEQac1gQFt1pH+Li
 3GRM9B8nPuej3gE/zlLMirpa00z1azPpMejXRzDeqG8tqR5xmYbXRvKCMI2fhidjLqXM
 WVi3oFnrKjHeusIebXStgIi4VaRurzRT+LmVLDkqTxgnI6a8n4DlYvCoiLj/71BqRx8G
 KOpy2MaTcBHpDQeC4I9HayShZfFSA88kWpFEbU4eays6ffbbhZK1XJ/S/bkDcduDeif1
 D+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=s0bN5sJuFOp9u6T3ynvKwBCLRMeAQ1tWBzQTPfoDhkM=;
 b=Ql3PzFWhOzJd2E9xN+dfvlF8jDHWTaw3AtXMhgyaeyMOSbh22hdy229l3M/sRgk1Hh
 bGnq1AdnmJpePpgI1imK5luWhbhKMWQqE9DtPSWTG5iHYschJg80sh3M8nYlxoRZqx7N
 ypjwZVt+2x89SaOuSmt4pmFONOC4f8OLTGfUTegO6rxhEaXFjzKZaAYRTAdOtmhhwtqu
 0poCUZMVvGok0OGqNGuNLd8fpHobEskax8zMPI2Qx7JIBznd0cGFMRJt5GsZkzfQ6Qcr
 px1e224740r4S8lrv4MHFwHGH+7fleM0GW5vNAau3ZgVo8VNPz5Ok5gyvT4Xr0/td2HZ
 38Kg==
X-Gm-Message-State: AOAM533FUQ07mA3OTSdTbZDrQt0p9INjvdMuvN13Au+85jYZbiTpNCfw
 csS0lJKiGCZtXh+NLFmyLFPS3tDbfGSpZ1RTHUrNLw==
X-Google-Smtp-Source: ABdhPJx0b0I7F4FzqWxKiSCxZFw2TuVkFu6wVK2bUu74Hc7XIBSOoXl6Ry5A3mD7bTKP7POHHBWysBMDHgx90087urw=
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr3068255edq.251.1602510232845; 
 Mon, 12 Oct 2020 06:43:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201012132017.3423954-1-f4bug@amsat.org>
 <20201012132017.3423954-4-f4bug@amsat.org>
In-Reply-To: <20201012132017.3423954-4-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 14:43:41 +0100
Message-ID: <CAFEAcA--bNZGyYyHMJr+yCAtXYepf6x641Xr7VuhCcjBF14tCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] hw/pci-host/versatile: Add the MEMORY_WINDOW_COUNT
 definition
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 14:20, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Note from Peter Maydell:
>
>  The versatile/realview PCI controller has:
>    * three memory windows in the system address space
>      - those are represented by the pci_mem_window[] array
>      - mem_win_size[] holds the size of each window
>        (which is fixed but varies between the different
>        implementations of this controller on different boards)
>      - the device IMAPn registers allow the guest to
>        configure the mapping from "a CPU access to an
>        address in window n" to "a PCI address on the PCI bus,
>        and our imap[] array holds those register values
>
> Use self-explicit MEMORY_WINDOW_COUNT definition instead of
> a magic value.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

