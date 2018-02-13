Received: from eggs.gnu.org ([2001:4830:134:3::10]:39842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elYCF-0000PK-4Y
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:52:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elYCA-0007rR-6R
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:52:23 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60454)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1elYC9-0007r8-Uw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:52:18 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
	<CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
	<001b01d3a3c5$032e09f0$098a1dd0$@ru>
	<CAFXrp_dNj+BSYo+0rpv5d4PxdjJ1RL_cROaDWRvjQTLziFtO_Q@mail.gmail.com>
	<000c01d3a496$fd2bc470$f7834d50$@ru>
	<CAFXrp_cEsHH_6VQevxsrj8GTchraGKEJ_t0xhSbfajcBu-mmzg@mail.gmail.com>
	<001a01d3a4b1$273f1a90$75bd4fb0$@ru>
	<002201d3a4b5$2a642b80$7f2c8280$@ru>
	<CAFEAcA9yO_4FX0J6hsdAmV7TwZd5kp9J-B2EPwm_KZxDO25bGQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9yO_4FX0J6hsdAmV7TwZd5kp9J-B2EPwm_KZxDO25bGQ@mail.gmail.com>
Date: Tue, 13 Feb 2018 13:52:17 +0300
Message-ID: <002d01d3a4b8$b73a37e0$25aea7a0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Ciro Santilli' <ciro.santilli@gmail.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'QEMU Developers' <qemu-devel@nongnu.org>, 'Kevin Wolf' <kwolf@redhat.com>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, 'Juan Quintela' <quintela@redhat.com>, 'Jason Wang' <jasowang@redhat.com>, "'Michael S. Tsirkin'" <mst@redhat.com>, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, 'Gerd Hoffmann' <kraxel@redhat.com>, 'Thomas Dullien' <thomas.dullien@googlemail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>, =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> On 13 February 2018 at 10:26, Pavel Dovgalyuk <dovgaluk@ispras.ru> =
wrote:
> > Then I added SCSI adapter with the option =E2=80=93device =
lsi,id=3Dscsi0 and QEMU
> > failed with the following error:
> >
> > qemu: fatal: IO on conditional branch instruction
>=20
> > Seems, that your kernel is incomatible with QEMU, which ARM =
emulation is not
> > good enough.
>=20
> It seems fairly unlikely to me that the Linux driver for this
> SCSI adaptor is using weirdo self-modifying code of the kind
> that would trip up that cpu_abort(). I would suggest a bit
> more investigation into what's actually happening...

It happens for any SCSI adapter (i.e., for every system able to run).
And the log is not very big. Therefore the problem is in early boot =
code.

Pavel Dovgalyuk
