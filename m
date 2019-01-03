Received: from eggs.gnu.org ([208.118.235.92]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wong.syrone@gmail.com>) id 1gesms-0005yc-MG
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wong.syrone@gmail.com>) id 1gesmr-0008KJ-Ug
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:31:10 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:35140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wong.syrone@gmail.com>)
	id 1gesmr-00086b-Ll
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:31:09 -0500
Received: by mail-wm1-x332.google.com with SMTP id t200so17149077wmt.0
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 18:31:00 -0800 (PST)
MIME-Version: 1.0
From: Syrone Wong <wong.syrone@gmail.com>
Date: Thu, 3 Jan 2019 10:31:41 +0800
Message-ID: <CAEaqfoZ=3yMiJZ1ZkqvDjwHvntizxD-V54c=3A5vY+7LdhNJqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Q: nested virtualization and VMX live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

Hi all,

The VMX live migration blocker is added via
https://github.com/qemu/qemu/commit/d98f26073bebddcd3da0ba1b86c3a34e840c0fb8,
it claims
"Nested VMX does not support live migration yet".

While a commit from Linux 4.20 states
> With live migration support and finally a good solution for exception event injection,
> nested VMX should be ready for having a stable userspace ABI.

and the nested virtualization is enabled by default. Should we remove
the blocker for Linux 4.20 and upper?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e58e5e59148916fa43444a406335a990783fb78

Best Regards,
Syrone Wong
