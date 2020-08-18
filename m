Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2740DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 19:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E666E2075E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 19:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0JgGdnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E666E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k875V-0003F3-60
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 15:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k874O-0002f1-Nq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 15:14:52 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:34163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k874J-0004Ht-1X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 15:14:52 -0400
Received: by mail-ed1-x530.google.com with SMTP id bs17so16157039edb.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LLFMHmu3uB94HTin09U+bQV7QyxQPuHirz24g/jkiQM=;
 b=Y0JgGdnGywKGpYmDq3illyiTq9LxoweL+CVvArUHlKGmtmGtGt2/5bD827xMBaF1iX
 xnwm8Fnu0iMCfEeH++otang53wJobyBzdIpMwWuX1Z6GIp+ZckkuhVRVK0t8BWWa+Ox2
 +T4w4KgYCZ7Vo0Zn50FP4QnJjgoHQhx0ydVdKYMRmf3kvne8HvUxSg41LsVt526nlyQG
 2BMxccFjgAqNcva/9pG32YXFKb/KqoiKTGla0XwsvA+75sfqBCfW7xWrfVFiqoABlop0
 RpVcKzKbcfFngDACWwQQbbj82LWzY37ypBckow83mWQ+brliEg/qiZPuSk6jzwLL9mmu
 WJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LLFMHmu3uB94HTin09U+bQV7QyxQPuHirz24g/jkiQM=;
 b=oZX/rG4T2EB6UyrU72D1RMxHyPjYEfLhRJCc0CQO/GPygfwTxIUtCDNciUFOLqQwox
 ak5dC6BA+MdufGx1VKxRXBcqWLyP+snDyvXj+OzP9ErBO/TsbYvL0K02TgihNT9qY99L
 pFqBvjvgyAkEEXeLGnR+BeiuuAveE/LDHZgdALDzrAua0YVCx+WlwQfBiVqi9eXXRGtK
 JZgvXmuWEJ9vsSP2EDl3T7lJArLIp+tpuhn/QZJbn8h9vBmEvPGGKkCemGKfzTdAppbB
 zettUh0yE9ZRqY+wbhxUc/5SFq83FtmsIF8i2iEaK2nza31WA0bODYy1MkZvnkzWgB0m
 27Mg==
X-Gm-Message-State: AOAM530k1RLa0TxhFJS6TVrEItp+4QLIGf1IR2Od6jZJeYdDnNa3jk8x
 yP74URBGEkSdWMchvrR0clxkOJnac0VcR/x5aMG8pw==
X-Google-Smtp-Source: ABdhPJzBqAOEr6COKc+xoVNZuCZgvs3gKjTBunI9uDUwLD8r4Bkz5VadEAhIFJeL6LUm74ixRXYJJNXaho89zCbl2J8=
X-Received: by 2002:aa7:d596:: with SMTP id r22mr21498384edq.204.1597778085036; 
 Tue, 18 Aug 2020 12:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
In-Reply-To: <20200323133244.GK261260@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2020 20:14:33 +0100
Message-ID: <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020 at 13:32, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sat, Mar 21, 2020 at 11:50:23PM +0100, BALATON Zoltan wrote:
> > This was discussed before. I think instead of annoying people with a
> > warning, rather configure should be changed to create a build dir if run
> > from source and have a Makefile in top dir that runs make -C builddir so
> > people don't have to care about this or change their ways and can continue
> > to run configure && make from source dir but you don't have to support
> > in-tree build. Then you can deprecate in-tree builds but supporting only
> > out-of-tree without this convenience would not just unnecessarily annoy
> > those who prefer working in a single tree but people (and apparently some
> > tools) expect sources to build with usual configure; make; make install so
> > that should be the minimum to support.
>
> Yes, please!  I use in-tree builds and find it tedious to cd into a
> build dir manually.
>
> Also, many build scripts (packaging, etc) we'll break if we simply
> remove in-tree builds.  I think make && make install should continue to
> work.

Paolo's conversion-to-Meson patchseries is about to land, so now
is the time for people who would like this "automatically create
a build directory and use it" behaviour to write the necessary
patches. Any volunteers ?

My current plan is to land the Meson series first, because it is
really painful for Paolo to try to keep rebasing it as other
changes to the old build system occur. This would break
in-tree builds temporarily until the "automatic creation and
use of a builddir" patches go in on top of it.

thanks
-- PMM

