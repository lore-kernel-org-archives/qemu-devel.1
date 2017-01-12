Received: from eggs.gnu.org ([2001:4830:134:3::10]:35105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRn26-0007Ij-OR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cRn22-00005H-Qd
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:35:42 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60299)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cRn22-000057-Fd
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:35:38 -0500
References: <1484252284-29291-1-git-send-email-laurent@vivier.eu>
	<1484252284-29291-6-git-send-email-laurent@vivier.eu>
	<624520be-c04b-7a89-1c00-101912752b02@tuxfamily.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f3857694-9dd9-2d5d-fe1f-dcf828e75cfd@vivier.eu>
Date: Thu, 12 Jan 2017 22:35:30 +0100
MIME-Version: 1.0
In-Reply-To: <624520be-c04b-7a89-1c00-101912752b02@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] target-m68k: increment/decrement with
 SP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: rth@twiddle.net

Le 12/01/2017 à 22:14, Thomas Huth a écrit :
> On 12.01.2017 21:18, Laurent Vivier wrote:
>> Address Register indirect With postincrement:
>>
>> When using the stack pointer (A7) with byte size data, the register
>> is incremented by two.
>>
>> Address Register indirect With predecrement:
>>
>> When using the stack pointer (A7) with byte size data, the register
>> is decremented by two.
> 
> I think this is only valid for the full 680x0 CPUs. According to
> http://www.nxp.com/assets/documents/data/en/reference-manuals/CFPRM.pdf
> the stack pointer behaves differently on ColdFire:
> 
> "2.2.5 Address Register Indirect with Predecrement Mode [...]
> Note that the stack pointer (A7) is treated just like the other address
> registers."

Yes, you're right. This is true only for 680x0:

"MOTOROLA M68000 FAMILY Programmer’s Reference Manual"

"2.2.5 Address Register Indirect with Predecrement Mode
...
If the address register is thestack pointer and the operand size is
byte, the address is decremented by two to keep the stack pointer
aligned to a word boundary."

Thank you, I will update this patch accordingly.

Laurent
