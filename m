Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C97FC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33ECD20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 11:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ECD20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbNkG-00063D-Qx
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 07:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45163)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hbNiY-0005aL-Sk
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hbNiX-0000Hl-F0
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hbNiX-0008K9-76
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 07:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28736C1EB1FE;
 Thu, 13 Jun 2019 11:15:52 +0000 (UTC)
Received: from redhat.com (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90E16610A7;
 Thu, 13 Jun 2019 11:15:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
In-Reply-To: <CAFEAcA8Cvqi7ouHfjFkxPBjXszu+hUVy7gzeFCA+1DcpgEVv6A@mail.gmail.com>
 (Peter Maydell's message of "Thu, 13 Jun 2019 11:23:05 +0100")
References: <20190612104808.6398-1-quintela@redhat.com>
 <CAFEAcA8Cvqi7ouHfjFkxPBjXszu+hUVy7gzeFCA+1DcpgEVv6A@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 13 Jun 2019 13:15:48 +0200
Message-ID: <87tvctlorf.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 13 Jun 2019 11:15:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Wed, 12 Jun 2019 at 11:54, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit 219dca61ebf41625831d4f96a720852baf44b762:
>>
>>   Merge remote-tracking branch
>> 'remotes/ehabkost/tags/x86-next-pull-request' into staging
>> (2019-06-11 16:02:07 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/juanquintela/qemu.git tags/migration-pull-request
>>
>> for you to fetch changes up to 87fa344f0684d7c62b0859632de4b6c28e32f2c7:
>>
>>   migratioin/ram.c: reset complete_round when we gets a queued page
>> (2019-06-12 12:38:12 +0200)
>>
>> ----------------------------------------------------------------
>> Migration pull request
>>
>> * misc fixes from wei
>> * Fixes for the multifd compression tree (juan)
>>
>> Please apply
>
> Hi. This fails 'make check' on aarch32 (possibly on all
> 32-bit guests, aarch32 is my only 32-bit host):
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
> malloc_consolidate(): invalid chunk size
> Broken pipe
> qemu-system-aarch64: check_section_footer: Read section footer failed: -5
> qemu-system-aarch64: load of migration failed: Invalid argument
> /home/peter.maydell/qemu/tests/libqtest.c:137: kill_qemu() tried to
> terminate QEMU process but encountered exit status 1
> Aborted
> ERROR - too few tests run (expected 9, got 8)
> /home/peter.maydell/qemu/tests/Makefile.include:888: recipe for target
> 'check-qtest-aarch64' failed

Thanks, looking into it.

Later, Juan.

