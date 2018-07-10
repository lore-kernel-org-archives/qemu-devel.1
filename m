Received: from eggs.gnu.org ([2001:4830:134:3::10]:54072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fchuz-0002g7-TP
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fchuw-00006a-Re
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:58:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fchuw-00006P-MF
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:58:14 -0400
Date: Tue, 10 Jul 2018 04:58:13 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710045614-mutt-send-email-mst@kernel.org>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<d5db37d0-5eaf-8942-8ab7-d73057a67e6f@oracle.com>
	<20180709130035.GA6271@rkaganb.sw.ru>
	<9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9136094e-a510-4201-7c71-d1c49226fa5f@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: si-wei liu <si-wei.liu@oracle.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Venu Busireddy <venu.busireddy@oracle.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, sridhar.samudrala@intel.com, alexander.h.duyck@intel.com, netdev@vger.kernel.org

On Mon, Jul 09, 2018 at 06:11:53PM -0700, si-wei liu wrote:
> What do we buy
> for using a random address during initial discovery and requiring VF to
> complete the handshake?

I don't see advantages to using a random address that is then
changed either: changing a MAC causes network downtime for most users.

> Less network downtime during datapath switching?
> Sorry but that's not a key factor at all for our main goal - live migration.

Isn't avoiding downtime what makes the migration "live"?
If you don't care about it at all just remove the device
and migrate without all these tricks.


-- 
MST
