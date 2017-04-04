Received: from eggs.gnu.org ([2001:4830:134:3::10]:49345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leon@kernel.org>) id 1cvSKx-0004bT-KZ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leon@kernel.org>) id 1cvSKu-0003oe-Gs
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:33:47 -0400
Received: from mail.kernel.org ([198.145.29.136]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <leon@kernel.org>) id 1cvSKu-0003oU-6x
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 13:33:44 -0400
Date: Tue, 4 Apr 2017 20:33:49 +0300
From: Leon Romanovsky <leon@kernel.org>
Message-ID: <20170404173349.GY20443@mtr-leonro.local>
References: <1490872341-9959-1-git-send-email-marcel@redhat.com>
	<20170330141314.GM20443@mtr-leonro.local>
	<5e952524-7c2d-b4da-4bd7-6437830a40d8@redhat.com>
	<f7f3fc0e-0a75-2fdc-b3c2-6c3d34ff2978@redhat.com>
	<20170403062314.GO20443@mtr-leonro.local>
	<aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ca23f2aBZR6YDKM9"
Content-Disposition: inline
In-Reply-To: <aa400244-426a-ea62-0ccf-ac5adb76fdd1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pvrdma: Proposal of a new pvrdma
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Doug Ledford <dledford@redhat.com>, qemu-devel@nongnu.org, linux-rdma@vger.kernel.org, yuval.shaia@oracle.com


--Ca23f2aBZR6YDKM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 04, 2017 at 04:38:40PM +0300, Marcel Apfelbaum wrote:
> On 04/03/2017 09:23 AM, Leon Romanovsky wrote:
> > On Fri, Mar 31, 2017 at 06:45:43PM +0300, Marcel Apfelbaum wrote:
> > > On 03/30/2017 11:28 PM, Doug Ledford wrote:
> > > > On 3/30/17 9:13 AM, Leon Romanovsky wrote:
> > > > > On Thu, Mar 30, 2017 at 02:12:21PM +0300, Marcel Apfelbaum wrote:
> > > > > > From: Yuval Shaia <yuval.shaia@oracle.com>
> > > > > >
> > > > > >  Hi,
> > > > > >
> > > > > >  General description
> > > > > >  ===================
> > > > > >  This is a very early RFC of a new RoCE emulated device
> > > > > >  that enables guests to use the RDMA stack without having
> > > > > >  a real hardware in the host.
> > > > > >
> > > > > >  The current implementation supports only VM to VM communication
> > > > > >  on the same host.
> > > > > >  Down the road we plan to make possible to be able to support
> > > > > >  inter-machine communication by utilizing physical RoCE devices
> > > > > >  or Soft RoCE.
> > > > > >
> > > > > >  The goals are:
> > > > > >  - Reach fast and secure loos-less Inter-VM data exchange.
> > > > > >  - Support remote VMs or bare metal machines.
> > > > > >  - Allow VMs migration.
> > > > > >  - Do not require to pin all VM memory.
> > > > > >
> > > > > >
> > > > > >  Objective
> > > > > >  =========
> > > > > >  Have a QEMU implementation of the PVRDMA device. We aim to do so without
> > > > > >  any change in the PVRDMA guest driver which is already merged into the
> > > > > >  upstream kernel.
> > > > > >
> > > > > >
> > > > > >  RFC status
> > > > > >  ===========
> > > > > >  The project is in early development stages and supports
> > > > > >  only basic send/receive operations.
> > > > > >
> > > > > >  We present it so we can get feedbacks on design,
> > > > > >  feature demands and to receive comments from the
> > > > > >  community pointing us to the "right" direction.
> > > > >
> > > > > If to judge by the feedback which you got from RDMA community
> > > > > for kernel proposal [1], this community failed to understand:
> > > > > 1. Why do you need new module?
> > > >
> > > > In this case, this is a qemu module to allow qemu to provide a virt rdma device to guests that is compatible with the device provided by VMWare's ESX product.  Right now, the vmware_pvrdma driver
> > > > works only when the guest is running on a VMWare ESX server product, this would change that.  Marcel mentioned that they are currently making it compatible because that's the easiest/quickest thing to
> > > > do, but in the future they might extend beyond what VMWare's virt rdma driver provides/uses and might then need to either modify it to work with their extensions or fork and create their own virt
> > > > client driver.
> > > >
> > > > > 2. Why existing solutions are not enough and can't be extended?
> > > >
> > > > This patch is against the qemu source code, not the kernel.  There is no other solution in the qemu source code, so there is no existing solution to extend.
> > > >
> > > > > 3. Why RXE (SoftRoCE) can't be extended to perform this inter-VM
> > > > >    communication via virtual NIC?
> > > >
> > > > Eventually they want this to work on real hardware, and to be more or less transparent to the guest.  They will need to make it independent of the kernel hardware/driver in use.  That means their own
> > > > virt driver, then the virt driver will eventually hook into whatever hardware is present on the system, or failing that, fall back to soft RoCE or soft iWARP if that ever makes it in the kernel.
> > > >
> > > >
> > >
> > > Hi Leon and Doug,
> > > Your feedback is much appreciated!
> > >
> > > As Doug mentioned, the RFC is a QEMU implementation of a pvrdma device,
> > > so SoftRoCE can't help here (we are emulating a PCI device).
> >
> > I just responded to the latest email, but as you understood from my question,
> > it was related to your KDBR module.
> >
> > >
> > > Regarding the new KDBR module (Kernel Data Bridge), as the name suggests is
> > > a bridge between different VMs or between a VM and a hardware/software device
> > > and does not replace it.
> > >
> > > Leon, utilizing the Soft RoCE is definitely part of our roadmap from the start,
> > > we find the project a must since most of our systems don't even have real
> > > RDMA hardware, and the question is how do best integrate with it.
> >
> > This is exactly the question, you chose as an implementation path to do
> > it with new module over char device. I'm not against your approach,
> > but would like to see the list with pros and cons for over possible
> > solutions if any. Does it make sense to do special ULP to share the data
> > between different drivers over shared memory?
>
> Hi Leon,
>
> Here are some thoughts regarding the Soft RoCE usage in our project.
> We thought about using it as backend for QEMU pvrdma device
> we didn't how it will support our requirements.
>
> 1. Does Soft RoCE support inter process (VM) fast path ? The KDBR
>    removes the need for hw resources, emulated or not, concentrating
>    on one copy from a VM to another.
>
> 2. We needed to support migration, meaning the PVRDMA device must preserve
>    the RDMA resources between different hosts. Our solution includes a clear
>    separation between the guest resources namespace and the actual hw/sw device.
>    This is why the KDBR is intended to run outside the scope of the SoftRoCE
>    so it can open/close hw connections independent from the VM.
>
> 3. Our intention is for KDBR to be used in other contexts as well when we need
>    inter VM data exchange, e.g. backend for virtio devices. We didn't see how this
>    kind of requirement can be implemented inside SoftRoce as we don't see any
>    connection between them.
>
> 4. We don't want all the VM memory to be pinned since it disable memory-over-commit
>    which in turn will make the pvrdma device useless.
>    We weren't sure how nice would play Soft RoCE with memory pinning and we wanted
>    more control on memory management. It may be a solvable issue, but combined
>    with the others lead us to our decision to come up with our kernel bridge (char
>    device or not, we went for it since it was the easiest to implement for a POC)

I'm not going to repeat Jason's answer, I'm completely agree with him.

Just add my 2 cents. You didn't answer on my question about other possible
implementations. It can be SoftRoCE loopback optimizations, special ULP,
RDMA transport, virtual driver with multiple VFs and single PF.

>
>
> Thanks,
> Marcel & Yuval
>
> >
> > Thanks
> >
> > >
> > > Thanks,
> > > Marcel & Yuval
> > >
> > >
> > > > >
> > > > > Can you please help us to fill this knowledge gap?
> > > > >
> > > > > [1] http://marc.info/?l=linux-rdma&m=149063626907175&w=2
> > > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Ca23f2aBZR6YDKM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAljj2P0ACgkQ5GN7iDZy
WKfEzhAAw+f15YDwGVK4HjkeMMqGyacQ5rUZUMWFGZaYGMC0NTjoqI+TCBYaxTNM
CICp/ah39YirCielhZSFCiYxWfb4n272vJN8fHoLjRjkJp8jnBN8+E2OVCD2Tmz3
JH9ATzf2lwYgEAq2pe43kjTYj3cbmwn+DCHuofMfm29E1DaF6FOYy50YtfO+nrwB
0ElNyeQHr6CjnddI7brxF/1a6jmHNp1lNiOK9KUMeuWn/zI2Jy39sF/LNGPY2i9b
ItzssNhyKnr0k++ZowpzxniZf2NvlrszNVSQbkQjMh5RFjlp4ep4yNG/VLoSSBqI
4N3ov8RqJOnzpX/hHI8Y3bj9CenbS3LlDX5/srANoeV3HGejv86IDqEnqujEvSBx
MDHHy1FLacXkG4E3Oa017hldghLMh0JyAtmQ8/7ojXBq5hF0b/3qcXIFtd7DUNd7
WlU29FbiAsKXJH+G/d9S8rVuwXvcpGo8OwdQCof2lTTh2hCac9MtMQr1nGNyQ0jv
UsWXad30QnLTQPA21i9UwbwB/fn2q/BLJpP2+tl0e/ga9yBEVLWOJ/IBHjoWa610
V7WrRCzb3LIcRSzb18sA0MZWiwlGKRAYBzoXswwlvtQFIWdJUbGEBom5idMYd0JL
6qALcyKO28QBJGDQVXtd/DonOPKQLs6X9zMa6jtIl2G46rD406c=
=2X4n
-----END PGP SIGNATURE-----

--Ca23f2aBZR6YDKM9--
