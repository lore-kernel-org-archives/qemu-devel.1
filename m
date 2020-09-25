Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC02C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2614208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jl+OZMlA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2614208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLomN-00012A-T5
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLolF-00006M-4e
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLolC-0006S7-61
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 10:31:44 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601044300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wyCK96cBHAYN/P4O7aHWtbW7QHEao1bFU7EH+bJiPk8=;
 b=Jl+OZMlAq5ojsCvG3DrfWgkly9gjsbOdrbnq2Vs5sfu2QtHvNQ6HVSDSsgr9U+qoxmFwCc
 UxGy4W+9eIHm10NGHizYVMneWIpSIY/nVF5aBfk1agUE61WK5blcqEKpneqnPYaUXRYZSe
 SJo6SnumzfZKG94OiPGDpHHUT5oMSbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-X3TQs7pzM-mS8oyE32nqJw-1; Fri, 25 Sep 2020 10:31:27 -0400
X-MC-Unique: X3TQs7pzM-mS8oyE32nqJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86A0C1868425;
 Fri, 25 Sep 2020 14:31:25 +0000 (UTC)
Received: from work-vm (ovpn-114-177.ams2.redhat.com [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B60C655785;
 Fri, 25 Sep 2020 14:31:12 +0000 (UTC)
Date: Fri, 25 Sep 2020 15:31:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/26] migration and friends queue
Message-ID: <20200925143110.GB2874@work-vm>
References: <20200925120655.295142-1-dgilbert@redhat.com>
 <160103732220.12744.17131266745475052918@66eaa9a8a123>
MIME-Version: 1.0
In-Reply-To: <160103732220.12744.17131266745475052918@66eaa9a8a123>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: lvivier@redhat.com, quintela@redhat.com, hgcoin@gmail.com,
 zhangjiachen.jaycee@bytedance.com, peterx@redhat.com, zhengchuan@huawei.com,
 dovmurik@linux.vnet.ibm.com, ann.zhuangyanying@huawei.com, stefanha@redhat.com,
 jinyan12@huawei.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Patchew URL: https://patchew.org/QEMU/20200925120655.295142-1-dgilbert@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20200925120655.295142-1-dgilbert@redhat.com
> Subject: [PULL 00/26] migration and friends queue
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/20200925120655.295142-1-dgilbert@redhat.com -> patchew/20200925120655.295142-1-dgilbert@redhat.com
> Switched to a new branch 'test'
> 786afbf virtiofsd: Add -o allow_direct_io|no_allow_direct_io options
> b4e3d2f virtiofsd: Used glib "shared" thread pool
> 5c6cf53 virtiofsd: document cache=auto default
> b0a5d54 monitor: Use LOCK_GUARD macros
> 88b31e8 migration/tls: add trace points for multifd-tls
> 42dd844 migration/tls: add support for multifd tls-handshake
> 0dd99f4 migration/tls: extract cleanup function for common-use
> e951359 migration/tls: add tls_hostname into MultiFDSendParams
> 652dea8 migration/tls: extract migration_tls_client_create for common-use
> d70fc72 migration/tls: save hostname into MigrationState
> cb0c3a3 migration: increase max-bandwidth to 128 MiB/s (1 Gib/s)
> b4f2d50 migration: Truncate state file in xen-save-devices-state
> 7448415 migration/dirtyrate: Add trace_calls to make it easier to debug
> aa44e3a migration/dirtyrate: Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function
> 9a1f005 migration/dirtyrate: Implement calculate_dirtyrate() function
> f1bfba7 migration/dirtyrate: Implement set_sample_page_period() and is_sample_period_valid()
> cb3b7ff migration/dirtyrate: skip sampling ramblock with size below MIN_RAMBLOCK_SIZE
> a82b646 migration/dirtyrate: Compare page hash results for recorded sampled page
> 7d0f4d2 migration/dirtyrate: Record hash results for each sampled page
> 8a90389 migration/dirtyrate: move RAMBLOCK_FOREACH_MIGRATABLE into ram.h
> 539c0d7 migration/dirtyrate: Add dirtyrate statistics series functions
> 421892b migration/dirtyrate: Add RamblockDirtyInfo to store sampled page info
> cab1614 migration/dirtyrate: add DirtyRateStatus to denote calculation status
> 83826ff migration/dirtyrate: setup up query-dirtyrate framwork
> c58f028 migration: Rework migrate_send_rp_req_pages() function
> 012226f migration: Properly destroy variables on incoming side
> 
> === OUTPUT BEGIN ===
> 1/26 Checking commit 012226fcacb7 (migration: Properly destroy variables on incoming side)
> 2/26 Checking commit c58f0286fdde (migration: Rework migrate_send_rp_req_pages() function)
> WARNING: Block comments use a leading /* on a separate line
> #32: FILE: migration/migration.c:317:
> +/* Request one page from the source VM at the given start address.
> 
> total: 0 errors, 1 warnings, 89 lines checked

This is just changing the text of an existing comment that's of slightly
the wrong format.


> 
> Patch 2/26 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 3/26 Checking commit 83826ffcaf74 (migration/dirtyrate: setup up query-dirtyrate framwork)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #20: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 71 lines checked
> 
> Patch 3/26 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/26 Checking commit cab161480dd1 (migration/dirtyrate: add DirtyRateStatus to denote calculation status)
> 5/26 Checking commit 421892b2ce34 (migration/dirtyrate: Add RamblockDirtyInfo to store sampled page info)
> 6/26 Checking commit 539c0d7abcf0 (migration/dirtyrate: Add dirtyrate statistics series functions)
> 7/26 Checking commit 8a9038992bc0 (migration/dirtyrate: move RAMBLOCK_FOREACH_MIGRATABLE into ram.h)
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #67: FILE: migration/ram.h:42:
> +#define RAMBLOCK_FOREACH_NOT_IGNORED(block)            \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (ramblock_is_ignored(block)) {} else

This is just moving an existing macro and not changing it.

> ERROR: trailing statements should be on next line
> #69: FILE: migration/ram.h:44:
> +        if (ramblock_is_ignored(block)) {} else
> 
> ERROR: Macros with multiple statements should be enclosed in a do - while loop
> #71: FILE: migration/ram.h:46:
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    INTERNAL_RAMBLOCK_FOREACH(block)                   \
> +        if (!qemu_ram_is_migratable(block)) {} else
> 
> ERROR: trailing statements should be on next line
> #73: FILE: migration/ram.h:48:
> +        if (!qemu_ram_is_migratable(block)) {} else
> 
> ERROR: braces {} are necessary for all arms of this statement
> #73: FILE: migration/ram.h:48:
> +        if (!qemu_ram_is_migratable(block)) {} else
> [...]
> +        if (!qemu_ram_is_migratable(block)) {} else
> [...]
> 
> total: 5 errors, 0 warnings, 45 lines checked
> 
> Patch 7/26 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 8/26 Checking commit 7d0f4d22333b (migration/dirtyrate: Record hash results for each sampled page)
> 9/26 Checking commit a82b6464e8aa (migration/dirtyrate: Compare page hash results for recorded sampled page)
> 10/26 Checking commit cb3b7ff83ca3 (migration/dirtyrate: skip sampling ramblock with size below MIN_RAMBLOCK_SIZE)
> 11/26 Checking commit f1bfba70ecdd (migration/dirtyrate: Implement set_sample_page_period() and is_sample_period_valid())
> 12/26 Checking commit 9a1f0050a876 (migration/dirtyrate: Implement calculate_dirtyrate() function)
> 13/26 Checking commit aa44e3a85c97 (migration/dirtyrate: Implement qmp_cal_dirty_rate()/qmp_get_dirty_rate() function)
> 14/26 Checking commit 74484157cf26 (migration/dirtyrate: Add trace_calls to make it easier to debug)
> 15/26 Checking commit b4f2d50c15a8 (migration: Truncate state file in xen-save-devices-state)
> 16/26 Checking commit cb0c3a374335 (migration: increase max-bandwidth to 128 MiB/s (1 Gib/s))
> 17/26 Checking commit d70fc7217cc7 (migration/tls: save hostname into MigrationState)
> 18/26 Checking commit 652dea809a4b (migration/tls: extract migration_tls_client_create for common-use)
> 19/26 Checking commit e951359067b9 (migration/tls: add tls_hostname into MultiFDSendParams)
> 20/26 Checking commit 0dd99f4db197 (migration/tls: extract cleanup function for common-use)
> 21/26 Checking commit 42dd8447efd6 (migration/tls: add support for multifd tls-handshake)
> 22/26 Checking commit 88b31e8e1583 (migration/tls: add trace points for multifd-tls)
> 23/26 Checking commit b0a5d54e6e3e (monitor: Use LOCK_GUARD macros)
> 24/26 Checking commit 5c6cf5345c0f (virtiofsd: document cache=auto default)
> 25/26 Checking commit b4e3d2f9afca (virtiofsd: Used glib "shared" thread pool)
> 26/26 Checking commit 786afbf48ae9 (virtiofsd: Add -o allow_direct_io|no_allow_direct_io options)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200925120655.295142-1-dgilbert@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


