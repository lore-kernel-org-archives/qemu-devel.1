Received: from eggs.gnu.org ([2001:4830:134:3::10]:51955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffgoQ-00030g-PL
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ffgoM-00009e-Pv
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:23:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60362 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ffgoM-00007x-Fv
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 03:23:46 -0400
References: <cover.1531859179.git.alistair.francis@wdc.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <773d9510-a651-a32a-e7b1-4de8fae1de21@redhat.com>
Date: Wed, 18 Jul 2018 09:23:44 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1531859179.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5] riscv: Fix introspection problems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Cc: mjc@sifive.com

On 17.07.2018 22:27, Alistair Francis wrote:
> This is based on Thomas's work fixing introspection problems [1] and
> applied to the RISC-V port.
> 
> 1: https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03261.html
> 
> Alistair Francis (5):
>   sifive_e: Fix crash when introspecting the device
>   sifive_u: Fix crash when introspecting the device
>   virt: Fix crash when introspecting the device
>   riscv_hart: Fix crash when introspecting the device
>   spike: Fix crash when introspecting the device
> 
>  hw/riscv/riscv_hart.c |  7 +++----
>  hw/riscv/sifive_e.c   | 12 ++++++------
>  hw/riscv/sifive_u.c   | 15 +++++++--------
>  hw/riscv/spike.c      | 10 ++++------
>  hw/riscv/virt.c       |  5 ++---
>  5 files changed, 22 insertions(+), 27 deletions(-)

For the whole patch series:

Reviewed-by: Thomas Huth <thuth@redhat.com>
