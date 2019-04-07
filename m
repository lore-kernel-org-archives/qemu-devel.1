Return-Path: <SRS0=0TSG=SJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E37C10F0E
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D83218D0
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2019 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ww2UvcHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D83218D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hD8Gq-0007Of-Gy
	for qemu-devel@archiver.kernel.org; Sun, 07 Apr 2019 09:55:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD8G2-00075S-Me
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hD8G1-0000dr-M2
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:54:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hD8G1-0000dY-5P
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 09:54:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id u15so9639551otq.10
	for <qemu-devel@nongnu.org>; Sun, 07 Apr 2019 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/fjYcpK2tKjyXEYxy2I7PrYE0KgauzlaRLppJlYJ9Fo=;
	b=ww2UvcHxVdh+QE75NTJ5FJqF9V3UO579qfGcYh4OhWoYPwmzLZ42KDUy/4OIJ+V8vt
	2TZFAjQn/wvszD/j1cCkj5AJS3gz3w3QiBMyahVgWcXfRSWHk1Rna8lODRjW3lRdGjh4
	dj3D/BIEr5Xox22U4tl8O70I3RQYVeRsUeSPxJ/KaSQbSF2uZVi5wzNOzvY2HtzuZASg
	tpvYOeJE/Ha8EudA8kub5DdZhlNYsIqFuwasmVAAtSbd9XuROPAUHxLwfkrTf7UCnHRE
	qBJedTqGYR2CqsIdEBq51C6c1MaoIjPGgaq5DBkbvn9iIGR4zd0xGhEXLUGvDyjj/NGs
	/uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/fjYcpK2tKjyXEYxy2I7PrYE0KgauzlaRLppJlYJ9Fo=;
	b=CVRbk3Jf/3zc0jRrwdBe6j7PL3Py/jCCngwVRYaBSkMsh36ucJOuqrEgfpznBau3BO
	U/hiwrO+Vt2fhUc8DxDxV3qR3q1VhP3CQZyYTpZLYnW1KG1irXLZduTBKPvHW7dsyeI+
	FLwEeWOlF0rD++SiSZL7PcoClVko2LwZF7L3ORb+zjNsxm/dL9mR4waB3pm1E6KltDc4
	Wf6O6rsPnbPW6tNQdtZh6Hq+DMeLMYqUgj6tzUijdG7wakYpzOsTZqhj35w519u0N2mc
	g/Wds3DA353Ui1o149/eUq8IceRyqklq8R+a7ravBVQ5nH6CMOm71qClzj3FOXY4o5+H
	L4iQ==
X-Gm-Message-State: APjAAAWCMDCcqfabKZkdHEqbMq4gbNS7F2Agy/f7Nl6C/Vs8blfVYLe+
	uRZ12zF3DUupVPWj9AUcEKkRoyh9erRdyl+TVu/cRA==
X-Google-Smtp-Source: APXvYqzdTm7fmzxWFazKuTM0qbv5LPHRTmqPY5vqbSwxwDSbh3fwRyn0jayXa0vAK1IAbW2pcg9YW8CdLyoJ0c+jdWQ=
X-Received: by 2002:a05:6830:1497:: with SMTP id
	s23mr12038139otq.236.1554645287956; 
	Sun, 07 Apr 2019 06:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190405154934.18664-1-dgilbert@redhat.com>
In-Reply-To: <20190405154934.18664-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 7 Apr 2019 14:54:36 +0100
Message-ID:
 <CAFEAcA8xXxtEkBe_brLMv+TTxuRAwhfHZXntd3d5bpZ2un57ow@mail.gmail.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 0/2] migration queue
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
Cc: Zhang Chen <chen.zhang@intel.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190407135436.t9tUNDUYdqSQJv3oFnMVqIQkypgzicQzthHFzDSnMI8@z>

On Fri, 5 Apr 2019 at 16:51, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 10546e09e174e0bb185b66a4c397aa845efcd36e:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-4.0-rc3-v2' into staging (2019-04-05 04:50:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190405a
>
> for you to fetch changes up to d013283a46e1f197594e76ed320f867067ab80b3:
>
>   migration: Fix migrate_set_parameter (2019-04-05 15:32:13 +0100)
>
> ----------------------------------------------------------------
> Migration fixes pull for 4.0
>
> A couple of fixes for crashes in colo and
> migration parameters.
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM

