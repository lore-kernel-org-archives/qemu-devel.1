Received: from eggs.gnu.org ([2001:4830:134:3::10]:51160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS6W4-0007YX-5k
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cS6W0-0003hc-9D
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:23:56 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:53048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cS6Vz-0003gT-VC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:23:52 -0500
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-2-git-send-email-laurent@vivier.eu>
	<099ce4bd-8256-c797-16f8-74d3ee5833ff@twiddle.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <520a7576-eb74-0c5d-80bf-ba521dbab29e@vivier.eu>
Date: Fri, 13 Jan 2017 19:23:41 +0100
MIME-Version: 1.0
In-Reply-To: <099ce4bd-8256-c797-16f8-74d3ee5833ff@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target-m68k: fix bit operation with
 immediate value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 13/01/2017 à 18:55, Richard Henderson a écrit :
> On 01/13/2017 04:51 AM, Laurent Vivier wrote:
>> M680x0 bit operations with an immediate value use 9 bits of the 16bit
>> value, while coldfire ones use only 8 bits.
> 
> I don't see that in the reference manual.  Where do you get this from?

See "BSET Instruction Format:BIT NUMBER STATIC, SPECIFIED AS IMMEDIATE
DATA", p. 4.58 of "M68000 FAMILY PROGRAMMER’S REFERENCE MANUAL", "BIT
NUMBER" is bits 0 to 8 of extended word.

See "Test a Bit and Set", p. 4-22 of "ColdFire Family Programmer’s
Reference Manual, Rev. 3" (link given by Thomas), "Bit Number" is bits 0
to 7 of extended word.

I've found the problem with RISU.

Thanks,
Laurent
