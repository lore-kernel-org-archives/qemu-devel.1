Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F40FC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 07:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AA62086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 07:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AA62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQRUP-0007rf-Gl
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 03:04:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQRTW-0007Rb-Kb
	for qemu-devel@nongnu.org; Tue, 14 May 2019 03:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hQRTV-0000Is-IK
	for qemu-devel@nongnu.org; Tue, 14 May 2019 03:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hQRTU-0000FO-L6
	for qemu-devel@nongnu.org; Tue, 14 May 2019 03:03:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84137307D941;
	Tue, 14 May 2019 07:03:42 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F266160C4D;
	Tue, 14 May 2019 07:03:28 +0000 (UTC)
Date: Tue, 14 May 2019 09:03:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Message-ID: <20190514090326.2f4288ae.cohuck@redhat.com>
In-Reply-To: <20190514061235.GC20407@joy-OptiPlex-7040>
References: <20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190509173839.2b9b2b46.cohuck@redhat.com>
	<20190509154857.GF2868@work-vm>
	<20190509175404.512ae7aa.cohuck@redhat.com>
	<20190509164825.GG2868@work-vm>
	<20190510110838.2df4c4d0.cohuck@redhat.com>
	<20190510093608.GD2854@work-vm>
	<20190510114838.7e16c3d6.cohuck@redhat.com>
	<20190513132804.GD11139@beluga.usersys.redhat.com>
	<20190514061235.GC20407@joy-OptiPlex-7040>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 14 May 2019 07:03:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio/mdev: add version attribute
 for mdev device
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
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
	"shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"eauger@redhat.com" <eauger@redhat.com>, "Liu,
	Yi L" <yi.l.liu@intel.com>, Erik Skultety <eskultet@redhat.com>,
	"Yang, Ziye" <ziye.yang@intel.com>,
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"libvir-list@redhat.com" <libvir-list@redhat.com>,
	"arei.gonglei@huawei.com" <arei.gonglei@huawei.com>,
	"felipe@nutanix.com" <felipe@nutanix.com>,
	"Ken.Xue@amd.com" <Ken.Xue@amd.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
	"dinechin@redhat.com" <dinechin@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	"intel-gvt-dev@lists.freedesktop.org"
	<intel-gvt-dev@lists.freedesktop.org>, "Liu,
	Changpeng" <changpeng.liu@intel.com>,
	"berrange@redhat.com" <berrange@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Wang, Zhi A" <zhi.a.wang@intel.com>,
	"jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>, "He,
	Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 May 2019 02:12:35 -0400
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Mon, May 13, 2019 at 09:28:04PM +0800, Erik Skultety wrote:

> > In case of libvirt checking the compatibility, it won't matter how good the
> > error message in the kernel log is and regardless of how many error states you
> > want to handle, libvirt's only limited to errno here, since we're going to do
> > plain read/write, so our internal error message returned to the user is only
> > going to contain what the errno says - okay, of course we can (and we DO)
> > provide libvirt specific string, further specifying the error but like I
> > mentioned, depending on how many error cases we want to distinguish this may be
> > hard for anyone to figure out solely on the error code, as apps will most
> > probably not parse the
> > logs.
> > 
> > Regards,
> > Erik  
> hi Erik
> do you mean you are agreeing on defining common errors and only returning errno?
> 
> e.g.
> #define ENOMIGRATION         140  /* device not supporting migration */
> #define EUNATCH              49  /* software version not match */
> #define EHWNM                142  /* hardware not matching*/

Defining custom error codes is probably not such a good idea... can we
match to common error codes instead? Do we have a good idea about
common error categories, anyway?

(Btw: does libvirt do a generic error-to-description translation, or
does it match to the context? I.e., can libvirt translate well-defined
error codes to a useful message for a specific case?)

