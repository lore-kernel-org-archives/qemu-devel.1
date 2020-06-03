Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB61CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764A4207D5
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SUi+9uGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764A4207D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUJe-0000nH-MD
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgUIi-0007fJ-PX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:23:28 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jgUId-0002Gm-CY
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:23:28 -0400
Received: by mail-ot1-x343.google.com with SMTP id o7so1983843oti.9
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SKpdP9vGeB1tX9GzeRCGf8yJGZXxg6QS3w22hbJrIK4=;
 b=SUi+9uGiAO/LUAVKBf8pDAJSH5KK+B4ZSCsRV7tQjDdT6L+/jVMq6zM6QtyBn7zZTV
 Vh7pX82VAc1uLX1LBaBhhkLgpdAbaW/zDooI/hjn+saEhPZDCsKrLJavkLBHdZQdGDoD
 kqZe37hNh1eD9VU3TxWIQ7I4mNoNhaik5wk7iOnqvOQhJ+KvvaCw+edcym4NhvBjjzPx
 IUJTY58NUSJtyimECW+GLw7TVpEgbX8FKYsZ+4lbz2j8DxeKtB1dvjjnjQvrS6qCwl3a
 YuncIuFXsxFtJivmbfGZ19zhOG3SmC2fct9RAyHwDGPxbESEFM4MvpW8N1FNc5oi/pLs
 CloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SKpdP9vGeB1tX9GzeRCGf8yJGZXxg6QS3w22hbJrIK4=;
 b=oQSEhYnBuw6u2j1fDoOJsLorZ4C5i4PZZ/usI9A7DK5IlT/WrG7QklMsp8zARH09I2
 5PXxFtnsNGoGZld4bkIaXNKkJFGJdLfowbrvkTKCILnjb60lGVv+H2UkvpP5QhgDvM91
 XrVif7XMYYi12CL2G6to7ehGRRHjs08yzNsuV44z2n5fqo4AGqEesulPkxYonJDf2Suq
 AGIT92q7/AVWCCHL9J3tq920iPoWDZRJgOmyeo4YxZSm2at77V30AAIqL9ebqSZGMzkV
 u7NcbR/z1Na/AQOXWs9OxXj747SOjbd2D9BI4y+ndfX0d3dYQ4F1yqD/z+wlkEnu+bEr
 Ql0A==
X-Gm-Message-State: AOAM530mG5rdx5oT/K6Patw4Wt5xxH7tCMIUByftT8Fj34/HOAnYdQ/7
 UUDGEoELBeCjPDiohfbSTv6dp2cWYHGWQXQFSjioCw==
X-Google-Smtp-Source: ABdhPJwRlmKgfuEV+kODwG1KWk4YjIx/1mOl+QHkd9RiARO1OTeQYQI4HWtX23PaZkV0DFPSY4olibpqoaH0TPNoPDs=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr139947oth.221.1591194199665;
 Wed, 03 Jun 2020 07:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200603020208.2089-1-fangying1@huawei.com>
 <20200603082600.efes4srlft3xv2tq@kamzik.brq.redhat.com>
In-Reply-To: <20200603082600.efes4srlft3xv2tq@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 3 Jun 2020 15:23:07 +0100
Message-ID: <CAFEAcA-p2rYuU+xG2jtY71VKD8QLLXPuWBa4UJqxRAABsyvNKg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm/cpu: adjust virtual time for arm cpu
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, wu.wubin@huawei.com,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 09:26, Andrew Jones <drjones@redhat.com> wrote:
> The name 'kvm_arm_add_vcpu_properties' says nothing about being specific
> to the timer. So this is either the wrong place for this function, or the
> function is named wrong. I'd say it's the wrong place, because, as the
> comment above kvm_arm_add_vcpu_properties() implies, the function is
> for all 'kvm-*' prefixed properties, not just timer related ones. It's
> true we don't have any others yet, but we will. I have plans to post
> kvm-steal-time soon, and despite it also having 'time' in its name, it
> shouldn't depend on ARM_FEATURE_GENERIC_TIMER.
>
> How about the below [untested] patch instead?

Your patch is the code arrangement I had in mind, yes.

-- PMM

