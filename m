Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559A7C742D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:54:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B2392054F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 17:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2392054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlzkq-0006fM-R4
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 13:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hlzkg-0006Fo-EQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hlzke-000796-DS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:54:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28503)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hlzkc-00077K-I1
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 13:54:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1884A3E2CD;
 Fri, 12 Jul 2019 17:54:28 +0000 (UTC)
Received: from work-vm (ovpn-117-214.ams2.redhat.com [10.36.117.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3DCF601B7;
 Fri, 12 Jul 2019 17:54:22 +0000 (UTC)
Date: Fri, 12 Jul 2019 18:54:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190712175420.GO2730@work-vm>
References: <20190712143207.4214-1-quintela@redhat.com>
 <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ydNS072OH7CyGNq2+sESgonW-8QSJdNYJq6zW-rYjUQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 12 Jul 2019 17:54:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/19] Migration patches
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
 kvm-devel <kvm@vger.kernel.org>, Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Fri, 12 Jul 2019 at 15:32, Juan Quintela <quintela@redhat.com> wrote:
> >
> > The following changes since commit a2a9d4adabe340617a24eb73a8b2a116d28a6b38:
> >
> >   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-4.1-20190712' into staging (2019-07-12 11:06:48 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/juanquintela/qemu.git tags/migration-pull-request
> >
> > for you to fetch changes up to a48ad5602f496236b4e1955d9e2e8228a7d0ad56:
> >
> >   migration: allow private destination ram with x-ignore-shared (2019-07-12 16:25:59 +0200)
> >
> > ----------------------------------------------------------------
> > Migration pull request
> >
> > Fix the issues with the previous pull request and 32 bits.
> >
> > Please apply.
> >
> 
> Still fails on aarch32 host, I'm afraid:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=aarch64-softmmu/qemu-system-aarch64
> QTEST_QEMU_IMG=qemu-img tests/migration-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="migration-test"
> PASS 1 migration-test /aarch64/migration/deprecated
> PASS 2 migration-test /aarch64/migration/bad_dest
> PASS 3 migration-test /aarch64/migration/fd_proto
> PASS 4 migration-test /aarch64/migration/postcopy/unix
> PASS 5 migration-test /aarch64/migration/postcopy/recovery
> PASS 6 migration-test /aarch64/migration/precopy/unix
> PASS 7 migration-test /aarch64/migration/precopy/tcp
> PASS 8 migration-test /aarch64/migration/xbzrle/unix
> malloc(): memory corruption
> Broken pipe
> qemu-system-aarch64: load of migration failed: Invalid argument
> /home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1
> Aborted
> ERROR - too few tests run (expected 9, got 8)
> /home/peter.maydell/qemu/tests/Makefile.include:899: recipe for target
> 'check-qtest-aarch64' failed

Hmm, I think the only one to go near xbzrle specifically is
'migration/xbzrle: update cache and current_data in one place'

it did look right to me; but that is a subtle function so hmmmm.

Dave

> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

