Received: from eggs.gnu.org ([2001:4830:134:3::10]:60217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUV8E-0000Hb-EP
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUV8B-000784-Bp
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:05:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUV8B-00077b-70
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:05:11 -0500
Date: Fri, 20 Jan 2017 17:05:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170120090506.GJ4914@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-3-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C14F86@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 02/14] intel_iommu: simplify irq
 region translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

On Fri, Jan 20, 2017 at 08:22:14AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, January 13, 2017 11:06 AM
> > 
> > Before we have int-remap, we need to bypass interrupt write requests.
> > That's not necessary now - we have supported int-remap, and all the irq
> > region requests should be redirected there. Cleaning up the block with
> > an assertion instead.
> 
> This comment is not accurate. According to code, the reason why you
> can do such simplification is because we have standalone memory
> region now for interrupt addresses. There should be nothing to do 
> with int-remap, which can be disabled by guest... Maybe the standalone
> region was added when developing int-remap, but functionally they
> are not related. :-)

IMHO the above commit message is fairly clear. :-)

But sure I can add some more emphasise like:

  "Before we have int-remap memory region, ..."

Do you think it's okay? Or any better suggestion?

(Just to mention that even guest disables IR, the MSI region will
 still be there.)

Thanks,

-- peterx
