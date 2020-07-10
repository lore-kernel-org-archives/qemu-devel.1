Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849E6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D02820748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 10:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FVaMYmq0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D02820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtqZ7-0003FC-Kx
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqY4-0002mm-H3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:46:32 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:39220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtqY1-0005rG-Ou
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:46:32 -0400
Received: by mail-ot1-x329.google.com with SMTP id 18so3882626otv.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8UbVlhMgVF3ix+3VF0Q6/lrts5Y1S64xMCPineqCRxw=;
 b=FVaMYmq0DEgcE8BbHpKwTyJThztCZgblWtAxRdInywvv8N+UKx9LbgfjB2huE3jSql
 +Fkbi5QJf0Y4SITr6BKTk3wMj0/IxLknzTwK9dZ7pZCL8CLzjwNTPLikMwucNbZyNDRb
 /aFqWxldOvypcZi9J9BXYD7KiHdlTLzCnxE957Mc9pheroaetsUDhQRgGTnHFPEyxgAG
 wWVNiiewBezUl+D6AxzYcPUQmK6p5FJteklP/XA3TYKsRoqKF+1RV7xHkGpI1bpYu9zb
 WxcPqRedsG93hIkG8fgB/OHDvqeJqJNcwMwZFiaLoIeQLlFOKyvCD2tMFEGyEMKJLkY/
 JdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8UbVlhMgVF3ix+3VF0Q6/lrts5Y1S64xMCPineqCRxw=;
 b=dbPkNGtqXBXAYnZZEWRzg0bNXe2BfqH8FS3q/YIX76jQBA+BPB2LajFRatlaTLlgl1
 yx+kU4JMfTnaX2NzDPr4fWx7pI5QY7DkkPdRnufPUhxTZLIfAkN2BPmK/Pxe1rwPIsn5
 2jbJDC33JRXPAZVIZZUiOTx2tGTnPJmnKiY0uV1VMCEESzDrnCatMtqq5jONxbhThKGr
 EKlnO4ycl87BWVKk9YFzLbFSQVA15Hvam7ynojk11VhukxgPOuNlaPK4Rwx+ZLtYh4XU
 uQzmMZUzlbdVz27AZowRmu7GHkG+IOWmsQL6woMPg8d8KXLYtvXFbGQbYtYO1y9JrAuB
 XplA==
X-Gm-Message-State: AOAM532K8NhJkplkO61dZbqhxE01CzU0sVNC7k/Y6p2XnbaAKzOz/L1e
 GAFObrk2kRUHq+pDiPHqrsLpppvpiMt4QZMBNdaWgA==
X-Google-Smtp-Source: ABdhPJyHxP19T28yX/Y3aWyT0/eMtpo5lwf+7YAmX48dSPcNXT6IBgbSmkrdbXrlJw0Q/Rj/6dv0ZMw76qQDfwSkBKg=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr49955535otk.221.1594377988250; 
 Fri, 10 Jul 2020 03:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <05a9301c-dbad-f11c-12a0-3c60fe0fcccb@redhat.com>
 <CABgObfagZ+=+sv6j_3LyBd5Y7=+mzPdQHpS3JRPtin4Tvtgc2w@mail.gmail.com>
 <CAHiYmc6Df1O=siF4L-MC2qg+W7XGoMyhZCm8p=Mo1-92w4o+jg@mail.gmail.com>
In-Reply-To: <CAHiYmc6Df1O=siF4L-MC2qg+W7XGoMyhZCm8p=Mo1-92w4o+jg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 11:46:17 +0100
Message-ID: <CAFEAcA8gP-arub_6dvdtkYTZ-ejz7TUC1ty6EySHoaWfrj58+g@mail.gmail.com>
Subject: Re: [PULL 0/3] MIPS + TCG Continuous Benchmarking queue for July 7th,
 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jul 2020 at 22:58, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> Peter, please discard this pull request, I will send a new one, as soon as I can, most likely tomorrow, that will fully follow Paolo's and Thomas' recommendations, no need to worry.

Thanks. As Paolo says, on the technical aspects of the disassembler
patch you could go either way; let's take the conservative option
and not put it in the tree for now. I'll drop this pullreq from my
queue to process.

-- PMM

