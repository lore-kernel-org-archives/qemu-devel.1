Received: from eggs.gnu.org ([2001:4830:134:3::10]:56589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM82v-0001VS-LO
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM82s-0001za-Fe
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:58:13 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM82r-0001yK-R4
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:58:10 -0500
Received: by mail-wm1-x342.google.com with SMTP id f10-v6so7594015wme.3
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:58:09 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-9-f4bug@amsat.org>
	<BN6PR2201MB1251ADAEA3C596FD3F1AB3E6C6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ad3bd757-861d-2086-94e5-64779cd0affb@linaro.org>
Date: Mon, 12 Nov 2018 09:58:05 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251ADAEA3C596FD3F1AB3E6C6C10@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 08/11] target/mips: Add a decodetree
 stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 11/12/18 6:37 AM, Aleksandar Markovic wrote:
>> Subject: [RFC PATCH 08/11] target/mips: Add a decodetree stub
> 
> There is no plan to use decodetree for MIPS target. MIPS decoding engine is
> mostly stable mature code that was well tested over many years, and there is no
> point in introducing such drastic change to the code that works.

This attitude is unnecessarily obstructionist.

The reorganization of the instruction implementation that is implied by a
transition to decodetree is exactly what you and I talked about some months ago.

The ability to use multiple decodetree parsers to vector directly to the
instruction implementations would help unify code across multiple encoding
schemes.  (There 4 now: mips, mips16, micromips, nanomips; and mipsr6 is
different enough that it could be considered a 5th encoding.)

In a sample transition of 10 insns that Phillipe sent me via private email this
weekend, I noticed an existing bug in MULT{,U} that fails to enforce rd == 0 on
cpus that have only one accumulator -- any bets there are no more to be found?
 You have just this year added yet another encoding scheme for nanomips.  Your
statement "well tested over many years" is a bit of a stretch.

If you do not wish to work on this, that's your prerogative.  But I don't think
you should be arbitrarily shutting down experimentation on this line before it
has a chance to show results.


r~
