Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E528C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:54:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B5624641
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCcEp3Fb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B5624641
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5l9-0005ZP-8w
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5jt-00056v-J9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kX5jp-0004fS-OG
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 12:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603731170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aSAECN1rOh1RDoF+w42zxD8/cd0u5IeZdo7PG+SJk1E=;
 b=JCcEp3Fb7qksaDmY86Lyl3aqhFpiuHr82o0z1iFsVh3GSaAX8wYxAZWwxcOgxlGDTLlDSe
 vvvv+o09TCGnTG1y7/7i6NPhYy1l5YwRwT+1fxNtYoY4fbOpmswQn2w2pbGVkMJIuwgK/g
 ibdMdkhwtuJBIgs3bjMwUcEG2MGaPS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-j1LepEjGNASnrHjkagncDA-1; Mon, 26 Oct 2020 12:52:46 -0400
X-MC-Unique: j1LepEjGNASnrHjkagncDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D47BA809DC0;
 Mon, 26 Oct 2020 16:52:44 +0000 (UTC)
Received: from work-vm (ovpn-112-208.ams2.redhat.com [10.36.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91E516EF50;
 Mon, 26 Oct 2020 16:52:40 +0000 (UTC)
Date: Mon, 26 Oct 2020 16:52:37 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/16] migration queue
Message-ID: <20201026165237.GJ3277@work-vm>
References: <20201026161952.149188-1-dgilbert@redhat.com>
 <160373038097.1984.565441285420567282@66eaa9a8a123>
MIME-Version: 1.0
In-Reply-To: <160373038097.1984.565441285420567282@66eaa9a8a123>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: yubihong@huawei.com, peter.maydell@linaro.org, peterx@redhat.com,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* no-reply@patchew.org (no-reply@patchew.org) wrote:
> Patchew URL: https://patchew.org/QEMU/20201026161952.149188-1-dgilbert@redhat.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20201026161952.149188-1-dgilbert@redhat.com
> Subject: [PULL 00/16] migration queue
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
>  - [tag update]      patchew/1603704987-20977-1-git-send-email-kwankhede@nvidia.com -> patchew/1603704987-20977-1-git-send-email-kwankhede@nvidia.com
>  * [new tag]         patchew/20201026161952.149188-1-dgilbert@redhat.com -> patchew/20201026161952.149188-1-dgilbert@redhat.com
> Switched to a new branch 'test'
> eec7173 migration-test: Only hide error if !QTEST_LOG
> 3cf5619 migration/postcopy: Release fd before going into 'postcopy-pause'
> 05826d6 migration: Sync requested pages after postcopy recovery
> e3ab9bd migration: Maintain postcopy faulted addresses
> 94c47fd migration: Introduce migrate_send_rp_message_req_pages()
> 37f5d13 migration: Pass incoming state into qemu_ufd_copy_ioctl()
> d212778 migration: using trace_ to replace DPRINTF
> 57fda59 migration: Delete redundant spaces
> 5b093f1 migration: Open brace '{' following function declarations go on the next line
> 0b60dca migration: Do not initialise statics and globals to 0 or NULL
> 2f219b6 migration: Add braces {} for if statement
> 3fdcabc migration: Open brace '{' following struct go on the same line
> 63bb26e migration: Add spaces around operator
> fadaa39 migration: Don't use '#' flag of printf format
> e568828 migration: Do not use C99 // comments
> e477d01 migration: Drop unused VMSTATE_FLOAT64 support
> 
> === OUTPUT BEGIN ===
> 1/16 Checking commit e477d010bf93 (migration: Drop unused VMSTATE_FLOAT64 support)
> 2/16 Checking commit e568828c0e63 (migration: Do not use C99 // comments)
> 3/16 Checking commit fadaa39cfb42 (migration: Don't use '#' flag of printf format)
> 4/16 Checking commit 63bb26e930c4 (migration: Add spaces around operator)
> ERROR: spaces required around that '*' (ctx:WxV)
> #65: FILE: migration/savevm.c:523:
> +    .subsections = (const VMStateDescription *[]) {
>                                               ^
> 
> total: 1 errors, 0 warnings, 59 lines checked

We decided that was preferable

> 
> Patch 4/16 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 5/16 Checking commit 3fdcabce2015 (migration: Open brace '{' following struct go on the same line)
> 6/16 Checking commit 2f219b67cf64 (migration: Add braces {} for if statement)
> 7/16 Checking commit 0b60dca56f19 (migration: Do not initialise statics and globals to 0 or NULL)
> 8/16 Checking commit 5b093f15f482 (migration: Open brace '{' following function declarations go on the next line)
> 9/16 Checking commit 57fda592d44b (migration: Delete redundant spaces)
> 10/16 Checking commit d21277810b4a (migration: using trace_ to replace DPRINTF)
> 11/16 Checking commit 37f5d13fa1bb (migration: Pass incoming state into qemu_ufd_copy_ioctl())
> 12/16 Checking commit 94c47fdc32f4 (migration: Introduce migrate_send_rp_message_req_pages())
> 13/16 Checking commit e3ab9bded382 (migration: Maintain postcopy faulted addresses)
> 14/16 Checking commit 05826d6ec62a (migration: Sync requested pages after postcopy recovery)
> 15/16 Checking commit 3cf5619e375b (migration/postcopy: Release fd before going into 'postcopy-pause')
> 16/16 Checking commit eec7173d989d (migration-test: Only hide error if !QTEST_LOG)
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20201026161952.149188-1-dgilbert@redhat.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


