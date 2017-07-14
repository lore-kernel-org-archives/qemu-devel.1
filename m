Received: from eggs.gnu.org ([2001:4830:134:3::10]:52835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW72D-0000sg-Vg
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW729-00027I-TQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW729-00026d-NA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 16:17:53 -0400
Date: Fri, 14 Jul 2017 23:17:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714230852-mutt-send-email-mst@kernel.org>
References: <20170714182012.4595-1-marcandre.lureau@redhat.com>
	<20170714182012.4595-3-marcandre.lureau@redhat.com>
	<20170714222023-mutt-send-email-mst@kernel.org>
	<5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d31f22d-e0ae-92f4-ea17-690419f72944@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/8] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jul 14, 2017 at 10:04:31PM +0200, Laszlo Ersek wrote:
> > It worries me that the format of this seems completely undefined
> > except in the patchset cover letter.
> > I don't think we should merge this before it is.
> 
> I'm not sure what you mean, this patch adds "docs/specs/vmcoreinfo.txt".
> That file is the first level contract between the guest firmware
> (generally, via the linker/loader), the guest kernel driver
> (specifically), and QEMU (also specifically).
> 
> The second level contract is the guest kernel's vmcoreinfo ELF note
> (which is pointed-to by the first level contract). The layout of that is
> specified elsewhere indeed (I don't think it belongs here).
> 
> We've taken care not to trust anything coming from the guest kernel.
> 
> Can you clarify please?
> 
> Thanks
> Laszlo

All there is is this:

+Version 0 content:
+
+ uint64 paddr:
+  Physical address of the Linux vmcoreinfo ELF note.
+ uint32 size:
+  Size of the vmcoreinfo ELF note.

It isn't defined here what is the Linux vmcoreinfo ELF note.
You want a bit more info so people trying to use it know where to start
and what they can get out of it.

-- 
MST
