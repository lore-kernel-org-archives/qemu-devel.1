Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B6C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:38:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A464E20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 17:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNRqMV+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A464E20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50879 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLWiK-0004sr-W9
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 13:38:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLWXE-0005MF-Pe
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hLWXD-0003lI-JU
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:27:16 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:38999)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hLWXD-0003kn-Eu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 13:27:15 -0400
Received: by mail-ot1-x330.google.com with SMTP id o39so1398561ota.6
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 10:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:from:date:message-id:subject:to:cc;
	bh=Mv7L6YH1vwZQ5V0voouf7+D+RgJo7sqyvVYumdefQKQ=;
	b=BNRqMV+YmaffJXJohfdLj3Kf+EfqgRNq4Fmz92bGWeMJb6FHIWnpIuYsFAsHJDqUGY
	ckcBCEdkQMWntKcPHRYStLEIC0ZmWzaThEjDrRkGTQ3RROJNL8i5LOv4meNfylAT5ALJ
	bHOyB7j0rXjnYIV+oZTmksNT8hOHBLAU52pRyunPN4fqR1NMTG1lzX9oWpoljRqqt+iA
	6S1w6hMmZCVp8ORB0UMuRf2iJWoQD6aTr+bnH1WidmQ2oophUYVREyhqVgKneT+eoN41
	2cXY6L6zOQ9tdQ+f2vvYTSjhGt6dFWqwQWmxFcYp8vQcXxjzcR157jwVjS9MdedVcBSR
	Z5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
	bh=Mv7L6YH1vwZQ5V0voouf7+D+RgJo7sqyvVYumdefQKQ=;
	b=cRXjuOOgPtObO84/9nBtRkWUGjekJXzfWyjsS0yrqfmqEEqlMqnxUTFcdGZw2jR86g
	wBWsacfz+TmGQVhigAc0Kx1yBt3lhXtW9Nz+ooetw7+dZPPaM6/U2smuEsBEodL/0qn/
	8GyrttIQk1fbK9GmfiHb0EC6hSKOEfQJHbs4onX8F+G4hA2SrrVGXS65FSYMD5z+wsCU
	S85MrsoH8NVuRdjW65Ve308m+zOTWHxY1x3mzdaxyTFPXw7W/Y95p0GY5blVqDjhq98w
	MaLyWt7LzcEDsz0qTGcjmx6sf+tL7N9NuFKJ3vkpwU15NCL3AY9df2wtjBkU1WpLJuDq
	J9iw==
X-Gm-Message-State: APjAAAVug3XmtBjEjJZERmb6JkTNduHpxnsJJ+co1klHrS6K56k0FcFb
	X0K7ZCDgI+d8Kt1k++hijSnjpGtbMrySSESledUb+7mbx/U=
X-Google-Smtp-Source: APXvYqwg4f1CA+m9N5f1xVF3svKdrdiPI907amvbFSrA2G4oAyPjxLx11puFmhtTBVIHy4ceKzT9kM3whAURRLwVV4A=
X-Received: by 2002:a9d:360b:: with SMTP id w11mr16964946otb.238.1556645234272;
	Tue, 30 Apr 2019 10:27:14 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2019 18:27:03 +0100
Message-ID:
 <CAFEAcA9BCXuOxaFaHvT0bDnb+7e_vYuhxspjokRp19G+SUf+MA@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: [Qemu-devel] Spreading the load on QEMU pullreq handling and
 release work
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430172703.Ick5h8VVN9UqAXKVlQWAMGgRiSUy_loI9ck1_ucLylw@z>

For most releases in the past five years, I've been handling the
work of applying pull requests, tagging release candidates, and
so on. (For one or two releases somebody else has done this when
I've been off on holiday.) This takes up a fair chunk of my time
during the actual "release" phase of a cycle, and it also
represents a "bus factor" issue for the project if I'm the only
person doing this. I'd like to try to spread this work out a bit
between more people.

Specifically, where I'd like to get to is that we have a rota of
three people doing this, which at our "three releases a year"
pace means any one person only has to handle one release cycle
a year.

Part of this move is going to require moving away from some of the
ad-hoc scripting and testing that I currently do on a selection of
personal and work machines and instead using machines that can be
used by other project members.  (One recent suggestion is that
perhaps the gitlab CI might be a useful place to start, since it
allows us to provide custom build workers rather than only doing
x86 host testing.)

For the moment I'd like to ask for in-principle volunteers
to be on the release-handling rota.

The work involves:
 * the mechanical process of actually processing pullreq
   emails and applying them
 * letting people know about failures, which can mean some
   investigation of exactly why something has failed to
   distinguish problems with the pull from preexisting
   intermittent failures from infrastructure issues
 * more careful by-hand scrutiny of pull requests from
   submaintainers who haven't done it before or who don't make
   pull requests often (checking for missing signoffs, weirdly
   malformed pull requests, patches that shouldn't be in the
   pull, etc)
 * maintenance of what I guess will need to be a shared
   project GPG keyring to add submaintainer keys (there's
   a judgement call required for whether a new key is
   sufficiently trusted, working with the submaintainer to
   ask them to try to get more signatures if possible, etc)
 * curating the "Planning" wiki page where we record things
   not yet fixed in the current release, including chasing
   people for fixes for RC bugs, asking around if anything
   ought to go in, tracking potential RC issues that crop up
   on the mailing list, etc
 * making sure we correctly raise the "is this important
   enough to go in" bar for pull requests during the release
   candidate phase by scrutinizing pull requests and if
   necessary pushing back on submaintainers
 * likely some other things I have forgotten

Since there is a definite human judgement required here, this
isn't going to be a fully automatable process[*], and it would
be best done by people who've got a reasonably long history of
working with the project (both from a trust perspective and
because they have the experience to make the judgement calls
required).

[*] It could quite possibly be automated a bit more than I
currently do it, though. I'm also open to the idea that maybe we
should do less gatekeeping at the apply-pull stage and instead
delegate to submaintainers to make the right judgements, though
in my experience there is usually at least one pullreq
submitted late in the rc process which has stuff in it that
should not go in at that point...

NB: at the moment there is a split in handling of release
candidates and the release, where I do the tagging of an rc in
git, and Michael Roth then rolls tarballs and makes
announcements of the rc or final release. Michael -- is that
work something you'd like to spread around between more people
or are you happy to continue to do it all?

So, any volunteers (from anybody, not just people on the cc list) ?

thanks
-- PMM

