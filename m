Received: from eggs.gnu.org ([2001:4830:134:3::10]:35966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTVZh-0004ue-0v
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cTVZg-00024R-8t
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:21:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cTVZg-00024J-2g
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 10:21:28 -0500
Date: Tue, 17 Jan 2017 17:21:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170117171155-mutt-send-email-mst@kernel.org>
References: <20161006041949-mutt-send-email-mst@kernel.org>
	<D5FCB73B-435E-4423-B21C-BEEF1C1EA2FD@skyportsystems.com>
	<20161211052355-mutt-send-email-mst@kernel.org>
	<FBD67273-74C4-4183-8FCF-8260D13B04D4@skyportsystems.com>
	<20170116161857-mutt-send-email-mst@kernel.org>
	<85C3D50B-7AFD-41E7-AD1B-634A42D04BB2@skyportsystems.com>
	<20170117142650.2a2a351f@nial.brq.redhat.com>
	<CAO_EM_km-04HBOZP2H3UvPPaCKyQx1nZD1QKPVYuawwTJjdYSQ@mail.gmail.com>
	<20170117163002-mutt-send-email-mst@kernel.org>
	<CAO_EM_kcfhVPye+5vUZPY=mWS3TrcCWYh_ozTy8gPRgkCLMG-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_kcfhVPye+5vUZPY=mWS3TrcCWYh_ozTy8gPRgkCLMG-w@mail.gmail.com>
Subject: Re: [Qemu-devel] Virtual Machine Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ben Warren <ben@skyportsystems.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

Let's not top-post anymore pls.

On Tue, Jan 17, 2017 at 07:01:27AM -0800, Ed Swierk wrote:
> You mean what causes the guest to re-read the vmgenid guid? The
> vmgenid ACPI table defines a notify method, and when the guest
> receives the corresponding event, it re-reads the guid. (Also it
> appears that with Windows Server 2012 at least, if no notify method is
> defined, as is the case with Xen, the guest just re-reads it on
> demand.)
> 
> Wouldn't it be sufficient for the qmp set-vmgenid command to call
> acpi_ram_update() with the new guid, and acpi_send_event() to notify
> the guest?
> 
> --Ed
> 

Not if you want to reliably be able to know that gen ID
did not change.

Consider an application that sends a transaction to
a database. It should be able to read gen ID and if that
is unchanged then you know you only sent it once.
If that is changed you may have sent it twice,
and may need to recover.

If guest updates gen id in memory after getting a notify,
there's a window after receiving a notify and before
updating it.



-- 
MST
