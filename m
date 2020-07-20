Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC49C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65B992065E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0Hd2sgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65B992065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWju-00066G-MU
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxWfX-0000xc-GC
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:21:28 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:42018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxWfV-0003XR-Is
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:21:27 -0400
Received: by mail-ot1-x32e.google.com with SMTP id g37so12286721otb.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fesmCgacJCuaUPIINlJUL9oFxJehN7lpN632V9vSM2M=;
 b=Q0Hd2sglYvTtClCVaxSej/oC/PufP7k4Cq9A+/xnENjhgwI6+1eTAHv3lVhltf13R5
 v4OvDM1wuGGAL3Zb+M0p5pbXklRBwFPHQ4BLNuU+72PUZxcN4Ht+ZpIVespNoZCyGHXy
 737XK3WOxdApI7RJYtDZsg+i1kj66ZsqRL44fKhmZ96Bpaa6Hy4OsPOrqD03FjCpwyjR
 k9QlpbOavtoexOTKKPHCTCPObXHS3sj5XAz5Wv/9BgxCYc9EnMblnRYvVqYOBiumF5gZ
 PklwA6XniFefP6DGRTSEpoa05es7CwALGM8lDK6htRY6B5ZuZn8+psAXNfMa86qefHO6
 /5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fesmCgacJCuaUPIINlJUL9oFxJehN7lpN632V9vSM2M=;
 b=GE2XJnJlsN/52kL6NyW8Nxxn3w2W7mpf4BZr+fblvjBAr1o5Z9MBmBNQEkIkaqM8cS
 0l0zseDSfk/wHyBHbY4R7ViUKJuRcZMU33/kyt3QeGoSIf6Nrl9XExbaI/GNK3rxlCTN
 GDTptNrFj8h9B+7ELKOH2Qy1vPcg4rkwNapwnFzsWtCb0OlkNGAuuCrk1Z47XrzccIzq
 PpxPRT+Tuw+nIb+QUUuj2951Pf9Kmos8T0i3NOkHG7qMIf8rOt/Ghh6WDSF6JexzwUHk
 gU3FHmmT2D/OiaNqLm8eoajA074xVaLTVrauxmHUC4pCPKGhsW3J1d8HbpX593554SUZ
 DSPg==
X-Gm-Message-State: AOAM533av9u4NlT9OyslrnsanDGz6YbxOJknsQ6dJSkfGRLk8MR6XtMk
 IZHmHbF8dRo4pXLvqeghE4A1l/KhoSAtJjIKuTOicA==
X-Google-Smtp-Source: ABdhPJzuMxRjwh/n4NVN4ast+UO57OEn3ESS8l9eZMY8SWkE/GBHUkEZb0ITGCpezTVQRdh3MftsiZV8P5759j0UBzo=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr19961016ota.91.1595254884126; 
 Mon, 20 Jul 2020 07:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_dEBT1jNLWeThhmKisFNwbaSUe+vAEEbv5bnVVb+=bjA@mail.gmail.com>
 <20200720104641.GB5541@linux.fritz.box>
 <90c29aa8-ad14-0538-0e29-c2c9c434a051@redhat.com>
 <CAFEAcA_SWO7fwR6nDAn9=HoYOVEf=L6AomjsonjbscPvTejQQA@mail.gmail.com>
 <439a5b00-997d-dbd2-f8d9-55d440ebd567@redhat.com>
In-Reply-To: <439a5b00-997d-dbd2-f8d9-55d440ebd567@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 15:21:13 +0100
Message-ID: <CAFEAcA-aCk1FX4bK8V++CCcqUCxQ5hCw+XtNGOTQuw=VrCg2Tg@mail.gmail.com>
Subject: Re: various iotests failures apparently due to overly optimistic
 timeout settings
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 at 15:18, John Snow <jsnow@redhat.com> wrote:
>
> On 7/20/20 10:15 AM, Peter Maydell wrote:
> > On Mon, 20 Jul 2020 at 15:12, John Snow <jsnow@redhat.com> wrote:
> >>
> >> On 7/20/20 6:46 AM, Kevin Wolf wrote:
> >>> John, I think this is a result of your recent python/qemu/ changes that
> >>> make failure of graceful shutdown an error rather than just silently
> >>> falling back to SIGKILL.
> >>>
> >>> Should the default timeout be longer, should iotests override the
> >>> default, or should iotests just always kill their VM instead of trying
> >>> to shut it down gracefully?
> >
> >> Let's make it longer. Since you are seeing the failures, can you edit
> >> python/qemu/machine.py and find the default timeout of 3 seconds for
> >> shutdown() and change it to 10? 30? 60?
> >
> > Not conveniently, because this is for merge pull requests, and
> > all the iotests failures are nested inside the tests/vm BSD VM
> > setup.
>
> I meant permanently, for everything -- not as a one-off for just this case.

Can't conveniently do that either, because the merge build runs on
head-of-master plus the thing being merged, so it won't have local
edits to machine.py in it, only the version that's in master.

-- PMM

