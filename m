Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F2FC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828D5206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 18:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhW7DnsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828D5206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hygna-0006vR-IQ
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 14:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hygmj-0006S2-KY
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hygmh-0008JB-VX
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:17:09 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:38861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hygmh-0008Is-PV
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 14:17:07 -0400
Received: by mail-oi1-x22e.google.com with SMTP id p124so5449049oig.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=ufR6XL4bF/TzAlBaApWvgRJSr8sN52C10wDxxE7df8A=;
 b=hhW7DnsSz2LXV7W90KdwWsXbuLtQJQa1prJ0+1JD/I/xCjNSbfB+CxCBOX5OEgM/Qs
 jyvSpzeVCa/J6685ib2lYjyzpalNsDUc7NQ67roJaEYLEN/GuVV3L14r4fkEBwf+UmJl
 os9NGl+FxA9POE1u5zD1uktZeSmPwG6VrOunKm0KdiwJLlKkRnB47j3ViaMymf+zJNa2
 lG0SyIJq+tMYPxz4HjAjjjx24FeQRJCbSmCo2lvNz9mDVSCdakATRMwzoNcUzr5DKgnN
 QUNTh7IpqxECV/XKKuX+53Umr8OGldFVrq0VOEbR830Ft7LQmThclDtmT5idpp7EtuoB
 ZWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=ufR6XL4bF/TzAlBaApWvgRJSr8sN52C10wDxxE7df8A=;
 b=MG/NyNNJgRy4lOEjaSEwQ5YclNyg3sKPdldc3/WW5xvXao4BvvMxuHIpLyOul92uO6
 Ta85xbC6dg/G3QiFdRaEB0jopPbjily38jvB/TCLyrFWxrWcPhmvo19X9IRgt+0/b5Xh
 hkhF/q3OMdsUQZ0gGtbRbA5xdcYBaBBKwNjij/dkW+oYO0FgeO93GWfW4QTCOoiJcUEH
 ziP9X0jZD7NAyEN4VSLgXTTm9TIX6lY4PC10aB7zBXfMm6Wh129jZzQkmxYM6dM1hJOS
 cZKDuzLVcCZ96RjeAYmAIBRTU7jqhFqDHN3ttX/VFxjkH3DsoWdz5/ooQxZdFEKqiFCm
 2fGw==
X-Gm-Message-State: APjAAAUok+rtSSKORxkUKWViZeujjFeBE9+96svUaP+PhX37XSgvK0CD
 oWkIDCVtgRB6eZL5wLHAuHBQ8vHXhLEuao0QzsZAeGBW
X-Google-Smtp-Source: APXvYqz+ofnKGRCVMhD9EO2IEB/xlvg2RxPeXLLA6x64Qw/pRCIINUUEET0oEV+xpC1L+ZEFUMqgLIzxumGKZjubpRQ=
X-Received: by 2002:aca:6185:: with SMTP id v127mr5958831oib.163.1565979426389; 
 Fri, 16 Aug 2019 11:17:06 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Aug 2019 19:16:55 +0100
Message-ID: <CAFEAcA8kEKVcRu62+VGDkzRj2J87QPxzjg05dCHszeBC6X76pg@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: [Qemu-devel] more automated/public CI for QEMU pullreqs
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had a conversation some months back about ways we might switch
away from the current handling of pull requests which I do via some
hand-curated scripts and personal access to machines, to a more
automated system that could be operated by a wider range of people.
Unfortunately that conversation took place off-list (largely my fault
for forgetting a cc: at the beginning of the email chain), and in any
case it sort of fizzled out.  So let's restart it, on the mailing
list this time.

Here's a summary of stuff from the old thread and general
explanation of the problem:

My current setup is mostly just running the equivalent of
"make && make check" on a bunch of machines and configs
on the merge commit before I push it to master. I also do
a 'make check-tcg' on one of the builds and run a variant
of the 'linux-user-test' tarball of 'ls' binaries.
The scripts do some simple initial checks which mostly are
preventing problems seen in the past:
 * don't allow submodules to be updated unless I kick the
   merge off with a command line option saying submodule updates
   are OK here (this catches accidental misdriving of git by
   a submaintainer folding a submodule change into a patch
   during a rebase)
 * check we aren't trying to merge after tagging the final
   release but before doing the 'reopen development tree'
   commit that bumps the VERSION file
 * check for bogus "author is qemu-devel@nongnu.org" commits
 * check for UTF-8 mangling
 * check the gpg signature on the pullreq
A human needs to also eyeball the commits and the diffstat
for weird stuff (usually cursory for frequent pullreq submitters,
and more carefully for new submaintainers).

I have this semi-automated with some hacky scripts.  The major thing we
need for a replacement is the coverage of different host
architectures and operating systems, which is a poor match to most of
the cloud-CI services out there (including Travis).  We also want the
tests to run in a reasonably short wall-clock time from being kicked
off.

Awkward bonus extra requirement: it would be useful to be
able to do a merge CI run "privately", eg because the thing
being tested is a fix for a security bug that's not yet
public. But that's rare so we can probably do it by hand.

There are some other parts to this, like getting some kind of
project-role-account access to machines where that's OK, or finding
replacements where the machines really are my personal ones or
otherwise not OK for project access.  But I think that should be
fairly easy to resolve so let's keep this thread to the
automating-the-CI part.

The two major contenders suggested were:

(1) GitLab CI, which supports custom 'runners' which we can set
up to run builds and tests on machines we have project access to

(2) Patchew, which can handle running tests on multiple machines (eg
we do s390 testing today for all patches on list), and which we could
enhance to provide support for the release-manager to do their work

Advantages of Gitlab CI:
 * somebody else is doing the development and maintainance of the
   CI tool -- bigger 'bus factor' than patchew
 * already does (more or less) what we want without needing
   extra coding work

Advantages of Patchew:
 * we're already using it for patch submissions, so we know it's
   not going to go away
 * it's very easy to deploy to a new host
 * no dependencies except Python, so works anywhere we expect
   to be able to build QEMU (whereas gitlab CI's runner is
   written in Go, and there seem to be ongoing issues with getting
   it actually to compile for other architectures than x86)

I don't have an opinion really, but I think it would be good to
make a choice and start working forwards towards getting this
a bit less hacky and a bit more offloadable to other people.

Perhaps a good first step would be to keep the 'simple checks
of broken commits' part done as a local script but have the
CI done via "push proposed merge commit to $SOMEWHERE to
kick off the CI".

Input, opinions, recommendations, offers to do some of the work? :-)

thanks
-- PMM

