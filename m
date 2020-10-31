Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52487C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 16:13:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 700A82224D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 16:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="cct7xWnZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 700A82224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYtVQ-0007xW-5O
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYtUS-0007R9-1a
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 12:12:28 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYtUP-0004QP-Vs
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 12:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=BOnknlWkU6SfqAeSSKXQkZeSj+EBLxh0IVngr6pfjYI=; b=cct7xWnZoAFCntfFT/VKpWcgxj
 QCBRuvNB+3y1qpy2Zri0R2RJxqs8cqaVgy5ENSz3hgRTVZ/WV8HNVbBwKZXYtswWMQZ3dOmo5HspE
 +r5OK2LCIh79IhAAfUzSdwV6C8c79c/v5AWSnfvNJpnTeR9DtoCzVIGrGAz77v6ssoTJHhI07ATmM
 wpUExCW9y1tQuGVMJh2A+woNX172uNvx1lhPzdV3Z7chxkoqcuUQPrMQKDJJyp37xLd4JV+hQIdh5
 pMhMHO8Vfp/7VZAiIUYLD6QnVb95oPdLj366eO0MHUnyxXtlddKIT4+6R7MUAmBXh/KDyApqW0okG
 DZKqDNWg==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, yubihong@huawei.com,
 peterx@redhat.com, peter.maydell@linaro.org, quintela@redhat.com
Subject: Re: [PULL 00/16] migration queue
Date: Sat, 31 Oct 2020 17:12:20 +0100
Message-ID: <2333379.eghUmhzIt0@silver>
In-Reply-To: <20201026161952.149188-1-dgilbert@redhat.com>
References: <20201026161952.149188-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 12:12:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 26. Oktober 2020 17:19:36 CET Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The following changes since commit a46e72710566eea0f90f9c673a0f02da0064acce:
> 
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201026' into
> staging (2020-10-26 14:50:03 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/dagrh/qemu.git tags/pull-migration-20201026a
> 
> for you to fetch changes up to a47295014de56e108f359ec859d5499b851f62b8:
> 
>   migration-test: Only hide error if !QTEST_LOG (2020-10-26 16:15:04 +0000)
> 
> ----------------------------------------------------------------
> migration pull: 2020-10-26
> 
> Another go at Peter's postcopy fixes
> 
> Cleanups from Bihong Yu and Peter Maydell.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

May it be possible that this PR introduced a lockup of the qtests that I am 
encountering in this week's upstream revisions?

PASS 25 qtest-x86_64/bios-tables-test /x86_64/acpi/microvm/pcie

Looking for expected file 'tests/data/acpi/microvm/FACP.rtc'
Looking for expected file 'tests/data/acpi/microvm/FACP'
Using expected file 'tests/data/acpi/microvm/FACP'
Looking for expected file 'tests/data/acpi/microvm/APIC.rtc'
Looking for expected file 'tests/data/acpi/microvm/APIC'
Using expected file 'tests/data/acpi/microvm/APIC'
Looking for expected file 'tests/data/acpi/microvm/DSDT.rtc'
Using expected file 'tests/data/acpi/microvm/DSDT.rtc'
PASS 24 qtest-i386/bios-tables-test /i386/acpi/microvm/rtc
PASS 15 qtest-i386/migration-test /i386/migration/multifd/tcp/cancel
PASS 16 qtest-i386/migration-test /i386/migration/multifd/tcp/zlib
^Cmake: *** [Makefile.mtest:1169: run-test-144] Interrupt

I tried to bisect the causing commit and came up to this PR merge. But I'm not 
absolutely sure it really is, because it sometimes takes 2 hours or more to 
trigger the lockup, so the relevant commit may as well have slipped during 
bisection.

Last week's revisions run here for >24h without issues, right now I get 
lockups of test runs after ~3min .. ~2h when running the qtests in an endless 
loop:

#/bin/sh
i=0
while true; do
  i=$[$i+1]
  echo '**************************************************'
  echo "* RUN $i                                         *"
  echo '**************************************************'
  make check-qtest -j32 V=1
  if [[ "$?" -ne 0 ]]; then
    echo "Aborted after $i runs due to failure"
    break
  fi
done

> ----------------------------------------------------------------
> Bihong Yu (9):
>       migration: Do not use C99 // comments
>       migration: Don't use '#' flag of printf format
>       migration: Add spaces around operator
>       migration: Open brace '{' following struct go on the same line
>       migration: Add braces {} for if statement
>       migration: Do not initialise statics and globals to 0 or NULL
>       migration: Open brace '{' following function declarations go on the
> next line migration: Delete redundant spaces
>       migration: using trace_ to replace DPRINTF
> 
> Peter Maydell (1):
>       migration: Drop unused VMSTATE_FLOAT64 support
> 
> Peter Xu (6):
>       migration: Pass incoming state into qemu_ufd_copy_ioctl()
>       migration: Introduce migrate_send_rp_message_req_pages()
>       migration: Maintain postcopy faulted addresses
>       migration: Sync requested pages after postcopy recovery
>       migration/postcopy: Release fd before going into 'postcopy-pause'
>       migration-test: Only hide error if !QTEST_LOG
> 
>  include/migration/vmstate.h  | 13 ----------
>  migration/block.c            | 40 ++++++++++++++---------------
>  migration/migration.c        | 59
> +++++++++++++++++++++++++++++++++++++----- migration/migration.h        |
> 24 ++++++++++++++---
>  migration/page_cache.c       | 13 +++-------
>  migration/postcopy-ram.c     | 27 +++++++++++++++-----
>  migration/ram.c              | 14 +++++-----
>  migration/rdma.c             |  7 ++---
>  migration/savevm.c           | 61
> ++++++++++++++++++++++++++++++++++++++++++-- migration/trace-events       |
> 16 ++++++++++++
>  migration/vmstate-types.c    | 26 -------------------
>  migration/vmstate.c          | 10 ++++----
>  tests/qtest/migration-test.c |  6 ++++-
>  13 files changed, 213 insertions(+), 103 deletions(-)



