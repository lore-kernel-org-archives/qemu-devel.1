Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E4AC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B33DB208FE
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 00:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B33DB208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGXOE-0006CL-E8
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 20:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kGXNM-0005mL-FP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 20:57:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:5586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1kGXNJ-0005Xi-8y
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 20:57:15 -0400
IronPort-SDR: PxQE/0sGmuiEyv9jqV/hm9W9yzIjzZea7f2TFDkxklTlE2H3Dg5/+jiLIQ5d/JjEkIGpb5FL5l
 MumHvJRWgADw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="222866151"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="222866151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 17:57:07 -0700
IronPort-SDR: wEaes0t1JUF1+JRg83PT+AuKW2T0+i+m5Tw+HlOmyZYCycW14clh/UZyAcInoSfvgV57x5vsXO
 IQI6/6NUTH5A==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="481112652"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 17:57:01 -0700
Date: Fri, 11 Sep 2020 08:56:00 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: device compatibility interface for live migration with assigned
 devices
Message-ID: <20200911005559.GA3932@joy-OptiPlex-7040>
References: <20200825163925.1c19b0f0.cohuck@redhat.com>
 <20200826064117.GA22243@joy-OptiPlex-7040>
 <20200828154741.30cfc1a3.cohuck@redhat.com>
 <8f5345be73ebf4f8f7f51d6cdc9c2a0d8e0aa45e.camel@redhat.com>
 <20200831044344.GB13784@joy-OptiPlex-7040>
 <20200908164130.2fe0d106.cohuck@redhat.com>
 <20200909021308.GA1277@joy-OptiPlex-7040>
 <20200910143822.2071eca4.cohuck@redhat.com>
 <7cebcb6c8d1a1452b43e8358ee6ee18a150a0238.camel@redhat.com>
 <20200910120244.71e7b630@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910120244.71e7b630@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=yan.y.zhao@intel.com; helo=mga07.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 20:57:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 eskultet@redhat.com, Sean Mooney <smooney@redhat.com>,
 intel-gvt-dev@lists.freedesktop.org,
 Daniel =?iso-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, dinechin@redhat.com, devel@ovirt.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:02:44PM -0600, Alex Williamson wrote:
> On Thu, 10 Sep 2020 13:50:11 +0100
> Sean Mooney <smooney@redhat.com> wrote:
> 
> > On Thu, 2020-09-10 at 14:38 +0200, Cornelia Huck wrote:
> > > On Wed, 9 Sep 2020 10:13:09 +0800
> > > Yan Zhao <yan.y.zhao@intel.com> wrote:
> > >   
> > > > > > still, I'd like to put it more explicitly to make ensure it's not missed:
> > > > > > the reason we want to specify compatible_type as a trait and check
> > > > > > whether target compatible_type is the superset of source
> > > > > > compatible_type is for the consideration of backward compatibility.
> > > > > > e.g.
> > > > > > an old generation device may have a mdev type xxx-v4-yyy, while a newer
> > > > > > generation  device may be of mdev type xxx-v5-yyy.
> > > > > > with the compatible_type traits, the old generation device is still
> > > > > > able to be regarded as compatible to newer generation device even their
> > > > > > mdev types are not equal.    
> > > > > 
> > > > > If you want to support migration from v4 to v5, can't the (presumably
> > > > > newer) driver that supports v5 simply register the v4 type as well, so
> > > > > that the mdev can be created as v4? (Just like QEMU versioned machine
> > > > > types work.)    
> > > > 
> > > > yes, it should work in some conditions.
> > > > but it may not be that good in some cases when v5 and v4 in the name string
> > > > of mdev type identify hardware generation (e.g. v4 for gen8, and v5 for
> > > > gen9)
> > > > 
> > > > e.g.
> > > > (1). when src mdev type is v4 and target mdev type is v5 as
> > > > software does not support it initially, and v4 and v5 identify hardware
> > > > differences.  
> > > 
> > > My first hunch here is: Don't introduce types that may be compatible
> > > later. Either make them compatible, or make them distinct by design,
> > > and possibly add a different, compatible type later.
> > >   
> > > > then after software upgrade, v5 is now compatible to v4, should the
> > > > software now downgrade mdev type from v5 to v4?
> > > > not sure if moving hardware generation info into a separate attribute
> > > > from mdev type name is better. e.g. remove v4, v5 in mdev type, while use
> > > > compatible_pci_ids to identify compatibility.  
> > > 
> > > If the generations are compatible, don't mention it in the mdev type.
> > > If they aren't, use distinct types, so that management software doesn't
> > > have to guess. At least that would be my naive approach here.  
> > yep that is what i would prefer to see too.
> > >   
> > > > 
> > > > (2) name string of mdev type is composed by "driver_name + type_name".
> > > > in some devices, e.g. qat, different generations of devices are binding to
> > > > drivers of different names, e.g. "qat-v4", "qat-v5".
> > > > then though type_name is equal, mdev type is not equal. e.g.
> > > > "qat-v4-type1", "qat-v5-type1".  
> > > 
> > > I guess that shows a shortcoming of that "driver_name + type_name"
> > > approach? Or maybe I'm just confused.  
> > yes i really dont like haveing the version in the mdev-type name 
> > i would stongly perfger just qat-type-1 wehere qat is just there as a way of namespacing.
> > although symmetric-cryto, asymmetric-cryto and compression woudl be a better name then type-1, type-2, type-3 if
> > that is what they would end up mapping too. e.g. qat-compression or qat-aes is a much better name then type-1
> > higher layers of software are unlikely to parse the mdev names but as a human looking at them its much eaiser to
> > understand if the names are meaningful. the qat prefix i think is important however to make sure that your mdev-types
> > dont colide with other vendeors mdev types. so i woudl encurage all vendors to prefix there mdev types with etiher the
> > device name or the vendor.
> 
> +1 to all this, the mdev type is meant to indicate a software
> compatible interface, if different hardware versions can be software
> compatible, then don't make the job of finding a compatible device
> harder.  The full type is a combination of the vendor driver name plus
> the vendor provided type name specifically in order to provide a type
> namespace per vendor driver.  That's done at the mdev core level.
> Thanks,

hi Alex,
got it. so do you suggest that vendors use consistent driver name over
generations of devices?
for qat, they create different modules for each generation. This
practice is not good if they want to support migration between devices
of different generations, right?

and can I understand that we don't want support of migration between
different mdev types even in future ?

Thanks
Yan


