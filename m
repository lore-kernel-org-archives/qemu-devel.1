Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA33C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 11:55:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11654217FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 11:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11654217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJcyZ-0007Pl-9F
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 07:55:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJcxh-00071L-VG
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJcxh-0007gw-1p
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJcxg-0007fg-SM; Thu, 25 Apr 2019 07:54:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95A8F309D049;
	Thu, 25 Apr 2019 11:54:42 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC56D108BEE6;
	Thu, 25 Apr 2019 11:54:24 +0000 (UTC)
Date: Thu, 25 Apr 2019 13:54:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190425135422.2e853216.cohuck@redhat.com>
In-Reply-To: <20190417113143.5551-1-david@redhat.com>
References: <20190417113143.5551-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Thu, 25 Apr 2019 11:54:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/2] s390x/kvm: Properly detect page
 size of initial memory
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com,
	Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425115422.F_UrPGeCtSYq8P15I7t-esJY51H1kMrZJ8A5mTePEYY@z>

On Wed, 17 Apr 2019 13:31:41 +0200
David Hildenbrand <david@redhat.com> wrote:

> While the detection on s390x of the maximum ram pagesize works by pure luck,
> we should try to do better. Especially, once "-mem-path" is replaced
> by memory backends, the current approach will break.
> 
> Configure the maximum page size after configuring initital memory. Provide
> a function to detect the maximum ram pagesize
> 
> I think this can be deferred to 4.1 as I don't think anything is actually
> broken right now.
> 
> v2 -> v3:
> - Fix compile error
> - Tested that hugepages correctly result in an error with
>   "modprobe kvm hpage=0", but not with "modprobe kvm hpage=1".
> 
> v1 -> v2:
> - Add a better comment describing that only initial memory is considered
> - Add "exec: Introduce qemu_getmaxrampagesize() and rename
>   qemu_getrampagesize()"
> 
> David Hildenbrand (2):
>   s390x/kvm: Configure page size after memory has actually been
>     initialized
>   exec: Introduce qemu_maxrampagesize() and rename qemu_getrampagesize()
> 
>  exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
>  hw/ppc/spapr_caps.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c | 12 +++++++++++
>  hw/vfio/spapr.c            |  2 +-
>  include/exec/ram_addr.h    |  3 ++-
>  target/ppc/kvm.c           |  2 +-
>  target/s390x/cpu.c         |  7 ++++++
>  target/s390x/cpu.h         |  1 +
>  target/s390x/kvm-stub.c    |  4 ++++
>  target/s390x/kvm.c         | 35 ++++++++++++------------------
>  target/s390x/kvm_s390x.h   |  1 +
>  11 files changed, 85 insertions(+), 30 deletions(-)
> 

Thanks, applied.

