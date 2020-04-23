Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BCC54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:00:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96D2B20781
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxE5dzfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D2B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRaWe-0006px-M0
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRaVx-0006Q1-6H
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRaVw-0005kH-Fo
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:59:32 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRaVv-0005h0-ST
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 07:59:32 -0400
Received: by mail-ot1-x343.google.com with SMTP id j26so5549091ots.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kVkD1mu2q4zWkJZGvnGFY675V6vmWpwLJ9w5whZqQjM=;
 b=xxE5dzfiaeoVCqCOlr2UIAdxaT4Yo8Cise29yx4QfocFKt9Wl5ABsEup5y3T9Kh1tg
 E/DRNBPR3mGJPJUOK8f3rCQaEwOV9/ogaWG/Wu7Bh6DpkM/5lUeGEuLTNiuVfDf9rVMK
 rbRnZneVaLlyGqwPnHhtuea9ln+/H9VF10RPaND2HgLkz8bkNcsRIJiQneA4v61Vgn9b
 eKc7URT5WdQu/aR3xCOMsuCbI1DDT+rTi0Vhi8WfYiqq65vCThlfMjGNITzJt8e5s2IL
 bmEETUkCHgeL2JNrTefHFIwevQiTrkINBESzkaC5L2rNss0DI/47s1boIZZ4CEeGO5Rq
 moxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kVkD1mu2q4zWkJZGvnGFY675V6vmWpwLJ9w5whZqQjM=;
 b=ik0naty+hTxyApyEtf8iZpSC44BoaJK7J8osdEsWMctvzjQVU/gcQCNeCQ3UgXnnPN
 08+x8hNhOTxzUi0vWpf7lvzZUfzomYrlfee7ah2bqYrTQ+3zo7UbuhwJ8+lq1n0Ie44I
 SvB/R5/U9Ij/W7PTMyFDExlr/H1pDMIq9c+7v8ocEB/ujBT/BRw5RfIsM7QVdhAp0rPi
 T5rFE/jM2sR7N/SEApCRsaSSWIaocF1T3lSq90gccRFRkpRcr860JoLLUQcLXle6HmGZ
 Muq6V/CpfRzT/It+sydV0Skj3iwVKvjHasESDK3U7eQ6TpCLWbecYRNgGbK2SRvjwtrU
 SM/Q==
X-Gm-Message-State: AGi0PuYMoTEQnzXK+yhYbFucL/azR0+5ScuuVyDGThzooLo42uTQM/bn
 tJgahbzf4IXvTn0XUIPlv0SsMUJKbzxDj1FYcyIgew==
X-Google-Smtp-Source: APiQypLFWG0CRN7zBx3JWQtDgQKh08SlwMtoTKKGDZCjnWSF4baHV7ljiRs4xfhBjuYeI3OQJlic0/yWsshZmLdgVio=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr2901832otc.221.1587643170278; 
 Thu, 23 Apr 2020 04:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200420121807.8204-1-jerome@forissier.org>
In-Reply-To: <20200420121807.8204-1-jerome@forissier.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2020 12:59:18 +0100
Message-ID: <CAFEAcA_q58Yk_7b0DViWse1v7sRMR05FKjSbtFtgHasY7fYWYw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] hw/arm/virt: dt: add kaslr-seed property
To: Jerome Forissier <jerome@forissier.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: tee-dev@lists.linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, op-tee@lists.trustedfirmware.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 13:20, Jerome Forissier <jerome@forissier.org> wrote:
>
> This patchset creates the DT property /chosen/kaslr-seed which is used
> by the OS for Address Space Layout Randomization. If the machine is
> secure, a similar property is created under /secure-chosen.
>
> Changes since v1:
>  - Move creation of /secure-chosen to create_fdt()
>  - Use qemu_guest_getrandom() instead of qcrypto_random_bytes()
>  - Create kaslr-seed for the non-secure OS too
>
> Jerome Forissier (2):
>   hw/arm/virt: dt: move creation of /secure-chosen to create_fdt()
>   hw/arm/virt: dt: add kaslr-seed property



Applied to target-arm.next, thanks.

-- PMM

