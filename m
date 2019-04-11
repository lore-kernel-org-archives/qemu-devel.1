Received: from eggs.gnu.org ([209.51.188.92]:42992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hEUMb-0001ec-Es
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hEUMY-0001s9-OE
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:43:11 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:35750
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1hEUMX-0001pz-6z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:43:09 -0400
References: <20190410194838.10123-1-sw@weilnetz.de>
	<46e4ee2d-f991-1910-db15-0ec216ab9cab@twiddle.net>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <f7f4f96e-7900-45e8-10ef-65f7870b3c3e@weilnetz.de>
Date: Thu, 11 Apr 2019 09:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <46e4ee2d-f991-1910-db15-0ec216ab9cab@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tci: Add implementation for
 INDEX_op_ld16u_i64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

On 11.04.19 08:46, Richard Henderson wrote:
> Looks ok, I guess, although the introduction of tci_write_reg16 seems r=
edundant
> with the uint16_t value that is loaded.

It could directly call tci_write_reg, but the new code is similar to the
existing code which also uses the same kind of indirection.

The resulting binary code should be the same, as all those small
functions can be inlined by an optimizing compiler.

> Why not use tci_write_reg64, since that is the size of the register you=
're
> modifying?  Let the zero-extension explicit in the name of the opcode t=
o be
> reflected in the zero-extension implied by the passing of a uint16_t va=
lue to a
> uint64_t argument.

I think that using tci_write_reg64 would be wrong on 32 bit hosts.

Regards
Stefan
