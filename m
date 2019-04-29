Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE96C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:10:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7FF20673
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 16:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7FF20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60017 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8qt-0000PE-9X
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 12:09:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL8pZ-000839-EY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hL8pY-0001YO-HW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 12:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hL8pY-0001Ta-AN; Mon, 29 Apr 2019 12:08:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C2BD7FDE5;
	Mon, 29 Apr 2019 16:08:23 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1058817A64;
	Mon, 29 Apr 2019 16:08:19 +0000 (UTC)
Date: Mon, 29 Apr 2019 18:08:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190429180817.540c2f82.cohuck@redhat.com>
In-Reply-To: <20190429090250.7648-1-borntraeger@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 29 Apr 2019 16:08:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/9] s390x: new guest features
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429160817.kaoBB1TDLyVxh0gdue2zcIhuHqSgWYr6LI_5f-MPDis@z>

On Mon, 29 Apr 2019 05:02:41 -0400
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Adding gen15.
> 
> v2->v3: - merge  deprecation patch into gen 15 patch
> 	- fix comments
> 	- use gen15a and gen15b instead of cpuid
> v1->v2: - rework csske deprecation
> 	- white space fixes
> 	- also require msa4 for msa9
> 
> Christian Borntraeger (9):
>   linux header sync

I think we can do that sync once the companion kernel series hits the
kvm next branch.

>   s390x/cpumodel: ignore csske for expansion
>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
>   s390x/cpumodel: msa9 facility

This seems to be the only patch that does not yet have a R-b from David
-- David, do you plan to review this one as well?

>   s390x/cpumodel: vector enhancements
>   s390x/cpumodel: enhanced sort facility
>   s390x/cpumodel: add Deflate-conversion facility
>   s390x/cpumodel: add gen15 defintions
>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
> 
>  linux-headers/asm-s390/kvm.h    |   5 +-
>  target/s390x/cpu_features.c     |  54 ++++++++++++++++
>  target/s390x/cpu_features.h     |   3 +
>  target/s390x/cpu_features_def.h |  49 +++++++++++++++
>  target/s390x/cpu_models.c       |  13 ++--
>  target/s390x/gen-features.c     | 105 ++++++++++++++++++++++++++++++++
>  target/s390x/kvm.c              |  18 ++++++
>  7 files changed, 242 insertions(+), 5 deletions(-)
> 

Only thing I noticed were some minor typos in some commit messages, I
can fix up while applying.

