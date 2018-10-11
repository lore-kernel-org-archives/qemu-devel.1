Received: from eggs.gnu.org ([2001:4830:134:3::10]:38680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gAZso-0000Ac-EA
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gAZsj-0005U2-8G
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gAZsi-0005OH-4v
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:15:57 -0400
Message-ID: <ae0853d9e209e830fccb188bb3d6b396b3144d63.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 11 Oct 2018 14:15:48 +0200
In-Reply-To: <20181011114522.GB8125@redhat.com>
References: <cover.1538683492.git.alistair.francis@wdc.com>
	<5dd21056229d12a1af8d65e9208f4de43ba4a2ae.camel@redhat.com>
	<892d54c5-2851-74ec-bdf2-286c1665c44f@gmail.com>
	<7d54ec114745b00b82601875416ccfe6a5f9fe6f.camel@redhat.com>
	<20181011080114.GS27120@redhat.com> <20181011114522.GB8125@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/5] Connect a PCIe host and graphics
 support to RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Alistair <alistair23@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mjc@sifive.com" <mjc@sifive.com>, "palmer@sifive.com" <palmer@sifive.com>, "stephen@eideticom.com" <stephen@eideticom.com>

On Thu, 2018-10-11 at 12:45 +0100, Richard W.M. Jones wrote:
> On Thu, Oct 11, 2018 at 09:01:14AM +0100, Richard W.M. Jones wrote:
> > Here are the settings we currently do NOT have in my RV kernel:
> > 
> > CONFIG_HOTPLUG_PCI_PCIE=y
> > CONFIG_HOTPLUG_PCI=y
> > CONFIG_MEDIA_PCI_SUPPORT=y
> > CONFIG_PCI_ATS=y
> > CONFIG_PCI_DEBUG=y
> > CONFIG_PCIEAER=y
> > CONFIG_PCIEASPM_DEFAULT=y
> > CONFIG_PCIEASPM=y
> > CONFIG_PCI_ECAM=y
> > CONFIG_PCIE_MICROSEMI=y
> > CONFIG_PCI_ENDPOINT=y
> > CONFIG_PCIEPORTBUS=y
> > CONFIG_PCI_HOST_COMMON=y
> > CONFIG_PCI_HOST_GENERIC=y
> > CONFIG_PCI_IOV=y
> > CONFIG_PCI_PASID=y
> > CONFIG_PCI_PRI=y
> > CONFIG_PCI_SW_SWITCHTEC=y
> > CONFIG_USB_BDC_PCI=y
> > 
> > If you're happy with it, I can add all of those.  If there are any
> > which shouldn't be added let me know.
> 
> I didn't see an answer but in any case I have tried to enable all of
> these.  The only settings which could not be enabled were:
> 
> CONFIG_MEDIA_PCI_SUPPORT=y
> CONFIG_PCI_ECAM=y
> CONFIG_PCI_HOST_COMMON=y
> CONFIG_PCI_HOST_GENERIC=y

I believe these last two are the ones we really miss. I could be
wrong though - as you know, I've made a few guesses that didn't
quite pan out already :)

> CONFIG_USB_BDC_PCI=y
> 
> Probably missing deps or missing arch support.  I didn't track them
> down yet, but note I'm still using kernel 4.15.
> 
>   https://github.com/rwmjones/fedora-riscv-kernel/commits/master

We talked about this on IRC a while ago: assuming my guess above
is correct, you would need to backport

  https://github.com/torvalds/linux/commit/51bc085d6454214b02dba7a259ee1fdfe3ee8d9f

because that's the one that makes PCI_HOST_GENERIC available to
non-ARM architectures.

> In any case a new kernel/bbl has been built, available in the usual
> place:
> 
>   https://fedorapeople.org/groups/risc-v/disk-images/

I gave it a spin: it doesn't work :(

-- 
Andrea Bolognani / Red Hat / Virtualization
