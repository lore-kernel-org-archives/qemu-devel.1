Received: from eggs.gnu.org ([2001:4830:134:3::10]:46295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcZAH-0000t1-Ki
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcZAE-0007mw-H6
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55737)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcZAE-0007m5-Bi
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 11:32:54 -0400
Date: Tue, 1 Aug 2017 18:32:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170801183208-mutt-send-email-mst@kernel.org>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-3-git-send-email-zuban32s@gmail.com>
	<e64320d2-6fa3-03cb-a96e-7c5ce508afdb@redhat.com>
	<CAKSfGUCo9bqxwtMgmW1PO4h-ratpLodJwJa3twL8OKkbuNJs=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKSfGUCo9bqxwtMgmW1PO4h-ratpLodJwJa3twL8OKkbuNJs=w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/5] hw/pci: introduce pcie-pci-bridge
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, Kevin OConnor <kevin@koconnor.net>, lersek@redhat.com, seabios@seabios.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On Mon, Jul 31, 2017 at 09:40:41PM +0300, Alexander Bezzubikov wrote:
> >> +typedef struct PCIEPCIBridge {
> >> +    /*< private >*/
> >> +    PCIBridge parent_obj;
> >> +
> >> +    bool msi_enable;
> >
> >
> > Please rename the msi_enable property to "msi" in order
> > to be aligned with the existent PCIBridgeDev and
> > consider making it OnOffAuto for the same reason.
> > (I am not sure about the last part though, we have
> >  no meaning for "auto" here)
> >
> 
> Agreed about "msi", but OnOffAuto looks weird to me
> as we always want MSI to be enabled.

Why even have a property then? Can't you enable it unconditionally?

-- 
MST
