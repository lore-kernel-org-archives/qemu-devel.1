Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUVYn-0002NA-Pm
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUVYk-0005rD-KV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:41:45 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:56845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=870ab16ad=anthony.perard@citrix.com>)
	id 1gUVYk-0005pX-Bi
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:41:42 -0500
Date: Wed, 5 Dec 2018 11:41:32 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20181205114132.GA1259@perard.uk.xensource.com>
References: <20181205075830.15678-1-yan.y.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181205075830.15678-1-yan.y.zhao@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4] xen/pt: allow passthrough of devices
 with bogus interrupt pin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhao Yan <yan.y.zhao@intel.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, xen-devel@lists.xenproject.org, Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>, Jan Beulich <JBeulich@suse.com>

On Wed, Dec 05, 2018 at 02:58:30AM -0500, Zhao Yan wrote:
> For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
> doesn't support INTx mode, so its machine irq read from host sysfs is 0.
> In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
> continue.
> 
> Cc: Roger Pau Monné <roger.pau@citrix.com>
> Cc: Jan Beulich <JBeulich@suse.com>
> Reviewed-by: Roger Pau Monné <roger.pau@citrix.com>
> Signed-off-by: Zhao Yan <yan.y.zhao@intel.com>

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD
