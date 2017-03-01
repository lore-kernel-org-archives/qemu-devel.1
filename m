Received: from eggs.gnu.org ([2001:4830:134:3::10]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashok.raj@intel.com>) id 1cjBpP-0003rU-1r
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashok.raj@intel.com>) id 1cjBpL-0005gZ-TI
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:30:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:34604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ashok.raj@intel.com>) id 1cjBpL-0005fd-JZ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 16:30:27 -0500
Date: Wed, 1 Mar 2017 13:30:23 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
Message-ID: <20170301213023.fv5utdpbh4zvsxdy@araj-mobl1>
References: <A2975661238FB949B60364EF0F2C257436DE3165@shsmsx102.ccr.corp.intel.com>
	<20170228220719.GD2352@char.us.ORACLE.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C4FF94@SHSMSX101.ccr.corp.intel.com>
	<20170301210938.GE9043@char.us.ORACLE.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170301210938.GE9043@char.us.ORACLE.com>
Subject: Re: [Qemu-devel] [RFC Design Doc v3] Enable Shared Virtual Memory
 feature in pass-through scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Peng,	Chao P" <chao.p.peng@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Hao, Xudong" <xudong.hao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Ashok Raj <ashok.raj@intel.com>

On Wed, Mar 01, 2017 at 04:09:38PM -0500, Konrad Rzeszutek Wilk wrote:
> .snip..
> > 
> > No. SVM is purely about sharing CPU address space with device. Command
> > submission is still through kernel driver which controls rings (with SVM then
> > you can put VA into those commands). There are other vendor specific 
> > features to enable direct user space submission which is orthogonal to SVM.
> 
> Apologies for my ignorance but how is this beneficial? As in
> currently you would put in bus addresses on the ring, but now you
> can put VA addresses.
> 
> The obvious benefit I see is that you omit the DMA ops which means there is
> less of 'lookup' (VA->bus address) in software - but I would have thought this
> would be negligible performance impact? And now the IOMMU alongside with
> the CPU would do this lookup.
> 
> Or are there some other improvements in this?
Other benefits include,

- Application can simply pass its pointers to the SVM capable devices. which
  means no memory registration overhead to get IO Virtual Addresses. 
- No need to pin memory for DMA, since the devices can handle faults and
  can request pages to be paged-in on demand.
> 
> > 
> > Thanks
> > Kevin
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
