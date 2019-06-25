Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D10C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD67215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 08:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD67215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfgnf-0008Fi-5X
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 04:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52168)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hfgm3-0007Ki-Hs
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:25:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hfgm2-0004av-Fk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 04:25:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55174)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hfgm2-0004Zw-9c; Tue, 25 Jun 2019 04:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AB8586677;
 Tue, 25 Jun 2019 08:25:49 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FA40608D0;
 Tue, 25 Jun 2019 08:25:44 +0000 (UTC)
Date: Tue, 25 Jun 2019 10:25:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190625102542.4c0d52a7.cohuck@redhat.com>
In-Reply-To: <20190621134338.8425-1-david@redhat.com>
References: <20190621134338.8425-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 25 Jun 2019 08:25:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390x 0/3] s390x/tcg: pending
 patches
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Jun 2019 15:43:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> This pull request is not for master.
> 
> Hi Conny,
> 
> The following changes since commit 33d609990621dea6c7d056c86f707b8811320ac1:
> 
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-06-18 17:00:52 +0100)
> 
> are available in the Git repository at:
> 
>   https://github.com/davidhildenbrand/qemu.git tags/s390x-tcg-2019-06-21
> 
> for you to fetch changes up to ef506f804a48a6fb7983d721092f1b32a4543f3e:
> 
>   s390x/cpumodel: Prepend KDSA features with "KDSA" (2019-06-21 15:26:53 +0200)
> 
> ----------------------------------------------------------------
> One fix for a tcg test case and two cleanups/refactorings of cpu feature
> definitions.
> 
> ----------------------------------------------------------------
> David Hildenbrand (2):
>   s390x/cpumodel: Rework CPU feature definition
>   s390x/cpumodel: Prepend KDSA features with "KDSA"
> 
> Richard Henderson (1):
>   tests/tcg/s390x: Fix alignment of csst parameter list
> 
>  target/s390x/cpu_features.c         | 352 +-------------------------
>  target/s390x/cpu_features_def.h     | 352 +-------------------------
>  target/s390x/cpu_features_def.inc.h | 369 ++++++++++++++++++++++++++++
>  target/s390x/gen-features.c         |  30 +--
>  tests/tcg/s390x/csst.c              |   2 +-
>  5 files changed, 402 insertions(+), 703 deletions(-)
>  create mode 100644 target/s390x/cpu_features_def.inc.h
> 

Thanks, pulled.

