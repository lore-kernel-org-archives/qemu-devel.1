Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D80C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03FEB20693
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FEB20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxwW-0008B5-5O
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 12:06:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIxvV-0007ga-Nm
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIxvU-0007JL-TL
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hIxvU-0007Gn-NG; Tue, 23 Apr 2019 12:05:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1C78989C42;
	Tue, 23 Apr 2019 16:05:39 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9F417DDB;
	Tue, 23 Apr 2019 16:05:31 +0000 (UTC)
Date: Tue, 23 Apr 2019 18:05:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190423180524.56881870.cohuck@redhat.com>
In-Reply-To: <20190417113143.5551-3-david@redhat.com>
References: <20190417113143.5551-1-david@redhat.com>
	<20190417113143.5551-3-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 23 Apr 2019 16:05:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] exec: Introduce
 qemu_maxrampagesize() and rename qemu_getrampagesize()
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
Message-ID: <20190423160524.mKsHgn5gL_ktSflOMHCMofxNvBw8H-7C6xgcUiihHmI@z>

On Wed, 17 Apr 2019 13:31:43 +0200
David Hildenbrand <david@redhat.com> wrote:

> Rename qemu_getrampagesize() to qemu_minrampagesize(). While at it,
> properly rename find_max_supported_pagesize() to
> find_min_backend_pagesize().
> 
> s390x is actually interested into the maximum ram pagesize, so
> introduce and use qemu_maxrampagesize().
> 
> Add a TODO, indicating that looking at any mapped memory backends is not
> 100% correct in some cases.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  exec.c                     | 44 ++++++++++++++++++++++++++++++++++----
>  hw/ppc/spapr_caps.c        |  4 ++--
>  hw/s390x/s390-virtio-ccw.c |  2 +-
>  hw/vfio/spapr.c            |  2 +-
>  include/exec/ram_addr.h    |  3 ++-
>  target/ppc/kvm.c           |  2 +-
>  6 files changed, 47 insertions(+), 10 deletions(-)

This now has two R-bs, so unless somebody speaks up against it, I'll
just take this through the s390x tree together with patch 1.

