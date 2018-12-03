Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=868a16509=Andrew.Cooper3@citrix.com>)
	id 1gTozr-0002n7-6a
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=868a16509=Andrew.Cooper3@citrix.com>)
	id 1gTozn-000581-Uy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:14:51 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:51641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=868a16509=Andrew.Cooper3@citrix.com>)
	id 1gTozn-00055J-KH
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:14:47 -0500
References: <20181203050438.6034-1-yan.y.zhao@intel.com>
From: Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <f056b5d1-02c2-2ee7-3e37-bc5e4869f0cb@citrix.com>
Date: Mon, 3 Dec 2018 14:12:58 +0000
MIME-Version: 1.0
In-Reply-To: <20181203050438.6034-1-yan.y.zhao@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2] xen/pt: Fix a xen
 passthrough failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhao Yan <yan.y.zhao@intel.com>, anthony.perard@citrix.com, sstabellini@kernel.org, roger.pau@citrix.com, JBeulich@suse.com, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org

On 03/12/2018 05:04, Zhao Yan wrote:
> For some pci device, even its PCI_INTERRUPT_PIN is not 0, it actually
> doesn't support INTx mode, so its machine irq read from host sysfs is 0.
> In that case, report PCI_INTERRUPT_PIN as 0 to guest and let passthrough
> continue.

What causes this problem?  It it a non-PCI compliant device?  Is it a
device which has legacy lines prohibited?

~Andrew
