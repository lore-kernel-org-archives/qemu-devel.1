Received: from eggs.gnu.org ([2001:4830:134:3::10]:48630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fcece-0003es-JE
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 18:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fceca-0000JG-HY
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 18:27:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Jul 2018 00:26:52 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180709212319.GB22336@localhost.localdomain>
References: <20180705064348.3162-1-kraxel@redhat.com>
	<20180705064348.3162-3-kraxel@redhat.com>
	<20180705163501.GN7451@localhost.localdomain>
	<20180706065342.pggd2qgd4nyv35ys@sirius.home.kraxel.org>
	<20180709210833.GC7451@localhost.localdomain>
	<20180709212319.GB22336@localhost.localdomain>
Message-ID: <11c6f7d4364062c42df990364bf2c2de@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vga: don't pick cirrus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

Hi,

Am 2018-07-09 23:23, schrieb Eduardo Habkost:
> List of machines with default_display==NULL on those
> architectures:
> 
> alpha:
> none                 empty machine
> 
> mips:
> mipssim              MIPS MIPSsim platform
> none                 empty machine
> 
> ppc*:
> bamboo               bamboo
> mpc8544ds            mpc8544ds
> none                 empty machine
> powernv              IBM PowerNV (Non-Virtualized)
> ppce500              generic paravirt e500 platform
> ref405ep             ref405ep
> sam460ex             aCube Sam460ex
> taihu                taihu
> virtex-ml507         Xilinx Virtex ML507 reference design
> 
> x86_64:
> isapc                ISA-only PC
> none                 empty machine
> xenfv                Xen Fully-virtualized PC
> xenpv                Xen Para-virtualized PC

Which of these machines really require the Cirrus? The xen ones look 
like that they can deal with std. The isapc is should probably stay at 
the Cirrus.

Also the "none" seems to be a false-positive. I suppose they mean 
"empty", i.e., no graphics card at all?

And at least the ppc ones can be canceled out, they should work with 
std, the new default (expect the sam460ex which goes an own route for 
now).

What is the indented target release for the patch?

If the patch is applied to 3.1 then I think there is enough time to fix 
issues caused by the patch. Additionally, a warning could be put in the 
ChangeLog for 3.0 that in 3.1 that the default mode will be std unless 
machines define an own default. This is should be enough time for people 
to complain or to fix things.

If the patch is to be applied to 3.0 then all non-ppc ones need to be 
reconsidered.

The "important" ppc machines have been fixed already. I can do the 
remaining if this is wanted.

Bye
Sebastian
