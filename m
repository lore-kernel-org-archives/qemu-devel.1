Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53563C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:03:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2816321D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2816321D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtH8-00080p-Dh
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iAtEp-0006ef-GP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iAtEm-0004m4-LZ
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:00:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1iAtEm-0004iy-FI; Thu, 19 Sep 2019 06:00:32 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC9E33084045;
 Thu, 19 Sep 2019 10:00:30 +0000 (UTC)
Received: from gondolin (dhcp-192-230.str.redhat.com [10.33.192.230])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF6D71001281;
 Thu, 19 Sep 2019 10:00:27 +0000 (UTC)
Date: Thu, 19 Sep 2019 12:00:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190919120025.057cb0b2.cohuck@redhat.com>
In-Reply-To: <20190918152922.18949-1-david@redhat.com>
References: <20190918152922.18949-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 19 Sep 2019 10:00:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390x 00/29] s390x/tcg:
 mem_helper: Fault-safe handling
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Sep 2019 17:28:53 +0200
David Hildenbrand <david@redhat.com> wrote:

> This pull request is not for master.
> 
> Hi Conny,
> 
> The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:
> 
>   target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-09-18
> 
> for you to fetch changes up to ea83ebe1503e7496db3358d6a65d734ac4510424:
> 
>   tests/tcg: target/s390x: Test MVO (2019-09-18 16:10:55 +0200)
> 
> ----------------------------------------------------------------
> Fix a bunch of BUGs in the mem-helpers (including the MVC instruction),
> especially, to make them behave correctly on faults.
> 
> ----------------------------------------------------------------
> David Hildenbrand (29):
>   s390x/tcg: Reset exception_index to -1 instead of 0
>   s390x/tcg: MVCL: Zero out unused bits of address
>   s390x/tcg: MVCL: Detect destructive overlaps
>   s390x/tcg: MVCL: Process max 4k bytes at a time
>   s390x/tcg: MVC: Increment the length once
>   s390x/tcg: MVC: Use is_destructive_overlap()
>   s390x/tcg: MVPG: Check for specification exceptions
>   s390x/tcg: MVPG: Properly wrap the addresses
>   s390x/tcg: MVCLU/MVCLE: Process max 4k bytes at a time
>   s390x/tcg: MVCS/MVCP: Check for special operation exceptions
>   s390x/tcg: MVCOS: Lengths are 32 bit in 24/31-bit mode
>   s390x/tcg: MVCS/MVCP: Properly wrap the length
>   s390x/tcg: MVST: Check for specification exceptions
>   s390x/tcg: MVST: Fix storing back the addresses to registers
>   s390x/tcg: Always use MMU_USER_IDX for CONFIG_USER_ONLY
>   s390x/tcg: Fault-safe memset
>   s390x/tcg: Fault-safe memmove
>   s390x/tcg: MVCS/MVCP: Use access_memmove()
>   s390x/tcg: MVC: Fault-safe handling on destructive overlaps
>   s390x/tcg: MVCLU: Fault-safe handling
>   s390x/tcg: OC: Fault-safe handling
>   s390x/tcg: XC: Fault-safe handling
>   s390x/tcg: NC: Fault-safe handling
>   s390x/tcg: MVCIN: Fault-safe handling
>   s390x/tcg: MVN: Fault-safe handling
>   s390x/tcg: MVZ: Fault-safe handling
>   s390x/tcg: MVST: Fault-safe handling
>   s390x/tcg: MVO: Fault-safe handling
>   tests/tcg: target/s390x: Test MVO
> 
>  target/s390x/cpu.h              |   4 +
>  target/s390x/helper.h           |   2 +-
>  target/s390x/insn-data.def      |   2 +-
>  target/s390x/mem_helper.c       | 743 ++++++++++++++++++++++----------
>  target/s390x/translate.c        |  12 +-
>  tests/tcg/s390x/Makefile.target |   1 +
>  tests/tcg/s390x/mvo.c           |  25 ++
>  7 files changed, 564 insertions(+), 225 deletions(-)
>  create mode 100644 tests/tcg/s390x/mvo.c
> 

Thanks, pulled.

