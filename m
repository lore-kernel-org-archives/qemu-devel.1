Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D96C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 19:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCD127212
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 19:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCD127212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXsfT-0008Ty-KN
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 15:30:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hXsee-00086M-NL
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1hXsed-0008Eq-Of
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1hXsed-0008De-JP
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 15:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 13F7581E07;
	Mon,  3 Jun 2019 19:29:42 +0000 (UTC)
Received: from x1.home (ovpn-116-22.phx2.redhat.com [10.3.116.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E968A17ADA;
	Mon,  3 Jun 2019 19:29:32 +0000 (UTC)
Date: Mon, 3 Jun 2019 13:29:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190603132932.1b5dc7fe@x1.home>
In-Reply-To: <20190531004438.24528-1-yan.y.zhao@intel.com>
References: <20190531004438.24528-1-yan.y.zhao@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 03 Jun 2019 19:29:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 0/2] introduction of migration_version
 attribute for VFIO live migration
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
	Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
	qemu-devel@nongnu.org, kwankhede@nvidia.com, eauger@redhat.com,
	yi.l.liu@intel.com, eskultet@redhat.com, ziye.yang@intel.com,
	mlevitsk@redhat.com, pasic@linux.ibm.com, libvir-list@redhat.com,
	felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
	dgilbert@redhat.com, zhenyuw@linux.intel.com,
	dinechin@redhat.com, intel-gvt-dev@lists.freedesktop.org,
	changpeng.liu@intel.com, berrange@redhat.com, cohuck@redhat.com,
	linux-kernel@vger.kernel.org, zhi.a.wang@intel.com,
	jonathan.davies@nutanix.com, shaopeng.he@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 May 2019 20:44:38 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> This patchset introduces a migration_version attribute under sysfs of VFIO
> Mediated devices.
> 
> This migration_version attribute is used to check migration compatibility
> between two mdev devices of the same mdev type.
> 
> Patch 1 defines migration_version attribute in
> Documentation/vfio-mediated-device.txt
> 
> Patch 2 uses GVT as an example to show how to expose migration_version
> attribute and check migration compatibility in vendor driver.

Thanks for iterating through this, it looks like we've settled on
something reasonable, but now what?  This is one piece of the puzzle to
supporting mdev migration, but I don't think it makes sense to commit
this upstream on its own without also defining the remainder of how we
actually do migration, preferably with more than one working
implementation and at least prototyped, if not final, QEMU support.  I
hope that was the intent, and maybe it's now time to look at the next
piece of the puzzle.  Thanks,

Alex

