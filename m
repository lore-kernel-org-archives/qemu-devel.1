Received: from eggs.gnu.org ([2001:4830:134:3::10]:50429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8TQH-0007fk-7b
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8TGm-0007y7-TG
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:48:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8TGm-0007xa-Mb
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:48:04 -0400
Date: Fri, 5 Oct 2018 18:48:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181005164800.klw6siygbyk2ipbx@sirius.home.kraxel.org>
References: <20181005160147.892-1-kraxel@redhat.com>
	<20181005160147.892-2-kraxel@redhat.com>
	<CAKmqyKNY+Yziwq_82Oz4yueAvYAzrOev5=0taNm6qpUFcGZcnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKNY+Yziwq_82Oz4yueAvYAzrOev5=0taNm6qpUFcGZcnA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] display: add separate config option
 for bochs-display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Oct 05, 2018 at 09:22:29AM -0700, Alistair Francis wrote:
> On Fri, Oct 5, 2018 at 9:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > This allows modern architectures which don't care about vga
> > compatibility (risc-v for example) build bochs-display without
> > including all vga emulation too.
> 
> For RISC-V we end up including pci.mak anyway for other things such as
> NVMe drives. So we don't really need this, but it still seems useful.

Hmm, maybe we should split pci.mak into pci-legacy.mak and pci-express.mak
then?

cheers,
  Gerd
