Received: from eggs.gnu.org ([2001:4830:134:3::10]:48738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWYZ4-0005nv-Md
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eWYZ1-0003ik-Hy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:13:58 -0500
Date: Wed, 3 Jan 2018 10:13:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180103021350.GB19709@localhost.localdomain>
References: <20171218140136.31467-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218140136.31467-1-famz@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org

On Mon, 12/18 22:01, Fam Zheng wrote:
> Because usb-storage creates an internal scsi device, we should propagate
> options. We already do so for bootindex etc, but failed to take care of
> share-rw. Fix it in an apparent way: add a new parameter to
> scsi_bus_legacy_add_drive and pass in s->conf.share_rw.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Ping?
