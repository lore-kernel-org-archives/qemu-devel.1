Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE97C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E0D25A2D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 14:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qkh95/6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E0D25A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWLke-0000Lj-PJ
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 10:09:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWLin-0007uW-0b
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hWLil-0000YB-KG
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:07:56 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:34084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hWLil-0000XA-Ai
	for qemu-devel@nongnu.org; Thu, 30 May 2019 10:07:55 -0400
Received: by mail-oi1-x22f.google.com with SMTP id u64so5049822oib.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=R06p8qud1yajI9U3UsDhW0+rSDqBsP7O/b+kiNk89N8=;
	b=qkh95/6GSPXonDkwF9a4bgUQiUEZFAPVmB3wUUBwB8BycWkDYmvD64BW9Ilg/PPYwA
	sDy5OnplEIvT2WDOpgsNmhfPL7TVpMPIiHOsfYJga8UFZ5N8RnzvGoqNbXBEduiXFsMs
	rlHAUQaaL+pJExXKl8sVHarZ2pFs5v+sreMV0mdDtgw3ZQVhxZeyq/GmGFNN20U6nccY
	hh6/CxBV+JhK27vLzmrdG+nOsmAFKMVu8jS1AEWHN0QbF7AJUclvuOIfb7hZeWTt7SMC
	A5GtqQlyPBhAXFMiTUG0uTF7jbOUEafa7SAZqF7jBsKqfkzzw+9XetfAH1Dlu9nyeKKn
	BUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=R06p8qud1yajI9U3UsDhW0+rSDqBsP7O/b+kiNk89N8=;
	b=OLBOd//tRE2yqLrrrjsAW+cukjIM798H2vfAWXiMV+nfSdw0DPyVQD/pNuwe9M9aI7
	ou/j5Ko9eRe01Zw6ggTfdJh909RowL1WVmmSaUvK+wuW8IoJUePMCJCZOkHmtzM2PLbo
	5gFzYK8h5RuSJR77NH4ex4BHaF/BQLcTRLm1+7y6FXxS0OOQQzNeQ1CbPCTQS/XHTNTo
	L+SDhmCNLtLemSEHsyoDMW0+QSVjYG2+4UhPc2qwK7TGfBBvy7XuNJ6veW0YO9+oIuzF
	b2AWnSu7KNBH+WwdwnjOAdMWph6Nil5yR2gGhN+WIb1mihtIpZGIFNQc2IPTBVMrUBtS
	yXxQ==
X-Gm-Message-State: APjAAAVUkZftND6OJ9pgmVt6IKESquEscv248AacUNKV9kKmpk07OfS8
	F6FgAIEjqEsSW24fWu27cfwf1FylEMTmckKHBOQGZg==
X-Google-Smtp-Source: APXvYqyf/jnxF5VYQoMqiy0kL0xWN43BjKwkOv0EswlEW0FCqrHZG3lvDtTXqokgFj7Vjw9UAXgy1v+6bgGYHjfYdFY=
X-Received: by 2002:aca:4e42:: with SMTP id c63mr2708753oib.170.1559225274443; 
	Thu, 30 May 2019 07:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190529062832.26483-1-kraxel@redhat.com>
In-Reply-To: <20190529062832.26483-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2019 15:07:43 +0100
Message-ID: <CAFEAcA_y3kkQ_cLcNY_khR9UVz2u-LGkQaDZSQof2EkzJ2ydeQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22f
Subject: Re: [Qemu-devel] [PULL 0/9] Usb 20190529 patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 at 07:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit da35f7f1eeff9f249a9597400fc514c83fd3a0f8:
>
>   virtio-gpu: add sanity check (2019-05-28 08:14:44 +0200)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20190529-pull-request
>
> for you to fetch changes up to 442bac16a6cd708a9f87adb0a263f9d833f03ed5:
>
>   usb-tablet: fix serial compat property (2019-05-29 07:10:02 +0200)
>
> ----------------------------------------------------------------
> usb-hub: port count config option, emulate power switching, cleanups.
> usb-tablet, usb-host: bugfixes.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

