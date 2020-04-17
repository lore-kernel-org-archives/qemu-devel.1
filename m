Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A9C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED90321D95
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 11:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O663D6DQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED90321D95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPOuK-0000fn-6R
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 07:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPOtI-0007tb-F5
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPOtH-0003Th-Ew
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:10:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPOtH-0003TD-9m
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 07:10:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id i27so1090649ota.7
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=86vZQve9ArhUT+FdYs/F/8RHbYqg4H9Jt1CkszzGv+o=;
 b=O663D6DQRTAE+VSKeN4pn5cLcLkbeFLu94HvHP8/m4RoXw9Afv3Pkg6TQjeTQ+aNiv
 XrEHAcQ1VCB36jMUZR61WaNMfN/WqJ8KKks8anJIkHqX1b17mTogUuOvb7XBG/tslpyP
 4xGpWcFe2o3tuAt4cMCyiOYk1R1fkg8OajEchcOGkbKZpZpqHe0O1h53Z3hDLcpiMuYU
 ruXhdkU373gcxBAhPhfJS8QPRNnOzRbCQlZ6CBkY4jUK7i0oKFlPbhQej6oAjNoKklrn
 ubjxc7rOYnbWdQnYUrf9JHNDrYS4YjHns0NweUFSqfk3Da2ANvWkO1FbfaB286oQ6/f7
 BQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=86vZQve9ArhUT+FdYs/F/8RHbYqg4H9Jt1CkszzGv+o=;
 b=bqdc0fRWLbpqnmHdyXX/LTCMFRq3bTMaqJlfvfyeXfs+9fraEq6U7Cz9zMYZgeQztD
 HAYWIWphmuOKcJTkmIkC+PDfyrFS91RTehgQ7r0oCPV5XA0fvDegApDVqW5eWL6h8gj2
 aKZNP2z/8AlCrrvz8/aVFgllMp+07/+3QrlTG9ZProvPCE7JqY8QcxeQ+RHdS1JvcJfN
 100hqV+qbOjbdXkzw37lnA2w+noHN65vo4sOBdMRNyl0RnADcYKm7vWH/oM2bM/KwaS9
 r/HFbI3tue7syhAdl4SOJvE9giY2DvrWOZYUTdyaoRR8QplV4bC+GlyoUO92M9u5c5qY
 j7FQ==
X-Gm-Message-State: AGi0PuZFD9LKSBdXt09dq6AXvdlCscm0lc581C+sbPLwNTANJZj45M8b
 DMSrzBUgQVmRBfZJHgn1k+OdQUtkVjPrUutxxuMXGQ==
X-Google-Smtp-Source: APiQypL5UtAy+ZBz0Hmu+2NcNNEBAX3fc6F8gJXbiQvxyrkFXfCQcW3v+23iBmzqtm5XGCpq8g9NYvkWgNCtttGMNcs=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr2048286otj.91.1587121834569; 
 Fri, 17 Apr 2020 04:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200413091552.62748-1-zhukeqian1@huawei.com>
In-Reply-To: <20200413091552.62748-1-zhukeqian1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 12:10:23 +0100
Message-ID: <CAFEAcA_qTykOyC3ZOJkcRMiOm7tjc0iH_pA33zyLE7ZH8Kn14w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Some trivial fixes
To: Keqian Zhu <zhukeqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
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
Cc: wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Apr 2020 at 10:18, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>
> Hi all,
>
> This patch-set contains trivial bugfix and typo fix.
>
> Thanks,
> Keqian
>
> Keqian Zhu (3):
>   bugfix: Use gicr_typer in arm_gicv3_icc_reset
>   intc/gicv3_kvm: use kvm_gicc_access to get ICC_CTLR_EL1
>   Typo: Correct the name of CPU hotplug memory region

Thanks for these fixes; I've applied 1 and 3 to target-arm.next
for 5.1. I don't think we should apply patch 2 (I've followed
up to that explaining my thinking.)

-- PMM

