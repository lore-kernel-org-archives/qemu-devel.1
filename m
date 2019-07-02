Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34834C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 100272184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 19:33:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100272184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiOWa-0000G4-B1
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 15:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60493)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hiMTg-0001pz-8t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hiMTb-0005uu-Ih
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:21:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hiMTb-0005u7-Ah
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 13:21:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FB6A87628;
 Tue,  2 Jul 2019 17:21:49 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 495061001DDE;
 Tue,  2 Jul 2019 17:21:48 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id 205BA1806B0E;
 Tue,  2 Jul 2019 17:21:48 +0000 (UTC)
Date: Tue, 2 Jul 2019 13:21:47 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <414139761.38694943.1562088107752.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190702131058-mutt-send-email-mst@kernel.org>
References: <20190619094907.10131-1-pagupta@redhat.com>
 <20190619094907.10131-4-pagupta@redhat.com>
 <20190702135030.6159266b.cohuck@redhat.com>
 <918283919.38605393.1562068757047.JavaMail.zimbra@redhat.com>
 <20190702125842-mutt-send-email-mst@kernel.org>
 <1684593151.38693781.1562087381735.JavaMail.zimbra@redhat.com>
 <20190702131058-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.51, 10.4.195.1]
Thread-Topic: virtio-pmem: sync linux headers
Thread-Index: TM3xWSA/rqmET2YsEvCBdYWJJerKow==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 02 Jul 2019 17:21:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/7] virtio-pmem: sync linux headers
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
Cc: kwolf@redhat.com, aarcange@redhat.com,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, riel@surriel.com,
 armbru@redhat.com, Cornelia Huck <cohuck@redhat.com>, david@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, lcapitulino@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 dan j williams <dan.j.williams@intel.com>, nilal@redhat.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> > > > 
> > > > > 
> > > > > On Wed, 19 Jun 2019 15:19:03 +0530
> > > > > Pankaj Gupta <pagupta@redhat.com> wrote:
> > > > > 
> > > > > > Sync linux headers for virtio pmem.
> > > > > > 
> > > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > > > > ---
> > > > > >  include/standard-headers/linux/virtio_ids.h  |  1 +
> > > > > >  include/standard-headers/linux/virtio_pmem.h | 35
> > > > > >  ++++++++++++++++++++++++++++
> > > > > >  2 files changed, 36 insertions(+)
> > > > > >  create mode 100644 include/standard-headers/linux/virtio_pmem.h
> > > > > 
> > > > > That's not yet upstream, right?
> > > > 
> > > > right.
> > > > 
> > > > > 
> > > > > If so, I fear this feature won't make 4.1, as the merge window for
> > > > > Linux only opens in one or two weeks :(
> > > > 
> > > > Looks so. Its lined up for 5.3 merge window.
> > > 
> > > In which tree is it?
> > 
> > Patches are in Dan's tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/log/?h=libnvdimm-pending
> > 
> > Thanks,
> > Pankaj
> 
> Hmm ok, but that isn't part of linux-next. Do you know why?

Dan suggested to first apply in libnvdimm-pending tree to check for any zero day test bot 
warnings and then apply in linux-next. So, I think next step is to merge in linux-next.  

Thanks,
Pankaj

> 
> > > 
> > > > Waiting for the kernel patch series to be merged and send an updated
> > > > version
> > > > of qemu series with review suggestion if any :)
> > > > 
> > > > Thanks,
> > > > Pankaj
> > > > 
> > > > > 
> > > 
> 

