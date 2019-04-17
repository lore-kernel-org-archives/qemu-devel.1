Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBF8C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 20:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A1CE2183F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 20:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1CE2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58997 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGqjg-0005k6-NA
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 16:00:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqga-0003Y4-ET
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hGqgZ-0001fl-KG
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 15:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hGqgW-0001Zt-Rz; Wed, 17 Apr 2019 15:57:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D154B0AA6;
	Wed, 17 Apr 2019 19:57:32 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6547B6013D;
	Wed, 17 Apr 2019 19:57:30 +0000 (UTC)
Message-ID: <4a81259e6f47263942baa514de02d114e119c69f.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Date: Wed, 17 Apr 2019 22:57:29 +0300
In-Reply-To: <c239eeac-8bf1-6af4-8a2a-370be84bfcdb@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
	<c239eeac-8bf1-6af4-8a2a-370be84bfcdb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Wed, 17 Apr 2019 19:57:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] Few fixes for userspace
 NVME driver
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417195729.A-_DnhRpo3rI6duNos4KJETy75ie07ppL6xd0M8p9DU@z>

On Tue, 2019-04-16 at 15:50 +0200, Paolo Bonzini wrote:
> On 15/04/19 15:57, Maxim Levitsky wrote:
> > 
> > 
> > Hi!
> > These are few assorted fixes and features for the userspace
> > nvme driver.
> > 
> > Tested that on my laptop with my Samsung X5 thunderbolt drive, which
> > happens to have 4K sectors, support for discard and write zeros.
> > 
> > Also bunch of fixes sitting in my queue from the period when I developed
> > the nvme-mdev driver.
> > 
> > Best regards,
> > 	Maxim Levitsky
> 
> I only pointed out just two cosmetic changes.  Thanks very much!
> 
> Paolo
> 
Hi Paolo!
Thank you very much!

I have just resent V2 of the series with the fixes.

Best regards,
	Maxim Levitsky


