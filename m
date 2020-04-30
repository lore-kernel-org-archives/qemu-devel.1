Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D65C83000
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 00:58:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A22920787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 00:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A22920787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTxXB-0006y8-9p
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 20:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jTxWG-0006Uy-VK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <yan.y.zhao@intel.com>) id 1jTxUC-0001yD-FK
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:57:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:43036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yan.y.zhao@intel.com>)
 id 1jTxUB-0001dM-CJ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 20:55:32 -0400
IronPort-SDR: efd8MDCNsYyFMv0M0/j2vXQBoR7OMKmI67uAlEXJZI+r5jd+fyBoHbh29PuaLyJkt1JuyCVLhY
 TkTTFetdPnCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 17:55:28 -0700
IronPort-SDR: +gRX2R/WV/4QXJPPo6djRHcjf8PsJ1DwkfropLFEC/MLZ7TCqHkGV7ms5qWKqZXcpf0RzixPXC
 dDGi/gCLRJ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,333,1583222400"; d="scan'208";a="249600406"
Received: from joy-optiplex-7040.sh.intel.com (HELO joy-OptiPlex-7040)
 ([10.239.13.16])
 by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2020 17:55:21 -0700
Date: Wed, 29 Apr 2020 20:45:38 -0400
From: Yan Zhao <yan.y.zhao@intel.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 0/4] introduction of migration_version attribute for
 VFIO live migration
Message-ID: <20200430004537.GO12879@joy-OptiPlex-7040>
References: <20200422073628.GA12879@joy-OptiPlex-7040>
 <20200424191049.GU3106@work-vm>
 <20200426013628.GC12879@joy-OptiPlex-7040>
 <20200427153743.GK2923@work-vm>
 <20200428005429.GJ12879@joy-OptiPlex-7040>
 <20200428141437.GG2794@work-vm>
 <20200429072616.GL12879@joy-OptiPlex-7040>
 <20200429082201.GA2834@work-vm>
 <20200429093555.GM12879@joy-OptiPlex-7040>
 <94cd58d2-0580-53cd-6ca2-2c33146e0f2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94cd58d2-0580-53cd-6ca2-2c33146e0f2c@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=134.134.136.20; envelope-from=yan.y.zhao@intel.com;
 helo=mga02.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 20:55:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 134.134.136.20
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
Cc: Cornelia Huck <cohuck@redhat.com>, "cjia@nvidia.com" <cjia@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 "Zhengxiao.zx@alibaba-inc.com" <Zhengxiao.zx@alibaba-inc.com>,
 "shuangtai.tst@alibaba-inc.com" <shuangtai.tst@alibaba-inc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "eauger@redhat.com" <eauger@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Yang, Ziye" <ziye.yang@intel.com>,
 "mlevitsk@redhat.com" <mlevitsk@redhat.com>,
 "pasic@linux.ibm.com" <pasic@linux.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "felipe@nutanix.com" <felipe@nutanix.com>, "Ken.Xue@amd.com" <Ken.Xue@amd.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Zeng, Xin" <xin.zeng@intel.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
 "jonathan.davies@nutanix.com" <jonathan.davies@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "intel-gvt-dev@lists.freedesktop.org" <intel-gvt-dev@lists.freedesktop.org>,
 "Liu, Changpeng" <changpeng.liu@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eskultet@redhat.com" <eskultet@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wang,
 Zhi A" <zhi.a.wang@intel.com>, "dinechin@redhat.com" <dinechin@redhat.com>,
 "He, Shaopeng" <shaopeng.he@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 29, 2020 at 10:13:01PM +0800, Eric Blake wrote:
> [meta-comment]
> 
> On 4/29/20 4:35 AM, Yan Zhao wrote:
> > On Wed, Apr 29, 2020 at 04:22:01PM +0800, Dr. David Alan Gilbert wrote:
> [...]
> >>>>>>>>>>>>>>>>> This patchset introduces a migration_version attribute under sysfs
> >>>>>>>>>>> of VFIO
> >>>>>>>>>>>>>>>>> Mediated devices.
> 
> Hmm, several pages with up to 16 levels of quoting, with editors making 
> the lines ragged, all before I get to the real meat of the email. 
> Remember, it's okay to trim content,...
> 
> >> So why don't we split the difference; lets say that it should start with
> >> the hex PCI Vendor ID.
> >>
> > The problem is for mdev devices, if the parent devices are not PCI devices,
> > they don't have PCI vendor IDs.
> 
> ...to just what you are replying to.
>
sorry for that. next time I'll try to make a better balance between
keeping conversation background and leaving the real meat of the email.

Thanks for reminding.
Yan

