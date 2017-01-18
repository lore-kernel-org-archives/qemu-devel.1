Received: from eggs.gnu.org ([2001:4830:134:3::10]:53808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTtet-0002VG-RV
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTteq-0003WU-MD
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:04:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTteq-0003W9-Gs
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:04:24 -0500
Date: Wed, 18 Jan 2017 15:04:21 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170118170421.GC3491@thinpad.lan.raisama.net>
References: <1484743490-24721-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484743490-24721-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] hw/core/null-machine: Add the
 possibility to instantiate a CPU and RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Berrange <berrange@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jan 18, 2017 at 01:44:50PM +0100, Thomas Huth wrote:
> Sometimes it is useful to have just a machine with CPU and RAM, without
> any further hardware in it, e.g. if you just want to do some instruction
> debugging for TCG with a remote GDB attached to QEMU, or run some embedded
> code with the "-semihosting" QEMU parameter. qemu-system-m68k already
> features a "dummy" machine, and xtensa a "sim" machine for exactly this
> purpose.
> All target architectures have nowadays also a "none" machine, which would
> be a perfect match for this, too - but it currently does not allow to add
> CPU and RAM yet. Thus let's add these possibilities in a generic way to the
> "none" machine, too, so that we hopefully do not need additional "dummy"
> machines in the future anymore (and maybe can also get rid of the already
> existing "dummy"/"sim" machines one day).
> Note that the default behaviour of the "none" machine is not changed, i.e.
> no CPU and no RAM is instantiated by default. You have explicitely got to
> specify the CPU model with "-cpu" and the amount of RAM with "-m" to get
> these new features.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I will wait for the opinion of others before applying it, though.

-- 
Eduardo
