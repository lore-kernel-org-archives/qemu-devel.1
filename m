Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E30C2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 09:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53B4206E9
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 09:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dA0ca4tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53B4206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKetx-00022P-1f
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 05:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKet8-0001ZT-JJ
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 05:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKet7-0002xy-Bz
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 05:14:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKet7-0002xP-0B
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 05:14:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id f52so9949901otf.8
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LuYE5lMDxbnkDvEV2hniTaIbXEIF++rxnVHKu/0Cs/8=;
 b=dA0ca4tVXWi5+dhF/IOkpPu3ummFlUPJ7fSeuIrPbQ4c3yQkNDxkqC60yzhlQbuQpy
 JyREdhwD1NWvZ+AqEtgochVc9VuHoqhzObuL2Q/VXOmmuJZJI6KLkDe81t/Rq9z0auV1
 6lvS9MDYGdzGW9TuFugHeMuFnN6h+mh9X41GFRNeF4+muyo8P25Lx4lZcKlFq9082TSl
 TaNlx1U0MMqK4POkr2E8xDcSv62/0iSJzJ1fiRMN+OOJhqQS2h68SN3/5tNa31B/pnqx
 CvBSZwMnjy+PNDfN4XrznGHK9tMXrALdSEJ4YKHLoxWDsKE5eUjf8f+fRWinxwkp4x1b
 VEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LuYE5lMDxbnkDvEV2hniTaIbXEIF++rxnVHKu/0Cs/8=;
 b=Mb4oA9FYk73pbjxAS4sgKMj7XSwMRjo/Txuob5xGVNyQxcR+lPvSaASc9jX/8Gvz7q
 166ZrWBiiEtYfXzS48i3Dtj/Hc+Ba1rKRhNxM1N2r2exc5LiCcxvrCr9gJnFcUYL6W1x
 UfUJXmpgYJgIGmf+q3b+ZQT8EgQEkd2uUXVVyRc0+UCyNh4sYmlXSpC6qHC7oeE3cTge
 jL6WUjl5qceWVK/Sry029jBOdMmbt94YbmYk9dbJpX8htxNb04iun2KOhCvlxZJM/ZD0
 2I6GipbuS3wAOrg2zxxFDcWMdqxAtTMpVw+N9YfCT6k01+POVSLl34BP5XX9cX4445ZQ
 JZlQ==
X-Gm-Message-State: AGi0PuZMX6DIxyUIttC71PyTi7cuziMvmSgzf8+/jqytZYRdlviLMbkW
 A39TrxRMMNJhJJrwwLbtry3pMOBTfHm4OuBB5TEQSQ==
X-Google-Smtp-Source: APiQypLtAx73VE6huS95RnhOfK/C+gGAkRxnuOaHUVYWPkck3CSQRheQQbbsihZDi2Il7u3kKqbQEP3zDIMR8KmNDkA=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr10058280oor.63.1585991687800; 
 Sat, 04 Apr 2020 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200403135306.665493-1-berrange@redhat.com>
 <93fbf486-d1c3-ec03-ea8d-163bb2374260@redhat.com>
 <813a6453-0cc1-2ee7-20fb-3ba624aad57a@redhat.com>
 <CAHiYmc4Sb0c3pqbOfD=tJf9xvC6rJcOH4kxB=1KZ64Cp-ty58g@mail.gmail.com>
In-Reply-To: <CAHiYmc4Sb0c3pqbOfD=tJf9xvC6rJcOH4kxB=1KZ64Cp-ty58g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Apr 2020 10:14:36 +0100
Message-ID: <CAFEAcA8Othn-Tp3+EKu0HcyszHxUyVukX+NfAKc997+o5ZY7mw@mail.gmail.com>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 23:35, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> But, Eric, while, to some extent I understand your motivation and the ide=
a, there are still features working in in-tree builds only (some coccinele =
scenarios, and some gcov-related scenarios - and perhaps others that nobody=
 seems to care to try to find out at all), and not in out-of tree builds. A=
nd, now, if I understand well your proposal, and supposing that I use gcov =
in-tree build (since I have to), this will stop me from doing out-of-tree b=
uilds in this QEMU directory, since my in-tree gcov build will be destroyed=
.

To repeat from the last thread: we are *not going* to remove in-tree
builds before we fix whatever we need to to allow people to
use out-of-tree for whatever they are currently doing with in-tree
builds. The reason for putting in deprecation warnings etc now
is timescales: releases are every four months or so, so if we
want to warn users about something we need to put in that warning
well in advance. Bug fixes on the other hand can go into the tree
very quickly, so we can without any problems have a timeline that
goes deprecation-notice --- fix bugs with out-of-tree builds -- remove
or convert in-tree builds to automatically out-of-tree.

Plus the only way we find out about problems we're going to need
to fix is if we tell people "in-tree is going away" and they then tell
us "er, XYZ doesn't seem to work out-of-tree".

The reason people are currently focusing on the warning bit
is that we have about one week to do that if we want to get
it into this release. After that we have months to investigate
and fix the problems with out-of-tree builds.

Can you provide repro instructions for your gcov issue?

What is the "coccinelle scenario" you mention?

thanks
-- PMM

