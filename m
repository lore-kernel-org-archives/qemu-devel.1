Received: from eggs.gnu.org ([2001:4830:134:3::10]:60551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLGtR-0002vt-RM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLGtM-0008TG-Ky
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:40:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLGtM-0008T8-BS
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:40:32 -0400
Date: Wed, 23 May 2018 02:40:26 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180523023944-mutt-send-email-mst@kernel.org>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
	<1526801333-30613-4-git-send-email-whois.zihan.yang@gmail.com>
	<ef3fc85d-7726-c888-e8ca-9dfae1b908d3@gmail.com>
	<17a3765f-b835-2d45-e8b9-ffd4aff909f9@redhat.com>
	<cbdfe0d6-f071-3560-009d-3bbdde12b33c@gmail.com>
	<f71a8c61-a0d7-6ebc-62ad-3dab8b9f8e5a@redhat.com>
	<dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd40007d-b63b-d965-505f-11ff0748e54f@redhat.com>
Subject: Re: [Qemu-devel] [RFC 3/3] acpi-build: allocate mcfg for multiple
 host bridges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zihan Yang <whois.zihan.yang@gmail.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eauger@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On Wed, May 23, 2018 at 12:42:09AM +0200, Laszlo Ersek wrote:
> Hold on,
> 
> On 05/22/18 21:51, Laszlo Ersek wrote:
> 
> > It had taken years until the edk2 core gained a universal
> > PciHostBridgeDxe driver with a well-defined platform customization
> > interface, and that interface doesn't support multiple domains /
> > segments.
> 
> after doing a bit more research: I was wrong about this. What I
> remembered was not the current state. Edk2 does seem to support multiple
> domains, with different segment numbers, ECAM base addresses, and bus
> number ranges. If we figure out a placement strategy or an easy to
> consume representation of these data for the firmware, it might be
> possible for OVMF to hook them into the edk2 core (although not in the
> earliest firmware phases, such as SEC and PEI).
> 
> In retrospect, I'm honestly surprised that so much multi-segment support
> has been upstreamed to the edk2 core. Sorry about the FUD. (My general
> points remain valid, for the record... But perhaps they no longer matter
> for this discussion.)
> 
> (I meant to send this message soon after
> <http://mid.mail-archive.com/fc603491-7c41-e862-a583-2bae6f165b5a@redhat.com>,
> but my internet connection had to die right then.)
> 
> Thanks
> Laszlo

Is there support for any hardware which we could emulate?

-- 
MST
