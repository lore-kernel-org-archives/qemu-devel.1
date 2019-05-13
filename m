Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D638C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 01:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42526208CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 01:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42526208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPzgO-0006Z8-Do
	for qemu-devel@archiver.kernel.org; Sun, 12 May 2019 21:23:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hPzfY-0006Fx-7H
	for qemu-devel@nongnu.org; Sun, 12 May 2019 21:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yan.y.zhao@intel.com>) id 1hPzfW-00008m-QJ
	for qemu-devel@nongnu.org; Sun, 12 May 2019 21:22:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:37896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yan.y.zhao@intel.com>)
	id 1hPzfW-00005f-Gg
	for qemu-devel@nongnu.org; Sun, 12 May 2019 21:22:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 May 2019 18:22:09 -0700
X-ExtLoop1: 1
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
	([10.239.13.9])
	by fmsmga005.fm.intel.com with ESMTP; 12 May 2019 18:22:05 -0700
Date: Sun, 12 May 2019 21:16:26 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190513011626.GI24397@joy-OptiPlex-7040>
References: <20190506014514.3555-1-yan.y.zhao@intel.com>
	<20190506014904.3621-1-yan.y.zhao@intel.com>
	<20190507151826.502be009@x1.home>
	<20190509173839.2b9b2b46.cohuck@redhat.com>
	<20190509154857.GF2868@work-vm>
	<20190509175404.512ae7aa.cohuck@redhat.com>
	<20190509164825.GG2868@work-vm>
	<20190510110838.2df4c4d0.cohuck@redhat.com>
	<20190510093608.GD2854@work-vm>
	<20190510114838.7e16c3d6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510114838.7e16c3d6.cohuck@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: "cjia@nvidia.com" <cjia@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"aik@ozlabs.ru" <aik@ozlabs.ru>,
	"Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
	"shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"kwankhede@nvidia.com" <kwankhede@nvidia.com>,
	"eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eskultet@redhat.com" <eskultet@redhat.com>, "Yang,
	Ziye" <ziye.yang@intel.com>, "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
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

On Fri, May 10, 2019 at 05:48:38PM +0800, Cornelia Huck wrote:
> On Fri, 10 May 2019 10:36:09 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Cornelia Huck (cohuck@redhat.com) wrote:
> > > On Thu, 9 May 2019 17:48:26 +0100
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Cornelia Huck (cohuck@redhat.com) wrote:  
> > > > > On Thu, 9 May 2019 16:48:57 +0100
> > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > >     
> > > > > > * Cornelia Huck (cohuck@redhat.com) wrote:    
> > > > > > > On Tue, 7 May 2019 15:18:26 -0600
> > > > > > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > > > > > >       
> > > > > > > > On Sun,  5 May 2019 21:49:04 -0400
> > > > > > > > Yan Zhao <yan.y.zhao@intel.com> wrote:      
> > > > > > >       
> > > > > > > > > +  Errno:
> > > > > > > > > +  If vendor driver wants to claim a mdev device incompatible to all other mdev
> > > > > > > > > +  devices, it should not register version attribute for this mdev device. But if
> > > > > > > > > +  a vendor driver has already registered version attribute and it wants to claim
> > > > > > > > > +  a mdev device incompatible to all other mdev devices, it needs to return
> > > > > > > > > +  -ENODEV on access to this mdev device's version attribute.
> > > > > > > > > +  If a mdev device is only incompatible to certain mdev devices, write of
> > > > > > > > > +  incompatible mdev devices's version strings to its version attribute should
> > > > > > > > > +  return -EINVAL;        
> > > > > > > > 
> > > > > > > > I think it's best not to define the specific errno returned for a
> > > > > > > > specific situation, let the vendor driver decide, userspace simply
> > > > > > > > needs to know that an errno on read indicates the device does not
> > > > > > > > support migration version comparison and that an errno on write
> > > > > > > > indicates the devices are incompatible or the target doesn't support
> > > > > > > > migration versions.      
> > > > > > > 
> > > > > > > I think I have to disagree here: It's probably valuable to have an
> > > > > > > agreed error for 'cannot migrate at all' vs 'cannot migrate between
> > > > > > > those two particular devices'. Userspace might want to do different
> > > > > > > things (e.g. trying with different device pairs).      
> > > > > > 
> > > > > > Trying to stuff these things down an errno seems a bad idea; we can't
> > > > > > get much information that way.    
> > > > > 
> > > > > So, what would be a reasonable approach? Userspace should first read
> > > > > the version attributes on both devices (to find out whether migration
> > > > > is supported at all), and only then figure out via writing whether they
> > > > > are compatible?
> > > > > 
> > > > > (Or just go ahead and try, if it does not care about the reason.)    
> > > > 
> > > > Well, I'm OK with something like writing to test whether it's
> > > > compatible, it's just we need a better way of saying 'no'.
> > > > I'm not sure if that involves reading back from somewhere after
> > > > the write or what.  
> > > 
> > > Hm, so I basically see two ways of doing that:
> > > - standardize on some error codes... problem: error codes can be hard
> > >   to fit to reasons
> > > - make the error available in some attribute that can be read
> > > 
> > > I'm not sure how we can serialize the readback with the last write,
> > > though (this looks inherently racy).
> > > 
> > > How important is detailed error reporting here?  
> > 
> > I think we need something, otherwise we're just going to get vague
> > user reports of 'but my VM doesn't migrate'; I'd like the error to be
> > good enough to point most users to something they can understand
> > (e.g. wrong card family/too old a driver etc).
> 
> Ok, that sounds like a reasonable point. Not that I have a better idea
> how to achieve that, though... we could also log a more verbose error
> message to the kernel log, but that's not necessarily where a user will
> look first.
> 
> Ideally, we'd want to have the user space program setting up things
> querying the general compatibility for migration (so that it becomes
> their problem on how to alert the user to problems :), but I'm not sure
> how to eliminate the race between asking the vendor driver for
> compatibility and getting the result of that operation.
> 
> Unless we introduce an interface that can retrieve _all_ results
> together with the written value? Or is that not going to be much of a
> problem in practice?
what about defining a migration_errors attribute, storing recent 10 error
records with format like:
    input string: error
as identical input strings always have the same error string, the 10 error
records may meet 10+ reason querying operations. And in practice, I think there
wouldn't be 10 simultaneous migration requests?

or could we just define some common errno? like 
#define ENOMIGRATION         140  /* device not supporting migration */
#define EUNATCH              49  /* software version not match */
#define EHWNM                142  /* hardware not matching*/

