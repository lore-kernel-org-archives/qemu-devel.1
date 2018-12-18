Received: from eggs.gnu.org ([2001:4830:134:3::10]:37624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZHGr-0008Eu-H9
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:27:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gZHGq-0005So-Kv
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:26:57 -0500
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
	<5139703f-0573-7498-b3a5-3d09661618ff@ilande.co.uk>
	<b0fc04d3-967d-f4c0-defe-63f1fbcd3893@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b63dda3a-7532-1685-d6fa-65180715a596@ilande.co.uk>
Date: Tue, 18 Dec 2018 15:26:42 +0000
MIME-Version: 1.0
In-Reply-To: <b0fc04d3-967d-f4c0-defe-63f1fbcd3893@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 18/12/2018 15:17, Richard Henderson wrote:

> On 12/18/18 7:05 AM, Mark Cave-Ayland wrote:
>> On 18/12/2018 09:49, Mark Cave-Ayland wrote:
>>
>>> Following on from this, the next patch "target/ppc: convert vsplt[bhw] to use vector
>>> operations" causes corruption of the OS X splash screen
>>> (https://www.ilande.co.uk/tmp/qemu/badapple2.png) in a way that suggests there may be
>>> an endian issue.
>>
>> Changing "#ifndef HOST_WORDS_BIGENDIAN" to "#ifdef HOST_WORDS_BIGENDIAN" in this
>> patch helps a lot, but something still isn't quite right:
>> https://www.ilande.co.uk/tmp/qemu/badapple3.png.
> 
> I can't figure out what the host+guest endian rules for ppc_avr_t are at all.
> 
> Certainly there appear to be bugs wrt vscr and which end of the register we
> pull the value.  On the tcg side we take host endianness into account, and on
> the gdb side we always use u32[3].

That seems wrong to me. Given that the ppc_avr_t is a union then I'd expect it to be
in host order? Certainly in the VMX helper macros I've looked at, the members are set
directly with no byte swapping.


ATB,

Mark.
