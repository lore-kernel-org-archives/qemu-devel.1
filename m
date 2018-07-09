Received: from eggs.gnu.org ([2001:4830:134:3::10]:37259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fcVzz-0000Qz-Te
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fcVzv-0001h3-SW
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:14:39 -0400
Received: from mail-ve1eur03hn0208.outbound.protection.outlook.com
	([104.47.9.208]:45472
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fcVzv-0001gh-35
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:14:35 -0400
Date: Mon, 9 Jul 2018 16:14:19 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180709131419.GB6271@rkaganb.sw.ru>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
	<20180703165200.180c93bb.cohuck@redhat.com>
	<CADGSJ23+sZiMCx=n=DytZ=TT2z7i0sMhrmnPuFYtuZhSc=qA+Q@mail.gmail.com>
	<20180704141523.377cb66d.cohuck@redhat.com>
	<CADGSJ206U4x0UNTEKu0Lt9K9qA025ajtmnj6ym4PDz4Q-c8RKA@mail.gmail.com>
	<20180706155406.0587733c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706155406.0587733c.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 0/3] Use of unique
 identifier for pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Siwei Liu <loseweigh@gmail.com>, Venu Busireddy <venu.busireddy@oracle.com>, si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Fri, Jul 06, 2018 at 03:54:06PM +0200, Cornelia Huck wrote:
> If we want to extend that to other device types, we can add the field
> in their config space; but I'd rather prefer a more generic "host
> relays config metainformation" approach.

The problem with this approach is that it's too generic and poorly
scoped.  As a result I guess it's likely to take ages to converge.

See for instance the discussion on including vm config metadata in qcow2
images: I think it's similar in scope (or the absense thereof).

Roman.
