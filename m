Received: from eggs.gnu.org ([2001:4830:134:3::10]:48153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cq6bh-0002uV-Kr
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cq6be-0003iO-EE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:20:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cq6be-0003g8-8S
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:20:54 -0400
Date: Mon, 20 Mar 2017 20:20:32 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20170320232032.GA28018@amt.cnet>
References: <cover.1352938305.git.mtosatti@redhat.com>
	<b0b873a07872f7ab7f66f259c73fb9dd42aa66a9.1352938305.git.mtosatti@redhat.com>
	<f8f0ebb7-0c79-8570-3210-dc45c3effda8@univention.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f0ebb7-0c79-8570-3210-dc45c3effda8@univention.de>
Subject: Re: [Qemu-devel] [PATCH 1/2] acpi_piix4: fix migration of gpe fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philipp Hahn <hahn@univention.de>
Cc: Anthony Liguori <aliguori@us.ibm.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, Mar 20, 2017 at 01:02:10PM +0100, Philipp Hahn wrote:
> Hello Marcelo, cc:qemu,
> 
> Sorry for re-using this old thread, but I have a problem loading some
> saved state from qemu-kvm-1.1.2, which fails for piix4_pm.
> 
> You following patch was committed as
> <http://git.qemu-project.org/?p=qemu.git;a=commitdiff;h=b0b873a07872f7ab7f66f259c73fb9dd42aa66a9>:
> 
> Am 15.11.2012 um 01:11 schrieb Marcelo Tosatti:
> > Migrate 16 bytes for en/sts fields (which is the correct size),
> > increase version to 3, and document how to support incoming
> > migration from qemu-kvm 1.2.
> 
> I my case qemu-kvm-1.1.2/hw/acpi_piix4.c:284
> | VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
> only saves 4 bytes, not 16 bytes.

Hi Philipp,

IIRC qemu-1.1.2 saved 16 bytes, which is the correct size, not 4 bytes.

So while merging from qemu-kvm -> qemu, it was decided to maintain
backwards compability with qemu, and not qemu-kvm.

Is there any way to differentiate between the two (qemu vs qemu-kvm, 
perhaps via some other field not in the VMState of ACPI PIIX4), so
your patch can be integrated upstream?
