Received: from eggs.gnu.org ([2001:4830:134:3::10]:56915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpywQ-0003rM-IX
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cpywK-0005Fd-Ku
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:09:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cpywK-0005FN-EM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:09:44 -0400
References: <20170320115951.25345-1-lersek@redhat.com>
	<20170320115951.25345-2-lersek@redhat.com>
	<20170320161756-mutt-send-email-mst@kernel.org>
	<97c77b4b-61d3-1527-43c1-89d52dcf08f4@redhat.com>
	<88fd49e5-1a89-0a35-3d1a-04b3a582168a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95b845cc-a0e2-d9dd-add6-73d92e1f92a9@redhat.com>
Date: Mon, 20 Mar 2017 16:09:41 +0100
MIME-Version: 1.0
In-Reply-To: <88fd49e5-1a89-0a35-3d1a-04b3a582168a@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/acpi/vmgenid: prevent device
 realization on pre-2.9 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu devel list <qemu-devel@nongnu.org>, Ben Warren <ben@skyportsystems.com>



On 20/03/2017 16:08, Laszlo Ersek wrote:
> (1) machine types up to and including 2.4 do not enable DMA for fw_cfg.
> Without DMA, the WRITE_POINTER linker/loader commands have no chance of
> working in the firmware.
> 
> (2) ... the other part of the problem was actually in my thinking, sorry
> about that. I forgot that that "-device vmgenid" itself is not available
> in QEMU releases prior to 2.9. So we shouldn't worry about the case
> where write support is missing from fw_cfg, although DMA is available.
> 
> In this patch I tried to address (non-)problem (2), thereby covering
> (real) problem (1). I now see that (2) doesn't actually exist. (1) does
> have to be addressed however.
> 
> If you agree, I'll respin this patch.

Yes, please do respin it with pre-2.4 machine types limited only.

Paolo
