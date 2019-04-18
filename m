Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E9C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 10:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD7E217D7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 10:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD7E217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH4bE-0004Hi-BL
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 06:49:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH4aD-0003oX-2p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hH4a9-0003QT-Aa
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 06:47:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hH4a1-0003Kg-CX; Thu, 18 Apr 2019 06:47:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 354C3307B964;
	Thu, 18 Apr 2019 10:47:42 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-132.ams2.redhat.com [10.36.116.132])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BCDE560BEC;
	Thu, 18 Apr 2019 10:47:38 +0000 (UTC)
Date: Thu, 18 Apr 2019 12:47:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190418104737.GC5242@linux.fritz.box>
References: <20190417115343.30527-1-pbonzini@redhat.com>
	<CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
	<cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <cf51d357-d9c0-3a20-1d23-7f6671d7948a@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 18 Apr 2019 10:47:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>,
	qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418104737.iyOaLOJtU9YNhG_eHTR7D9YRmyv-bER5eLfjEcNpOmU@z>

Am 18.04.2019 um 11:48 hat Paolo Bonzini geschrieben:
> On 17/04/19 14:30, Stefan Hajnoczi wrote:
> > On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
> >> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
> >> from exceeding these limits, by capping the maximum transfer length to
> >> that value in the block limits VPD page.
> >>
> >> [1] Oh well, at least it was easier to follow the kernel source knowing
> >>     it had to end as ENOMEM...
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Cc: qemu-block@nongnu.org
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
> >>  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> 
> This is acually only an issue with kernels prior to 4.5, so it should be
> fixed downstream instead.

I don't think that upstream QEMU has kernels > 4.5 as an official
requirement, though? We try to be compatible with quite old libs, so we
should stay compatible with old kernels, too.

Kevin

