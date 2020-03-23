Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF67C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05A420722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8jkr1yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05A420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGQf1-0008Gv-2I
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jGQeO-0007qw-6r
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jGQeM-0006Ng-Hf
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:14:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:23192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jGQeM-0006ME-Az
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584983645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G/nAXZEAXzpz+n0po8GWdShIDTPHmRr0vJRPpzjABU=;
 b=L8jkr1yCUyetjiEoOEmjMOMdfp/0+144Ci3tMWsM9KltlFksVzqcPdwc9gKgUP6jZU7FOB
 ZjgCxDwHKojvCF3VWTySoocwuR3jk+yIHDtvJgQ1qn64oxn4KtDd8veSdiBeYm9efXHevD
 nPEvVAGmV0yDLYqHiRh4LQU6Mt3+Gak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-xDNjG-ERMKe7LeGtQvDE5A-1; Mon, 23 Mar 2020 13:14:04 -0400
X-MC-Unique: xDNjG-ERMKe7LeGtQvDE5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA6751005F76;
 Mon, 23 Mar 2020 17:14:02 +0000 (UTC)
Received: from gondolin (ovpn-113-18.ams2.redhat.com [10.36.113.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE3CE19C4F;
 Mon, 23 Mar 2020 17:13:58 +0000 (UTC)
Date: Mon, 23 Mar 2020 18:13:56 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v11 00/16] s390x: Protected Virtualization support
Message-ID: <20200323181356.38b3f15d.cohuck@redhat.com>
In-Reply-To: <20200319131921.2367-1-frankja@linux.ibm.com>
References: <20200319131921.2367-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 09:19:05 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Most of the QEMU changes for PV are related to the new IPL type with
> subcodes 8 - 10 and the execution of the necessary Ultravisor calls to
> IPL secure guests. Note that we can only boot into secure mode from
> normal mode, i.e. stfle 161 is not active in secure mode.
> 
> The other changes related to data gathering for emulation and
> disabling addressing checks in secure mode, as well as CPU resets.
> 
> v11:
> 	* Review fixes
> 
> v10:
> 	* Moved documentation into subfolder
> 	* Added huge page fencing
> 	* Cleared up IO questions that were remaining
> 	* Added exits/abbort/assert for conditions where we can't recover
> 
> v9:
> 	* Moved pv.h into include/hw/s390x/
> 	* Replaced cmd strings with macro
> 	* Moved s390_is_pv() to pv.h
> 	* Added new copyright dates and authors
> v8:
> 	* Removed the iplb_valid changes as they are picked
> 	* Checkpatch fixes
> 	* Review fixes
> 	* Replaced env/ms->pv with s390_is_pv()
> v7:
> 	* Merged the diag 308 subcode patches and the unpack
> 	* Moved the SIDA memops into the sync patch
> 	* Bailout for the none machien and fencing of CONFIG_USER_ONLY
> 	* Changes due to review
> 
> v6:
> 	* diag308 rc numbers were changed by architecture
> 	* IPL pv block received one more reserved field by architecture
> 	* Officially added the bios patch to the series
> 	* Dropped picked constant rename patch
> 
> v5:
> 	* Moved docs into docs/system
> 	* Some more enable/disable changes
> 	* Moved enablement/disablement of pv in separate functions
> 	* Some review fixes
> 
> v4:
> 	* Sync with KVM changes
> 	* Review changes
> 
> V3:
> 	* Use dedicated functions to access SIDA
> 	* Smaller cleanups and segfault fixes
> 	* Error reporting for Ultravisor calls
> 	* Inject of RC of diag308 subcode 10 fails
> 
> V2:
> 	* Split out cleanups
> 	* Internal PV state tracking
> 	* Review feedback
> 
> Christian Borntraeger (1):
>   s390x: Add unpack facility feature to GA1
> 
> Janosch Frank (15):
>   s390x: Move diagnose 308 subcodes and rcs into ipl.h
>   Sync pv
>   s390x: protvirt: Support unpack facility
>   s390x: protvirt: Add migration blocker
>   s390x: protvirt: Inhibit balloon when switching to protected mode
>   s390x: protvirt: KVM intercept changes
>   s390x: Add SIDA memory ops
>   s390x: protvirt: Move STSI data over SIDAD
>   s390x: protvirt: SCLP interpretation
>   s390x: protvirt: Set guest IPL PSW
>   s390x: protvirt: Move diag 308 data over SIDA
>   s390x: protvirt: Disable address checks for PV guest IO emulation
>   s390x: protvirt: Move IO control structures over SIDA
>   s390x: protvirt: Handle SIGP store status correctly
>   docs: system: Add protvirt docs
> 
>  MAINTAINERS                         |   2 +
>  docs/system/s390x/protvirt.rst      |  60 +++++++++++
>  docs/system/target-s390x.rst        |   5 +
>  hw/s390x/Makefile.objs              |   1 +
>  hw/s390x/ipl.c                      |  59 ++++++++++-
>  hw/s390x/ipl.h                      | 102 ++++++++++++++++++-
>  hw/s390x/pv.c                       |  98 ++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c          | 148 +++++++++++++++++++++++++++-
>  hw/s390x/sclp.c                     |  56 ++++++++---
>  include/hw/s390x/pv.h               |  55 +++++++++++
>  include/hw/s390x/s390-virtio-ccw.h  |   1 +
>  include/hw/s390x/sclp.h             |   2 +
>  linux-headers/linux/kvm.h           |  45 ++++++++-
>  target/s390x/cpu.c                  |  27 +++--
>  target/s390x/cpu.h                  |   7 +-
>  target/s390x/cpu_features_def.inc.h |   1 +
>  target/s390x/diag.c                 |  77 +++++++++++----
>  target/s390x/gen-features.c         |   1 +
>  target/s390x/helper.c               |   6 ++
>  target/s390x/ioinst.c               |  96 +++++++++++++-----
>  target/s390x/kvm-stub.c             |   5 +
>  target/s390x/kvm.c                  |  79 +++++++++++++--
>  target/s390x/kvm_s390x.h            |   3 +
>  target/s390x/mmu_helper.c           |  14 +++
>  24 files changed, 870 insertions(+), 80 deletions(-)
>  create mode 100644 docs/system/s390x/protvirt.rst
>  create mode 100644 hw/s390x/pv.c
>  create mode 100644 include/hw/s390x/pv.h
> 

Thanks, queued to s390-next for 5.1 (with v12 of patch 3).

Patch 2 will obviously need to be replaced by a proper headers update;
I'll do that when 5.1 development opens up (I assume the kernel patches
will have reached Linux master before that.)

(Any further s390x patches for 5.0 will go via s390-fixes, as usual.)


