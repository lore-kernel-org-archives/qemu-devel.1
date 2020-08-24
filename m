Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9AC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 622B923100
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OgPqRw/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622B923100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFUS-0001iJ-Mk
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFTp-00015r-65
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:37:57 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:36166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFTm-0007b6-9v
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:37:56 -0400
Received: by mail-ej1-x644.google.com with SMTP id l2so6712416eji.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GJbQLrEXPHCF0Y7PvVokpWg8WvCHDJRCiTpLjr/3njY=;
 b=OgPqRw/Z42g9Ts8PU5GHHEVabIOtd/MmD2vtswrmrKbiVY/7TZfEDClJnl8zB5jgJG
 Qnw5TYl907QJWg3RpwFLnfE6ILHyHKapN1D+QCd4afJgoYF5aaMcfEwuuL7v2u1AAqAk
 cxmKrIHYbL+upztG96AIWGrELGmxoIZQ6LUu9NszLIxu8bvpTyoF033LG4aO6Oplwr0Y
 /LUAicDTM01Kfx5HP41mH3l1dHCKe0JatUy1M5svp672dMR57j83N3wV2gLWygvbR8rg
 jK9c8M4mN5ZiEvHF8j9Z17pWZ/UbiA8XdyHtwpZeU4qydOZN4hE88C5C9EeBDCrDnXiY
 fSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GJbQLrEXPHCF0Y7PvVokpWg8WvCHDJRCiTpLjr/3njY=;
 b=GvkvJXeXwKEV2iE6NUhns4S2bd9rV05wcrph0bapr1ymjsmmc0Wr+bmxJh3SL3qJrD
 XWW4Y9WsXneUwAX1+aizPKtGGTCNUKVpdBh/WvndQFK5BCSy4sRUz0tn4bgGFHF9wSGK
 8VUG2fHuWkmL00UQyWzKiRVmgNiZk4cm44Jq5vqOFWPwAIMhSalEn1yDWuLS9Xg4hDvQ
 Cs85m4klj9tY2cJFJCp9Rbjqba4ZQMd12BlpKEHONcwBBuQQvyHmW3DANBzbgQafeJ+b
 e/yrgKwtr1WjPrcl6aSmIOHjpSnTcCeMLCXcTmH+YK4t7RSDLWvlyKXMufDrF4WqSDZu
 U21g==
X-Gm-Message-State: AOAM533TxuGIHqgBo7bmeJYXUvWt30DjjrbmowG1Oy51TQa3u/6lad2C
 209wyQufO0S25dHyGlLr63CXo1xfNAfiFAL+m346Vw==
X-Google-Smtp-Source: ABdhPJxwM9ioYRUe81l4knMIK8r1ZkwOsHlQdOG12HsgQamnaKuWHiTtSRCZPkO204e/WALNTf0rHCn03wEtrx05lgI=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr6352924ejb.4.1598287072971; 
 Mon, 24 Aug 2020 09:37:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200814110057.307-1-f4bug@amsat.org>
In-Reply-To: <20200814110057.307-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:37:41 +0100
Message-ID: <CAFEAcA8E7OSD2saeZVvh7tn6Qs=qchH+kxSD9COULdiMJsaLng@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Aug 2020 at 12:01, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Allow the device to execute the DMA transfers in a different
> AddressSpace.
>
> The A10 and H3 SoC keep using the system_memory address space,
> but via the proper dma_memory_access() API.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>



Applied to target-arm.next, thanks.

-- PMM

