Received: from eggs.gnu.org ([2001:4830:134:3::10]:36012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzOA-0001oy-T4
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:28:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZzNu-00055f-Lm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:28:54 -0500
Date: Fri, 12 Jan 2018 14:28:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180112132833.4p7d3unvgs52nn4j@sirius.home.kraxel.org>
References: <20171218140136.31467-1-famz@redhat.com>
	<20180103021350.GB19709@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103021350.GB19709@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-stable] [PATCH] usb-storage: Fix share-rw
 option parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org

On Wed, Jan 03, 2018 at 10:13:50AM +0800, Fam Zheng wrote:
> On Mon, 12/18 22:01, Fam Zheng wrote:
> > Because usb-storage creates an internal scsi device, we should propagate
> > options. We already do so for bootindex etc, but failed to take care of
> > share-rw. Fix it in an apparent way: add a new parameter to
> > scsi_bus_legacy_add_drive and pass in s->conf.share_rw.
> > 
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Ping?

Doesn't apply cleanly any more, please send rebase.

thanks,
  Gerd
