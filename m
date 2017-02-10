Received: from eggs.gnu.org ([2001:4830:134:3::10]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ccFEu-0007Sa-4j
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:44:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1ccFEs-0006VG-EX
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:44:08 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1ccFEs-0006Uo-9q
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:44:06 -0500
Received: by mail-it0-x243.google.com with SMTP id f200so5012852itf.3
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 09:44:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8b4be5a0-7b07-dbc4-a899-f6b2192d5e5d@redhat.com>
References: <10f23e13-dfdc-bbb1-2b31-e698d722a984@redhat.com>
	<8b4be5a0-7b07-dbc4-a899-f6b2192d5e5d@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Fri, 10 Feb 2017 18:43:43 +0100
Message-ID: <CACXAS8CYXY=QgDCt9EYXBKzsrLwWq3HxFmXd5yXZrALZrBJDgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Sparc sun4v machine currently broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On Fri, Feb 10, 2017 at 6:29 PM, Thomas Huth <thuth@redhat.com> wrote:
> On 10.02.2017 14:49, Thomas Huth wrote:
>>  Hi,
>>
>> is it just me, or could it be that the sun4v machine is currently broken?
>> I get the following error when I try to run QEMU with this machine:
>>
>> qemu-system-sparc64 -nographic -M sun4v
>> qemu: fatal: Trap 0x0010 while trap level (6) >= MAXTL (6), Error state
>> pc: 0000000000000200  npc: 0000000000000204
>> %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %o0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %o4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 0000000000000000
>> %l4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %i0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %i4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> pstate: 00000014 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0 gl: 8
>> tbr: 0000000000000000 hpstate: 0000000000000004 htba: 0000000000000000
>> cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
>> fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000
>>
>> Aborted (core dumped)
>>
>> It works for when I use an older version of QEMU (version 2.7)...
>
> FWIW, it's also still working when I use QEMU 2.8, so this must be a
> recent regression...

Oh. This is surprising. Sun4v practically wasn't implemented before my
niagara series.
So, OpenBIOS worked because -M sun4v was like -M sun4u with some sun4v
instructions.
Now sun4v is closer to a real sun4v - it has sun4v MMU, so OpenBIOS is
not compatible with it anymore.
The proper fix would be adding sun4v support to OpenBIOS, but it may
take some time.


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
