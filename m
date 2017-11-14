Received: from eggs.gnu.org ([2001:4830:134:3::10]:37480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEXxd-0003Hk-Qv
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEXxZ-0006Ok-Vp
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:56:53 -0500
Date: Tue, 14 Nov 2017 10:56:30 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171114095630.2v4lzfxlmpom33mi@sirius.home.kraxel.org>
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<67465b2020def3680dfd15d6473d3316c3fc8be0.1510612380.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67465b2020def3680dfd15d6473d3316c3fc8be0.1510612380.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/29] Replace all occurances of
 __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Andrzej Zaborowski <balrogg@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org

On Mon, Nov 13, 2017 at 02:34:42PM -0800, Alistair Francis wrote:
> Replace all occurs of __FUNCTION__ except for the check in checkpatch
> with the non GCC specific __func__.
> 
> One line in hcd-musb.c was manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Andrzej Zaborowski <balrogg@gmail.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@imgtec.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: qemu-arm@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: xen-devel@lists.xenproject.org
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
