Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E8C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B4992073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 12:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aZy1DJzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B4992073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQPm-0006cJ-JI
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 07:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1isQOq-00064G-NM
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:06:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1isQOp-0001Cu-Qj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:06:52 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1isQOp-0001C6-M4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 07:06:51 -0500
Received: by mail-oi1-x242.google.com with SMTP id z64so21989594oia.4
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q3mCSAzg2VPOg+/r71bEPC1PqX5xRmVnxvJC2zYt79w=;
 b=aZy1DJzW5sv4PLj8fbjJXjseLeT2lSo+lgPq4S2qYria3waWL6R/VNhMrAnE1fRbDl
 cWp7q7e85FWLKbFlZ323JcTb0j112ZN+I/i22b0tj3b5n6DnWDhEktGlom26BYXRl45U
 4WaJODxyjBRw+kI6/tQWdQKrARmWc8tOuIiHa8rHpXgKUwHZfdgjYhlFL0O5xO3zTJ4t
 lDBB1/TTggKJReubW6Dv9zKFmQ6LpdmG797pobtb8fnz+Lx4cony3kgToWcehEBkHuub
 q2uX9ih921yVpthD1Q+tfzhXIRcaOq1SiX1+H8pSJZ4BCGvOJog4SpjSwCDpuiQmSoo8
 D/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q3mCSAzg2VPOg+/r71bEPC1PqX5xRmVnxvJC2zYt79w=;
 b=uZCuISa7tbVImj8UXhf4g1xOHxzNjLmYw2UjvzZIpU/0bARmgnqkteUyrbgeKnJMQJ
 EsGlF0QlLRG25yhlRCNjGbjscmkaXXbyldwDbDHIwhfdxsMpYGD98ps5/vuGZjD0FKVa
 9aVQ4sDPsDjMC91xDTlq0q7BSKf6AI5+FNrXKxZqaUku4R6/qoiCh3eBw1EoWMNpueMY
 6/opax+FwY63sghvpcpoaB3jNIpZ5w1DKjRXM1nEMi7zcL/v2vewEbsEKd5g4iK3yLZw
 /ZN2G/Wobp1GwzaeTP8+/i62QwoJjHtA/u4dBoJQewOD3h/Xa1gYVrEl56Nv5vNvQ6eU
 SWGA==
X-Gm-Message-State: APjAAAVO/DZnseuncU1qBsRsgolh0oQg+WG6A48cn9l/KT38eUhzU42p
 sh+2BVCEER7E8GpKNryy6oO4cvoh0rIWZv9IYOAtyw==
X-Google-Smtp-Source: APXvYqx35JTO5D97K2iB64SWGJ43iB9ocoMuaiEo4eHvYt22NXajH8RXxiXieK0cYh1E2iEgOHIr7IdB71HiuK8AfbU=
X-Received: by 2002:aca:570d:: with SMTP id l13mr3069391oib.146.1579262810785; 
 Fri, 17 Jan 2020 04:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20200117004618.2742-1-richard.henderson@linaro.org>
In-Reply-To: <20200117004618.2742-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Jan 2020 12:06:39 +0000
Message-ID: <CAFEAcA-WxPnz=s4cmrg6i1rW2+BCaxMipPHWTwT=UUe4XFfoGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] target/arm: Fix ISSIs16Bit
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jeff Kubascik <jeff.kubascik@dornerworks.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jan 2020 at 00:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes in v2:
>   - Include the merge_syn_data_abort fix, as a self-contained patch.
>
>
> r~
>


Applied to target-arm.next, thanks. (I didn't cc stable
since it turns out this has been a bug since forever rather
than a new regression introduced by the decodetree conversion.)

-- PMM

