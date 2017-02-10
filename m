Received: from eggs.gnu.org ([2001:4830:134:3::10]:37955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccF13-0003oO-JD
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccF0v-00010o-MY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:29:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ccF0v-00010d-F7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:29:41 -0500
References: <10f23e13-dfdc-bbb1-2b31-e698d722a984@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b4be5a0-7b07-dbc4-a899-f6b2192d5e5d@redhat.com>
Date: Fri, 10 Feb 2017 18:29:38 +0100
MIME-Version: 1.0
In-Reply-To: <10f23e13-dfdc-bbb1-2b31-e698d722a984@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Sparc sun4v machine currently broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 10.02.2017 14:49, Thomas Huth wrote:
>  Hi,
>=20
> is it just me, or could it be that the sun4v machine is currently broke=
n?
> I get the following error when I try to run QEMU with this machine:
>=20
> qemu-system-sparc64 -nographic -M sun4v
> qemu: fatal: Trap 0x0010 while trap level (6) >=3D MAXTL (6), Error sta=
te
> pc: 0000000000000200  npc: 0000000000000204
> %g0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %g4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %o0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> %o4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> %l0-3: 0000000007f00000 000001ff00000000 000001fff0080000 0000000000000=
000=20
> %l4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> %i0-3: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> %i4-7: 0000000000000000 0000000000000000 0000000000000000 0000000000000=
000=20
> %f00:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f08:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f16:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f24:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f32:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f40:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f48:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> %f56:  0000000000000000 0000000000000000 0000000000000000 0000000000000=
000
> pstate: 00000014 ccr: 44 (icc: -Z-- xcc: -Z--) asi: 00 tl: 6 pil: 0 gl:=
 8
> tbr: 0000000000000000 hpstate: 0000000000000004 htba: 0000000000000000
> cansave: 6 canrestore: 0 otherwin: 0 wstate: 0 cleanwin: 6 cwp: 7
> fsr: 0000000000000000 y: 0000000000000000 fprs: 0000000000000000
>=20
> Aborted (core dumped)
>=20
> It works for when I use an older version of QEMU (version 2.7)...

FWIW, it's also still working when I use QEMU 2.8, so this must be a
recent regression...

 Thomas
