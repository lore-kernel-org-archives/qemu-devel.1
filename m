Received: from eggs.gnu.org ([2001:4830:134:3::10]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etucX-0004j6-Ii
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etucT-0000dp-JJ
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:26:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etucT-0000dR-EE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:26:01 -0500
Date: Thu, 8 Mar 2018 12:25:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308122549.GO4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1520365586-30384-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1520365586-30384-1-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PULL] RISC-V QEMU Port Submission v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On Wed, Mar 07, 2018 at 08:46:26AM +1300, Michael Clark wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:
> 
>   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)
> 
> are available in the git repository at:
> 
>   https://github.com/riscv/riscv-qemu.git tags/riscv-qemu-upstream-v8.2
> 
> for you to fetch changes up to 7051b081bf6796e5e84406f6223a7c4900bf7298:
> 
>   RISC-V - Remove support for adhoc non-standard X_COP local-interrupt (2018-03-07 08:36:03 +1300)

So to move this forward in a productive way....

IIUC, the 'qemu-upstream-v8.2' branch has the correct set of 23
patches, but the 'riscv-qemu-upstream-v8.2' tag has mistakenly
gained a bunch of extra patches that were not intended for
submission yet.

So I think you likely just need to create a v8.3 branch and
tag with the correct set of 23 commits. Though, do note Paolo's
comment about logic looking wrong in one of the patches. I'm
not sure if that's something we can live with now, and fix
up in followup patches before release or not, vs should be
fixed right away.

The 'soft freeze' on next Tuesday only applies to feature
patches. So assuming we can get this initial series mergable,
you will still have time to send more pull requests with bug
fixes before release.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
