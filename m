Received: from eggs.gnu.org ([2001:4830:134:3::10]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDXcw-0007kU-U7
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDXYO-0004D5-DQ
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:55:38 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58869)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fDXYN-0004C4-Tu
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:50:56 -0400
References: <20180411192347.30228-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a29b198d-b9dc-34da-2f1c-a0cf3003a368@vivier.eu>
Date: Tue, 1 May 2018 17:50:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180411192347.30228-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.13] linux-user: introduce
 target_sigsp() and target_save_altstack()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 11/04/2018 à 21:23, Laurent Vivier a écrit :
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> Based-on: <20180411185651.21351-1-laurent@vivier.eu>
> "[PATCH for 2.13 v2 00/19] linux-user: move arch specific parts from main.c to arch directories"

This patch can be applied now on top of master.

> 
>  linux-user/aarch64/signal.c    | 13 ++-----------
>  linux-user/alpha/signal.c      | 17 ++++++-----------
>  linux-user/arm/signal.c        | 17 ++++-------------
>  linux-user/hppa/signal.c       | 14 ++++----------
>  linux-user/i386/signal.c       | 12 +++---------
>  linux-user/m68k/signal.c       | 15 +++------------
>  linux-user/microblaze/signal.c |  4 +---
>  linux-user/mips/signal.c       | 15 ++-------------
>  linux-user/nios2/signal.c      | 21 ++-------------------
>  linux-user/openrisc/signal.c   | 14 +++-----------
>  linux-user/ppc/signal.c        | 15 ++-------------
>  linux-user/riscv/signal.c      | 28 +++++++++-------------------
>  linux-user/s390x/signal.c      | 12 +++---------
>  linux-user/sh4/signal.c        | 11 ++---------
>  linux-user/signal-common.h     | 15 ++++-----------
>  linux-user/signal.c            | 32 ++++++++++++++++++++++++++++++++
>  linux-user/sparc/signal.c      | 28 +++++++++++++++++++---------
>  linux-user/tilegx/signal.c     | 13 +++----------
>  linux-user/xtensa/signal.c     | 15 ++++-----------
>  19 files changed, 108 insertions(+), 203 deletions(-)
>

Changes are trivial. Any reviewers?

Thanks,
Laurent
