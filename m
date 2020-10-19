Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E291AC433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D2622365
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 19:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWknhYI/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D2622365
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUaR2-00080r-Fz
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 15:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUaOj-0006uQ-Cd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:00:45 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUaOh-0000Z9-N2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 15:00:44 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so392473edb.10
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zt86L0fH6lSWWWWZfzUSdqynJiqiSos24HG4wJt/Sc8=;
 b=DWknhYI/TxVs4riPJ76sCj0uOmm6MGIoYIxdxk/UrHi+fNZNQDQBSpB+JC5NEENEs6
 IpCNcTb8P4yQPol/+H23ueXMj4wCtHp6xw6FBRcDTilmmmYC3c6kdyvuWxP5RvgCO48k
 mEE4SbGxBul8VHRLIUreS/utIfv5rxBsbQ/RgCrqsTq+fsZc1CIOGUV7O2Hjjq+//PfS
 y2KovWki4ZdPYXZ0NLs5d8tnpuUpGSzv+kaFBFKV5o1Rc60/aTQ+kXUHz42uurnyscEz
 DmwTESMOXVbQcyjtKvxD5rqM8Woim6vA0jWveDz+B0s63ITA/Q4r8cH53phgANdawbQN
 weeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zt86L0fH6lSWWWWZfzUSdqynJiqiSos24HG4wJt/Sc8=;
 b=gyUwBGG234YY5mTGeb3Zjlcrp99gqSgbGE5ty105ZR6D0q075n36G71pndelgZQQsZ
 ZoEOiudTKDV6G9+7KgiVTXDRdt37SbUiFWyKEcdVHjYL3ixoeytNeWcQoF5dozrQBpjI
 XfcXkFaqv7cULDEb+LO/Rn2A8ORZUvPxeT+rAtMjuexKeqSHPDvqqVHAmAtL+gfowFP1
 jB69y/46tZcOv7DFVUT6oyQ+8akIS5yFLdU9xhaDUxYIpaS+pcZadl1CqiejC22P2xUe
 mJ/ac9kAsXwl7wtL9zWqCgZIBl2KUYpNkbbjzCq0PLHdxLHDJY1YQb8GVAPFJuUaUcni
 lccA==
X-Gm-Message-State: AOAM532+RTpWjl2qqy6AZ+JrW8/3b0KxqnA8HdnbUQev17EKTk1hVoWU
 Hij0NNOReRE2+EdrmqLShANpLLGet/KBYrJBTQnGQA==
X-Google-Smtp-Source: ABdhPJxjSdYnoNxKCAcfCTz+HtRW+nFfAwRerIanQrCx1OrrxUD3ud/zvl/SimAxJ4KLGxbfA8DOs5FqtQjrlr6vaBA=
X-Received: by 2002:aa7:c683:: with SMTP id n3mr1295824edq.146.1603134042071; 
 Mon, 19 Oct 2020 12:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20201019173922.100270-1-peterx@redhat.com>
In-Reply-To: <20201019173922.100270-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 20:00:30 +0100
Message-ID: <CAFEAcA9RHVZQ6KzEJOs8V74E3v6Bw=WaimdYRkcLr-9HR07gng@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Fix two misuse of "0x%u" prints
To: Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 18:43, Peter Xu <peterx@redhat.com> wrote:
>
> Dave magically found this.  Fix them with "0x%x".
>
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Hmm, a quick grep finds also some "0x%d" in an arm trace-event file :-)
I'll send a patch...

-- PMM

