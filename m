Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7CDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E43C20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 13:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YB+E5A4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E43C20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joRw0-0004hc-Jp
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 09:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRuz-0002xF-E2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:27:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joRuJ-0004Fm-4h
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 09:27:52 -0400
Received: by mail-oi1-x242.google.com with SMTP id s21so4915573oic.9
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/dad2yicRXv+Wr/si9SLQwxM75lHeo3Y4nG5bPjtJWw=;
 b=YB+E5A4loXr9Qfjjr7mTPbFmCFMn5ozWJaDj7l6dGlF0UhOeXZDVBqDJkrkvRsx8Is
 m2XSgApxaQiwwvc0vJ63Oq/E0w3xaUVIiEJz+ONSZqma50nwX9kUZvgdYJ9qVzCXqoY1
 u30oUIyuDNBrkhJsNmstJVGE0FGPS2CqnqdxGiuTzGRyNfghRFgPzRlneRQ+Fad9kuGV
 Uqdmarl0RzOg886eBWm288851Zqvnr9fMozfwCQ//qIDmSYlDPhtahL6h1jLYVnlpOcw
 Oj9Xq/+wYcTL+Z+gsjGuMgQPLh3dG/RmJXkVwrRGj5+LD2OQ0o/w7AD4tBq6ESnOWeM0
 HSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/dad2yicRXv+Wr/si9SLQwxM75lHeo3Y4nG5bPjtJWw=;
 b=YQpGkWXA6olWCPkeVgjqS8KJoYvRwS76pTd5xGSp65Ob83nXuvKXHNT6TA59zLB7S0
 i+dj0Pdlayuyh2J2lPsHTKdtF2tUlTb9TucXaupL0pZG3MAj6EtJ+M7sawRXKxHTRu7w
 3EIAjtbxV+Hi8TKSm08NVp53LjtdISJeeT4yh4i8TTcxIPv04Csz/GQP9nI03e/I68g3
 3EpbzR5S4DalhhXcMTO06mk8lLBAzYmwdTvGVzW+bIxe7zL7nzcbRxOOzCNBM6mf5gBr
 wNxmq8IwdLBDiJ0JU50LS9/l5z1vs6U7WEWfhW0pA8TLQHJh+uKGkLfikcuLW0zjkRKt
 nmUg==
X-Gm-Message-State: AOAM532aVooXONMUlevWLXuPJFPB96dHOv+BVmAyFt9t4YHf6DhabAFl
 FLmnKsxJC80hCxVBVxzJOF3gvQXpbVTlDkPSswB2Bg==
X-Google-Smtp-Source: ABdhPJwQ+qtAx4GA87BEykJ4z6xAOlTa5DUAXwCFcgijzw8ZzWhmBKrMbzSuvTWaiOs3jnInrpHVPFwPdRf8DrD0QOc=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2147533oia.163.1593091628252; 
 Thu, 25 Jun 2020 06:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200623193658.623279-1-richard.henderson@linaro.org>
 <20200623193658.623279-44-richard.henderson@linaro.org>
In-Reply-To: <20200623193658.623279-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 14:26:57 +0100
Message-ID: <CAFEAcA9e_w=iB=fqWj7UgpseOXzTzFcCj6-YBGUHup83oCWOCg@mail.gmail.com>
Subject: Re: [PATCH v8 43/45] target/arm: Create tagged ram when MTE is enabled
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: david.spickett@linaro.org, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 23 Jun 2020 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Assign cs->num_ases to the final value first.
>     Downgrade to ID_AA64PFR1.MTE=1 if tag memory is not available.
> v6: Add secure tag memory for EL3.
> v8: Add arm,armv8.5-memtag.

> +    if (tag_memory) {
> +        qemu_fdt_setprop(fdt, nodename, "arm,armv8.5-memtag", "", 0);
> +    }

Catalin mentioned in a recent email that the plan is not to
require the dt to specify whether memory nodes support tags.
Could we keep the dtb-modification parts in a separate patch
so it's easier to drop them (or to commit the actual
emulation support first and the dtb changes later), please?

thanks
-- PMM

