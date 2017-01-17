Received: from eggs.gnu.org ([2001:4830:134:3::10]:42688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTRD9-0005Qw-3C
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:41:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cTRD7-0007is-Ri
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 05:41:55 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
	<20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
Date: Tue, 17 Jan 2017 11:41:44 +0100
MIME-Version: 1.0
In-Reply-To: <20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-stable] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Fabian_Gr=c3=bcnbichler?= <f.gruenbichler@proxmox.com>, Alexandre DERUMIER <aderumier@odiso.com>
Cc: Peter Lieven <pl@kamp.de>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>



On 17/01/2017 09:03, Fabian Grünbichler wrote:
> Commit 8fdc7839e40f43a426bc7e858cf1dbfe315a3804 (first included in
> 2.7.0)[1] changed the behaviour of scsi-block passthrough. Previously
> this worked with SATA disks, now it doesn't anymore. A bisect run
> confirmed this, scsi-block with a SATA disk passed through via
> virtio-scsi-single corrupts on writes since that commit, scsi-hd and
> scsi-disk work fine (scsi-generic corrupts as well).
> 
> PVE's detection logic for passthrough just differentiated between disks
> and tape drives, and unfortunately the SG_IO ioctl says SATA disks are
> disks as well.. we probably need to default to scsi-hd or scsi-disk
> instead of scsi-block, and only when we explicitly detect a "real" SCSI
> disk we are allowed to use scsi-block?
> 
> @Paolo: was the old behaviour just an accident and the new bevaviour
> intentional? documentation is quite sparse, or maybe I am looking in the
> wrong places..

No, it would be a bug (QEMU or kernel).

Do you have an easy reproducer with dd, as suggested at
https://forum.proxmox.com/threads/proxmox-4-4-virtio_scsi-regression.31471/page-2?

Paolo
