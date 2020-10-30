Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF0C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092B3206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KwXxRPaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092B3206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYadL-00031M-RN
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 16:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYabg-00026Y-8r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:02:45 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:43487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYabd-0005A2-Vx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 16:02:39 -0400
Received: by mail-ed1-x542.google.com with SMTP id dn5so7851632edb.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=02vH7YJREuXx7JXqcCpqu+sa0reoOnN01mTCOw+Mcpk=;
 b=KwXxRPaMoZYuiiEi39KbHv1HMmephb09FdVnr2nTzuArZ1FZeQY+PsWgrhx+0b5Lg4
 XSVr3AH7GNIlVRcAcvBCW22nCWuqd2w9NFq7rcMGOD8AI0U7t9kgV1u91EVr18iZim0J
 SjOPj4ouyuf2OP91kwGWEeEhKWDPzOlnN+hJIFvaOMipfoQKTQergetrqci20UWXE6hw
 M9VUVj/U4LobG9zMhUT+GjQ0dfGRZDL4E3kfJfKGMDYX9Rh2xu0Z8Eoh+y07Z5RMnuVX
 oBTI+fQ4ZhClbX81bcdtHoo4DtBjH8QbaHKjMRWwU0+uK+DUYFlfL9Dq3/IPU2y9fNah
 PUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=02vH7YJREuXx7JXqcCpqu+sa0reoOnN01mTCOw+Mcpk=;
 b=Fg76b6WS1CHBuHu4vCE2ZAjScbs7vQcPGIcTY/bN+Urr5c6DyOINCCnGBjx+FWvMt9
 bztCf8JYQmYgdRmUBRfqTlIULN0TUzs7Q14IaPCwVYMs/WGBEud1FGpE3wdy81tQW2+r
 Q5QTfDRyDLohc5auGhCYqjC+EbrZH5LRdXrD6KO7Gq6fsjKEsgP+yopYdFyiaYc8ee9p
 PwRHmSwDNdZRYuso66IcJ+ilfh14WQ6hwFsCi00DHgCD6GdJiYoeGfksmlrJZQs/WOCV
 Rp3K/Fw2xJuY76xjfK+1Sq1P03IBkZcxiIwc4fLJdYpUKyyNQVH/luDwyJwhRTN9/2eP
 JJ1Q==
X-Gm-Message-State: AOAM531zNp50WpaiQM//lmAYatKTpnM7IA2xKj275B6cWK+24px0K0MM
 Fx3Qw6eDB18qbMcnkbRufShU0bBnBYWQVjUzS76tBQ==
X-Google-Smtp-Source: ABdhPJxTVZSo9Bo5Ua0Nyyj3XaPWBVUgMlUlzfF3YSTLm0n7gckV+PdaRFZT+/l+HzWtxMD0FsaQQMoXZlLYXT9/04E=
X-Received: by 2002:a05:6402:4c6:: with SMTP id
 n6mr4371439edw.204.1604088156154; 
 Fri, 30 Oct 2020 13:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201030174700.7204-1-peter.maydell@linaro.org>
 <7ef49ead-40e1-1705-afc3-e94cac2bf5c9@redhat.com>
 <CAFEAcA-qOWGvuzyvht+J_kmj+gBvqPdhiMPVj67R4ds50PjfPQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-qOWGvuzyvht+J_kmj+gBvqPdhiMPVj67R4ds50PjfPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 20:02:25 +0000
Message-ID: <CAFEAcA_7dbapFgDQeWObejCTqZOUQ9TxaKfwyELGsKMh+dUQuw@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Fix building with Sphinx 3.2
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 19:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 30 Oct 2020 at 18:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 30/10/20 18:46, Peter Maydell wrote:
> > >
> > > This does mean our kernel-doc gets another patch that makes
> > > it diverge a little from the kernel's version, but we already
> > > have one of those (commit 152d1967f650f67b7e). I do want to
> > > try to upstream these to the kernel, but that will require
> > > more work I suspect since the kernel makes much more extensive
> > > use of kernel-doc and probably also has other issues when
> > > building with newer Sphinxes. For the moment I would like us
> > > to release QEMU 5.2 with docs that build with all the Sphinxes
> > > we know about.
> >
> > FWIW I've sent to Linux our other two local patches, and if you are okay
> > with it I can also do the sync in the other direction before 5.2 (the
> > plan was to do it afterwards).
>
> Probably safer to sync afterwards. Do you have a link to the
> patches you've sent in the Linux direction ?

Having actually looked at the current state of the kernel's
kernel-doc script I see somebody has already done the
necessary updates for Sphinx 3 compatibility. So we have
two choices for 5.2:
 * take this patch 1 as a minimal fix
 * do the sync of the kernel's version of the script

I'll have a look at how painful or otherwise the sync is, I guess.
We only use the kerneldoc stuff in the 'devel' manual which
is not really userfacing anyway.

thanks
-- PMM

