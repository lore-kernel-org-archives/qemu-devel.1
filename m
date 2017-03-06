Received: from eggs.gnu.org ([2001:4830:134:3::10]:54261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1cksZk-0002K7-RZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1cksZf-0005yG-UT
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:21:20 -0500
Received: from mail.genode-labs.com ([88.198.56.169]:35747)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexander.boettcher@genode-labs.com>)
	id 1cksZf-0005y3-Md
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:21:15 -0500
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87k282im0q.fsf@linaro.org>
From: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Message-ID: <6515bcf7-e3cd-21b4-746b-c386b1296d88@genode-labs.com>
Date: Mon, 6 Mar 2017 14:21:09 +0100
MIME-Version: 1.0
In-Reply-To: <87k282im0q.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu deadlocks in tb_lock when using SVM+SoftMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, fred.konrad@greensocs.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com

Hi,

On 06.03.2017 14:15, Alex Benn=C3=A9e wrote:
> I found the virtualbox.iso on your branch but I can't trigger the
> assert. Running:
>=20
> #!/bin/sh
>=20
> QEMU=3D"$@"
>=20
> ${QEMU} -s -no-kvm -display sdl -m 512 -cpu phenom -nographic -cdrom vi=
rtualbox.iso
>=20
> I get:
>=20
> NOVA Microhypervisor v7-2436fe2 (x86_32): Feb 25 2017 17:58:48 [gcc 4.9=
.2]
> [init -> log_terminal]
> [init -> log_terminal] [ 0] CORE:0:0:0 10:2:3:0 [0] AMD Phenom(tm) 9550=
 Quad-Core Processor
> qemu: fatal: invalid tss type


> Which is a guest error?

It's a race which happens in Qemu (not on hardware), so I still
investigating it within Qemu. Because of that on [0] the commit before
the virtualbox.iso is one commit to avoid this for the moment in order
to continue.

>> [0] https://github.com/alex-ab/qemu/commits/genode_svm_issue

Alex.

--=20
Alexander Boettcher
Genode Labs

http://www.genode-labs.com - http://www.genode.org

Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
