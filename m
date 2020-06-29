Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66ABDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C2523D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v8mh/ctm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C2523D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuLr-0001YI-GA
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpuL0-0000uN-WB
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:00:47 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:46253)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpuKz-0003A8-4y
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:00:46 -0400
Received: by mail-ot1-x335.google.com with SMTP id n24so13331932otr.13
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yl4lyU1uXsWZ0Q8HHZMNrLjx3Cqf5Lzds7BQ6rtRyfo=;
 b=v8mh/ctmnOcsEXFnRGYGSq0xd6jgy9aihO0o+nVYdNWqIFgH52I7cryK+1TkIG1YJj
 aBQcRbiSqwpS7BaU/xPzJK3auRy7L2QxrgIiUXi+cijlA1Zva3HiZFohG8O8iN2tdSGl
 N5XL2A6ra90rWXngLLoa1wE4JwcKGdo0CWTVa43dYUGlbG39NOix1SBYNJxbOVWqcMI9
 9Byl3zvyFfLX7w8yZP7lU5eRrBi9JH3kr6p3BQWjM/PMWYkcX6rWWfKhEuQ5GgfYqfx4
 pUCXI2GPTXKASbLlujrxbckmBch+XMruhMPLzCqtVuKRirE1h2NboG1gVw8+rUybwE2B
 e4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yl4lyU1uXsWZ0Q8HHZMNrLjx3Cqf5Lzds7BQ6rtRyfo=;
 b=FH1GsVstZ3EOqV/RfhIV2AUUbv8nHaZAl/V7PFScv/K9g1cDBGnM+RSyt97GEb3wOd
 wMuPPB7I9LouyBDW5N6LSspUsB/Qy2I5gPFgsQn8nx6PyGjEAbZ9yUY21lhBsoMUiRde
 zRsED5/JX4Dbgu9G6erG29f0mOXbe+P1ziY4bmQZBVPhLo3cuKlblujAYophq31i4ut3
 hvztJQDQfAOzf9zDwPil2jb4J1gjfKNFjMXDzTvPLmRz+wZpTSc/HzvVwD/cbZnPMKTA
 AQjqVasC3slkFmygvgFoKCmTNNTjtjM8jd966iM6KQ8h1j+H0HqkIYQNMLXZ53Mqtx01
 WIUg==
X-Gm-Message-State: AOAM532UVVyhy30zu89r3xeH2AYLH5IuiKblaDVnt9DYYrsiBO053Stc
 BooV9Y+pbriNlEStj6TfxQZIhOl43/VZyIA2b0Bs3w==
X-Google-Smtp-Source: ABdhPJzEoFXf0Wrp0Gs6LNvB+5c2hk/aI3b2jhbz+EOPoTz59Lz6TkBM6uzjd95F2z9MWVuksMBjC3bjTgWN/Stc4sQ=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr13733945oop.20.1593439243739; 
 Mon, 29 Jun 2020 07:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191029225932.14585-1-mst@redhat.com>
 <20191029225932.14585-9-mst@redhat.com>
 <CAFEAcA8uSbC80a+yB4_DFtCB1_-sXW5R3ugTX6H9XDeBZV-mQQ@mail.gmail.com>
 <20200629120939.GI2908@work-vm>
In-Reply-To: <20200629120939.GI2908@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 15:00:32 +0100
Message-ID: <CAFEAcA8jJnKpgDzqVstHAV=7C-C+W4nt_c_n6eja0pcOQTgUCA@mail.gmail.com>
Subject: Re: [PULL 08/14] migration: add new migration state wait-unplug
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 13:09, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Here we call qemu_sem_timedwait() but ignore the return value,
> > whereas all the other callsites for that function do something
> > with the return value. Is the code correct? (This is just a
> > heuristic Coverity has, and it's wrong a fair amount of the
> > time, so if it's wrong here too I can just mark it as a
> > false-positive in the Coverity UI.)
>
> Hmm it's OK; that semaphore isn't really used at the moment,
> so it's pretty much just a sleep. And the loop always
> calls the qemu_savevm_state_guest_unplug_pending() before
> it goes around again; so it doesn't care if the return
> value indicates timeout or not.

Thanks; have marked it as a false-positive in the UI.

-- PMM

