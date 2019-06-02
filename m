Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151BCC282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 09:13:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C74278A6
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 09:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C74278A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46741 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXMYP-00049l-PP
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 05:13:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hXMXM-0003g2-AK
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 05:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlevitsk@redhat.com>) id 1hXMXL-0007fb-DP
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 05:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
	id 1hXMXI-0007cm-WA; Sun, 02 Jun 2019 05:12:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3B93307D85B;
	Sun,  2 Jun 2019 09:12:14 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10E71608A7;
	Sun,  2 Jun 2019 09:12:12 +0000 (UTC)
Message-ID: <b87f080563bb4b8c16d1371f298c94c5b6865c49.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-block@nongnu.org
Date: Sun, 02 Jun 2019 12:12:11 +0300
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
References: <20190415135746.7571-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Sun, 02 Jun 2019 09:12:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/5] Few fixes for userspace NVME driver
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

On Mon, 2019-04-15 at 16:57 +0300, Maxim Levitsky wrote:
> CC: Fam Zheng <fam@euphon.net>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: qemu-devel@nongnu.org
> 
> 
> Hi!
> These are few assorted fixes and features for the userspace
> nvme driver.
> 
> Tested that on my laptop with my Samsung X5 thunderbolt drive, which
> happens to have 4K sectors, support for discard and write zeros.
> 
> Also bunch of fixes sitting in my queue from the period when I developed
> the nvme-mdev driver.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (5):
>   block/nvme: don't flip CQ phase bits
>   block/nvme: fix doorbell stride
>   block/nvme: support larger that 512 bytes sector devices
>   block/nvme: add support for write zeros
>   block/nvme: add support for discard
> 
>  block/nvme.c         | 194 +++++++++++++++++++++++++++++++++++++++++--
>  block/trace-events   |   3 +
>  include/block/nvme.h |  17 +++-
>  3 files changed, 204 insertions(+), 10 deletions(-)
> 

Ping.

Best regards,
	Maxim Levitsky



