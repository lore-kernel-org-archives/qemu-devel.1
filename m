Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49972C5B57D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 03:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20ED62085A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 03:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20ED62085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiVqJ-00073f-DS
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 23:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41972)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pagupta@redhat.com>) id 1hiVpS-0006bX-W6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pagupta@redhat.com>) id 1hiVpS-00083A-3o
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:21:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hiVpR-00080W-45
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 23:21:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4427D330265;
 Wed,  3 Jul 2019 03:21:02 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3093860856;
 Wed,  3 Jul 2019 03:21:02 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com
 (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id E2D4841F40;
 Wed,  3 Jul 2019 03:21:01 +0000 (UTC)
Date: Tue, 2 Jul 2019 23:21:01 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <1266721693.38750968.1562124061505.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190703024219.GA4444@richard>
References: <20190619094907.10131-1-pagupta@redhat.com>
 <20190702084934.GA25987@richard>
 <1872807933.38582516.1562062064161.JavaMail.zimbra@redhat.com>
 <20190703005836.GA18621@richard>
 <1866293380.38744564.1562117503276.JavaMail.zimbra@redhat.com>
 <20190703015718.GA3752@richard>
 <1195441475.38747365.1562121061024.JavaMail.zimbra@redhat.com>
 <20190703024219.GA4444@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.116.46, 10.4.195.22]
Thread-Topic: Qemu virtio pmem device
Thread-Index: rVcBxd32yHa+fx+1Sg8mffJHspBB7Q==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 03 Jul 2019 03:21:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Qemu virtio pmem device
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
Cc: kwolf@redhat.com, aarcange@redhat.com, nilal@redhat.com,
 xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, david@redhat.com,
 rth@twiddle.net, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 mst@redhat.com, stefanha@redhat.com, imammedo@redhat.com, pbonzini@redhat.com,
 riel@surriel.com, lcapitulino@redhat.com,
 dan j williams <dan.j.williams@intel.com>, dgilbert@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> >> 
> >> Ok, if it works, we could list those regions? and change pmem0 mode to dax
> >> mode, right?
> >
> >You mean fs dax?
> >I don't think currently we support this because raw image wont have any
> >metadata.
> >Will have to think if this is at all possible or how we can achieve such
> >behavior.
> >
> 
> Ok, I got it.
> 
> >Also, there is requirement to support host backing file on real NVDIMM and
> >virtio. Once we have have first version of virtio pmem series merged
> >upstream
> >we will continue to work on advance features depending upon feasibility.
> >
> 
> One curiosity, what difference make NVDIMM backend doesn't work now?
> 
> The /dev/dax0.0 is a char file. The nvdimm device use mmap to map HVA to HPA.
> It looks a normal file to me. Would appreciated it if you would share some
> light on it.
> 

It will require support of MAP_SYNC at host side without an explicit flush/fsync.
We need to add the usecase in both guest and host drivers/device. Also, thorough
testing is required to fix any issues. 

I will do the required changes for the next step. 

Thanks,
Pankaj

