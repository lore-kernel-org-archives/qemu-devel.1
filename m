Received: from eggs.gnu.org ([2001:4830:134:3::10]:47328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdKe4-0004he-CQ
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdKe1-0005HV-3Q
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:19:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fdKe0-0005HL-Tx
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 15:19:21 -0400
Date: Wed, 11 Jul 2018 16:19:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180711191916.GZ7451@localhost.localdomain>
References: <1531236069-7500-1-git-send-email-viktor.prutyanov@virtuozzo.com>
	<20180711160025.GU7451@localhost.localdomain>
	<5e03b9eb-22ce-69bf-ca04-a17201834dfb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e03b9eb-22ce-69bf-ca04-a17201834dfb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] dump: add kernel_gs_base to QEMU CPU state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>, qemu-devel@nongnu.org, rth@twiddle.net, rkagan@virtuozzo.com

On Wed, Jul 11, 2018 at 06:19:33PM +0200, Paolo Bonzini wrote:
> On 11/07/2018 18:00, Eduardo Habkost wrote:
> >> @@ -237,7 +237,7 @@ int x86_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> >>   * please count up QEMUCPUSTATE_VERSION if you have changed definition of
> >>   * QEMUCPUState, and modify the tools using this information accordingly.
> > Where are the tools using this information, that need to be
> > updated?  Won't this break existing versions of those tools?
> 
> I think it's okay to _not_ change the version, since the format is
> backwards-compatible.  Each QEMUCPUState struct is in a separate ELF
> note, and the presence of the new field is visible in both 1) the size
> of the note 2) the size field of the struct.

If we do it, can we please make the documentation (or at least
code comments, as documentation doesn't seem to exist) clearly
state that the new field is optional in version 1?

-- 
Eduardo
