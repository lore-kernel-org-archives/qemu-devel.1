Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E8EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F59920BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ey9ydOUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F59920BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPH6-0001jp-Eg
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGPGP-0001Bd-QS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:17:35 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:40408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGPGM-00079x-PZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:17:33 -0400
Received: by mail-ed1-x52a.google.com with SMTP id t16so6901723edw.7
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d1zXZOEgjCvDqH4TQTfV6VGTaNJ2HtR22eSSv5aQpQI=;
 b=ey9ydOUeMz6AnjSZymN2hY/+r4tmd0diLawBfjwdFXVYz3anLyOdzd2kSRhqC63nTX
 SaCSr0qklDWHfwyvyi036fQ6G9atqBFN+PNEvvo/+lSKYONNa0VmB1gkqGhbljztujE1
 RvEL+k7RieKlVcT7+g6AxWO/mSn5N9xsobPOAh4ThxXDXgqJPTw+eQ3pdBzuE+mqTIBy
 /7l3fZijyWfTs6HGZEPb3BO4k4FL9GEuOKuNfbIyw4tZvltduV2I8AFF6GVmzqjfWo/4
 4SaVXdsnM292LRtep5ZPIPUvA/6nd1fVNGSElCC/H9V5SzWI7NBXrJXaVfvNgOyPPYMH
 YSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d1zXZOEgjCvDqH4TQTfV6VGTaNJ2HtR22eSSv5aQpQI=;
 b=WCpC3Rxmt2RomnfqUEvg+LmWd3izKSc7XCO3umgRmlz/0iULS4+asRHmomx0gn6zBV
 PjTg0N2q3bd8N0P5fcq1o+SX/jiPd6eWNES7n0f6CnkG9A9ZaAMpNqdLDOdozSrBr0Xo
 ZOKijfdvtsIHejb+VD2y5TR5uSZT8V1Nm4gLn8zllmRUlxLUvXAc4b639XI8W7UM11s2
 MinvMMPds5o9xZ/htTGDO9ZbtLe0cA+0v/pZh585tUcGZhqgDOd8wBK3b3yTo+lJDzVJ
 qh2n5jqDTxwcREdaN4McdgOBemza0uP3Hm5heBOBH3V8qYwwwA2R8mjlBqioCzakMzRH
 sdFQ==
X-Gm-Message-State: AOAM5300FTKzztdOJTnFiJvOANDD2MBUSOY5PNd2zIP9XdEaD44aOCjy
 nZGAlny+z3jqoQobYcegXBhdAcTE1nr5W+pqwUVzgw==
X-Google-Smtp-Source: ABdhPJxkb3Z1wBFO4ZU32wnRsE1JVVA6ovzVttRJFzCBtrERAZl954led5+jkm3N3+TJznIcjLknnItLY1mpcPmkLaU=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr9948499edm.44.1599754649067; 
 Thu, 10 Sep 2020 09:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJoBWHwtE+HWkoj3a2pdYHOkPpG7ya=+-RRFvUp-SXwuTWvm5g@mail.gmail.com>
In-Reply-To: <CAJoBWHwtE+HWkoj3a2pdYHOkPpG7ya=+-RRFvUp-SXwuTWvm5g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 17:17:17 +0100
Message-ID: <CAFEAcA8spQVin2vj2V5DJYQCR_BizqrRneoRMKhqKAzFv8EiMg@mail.gmail.com>
Subject: Re: Master cannot execute MTE instructions
To: Derrick McKee <derrick.mckee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
Cc: "open list:ARM" <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 16:06, Derrick McKee <derrick.mckee@gmail.com> wrote:
>
> Hi,
>
> As of commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a compiled with the default configuration, softmmu-aarch64 issues an illegal instruction fault when executing a memory tag instruction.  Below is a minimal code example that triggers the bug.

What QEMU command line are you using to run this?
In particular, MTE is not enabled by default, so you need
"-cpu max,mte=on" or similar, is not enabled for any
board except 'virt', and doesn't work with KVM, only TCG.

thanks
-- PMM

