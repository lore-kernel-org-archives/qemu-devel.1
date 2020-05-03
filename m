Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F0EC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 14:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7422075B
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 14:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FyUBIv+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7422075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVFEr-0004CZ-I1
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 10:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVFDw-0003LC-UG
 for qemu-devel@nongnu.org; Sun, 03 May 2020 10:04:05 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:39109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jVFDq-0004Sw-UX
 for qemu-devel@nongnu.org; Sun, 03 May 2020 10:04:03 -0400
Received: by mail-ot1-x329.google.com with SMTP id m13so6600793otf.6
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ub+e3Hp+ToScg7VktiRzJweHuGZoRbmHAPt0eyX4nWQ=;
 b=FyUBIv+R9Zr/Xa6RxCBXMdhprMa8qDi9p7bXnwuZN/f6PHH6ABt8MybCWba82tImnA
 dAqPLtqqlPEy+/VIR+7TA7kEGeQhzMYyTZhFxnZ12DGs9DeEmv5LAHv8tyn6Qh1J/hPT
 RBNSuu0jvLXB6gt0+VjGt9htGRMG6AgY0Jgy52DUGJ6Z/GQWZ5A+FCvR2MWzExzJrLIt
 CsHhL108EqeHfG7eCsHclwfm8OjDnNqWazQydaZfeoCzuDk+Je73gJgGtssSTWxCBz+n
 M6XFHW79u6TCJXCPvm6573CZmNsoLm5QUWfPHB1pqpXXpqEg3tqGZWuARYskbH5s6PVX
 a3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ub+e3Hp+ToScg7VktiRzJweHuGZoRbmHAPt0eyX4nWQ=;
 b=dnqNw8GbYORDjqL4eUUurFLgphOGPrQoalNeJuTv7drtmDj9u9zduBD54/0PdGowqA
 ehv9nx+iao6m9PaZFB7dmSuOWWqk9GDkREGrbLgtNS0NTsUXlIl1W8oRYJJfllNRngPr
 BZAcGjL3tZ5unLSKsZGqtsBo7XiJqYp14Mv9MN/VjxRs5mAPQ/tSYsGDNZRcEC04Zedv
 ysSkZTCYA28RN2VWj9bkumtGAJCSrzxz1WsKBIyoeKW0ZzniXpDuKgY1FzsVbkmiEJri
 7nitsoTfEcl8YhRKV7EJ+cPqAn1OCY2hXq6hY3FF8ivDAPyKR8pbRDoHxP8yGmYOxnlL
 mGXw==
X-Gm-Message-State: AGi0Puboatng2GncW42qpQlX+cIGWQGQwFvaztfuWwLYmajz/Z85NmbS
 LcnzXyn/gH2abuHYLr1Yz+v0t+ZQ1TtOpACMaTKKpA==
X-Google-Smtp-Source: APiQypIXzbhcktgINKOVZZxgQKvexly//uVZDWHgo43z4IvPVPTK/GYXw05N2+FuuZdLPPZjdM11wtQ9tm+0F9/cQLI=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr11052757otb.135.1588514637488; 
 Sun, 03 May 2020 07:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200502191842.27250-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20200502191842.27250-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 May 2020 15:03:46 +0100
Message-ID: <CAFEAcA_SQJ-zjDuC_m48Lxww9jTR_U7mWGk7RK2OwuQ5zGaqcw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] RDMA queue
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 2 May 2020 at 20:18, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit 1c47613588ccff44422d4bdeea0dc36a0a308ec7:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-04-30 19:25:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to a5cde048e865da81fdc9077f3af28a43bff78d35:
>
>   hw/rdma: Destroy list mutex when list is destroyed (2020-05-02 21:31:17 +0300)
>
> ----------------------------------------------------------------
> RDMA queue
>
> * hw/rdma: Destroy list mutex when list is destroyed
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

