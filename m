Received: from eggs.gnu.org ([2001:4830:134:3::10]:39317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eedFe-00067K-Fo
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:51:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eedFb-0000aT-Cl
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:51:18 -0500
Date: Thu, 25 Jan 2018 09:51:08 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180125085108.tqmyzxpyyt6wsqez@sirius.home.kraxel.org>
References: <20180117005222.4781-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117005222.4781-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] usb-storage: Fix share-rw option parsing
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

On Wed, Jan 17, 2018 at 08:52:22AM +0800, Fam Zheng wrote:
> Because usb-storage creates an internal scsi device, we should propagate
> options. We already do so for bootindex etc, but failed to take care of
> share-rw. Fix it in an apparent way: add a new parameter to
> scsi_bus_legacy_add_drive and pass in s->conf.share_rw.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Fam Zheng <famz@redhat.com>

Added to usb queue.

thanks,
  Gerd
