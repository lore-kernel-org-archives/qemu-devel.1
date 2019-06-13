Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32037C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:26:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CD020644
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tkmzhgyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CD020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbMwS-0006rT-Tr
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 06:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbMtB-0004lX-8O
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbMt6-000127-VX
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:23:23 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:46847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbMt4-0000wB-Fq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 06:23:19 -0400
Received: by mail-ot1-x32e.google.com with SMTP id z23so18413495ote.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 03:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WdFRak7eHYh7zPC3SC0f3eYOmKBjjHJi7bXK4gAQk40=;
 b=tkmzhgyo/bm4HhfKq6uJOoW5MG5yRndOZVvujm+MWmWx/Pnepdr4R0OOaariWIGyfn
 6jfqoX7zLEddkv+dYtdbjNX814YRgHTHbIV4b7lNXmBNJr4EBn7QkZgRNuiOI7S/DUSk
 sxpSBQtEEAkc4VSrc9imWPz/n+WCFoyJnzoY/tD4ConRQzhxWcGXSvw5vTAi6v+RrlsY
 k31OoTJcpMyxBUT/t2Jkhxvrq1iiE5Q+OO51jY4Fh+PIdirTH0ZEI4YY+h5JS8z/QlBA
 BF76mvC0K1+rmCIGoeJLzY4TIhhkPbwNdusOqnOEsIDYJnbsVdpygGCAGel0p9ZGX43R
 mAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WdFRak7eHYh7zPC3SC0f3eYOmKBjjHJi7bXK4gAQk40=;
 b=N5wPb5Z9CBJ3q5FL+4647ylXGU6kFVSsTZQNhREO1O4WOTw9PJbX0pWbdujMi74oqH
 M2edz6InhpQXzk+5goY/u08m8IGfmrH/hhj7g8FOVldEScJ7yhuVV9NpFJhjYs7QGs9n
 r0s/UDU9G/QEgI8jtbQKnk/bKZwmsvzo52BMhMWl3CKbptyLOYd5p4fdcCdjA5d/KvEN
 VA3zkOWdkGehj7C2pD8VwgovGFOeJkG4Uol3I7OZ7hcsTbRVMXHWJ/lqeJpbJXBQUbeJ
 RZESTAzxkj3wFxZfpPSfvntpKI1BT1qzFoE8LGFtSCSUm98ouPebcIG3ANEtvoa5HUAp
 MDuw==
X-Gm-Message-State: APjAAAU4jsMlDe4t5ffPTj5QfGMmqciWNdFZFnV5d933hgvgOKIznI4R
 UxsOEOG4DZCXHo9QxDRtw8dpBYcEP3VdgJaP26AMfQ==
X-Google-Smtp-Source: APXvYqzjMhhLWU2kmqKhjfueWDBoXhO4fnLiG3Kcl3Wox+TUJlnF2HIKlUwpYYQS9LcLkKFTzaX6iSnV/1BsNoPGFFs=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr41591452oti.221.1560421396066; 
 Thu, 13 Jun 2019 03:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190612104808.6398-1-quintela@redhat.com>
In-Reply-To: <20190612104808.6398-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jun 2019 11:23:05 +0100
Message-ID: <CAFEAcA8Cvqi7ouHfjFkxPBjXszu+hUVy7gzeFCA+1DcpgEVv6A@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [PULL 0/8] Migration patches
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Jun 2019 at 11:54, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 219dca61ebf41625831d4f96a720852baf44b762:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-request' into staging (2019-06-11 16:02:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>
> for you to fetch changes up to 87fa344f0684d7c62b0859632de4b6c28e32f2c7:
>
>   migratioin/ram.c: reset complete_round when we gets a queued page (2019-06-12 12:38:12 +0200)
>
> ----------------------------------------------------------------
> Migration pull request
>
> * misc fixes from wei
> * Fixes for the multifd compression tree (juan)
>
> Please apply

Hi. This fails 'make check' on aarch32 (possibly on all
32-bit guests, aarch32 is my only 32-bit host):

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
/dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
PASS 1 migration-test /aarch64/migration/deprecated
PASS 2 migration-test /aarch64/migration/bad_dest
PASS 3 migration-test /aarch64/migration/fd_proto
PASS 4 migration-test /aarch64/migration/postcopy/unix
PASS 5 migration-test /aarch64/migration/postcopy/recovery
PASS 6 migration-test /aarch64/migration/precopy/unix
PASS 7 migration-test /aarch64/migration/precopy/tcp
PASS 8 migration-test /aarch64/migration/xbzrle/unix
malloc_consolidate(): invalid chunk size
Broken pipe
qemu-system-aarch64: check_section_footer: Read section footer failed: -5
qemu-system-aarch64: load of migration failed: Invalid argument
/home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
terminate QEMU process but encountered exit status 1
Aborted
ERROR - too few tests run (expected 9, got 8)
/home/peter.maydell/qemu/tests/Makefile.include:888: recipe for target
'check-qtest-aarch64' failed

thanks
-- PMM

