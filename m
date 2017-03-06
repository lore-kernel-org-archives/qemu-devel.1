Received: from eggs.gnu.org ([2001:4830:134:3::10]:57507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cknVX-0007oK-DZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cknVW-0003Fp-7H
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:56:39 -0500
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:33944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cknVV-0003FO-Vy
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 02:56:38 -0500
Received: by mail-it0-x235.google.com with SMTP id m27so4457645iti.1
	for <qemu-devel@nongnu.org>; Sun, 05 Mar 2017 23:56:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170305181803.7371.53021.malonedeb@chaenomeles.canonical.com>
References: <20170305181803.7371.53021.malonedeb@chaenomeles.canonical.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 6 Mar 2017 08:56:15 +0100
Message-ID: <CACXAS8B_H0PoVKPYq5oeQKiF1MEzJWe-MiGzqxcnHWRk6onehg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1670170] [NEW] `qemu-system-sparc64 -M
 Niagara` Aborted (core dumped)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1670170 <1670170@bugs.launchpad.net>
Cc: qemu-devel <qemu-devel@nongnu.org>

There was a major rework of the Niagara platform in the upcoming 2.9 release.
Please use the new version.

On Sun, Mar 5, 2017 at 7:18 PM, Michal Nowak <michal.nowak@resist.ca> wrote:
> Public bug reported:
>
>> qemu-system-sparc64 -M Niagara
> qemu: fatal: Trap 0x0064 while trap level (6) >= MAXTL (6), Error state
> pc: 0000000000004c80  npc: 0000000000004c84
> %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %o0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %o4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 0000000000000000
> %l4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %i0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %i4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> pstate: 00000414 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0
> cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
> fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000
>
> Aborted (core dumped)
>
>> qemu-system-sparc64 -M help
> Supported machines are:
> Niagara              Sun4v platform, Niagara
> none                 empty machine
> sun4u                Sun4u platform (default)
> sun4v                Sun4v platform
>
>> qemu-system-sparc64 -version
> QEMU emulator version 2.8.0(Virtualization:Staging / SLE_12_SP2)
>
> from https://build.opensuse.org/package/show/Virtualization:Staging/qemu
> on openSUSE Leap 42.2.
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
>
>
> ** Tags: sparc
>
> ** Attachment added: "coredumpctl core dump"
>    https://bugs.launchpad.net/bugs/1670170/+attachment/4831907/+files/core.qemu-system-spa.1000.79fef1d6233b4b989c19ea5c5c809627.451.1488737426000000.xz
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1670170
>
> Title:
>   `qemu-system-sparc64 -M Niagara` Aborted (core dumped)
>
> Status in QEMU:
>   New
>
> Bug description:
>   > qemu-system-sparc64 -M Niagara
>   qemu: fatal: Trap 0x0064 while trap level (6) >= MAXTL (6), Error state
>   pc: 0000000000004c80  npc: 0000000000004c84
>   %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %o0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %o4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 0000000000000000
>   %l4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %i0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %i4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   pstate: 00000414 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0
>   cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
>   fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000
>
>   Aborted (core dumped)
>
>   > qemu-system-sparc64 -M help
>   Supported machines are:
>   Niagara              Sun4v platform, Niagara
>   none                 empty machine
>   sun4u                Sun4u platform (default)
>   sun4v                Sun4v platform
>
>   > qemu-system-sparc64 -version
>   QEMU emulator version 2.8.0(Virtualization:Staging / SLE_12_SP2)
>
>   from
>   https://build.opensuse.org/package/show/Virtualization:Staging/qemu on
>   openSUSE Leap 42.2.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1670170/+subscriptions
>



-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu
