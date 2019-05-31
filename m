Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CAFC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 12:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691BA268EC
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 12:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691BA268EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWgse-0005Tu-Jd
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 08:43:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hWgro-0005AX-FZ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 08:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hWgrn-0004Qo-IE
	for qemu-devel@nongnu.org; Fri, 31 May 2019 08:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hWgrn-0004QC-D5; Fri, 31 May 2019 08:42:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6B574E3E08;
	Fri, 31 May 2019 12:42:28 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8BF001001F5D;
	Fri, 31 May 2019 12:42:22 +0000 (UTC)
Date: Fri, 31 May 2019 14:42:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>
Message-ID: <20190531144219.75e4dc39.cohuck@redhat.com>
In-Reply-To: <5cee6204-3106-9a99-3620-aa8f4df491aa@linux.ibm.com>
References: <20190507154733.28604-1-cohuck@redhat.com>
	<20190507154733.28604-3-cohuck@redhat.com>
	<5cee6204-3106-9a99-3620-aa8f4df491aa@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 31 May 2019 12:42:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 2/2] vfio-ccw: support async command
 subregion
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
Cc: Pierre Morel <pmorel@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 May 2019 09:47:57 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 5/7/19 11:47 AM, Cornelia Huck wrote:
> > A vfio-ccw device may provide an async command subregion for
> > issuing halt/clear subchannel requests. If it is present, use
> > it for sending halt/clear request to the device; if not, fall
> > back to emulation (as done today).
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> This looks fine to me; thanks for the explanations!
> 
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> 
> > ---
> >  hw/s390x/css.c              |  27 +++++++--
> >  hw/vfio/ccw.c               | 110 +++++++++++++++++++++++++++++++++++-
> >  include/hw/s390x/s390-ccw.h |   3 +
> >  3 files changed, 134 insertions(+), 6 deletions(-)

Thanks for your review!

Queued to s390-next.

