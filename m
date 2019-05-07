Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B35C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99717204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 09:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99717204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwjl-0001H9-T4
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 05:50:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNwiq-0000tX-1I
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hNwio-0003xL-2I
	for qemu-devel@nongnu.org; Tue, 07 May 2019 05:49:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hNwim-0003w4-56; Tue, 07 May 2019 05:49:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 30161CA1FE;
	Tue,  7 May 2019 09:49:10 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B9905D9D6;
	Tue,  7 May 2019 09:49:08 +0000 (UTC)
Date: Tue, 7 May 2019 11:49:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190507114906.76612de5.cohuck@redhat.com>
In-Reply-To: <b118f253-0f75-0252-6408-565ebf7f904b@de.ibm.com>
References: <20190429090250.7648-1-borntraeger@de.ibm.com>
	<20190429180817.540c2f82.cohuck@redhat.com>
	<b118f253-0f75-0252-6408-565ebf7f904b@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 07 May 2019 09:49:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 0/9] s390x: new guest
 features
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

On Tue, 7 May 2019 11:07:50 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 29.04.19 18:08, Cornelia Huck wrote:
> > On Mon, 29 Apr 2019 05:02:41 -0400
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> Adding gen15.
> >>
> >> v2->v3: - merge  deprecation patch into gen 15 patch
> >> 	- fix comments
> >> 	- use gen15a and gen15b instead of cpuid
> >> v1->v2: - rework csske deprecation
> >> 	- white space fixes
> >> 	- also require msa4 for msa9
> >>
> >> Christian Borntraeger (9):
> >>   linux header sync  
> 
> FWIW, all the patches are in kvm/next so they should hit 5.2-rc1. We can either wait
> for that or do a header sync on kvm/next.

I'd prefer to wait for the kvm patches to hit master... there are some
changes I'd like to include in a headers sync (for vfio-ccw) that are
already in master (but do not go via the kvm tree).

