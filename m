Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A03C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087EB2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087EB2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htTVV-0002f5-B9
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48213)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jfreimann@redhat.com>) id 1htTUz-0001j1-AA
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1htTUx-000364-Dh
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:05:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47078)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1htTUI-0002ib-5k
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:05:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6F2D746671;
 Fri,  2 Aug 2019 09:04:33 +0000 (UTC)
Received: from localhost (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DFFD60922;
 Fri,  2 Aug 2019 09:04:26 +0000 (UTC)
Date: Fri, 2 Aug 2019 11:04:25 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190802090425.6qe4ctrcelyvefmx@jenstp.localdomain>
References: <20190802040606.22573-1-jasowang@redhat.com>
 <20190802040606.22573-7-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190802040606.22573-7-jasowang@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 02 Aug 2019 09:04:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V5 6/6] virtio: add property to enable
 packed virtqueue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yang.zhong@intel.com, tiwei.bie@intel.com, mst@redhat.com,
 qemu-devel@nongnu.org, maxime.coquelin@redhat.com, weiyshay@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 02, 2019 at 12:06:06AM -0400, Jason Wang wrote:
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> include/hw/virtio/virtio.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>



