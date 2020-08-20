Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C3820724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 03:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C3820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8bGN-0005Jx-M8
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 23:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k8bFm-0004qa-2a
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:28:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:61004)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1k8bFk-00048t-4t
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 23:28:37 -0400
IronPort-SDR: n2cHu2deHxR8EBFy6Skk1be+ocmpf4DbYHxAaaTvmCD/OAuU8woq1l2qpE7mg3xWpGTaTwGNQb
 vyMOL034dsUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="134751558"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="134751558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2020 20:28:34 -0700
IronPort-SDR: 5Ny6jA7KhA8lJCsOir9TP57QNBIByN+QNcAZddSmKuJ1rbdS7J8N1MrhVKpYdsnjbRggx0kBQc
 89JhrB8/QU8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; d="scan'208";a="327281803"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga008.jf.intel.com with ESMTP; 19 Aug 2020 20:28:28 -0700
Date: Thu, 20 Aug 2020 11:16:21 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200820031621.GA24997@joy-OptiPlex-7040>
References: <20200810074631.GA29059@joy-OptiPlex-7040>
 <e6e75807-0614-bd75-aeb6-64d643e029d3@redhat.com>
 <20200814051601.GD15344@joy-OptiPlex-7040>
 <a51209fe-a8c6-941f-ff54-7be06d73bc44@redhat.com>
 <20200818085527.GB20215@redhat.com>
 <3a073222-dcfe-c02d-198b-29f6a507b2e1@redhat.com>
 <20200818091628.GC20215@redhat.com>
 <20200818113652.5d81a392.cohuck@redhat.com>
 <20200820003922.GE21172@joy-OptiPlex-7040>
 <20200819212234.223667b3@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819212234.223667b3@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yan.y.zhao@intel.com;
 helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 23:28:34
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, libvir-list@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, kwankhede@nvidia.com,
 eauger@redhat.com, xin-ran.wang@intel.com, corbet@lwn.net,
 openstack-discuss@lists.openstack.org, shaohe.feng@intel.com,
 kevin.tian@intel.com, Parav Pandit <parav@mellanox.com>,
 jian-feng.ding@intel.com, dgilbert@redhat.com, zhenyuw@linux.intel.com,
 hejie.xu@intel.com, bao.yumeng@zte.com.cn, Jiri Pirko <jiri@mellanox.com>,
 eskultet@redhat.com, smooney@redhat.com, intel-gvt-dev@lists.freedesktop.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 19, 2020 at 09:22:34PM -0600, Alex Williamson wrote:
> On Thu, 20 Aug 2020 08:39:22 +0800
> Yan Zhao <yan.y.zhao@intel.com> wrote:
> 
> > On Tue, Aug 18, 2020 at 11:36:52AM +0200, Cornelia Huck wrote:
> > > On Tue, 18 Aug 2020 10:16:28 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >   
> > > > On Tue, Aug 18, 2020 at 05:01:51PM +0800, Jason Wang wrote:  
> > > > >    On 2020/8/18 下午4:55, Daniel P. Berrangé wrote:
> > > > > 
> > > > >  On Tue, Aug 18, 2020 at 11:24:30AM +0800, Jason Wang wrote:
> > > > > 
> > > > >  On 2020/8/14 下午1:16, Yan Zhao wrote:
> > > > > 
> > > > >  On Thu, Aug 13, 2020 at 12:24:50PM +0800, Jason Wang wrote:
> > > > > 
> > > > >  On 2020/8/10 下午3:46, Yan Zhao wrote:    
> > > >   
> > > > >  we actually can also retrieve the same information through sysfs, .e.g
> > > > > 
> > > > >  |- [path to device]
> > > > >     |--- migration
> > > > >     |     |--- self
> > > > >     |     |   |---device_api
> > > > >     |    |   |---mdev_type
> > > > >     |    |   |---software_version
> > > > >     |    |   |---device_id
> > > > >     |    |   |---aggregator
> > > > >     |     |--- compatible
> > > > >     |     |   |---device_api
> > > > >     |    |   |---mdev_type
> > > > >     |    |   |---software_version
> > > > >     |    |   |---device_id
> > > > >     |    |   |---aggregator
> > > > > 
> > > > > 
> > > > >  Yes but:
> > > > > 
> > > > >  - You need one file per attribute (one syscall for one attribute)
> > > > >  - Attribute is coupled with kobject  
> > > 
> > > Is that really that bad? You have the device with an embedded kobject
> > > anyway, and you can just put things into an attribute group?
> > > 
> > > [Also, I think that self/compatible split in the example makes things
> > > needlessly complex. Shouldn't semantic versioning and matching already
> > > cover nearly everything? I would expect very few cases that are more
> > > complex than that. Maybe the aggregation stuff, but I don't think we
> > > need that self/compatible split for that, either.]  
> > Hi Cornelia,
> > 
> > The reason I want to declare compatible list of attributes is that
> > sometimes it's not a simple 1:1 matching of source attributes and target attributes
> > as I demonstrated below,
> > source mdev of (mdev_type i915-GVTg_V5_2 + aggregator 1) is compatible to
> > target mdev of (mdev_type i915-GVTg_V5_4 + aggregator 2),
> >                (mdev_type i915-GVTg_V5_8 + aggregator 4)
> > 
> > and aggragator may be just one of such examples that 1:1 matching does not
> > fit.
> 
> If you're suggesting that we need a new 'compatible' set for every
> aggregation, haven't we lost the purpose of aggregation?  For example,
> rather than having N mdev types to represent all the possible
> aggregation values, we have a single mdev type with N compatible
> migration entries, one for each possible aggregation value.  BTW, how do
> we have multiple compatible directories?  compatible0001,
> compatible0002? Thanks,
> 
do you think the bin_attribute I proposed yesterday good?
Then we can have a single compatible with a variable in the mdev_type and
aggregator.

   mdev_type=i915-GVTg_V5_{val1:int:2,4,8}
   aggregator={val1}/2

Thanks
Yan

