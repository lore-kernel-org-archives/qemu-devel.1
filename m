Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE5C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A612073F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 11:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A612073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48757 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG0AE-0002Mx-GO
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 07:52:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hG09L-000253-LD
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hG09K-0003fN-5z
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hG09J-0003a1-Pf; Mon, 15 Apr 2019 07:51:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73C3C66979;
	Mon, 15 Apr 2019 11:51:35 +0000 (UTC)
Received: from gondolin (unknown [10.40.205.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B96FE5C1B4;
	Mon, 15 Apr 2019 11:51:30 +0000 (UTC)
Date: Mon, 15 Apr 2019 13:51:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <20190415135126.2fa9b12b.cohuck@redhat.com>
In-Reply-To: <20190301093902.27799-1-cohuck@redhat.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 15 Apr 2019 11:51:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/6] vfio-ccw: support hsch/csch (kernel
 part)
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
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415115126.zf3pb7PLNSbmpgqmHOD0qIvx2M7EvO4w0dLid7lQFOs@z>

On Fri,  1 Mar 2019 10:38:56 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> [This is the Linux kernel part, git tree is available at
> https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git vfio-ccw-eagain-caps-v3
> 
> The companion QEMU patches are available at
> https://github.com/cohuck/qemu vfio-ccw-caps]
> 
> Currently, vfio-ccw only relays START SUBCHANNEL requests to the real
> device. This tends to work well for the most common 'good path' scenarios;
> however, as we emulate {HALT,CLEAR} SUBCHANNEL in QEMU, things like
> clearing pending requests at the device is currently not supported.
> This may be a problem for e.g. error recovery.
> 
> This patch series introduces capabilities (similar to what vfio-pci uses)
> and exposes a new async region for handling hsch/csch.

One more gentle ping for an ack/r-b for patches 4 and 6.

I could go ahead and merge patches 1-3 and then patches 1+3 of Farhan's
series, but I'd really like to merge patches 4-6 as well so I can later
merge the QEMU part after a headers update to 5.2-rc...

