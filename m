Received: from eggs.gnu.org ([2001:4830:134:3::10]:34866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZHCh-0003ry-2n
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gZH7w-0000hS-I1
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:17:50 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gZH7w-0000h6-7o
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 10:17:44 -0500
Received: by mail-pf1-x441.google.com with SMTP id b85so8285903pfc.3
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 07:17:44 -0800 (PST)
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<2175cdb6-bc52-5c0a-f767-23a08ae4384f@ilande.co.uk>
	<5139703f-0573-7498-b3a5-3d09661618ff@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0fc04d3-967d-f4c0-defe-63f1fbcd3893@linaro.org>
Date: Tue, 18 Dec 2018 07:17:40 -0800
MIME-Version: 1.0
In-Reply-To: <5139703f-0573-7498-b3a5-3d09661618ff@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/18/18 7:05 AM, Mark Cave-Ayland wrote:
> On 18/12/2018 09:49, Mark Cave-Ayland wrote:
> 
>> Following on from this, the next patch "target/ppc: convert vsplt[bhw] to use vector
>> operations" causes corruption of the OS X splash screen
>> (https://www.ilande.co.uk/tmp/qemu/badapple2.png) in a way that suggests there may be
>> an endian issue.
> 
> Changing "#ifndef HOST_WORDS_BIGENDIAN" to "#ifdef HOST_WORDS_BIGENDIAN" in this
> patch helps a lot, but something still isn't quite right:
> https://www.ilande.co.uk/tmp/qemu/badapple3.png.

I can't figure out what the host+guest endian rules for ppc_avr_t are at all.

Certainly there appear to be bugs wrt vscr and which end of the register we
pull the value.  On the tcg side we take host endianness into account, and on
the gdb side we always use u32[3].


r~
