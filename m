Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF0C742B5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE644208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 10:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE644208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlsQp-0005Ia-2Z
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 06:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53039)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hlsQf-0004qt-OU
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hlsQe-0003SB-RQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hlsQe-0003Qd-KH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 06:05:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D5B9030917A6;
 Fri, 12 Jul 2019 10:05:23 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC84C60BFB;
 Fri, 12 Jul 2019 10:05:23 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id BC40B18184A5;
 Fri, 12 Jul 2019 10:05:23 +0000 (UTC)
Date: Fri, 12 Jul 2019 06:05:23 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <751527018.41212832.1562925923328.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190712120333.25f23e47.cohuck@redhat.com>
References: <20190712073554.21918-1-pagupta@redhat.com>
 <20190712120333.25f23e47.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.117.66, 10.4.195.1]
Thread-Topic: virtio pmem: coverity fixes
Thread-Index: os6rW25HBnHJ4WY/4PQsc6KBMayeLw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 12 Jul 2019 10:05:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] virtio pmem: coverity fixes
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
Cc: peter maydell <peter.maydell@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> 
> On Fri, 12 Jul 2019 13:05:51 +0530
> Pankaj Gupta <pagupta@redhat.com> wrote:
> 
> > This patch series two fixes for coverity and a
> > transactional info removal patch.
> > 
> > Pankaj Gupta (3):
> >   virtio pmem: fix wrong mem region condition
> >   virtio pmem: remove memdev null check
> >   virtio pmem: remove transational device info
> > 
> >  hw/virtio/virtio-pmem-pci.c | 4 +---
> >  hw/virtio/virtio-pmem.c     | 4 ++--
> >  2 files changed, 3 insertions(+), 5 deletions(-)
> > 
> 
> I think all of this is 4.1 material.

Yes, forgot to add in the subject.

Thank you for the review.

Best regards,
Pankaj

> 
> 

