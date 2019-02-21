Received: from eggs.gnu.org ([209.51.188.92]:54641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwrdC-0003pv-8O
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwrdA-0004Ni-QG
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwrd8-0004Lb-LX
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so32324202qtz.0
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 08:55:24 -0800 (PST)
Date: Thu, 21 Feb 2019 11:55:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190221115446-mutt-send-email-mst@kernel.org>
References: <1550592459-7286-1-git-send-email-thuth@redhat.com>
	<20190219151825-mutt-send-email-mst@kernel.org>
	<bfdc4037-4017-a501-4e1f-e8da8949e672@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfdc4037-4017-a501-4e1f-e8da8949e672@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pci/pci-stub: Add msi_enabled() and
 msi_notify() to the pci stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, yang.zhong@intel.com, pbonzini@redhat.com

On Wed, Feb 20, 2019 at 07:24:00AM +0100, Thomas Huth wrote:
> On 19/02/2019 21.19, Michael S. Tsirkin wrote:
> > On Tue, Feb 19, 2019 at 05:07:39PM +0100, Thomas Huth wrote:
> >> Some machines have an AHCI adapter, but no PCI. To be able to
> >> compile hw/ide/ahci.c without CONFIG_PCI, we still need the two
> >> functions msi_enabled() and msi_notify() for linking.
> >> This is required for the upcoming Kconfig-like build system, if
> >> a user wants to compile a QEMU binary with just one machine that
> >> has AHCI, but no PCI, like the ARM "cubieboard" for example.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks!
> 
> > Do you want me to merge this or do you prefer to
> > merge it with kconfig patches?
> 
> If you plan a pci pull request soon, feel free to take it. Otherwise, I
> can also add it to my Kconfig-for-arm patch series where I need it.
> 
>  Thomas

Feel free to include but please talk to Paolo about his
ideas for abstracting it out.

Thanks!

-- 
MST
