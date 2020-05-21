Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A659C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B942072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mmkk+70z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B942072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbp3R-0004y7-40
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbodM-0005P6-LW
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:05:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41059)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbodJ-0002cC-VY
 for qemu-devel@nongnu.org; Thu, 21 May 2020 13:05:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id 23so5591620oiq.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pLFCIp0XFHZeGWDRfPEhCpc7Fs4qtKzYvjQ0W/FfaSM=;
 b=Mmkk+70zD/89rdujcnneto7uMGa9SbFNBrB0DVeAfBxci8pcFW4tXDNWLhkiHkyRxH
 ibercEhWtyj4XYbLkviAecFp5xjQKBU2qzTYSaRjJP9xE4aS2Q0PCP9hEmxT5RlBCsof
 WkFI8YHURhitHTB8gUQSTNNKcdNt7kgL4PRH8aFgevV7TTdOdgvDXJBKuU6rXQZCBrt1
 4HrThCh/PAPzp+P6mGX4fGhYwWxxVcKxBACUCpAgc+aqi1/Q5B+/LecviO9L+wL9eHBh
 YokVG5ENMQUoqAPZzdRdLInnzPz/+vaJ9cO5aruqr/Y3NFg0mgXfGZlWO5GAJHEuif7l
 hlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pLFCIp0XFHZeGWDRfPEhCpc7Fs4qtKzYvjQ0W/FfaSM=;
 b=fqAiariQoiGjy3OsU6UYmWnk2qZ5di7SdsJm+Dps4sYHIVz721NYFpK67hUUdz7Qis
 a80IA8Fue6bkf/kWaJhb7nZbpKf5bjgAsx8bGXhXoKuHc5aKePKPQ++INOF6lIhpNPWU
 9FZygTRrTUt10dchpGZxmEAXjB9JkaFtyh+rYkf2EEm4n0ox7jBFvrQf+fmnekEXd5jT
 O/ipCU/qolS74EJZWlI34C4366wYgR+6Z1RA3b8B8CJSbP9wr9G11jYpZLoEfcq2OeO0
 DwWVL7vnUXFLCDFNlxpHABcNez9WaQw112kzE3ZVryMYFnNEsc4idG33UAJRQWG2ZmW1
 Hs6w==
X-Gm-Message-State: AOAM531QZAIdEE1sJRQb+R/RcvCu8a4CMQATC8TViC2ZW2lzVQi5idsa
 QES4u5mJJJP8uoPg7vBlFOa4Tu4dnBFo8AKAP4UxZg==
X-Google-Smtp-Source: ABdhPJy/xi/VOmt0QhOBQzDsZYa2qxidP3k3XRG+uujHFRxjP/Hp8FbSRRA+KqmDpxicv90y0kVoRY+Fez1hLNJSVlI=
X-Received: by 2002:aca:eb96:: with SMTP id j144mr6875001oih.48.1590080723816; 
 Thu, 21 May 2020 10:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200518143014.20689-1-peter.maydell@linaro.org>
In-Reply-To: <20200518143014.20689-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 18:05:12 +0100
Message-ID: <CAFEAcA-X1MpWx-_Y_UwSyToZs+M2__vKj8tRSKEPMDq8t_M47w@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 15:30, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The Arm signal-handling code has some parts ifdeffed with a
> TARGET_CONFIG_CPU_32, which is always defined. This is a leftover
> from when this code's structure was based on the Linux kernel
> signal handling code, where it was intended to support 26-bit
> Arm CPUs. The kernel dropped its CONFIG_CPU_32 in kernel commit
> 4da8b8208eded0ba21e3 in 2009.
>
> QEMU has never had 26-bit CPU support and is unlikely to ever
> add it; we certainly aren't going to support 26-bit Linux
> binaries via linux-user mode. The ifdef is just unhelpful
> noise, so remove it entirely.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

