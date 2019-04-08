Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1DDC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DEA820880
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 17:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DEA820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDXld-0005Fn-NB
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 13:09:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hDXkm-0004wE-8M
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:08:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hDXkl-0005Wj-6Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 13:08:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hDXkk-0005MY-Hy; Mon, 08 Apr 2019 13:08:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 555C03003737;
	Mon,  8 Apr 2019 17:08:07 +0000 (UTC)
Received: from gondolin (ovpn-117-86.ams2.redhat.com [10.36.117.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 59637600C0;
	Mon,  8 Apr 2019 17:07:52 +0000 (UTC)
Date: Mon, 8 Apr 2019 19:07:47 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Message-ID: <20190408190747.12e3618b.cohuck@redhat.com>
In-Reply-To: <9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
References: <20190301093902.27799-1-cohuck@redhat.com>
	<20190301093902.27799-2-cohuck@redhat.com>
	<9e81af36-ebd2-671b-5256-90e8efaad6f2@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Mon, 08 Apr 2019 17:08:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 1/6] vfio-ccw: make it safe to access
 channel programs
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
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org,
	qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408170747.20wUYHBT0VqPR-xTOx2WbPVlBeU7JoJW_uv4uWofy-E@z>

On Mon, 8 Apr 2019 13:02:12 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 03/01/2019 04:38 AM, Cornelia Huck wrote:
> > When we get a solicited interrupt, the start function may have
> > been cleared by a csch, but we still have a channel program
> > structure allocated. Make it safe to call the cp accessors in
> > any case, so we can call them unconditionally.
> > 
> > While at it, also make sure that functions called from other parts
> > of the code return gracefully if the channel program structure
> > has not been initialized (even though that is a bug in the caller).
> > 
> > Reviewed-by: Eric Farman<farman@linux.ibm.com>
> > Signed-off-by: Cornelia Huck<cohuck@redhat.com>
> > ---  
> 
> Hi Connie,
> 
> My series of fixes for vfio-ccw depends on this patch as I would like to 
> call cp_free unconditionally :) (I had developed my code on top of your 
> patches).
> 
> Could we pick this patch up as well when/if you pick up my patch series? 
> I am in the process of sending out a v2.
> 
> Regarding this patch we could merge it as a stand alone patch, separate 
> from this series. And also the patch LGTM
> 
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>

Actually, I wanted to ask how people felt about merging this whole
series for the next release :) It would be one thing less on my plate...

