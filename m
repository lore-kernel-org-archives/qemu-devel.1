Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F604C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E9A21670
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 09:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E9A21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPKX-0008WU-MU
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 05:45:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLPJQ-0007th-2d
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLPJP-0005y8-2U
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hLPJO-0005xh-SX; Tue, 30 Apr 2019 05:44:31 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0678C3084249;
	Tue, 30 Apr 2019 09:44:30 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 75D74100164A;
	Tue, 30 Apr 2019 09:44:28 +0000 (UTC)
Date: Tue, 30 Apr 2019 11:44:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <20190430114426.5e805d30.cohuck@redhat.com>
In-Reply-To: <099881e7-b0a9-055a-ba3e-2ebb66b4e15c@linux.ibm.com>
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<20190429154003.7f8fc423.cohuck@redhat.com>
	<ef10a003-3eb8-df60-bfb1-bc99bfd6b7af@de.ibm.com>
	<099881e7-b0a9-055a-ba3e-2ebb66b4e15c@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Tue, 30 Apr 2019 09:44:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, thuth@redhat.com,
	Stefan Haberland <sth@linux.vnet.ibm.com>, alifm@linux.ibm.com,
	qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430094426.JiyfQzUouvrCttitIO7YDkOAjkzM5TFbvZWxvpExy04@z>

On Tue, 30 Apr 2019 11:24:27 +0200
Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> On 29.04.2019 15:45, Christian Borntraeger wrote:
> > 
> > 
> > On 29.04.19 15:40, Cornelia Huck wrote:  
> >> On Mon, 29 Apr 2019 09:09:41 -0400
> >> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >>  
> >>> Newer versions of zipl have the ability to write signature entries to the boot
> >>> script for secure boot. We don't yet support secure boot, but we need to skip
> >>> over signature entries while reading the boot script in order to maintain our
> >>> ability to boot guest operating systems that have a secure bootloader.
> >>>
> >>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> >>> ---
> >>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
> >>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
> >>>  2 files changed, 23 insertions(+), 6 deletions(-)  
> >>
> >> Skipping something that we don't have support for yet, but that doesn't
> >> hinder normal operation sounds reasonable; but can you point me to the
> >> relevant commit implementing this in zipl or some documentation? I
> >> haven't been able to find something like that in the s390-tools git
> >> tree.  
> > 
> > the s390-tools update is currently in preparation, adding Stefan and Peter.  
> 
> Here's the link to the s390-tools commit that introduces the new
> signature component to zipl:
> 
> https://github.com/ibm-s390-tools/s390-tools/commit/7c7e10ed8fb048efc4e0cd91b0f6fa704fba128e
> 
> 

Thanks!

