Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C11C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21262077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 20:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21262077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyiUK-0006FY-2K
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 16:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1hyiTh-0005lG-7w
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hyiTf-00015a-So
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 16:05:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44628)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>)
 id 1hyiTd-00012f-0d; Fri, 16 Aug 2019 16:05:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C259315C013;
 Fri, 16 Aug 2019 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-60.rdu2.redhat.com
 [10.10.124.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2E6517AFF;
 Fri, 16 Aug 2019 20:05:29 +0000 (UTC)
Date: Fri, 16 Aug 2019 16:05:27 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190816200527.GA20950@localhost.localdomain>
References: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563553816-148827-1-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 16 Aug 2019 20:05:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 0/6] Allow Valgrind checking all QEMU
 processes
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 19, 2019 at 07:30:10PM +0300, Andrey Shinkevich wrote:
> In the current implementation of the QEMU bash iotests, only qemu-io
> processes may be run under the Valgrind, which is a useful tool for
> finding memory usage issues. Let's allow the common.rc bash script
> runing all the QEMU processes, such as qemu-kvm, qemu-img, qemu-ndb
> and qemu-vxhs, under the Valgrind tool.
>

FIY, this looks very similar (in purpose) to:

   https://avocado-framework.readthedocs.io/en/71.0/WrapProcess.html

And in fact Valgrind was one of the original motivations:

   https://github.com/avocado-framework/avocado/blob/master/examples/wrappers/valgrind.sh

Maybe this can be helpful for the Python based iotests.

- Cleber.

> v5:
>   01: The patch "block/nbd: NBDReply is used being uninitialized" was detached
>       and taken into account in the patch "nbd: Initialize reply on failure"
>       by Eric Blake.
> 
> v4:
>   01: The patch "iotests: Set read-zeroes on in null block driver for Valgrind"
>       was extended with new cases and issued as a separate series.
>   02: The new patch "block/nbd: NBDReply is used being uninitialized" was
>       added to resolve the failure of the iotest 083 run under Valgrind.
> 
> v3:
>   01: The new function _casenotrun() was added to the common.rc bash
>       script to notify the user of test cases dropped for some reason.
>       Suggested by Kevin.
>       Particularly, the notification about the nonexistent TMPDIR in
>       the test 051 was added (noticed by Vladimir).
>   02: The timeout in some test cases was extended for Valgrind because
>       it differs when running on the ramdisk.
>   03: Due to the common.nbd script has been changed with the commit
>       b28f582c, the patch "iotests: amend QEMU NBD process synchronization"
>       is actual no more. Note that QEMU_NBD is launched in the bash nested
>       shell in the _qemu_nbd_wrapper() as it was before in common.rc.
>   04: The patch "iotests: new file to suppress Valgrind errors" was dropped
>       due to my superficial understanding of the work of the function
>       blk_pread_unthrottled(). Special thanks to Kevin who shed the light
>       on the null block driver involved. Now, the parameter 'read-zeroes=on'
>       is passed to the null block driver to initialize the buffer in the
>       function guess_disk_lchs() that the Valgrind was complaining to.
> 
> v2:
>   01: The patch 2/7 of v1 was merged into the patch 1/7, suggested by Daniel.
>   02: Another patch 7/7 was added to introduce the Valgrind error suppression
>       file into the QEMU project.
>   Discussed in the email thread with the message ID:
>   <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
> 
> Andrey Shinkevich (6):
>   iotests: allow Valgrind checking all QEMU processes
>   iotests: exclude killed processes from running under  Valgrind
>   iotests: Add casenotrun report to bash tests
>   iotests: Valgrind fails with nonexistent directory
>   iotests: extended timeout under Valgrind
>   iotests: extend sleeping time under Valgrind
> 
>  tests/qemu-iotests/028       |  6 +++-
>  tests/qemu-iotests/039       |  5 +++
>  tests/qemu-iotests/039.out   | 30 +++--------------
>  tests/qemu-iotests/051       |  4 +++
>  tests/qemu-iotests/061       |  2 ++
>  tests/qemu-iotests/061.out   | 12 ++-----
>  tests/qemu-iotests/137       |  1 +
>  tests/qemu-iotests/137.out   |  6 +---
>  tests/qemu-iotests/183       |  9 +++++-
>  tests/qemu-iotests/192       |  6 +++-
>  tests/qemu-iotests/247       |  6 +++-
>  tests/qemu-iotests/common.rc | 76 +++++++++++++++++++++++++++++++++-----------
>  12 files changed, 101 insertions(+), 62 deletions(-)
> 
> -- 
> 1.8.3.1
> 
> 

