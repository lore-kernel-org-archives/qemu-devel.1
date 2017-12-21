Received: from eggs.gnu.org ([2001:4830:134:3::10]:45336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eS1Gp-0001pi-Tq
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:52:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eS1Gm-0000iL-Jb
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:52:23 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:33542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eS1Gm-0000ga-8i
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:52:20 -0500
References: <20171220002941.14560-1-palmer@dabbelt.com>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <345662bb-caee-3d5f-3494-900d9becfbcc@mail.uni-paderborn.de>
Date: Thu, 21 Dec 2017 14:49:56 +0100
MIME-Version: 1.0
In-Reply-To: <20171220002941.14560-1-palmer@dabbelt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Implement renameat2 when
 defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@sifive.com>, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Riku Voipio <riku.voipio@iki.fi>

On 12/20/2017 01:29 AM, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
> 
> The RISC-V Linux port was recently accept upstream and will be released
> as part of 4.15.  While working on our glibc port I discovered that
> qemu's user-mode emulation doesn't support renameat2, which has replaced
> rename as part of the default system call list for new architectures.
> Since a bunch of commonly used functionality boils down to rename (and
> now renameat2), we ended up with many failures.
> 
> This patch adds support for renameat2.  As I'm not familiar with QEMU
> development, I haven't really testing anything more than a simple
> "./configure; make" on the upstream codebase, but I did test this
> against our (not yet upstream) QEMU port where it appears to work for
> me.  I've just cobbled it together by copying the existing renameat
> implementation, but as there appears to be no glibc wrapper for
> renameat2 on either of the systems I've tried this on I just emited the
> system call directly.
> 

CC'ed linux-user maintainer Riku Voipio.

Cheers,
Bastian
