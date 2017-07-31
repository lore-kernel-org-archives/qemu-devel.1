Received: from eggs.gnu.org ([2001:4830:134:3::10]:33351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcFrA-0007YS-Ck
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcFr5-0003Nw-EQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcFr5-0003Mh-4x
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:55:51 -0400
Date: Mon, 31 Jul 2017 21:55:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170731215200-mutt-send-email-mst@kernel.org>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-5-git-send-email-zuban32s@gmail.com>
	<20170726215625-mutt-send-email-mst@kernel.org>
	<CAKSfGUAh_rqGy8uNJXThH4v1z5zbPdLhkBx77Tui8PL-N-7JXw@mail.gmail.com>
	<20170727022103-mutt-send-email-mst@kernel.org>
	<f210b52b-b7ea-b27e-cca8-9f11a4b4f353@redhat.com>
	<98048fb7-34e7-d92f-cbe5-90f39c9fcb46@redhat.com>
	<20170729021229-mutt-send-email-mst@kernel.org>
	<1761dcb9-420b-228f-f3d1-149b66e5ec4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761dcb9-420b-228f-f3d1-149b66e5ec4c@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC PATCH v2 4/6] hw/pci: introduce
 bridge-only vendor-specific capability to provide some hints to firmware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, seabios@seabios.org, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, rth@twiddle.net

On Mon, Jul 31, 2017 at 08:16:49PM +0200, Laszlo Ersek wrote:
> OK. If the proposed solution with the r/o mem base/limit registers is
> rooted in the spec (and I think it indeed must be; apparently this would
> be the same as what we're already planning for IO disablement), then
> that's a strong argument for PciBusDxe to accommodate this probing in
> the platform hook.
> 
> Thanks
> Laszlo

Do you mean making base/limit read-only?
