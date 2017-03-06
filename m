Received: from eggs.gnu.org ([2001:4830:134:3::10]:51929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckzgY-0000ff-Je
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:56:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ckzgU-0004cf-US
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:56:50 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:39686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ckzgU-0004aL-Ko
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 15:56:46 -0500
Date: Mon, 6 Mar 2017 15:56:35 -0500 (EST)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1394881299.29178732.1488833795531.JavaMail.zimbra@redhat.com>
In-Reply-To: <986fbee4-e620-802d-b985-f732768ad039@genode-labs.com>
References: <49fcb3c4-df9d-ec64-2927-71c02fc2524b@genode-labs.com>
	<87k282im0q.fsf@linaro.org>
	<6515bcf7-e3cd-21b4-746b-c386b1296d88@genode-labs.com>
	<87innmii02.fsf@linaro.org>
	<d208c3f0-2e57-0b54-f18f-b5e27d698e28@genode-labs.com>
	<87h936ida2.fsf@linaro.org>
	<986fbee4-e620-802d-b985-f732768ad039@genode-labs.com>
MIME-Version: 1.0
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
To: Alexander Boettcher <alexander.boettcher@genode-labs.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, rth@twiddle.net, fred konrad <fred.konrad@greensocs.com>, crosthwaite peter <crosthwaite.peter@gmail.com>



----- Original Message -----
> From: "Alexander Boettcher" <alexander.boettcher@genode-labs.com>
> To: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: qemu-devel@nongnu.org, rth@twiddle.net, "fred konrad" <fred.konrad@gr=
eensocs.com>, pbonzini@redhat.com,
> "crosthwaite peter" <crosthwaite.peter@gmail.com>
> Sent: Monday, March 6, 2017 9:11:04 PM
> Subject: Re: Qemu deadlocks in tb_lock when using SVM+SoftMMU
>=20
> Hello,
>=20
> thank you for your effort.
>=20
> With your patch I get now a 0x3f exception shown by the hypervisor,
> which I have never encountered so far before. The guest kernel seems not
> to start, at least no life sign is shown.
>=20
> For me the patch of Paolo Bonzini works reliable.

Let's use mine then. :)  I'll post it properly tomorrow.

Paolo

> How to proceed ?
>=20
> Thanks,
>=20
> Alex.
>=20
> On 06.03.2017 17:24, Alex Benn=C3=A9e wrote:
> >=20
> > Alexander Boettcher <alexander.boettcher@genode-labs.com> writes:
> >=20
> >> Hi,
> > <snip>
> >>
> >> Sometimes Qemu just succeeds if the timing is well, will see.
> >>
> >> But this is not the point of this issue atm.
> >=20
> > I've sent a patch that works as Richard suggested. However your test
> > image seems to run into other issues. I have tested it on my known good
> > x86 image and it works.
> >=20
> > However my knowledge of x86's interrupt architecture is fairly minimal
> > so I'm looking for testing/feedback on the patch.
> >=20
> >>
> >> Alex.
> >=20
> >=20
> > --
> > Alex Benn=C3=A9e
> >=20
>=20
> --
> Alexander Boettcher
> Genode Labs
>=20
> http://www.genode-labs.com - http://www.genode.org
>=20
> Genode Labs GmbH - Amtsgericht Dresden - HRB 28424 - Sitz Dresden
> Gesch=C3=A4ftsf=C3=BChrer: Dr.-Ing. Norman Feske, Christian Helmuth
>=20
