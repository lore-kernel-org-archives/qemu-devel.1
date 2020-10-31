Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1871C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 17:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F85720702
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 17:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pM3aufIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F85720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYuex-0006xD-Q9
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 13:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYueJ-0006X3-21
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 13:26:43 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYueH-0004W9-7T
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 13:26:42 -0400
Received: by mail-ed1-x541.google.com with SMTP id o18so9959410edq.4
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Obob5LwLPYXMVcZS5RKDl9Wr4dxxInSpI+CUMNnxarc=;
 b=pM3aufIy7QiyFyNk6ROrkkLSaXXUU9Sz62tVcVk8XYosz0t1rLRUIpTcB15WUmleGL
 0DtCB6LRZgkr3w6o/8lOdxG9YAacIRfbPqmkuYeHdXOQdZNvGXp02YmZTDl4kDXT8+oq
 GwAIelCR1EzhL1W7hebMdHoX8j/sp9caKwXyMgF/EVd+I0mHHHWMauUZitF5dHRDJoNc
 kddwttiU6z7tNX0LezXaz4ZOJo/Bx/IzzK2m+I0k/XN5U0ohAB0AlnyfhCAxMFpRynYX
 pumwFZPZ9iWPceE61JfOfcITJuTU9vYGFdsLqvMgSY/5LoyCpZ1BtKYBT+LgpJe3iVnm
 Pbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Obob5LwLPYXMVcZS5RKDl9Wr4dxxInSpI+CUMNnxarc=;
 b=FilWwha2k2TBhkyKGHCIqrrdmaSNIuCgYM0Wzlunc04auUIE5RykykT/LN1z1edfMD
 XrJ5ch4MI5zBAdIaeA63koG0l4p/JQ6VKSjh2SZCfBSNPnYCn36Xjf/JURMUhW9qD1bo
 bEBZ6gOM1z6tpyMlDUHBPNSJYq9F6qcLT1ABfwKY9CYhEzLBpffqBQgZbTZmYD9MPEKj
 qklCrtGwCFwGm7LaloYEimYFe/Wk+nI5B3N5vmt1wyDDwXLZi2uQKkAmPqIw69JS6FtI
 lbjPRFsp0JDJ14iDHSo81DorqXPJXw0vMpAxkC4bhQmcLMVD/QdS12C0VftWin0YveJ5
 4t/w==
X-Gm-Message-State: AOAM53105ZN1x5fbNj+/lEIHYxrtK1cRrv48PI1yoBMz15N6vPQ/dQTx
 8CMCPfBuzLnx04NS4WxzRz7LUovy0KHDjRH5zLKB4A==
X-Google-Smtp-Source: ABdhPJyI1wfnXEqSmsdkIvk0kqU+SWZULpHYbGpcXQH2BZHBJixHPUd3mzpfJt1Z33OxYocTJxpOCS/8dZcuqebb060=
X-Received: by 2002:a05:6402:b35:: with SMTP id
 bo21mr8873043edb.52.1604165199406; 
 Sat, 31 Oct 2020 10:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201026161952.149188-1-dgilbert@redhat.com>
 <2333379.eghUmhzIt0@silver>
In-Reply-To: <2333379.eghUmhzIt0@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 31 Oct 2020 17:26:28 +0000
Message-ID: <CAFEAcA-ZfZ6pLEMRj5_qhD2Lz7gQtaLaybDK+BxvJbqoDMmSfA@mail.gmail.com>
Subject: Re: [PULL 00/16] migration queue
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: Bihong Yu <yubihong@huawei.com>, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Oct 2020 at 16:12, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Montag, 26. Oktober 2020 17:19:36 CET Dr. David Alan Gilbert (git) wrote:
> > ----------------------------------------------------------------
> > migration pull: 2020-10-26
> >
> > Another go at Peter's postcopy fixes
> >
> > Cleanups from Bihong Yu and Peter Maydell.
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
>
> May it be possible that this PR introduced a lockup of the qtests that I am
> encountering in this week's upstream revisions?

If you try the patches Peter Xu attached to this thread
does the lockup go away ?

https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/

(I'm also seeing intermittent hangs, for some reason almost always
on s390x host.)

thanks
-- PMM

