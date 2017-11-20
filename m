Received: from eggs.gnu.org ([2001:4830:134:3::10]:46834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eGnXu-0005iR-Nw
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chao.gao@intel.com>) id 1eGnXq-0000aA-JX
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:59:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:6728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chao.gao@intel.com>) id 1eGnXq-0000ZD-BV
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:59:34 -0500
Date: Mon, 20 Nov 2017 15:56:54 +0800
From: Chao Gao <chao.gao@intel.com>
Message-ID: <20171120075433.GA6286@op-computing>
References: <1510899865-40323-1-git-send-email-chao.gao@intel.com>
	<1510899865-40323-2-git-send-email-chao.gao@intel.com>
	<20171117152342-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171117152342-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] i386/msi: Correct mask of
 destination ID in MSI address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Peter Xu <peterx@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>

On Fri, Nov 17, 2017 at 03:24:21PM +0200, Michael S. Tsirkin wrote:
>On Fri, Nov 17, 2017 at 02:24:23PM +0800, Chao Gao wrote:
>> According to SDM 10.11.1, only [19:12] bits of MSI address are
>> Destination ID, change the mask to avoid ambiguity for VT-d spec
>> has used the bit 4 to indicate a remappable interrupt request.
>> 
>> Signed-off-by: Chao Gao <chao.gao@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>Do you want me to merge this?

Of course. It is a simple patch and has no dependency with the other two in
this series.

Thanks
Chao
