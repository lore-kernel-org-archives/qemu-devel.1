Received: from eggs.gnu.org ([2001:4830:134:3::10]:49847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dIMkI-0006XJ-Vm
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 18:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dIMkI-0004p4-6G
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 18:14:38 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
	<20170606025135.2685-2-david@gibson.dropbear.id.au>
	<CAFEAcA9arhJuzCs=ec4dW+_cgSodi0NWTnBB+-4mwAjSGMaLDA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d53d5c1f-cc28-fdd4-c383-8693c0aa2c12@redhat.com>
Date: Wed, 7 Jun 2017 00:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9arhJuzCs=ec4dW+_cgSodi0NWTnBB+-4mwAjSGMaLDA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 01/17] migration: remove register_savevm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 06/06/2017 19:49, Peter Maydell wrote:
> Things that would be interesting to explain/document:
>  * what is special about vmxnet3 that makes it the only pci device
>    that needs to use this rather than having a vmstate struct?

Nothing, it should be replaced by VMSTATE_MSIX (at the cost of breaking
migration from and to older QEMU versions).

Paolo
