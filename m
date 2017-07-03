Received: from eggs.gnu.org ([2001:4830:134:3::10]:52210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS4LW-0001sD-Nl
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:37:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS4LT-0000QZ-LM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:37:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS4LT-0000QH-E8
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:37:07 -0400
Date: Mon, 3 Jul 2017 19:37:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170703193427-mutt-send-email-mst@kernel.org>
References: <1498773362-18675-1-git-send-email-zuban32s@gmail.com>
	<20170630020622-mutt-send-email-mst@kernel.org>
	<ec616cb6-f693-76c5-5732-ec6ee7840d9c@redhat.com>
	<20170703142711.0a1db036@nial.brq.redhat.com>
	<CAKSfGUCWRMEZLazPibjMeJo9pV5SxdWK9p+4_prr9hAeWpU7nw@mail.gmail.com>
	<CAKSfGUCDaPFi=1MBxFkfz1ZtZfkfYneSVtxh=ydOAS0jtPsSJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKSfGUCDaPFi=1MBxFkfz1ZtZfkfYneSVtxh=ydOAS0jtPsSJw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/6] q35: add acpi pci hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

SHPC did work for linux. As ACPI is enabled by default, you need
to expose it in _OSC and maybe jump through more hoops
to avoid ACPI from trying to take over.

Source is available so if it doesn't work you should be able
to find out why.



On Mon, Jul 03, 2017 at 05:41:12PM +0300, Alexander Bezzubikov wrote:
> Do we have any surely working scenario of pci-bridge's SHPC usage? Because
> first of all I've tried to use SHPC to avoi involving any ACPI code, but it
> didn't look functioning even for ordinary pci-bridge, that's why after talking
> to Marcel I left SHPC idea.
> 
> 2017-07-03 16:58 GMT+03:00 Alexander Bezzubikov <zuban32s@gmail.com>:
> 
>     Hmm, I've failed to make SHPC (from current master) work on any modern
>     Linux guests.
> 
>     2017-07-03 15:27 GMT+03:00 Igor Mammedov <imammedo@redhat.com>:
> 
>         On Fri, 30 Jun 2017 10:25:05 +0300
>         Marcel Apfelbaum <marcel@redhat.com> wrote:
> 
>         [...]
>         >
>         > So for the modern systems not supporting PCI ACPI hotplug
>         > we don't need pci-bridges anyway, but for the older ones
>         > the ACPI code of the pci-bridge will be loaded into the
>         > ACPI namespace only if a pci-bridge is actually hot-plugged.
> 
>         just note that the set of 'older' guest OSes is limited to
>         one that do not support SHPC (i.e. to EOLed WinXP & co)
>         as for linux and more modern Windows SHPC hotplug should
>         just work without our ACPI hack (which taxes low memory
>         to keep acpi tables for bridges).
> 
>         So I'm in favor of Michael's suggestion to leave ACPI PCI
>         only in PC machine for old WinXP guests and to keep Q35
>         clean, where linux or newer Windows guests could just
>         use standard SHPC.
> 
>         [...]
> 
> 
> 
> 
>     --
>     Alexander Bezzubikov
> 
> 
> 
> 
> --
> Alexander Bezzubikov
