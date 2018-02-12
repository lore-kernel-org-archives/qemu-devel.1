Received: from eggs.gnu.org ([2001:4830:134:3::10]:55258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1el6y3-0004rx-SM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 00:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1el6xy-0003Qa-Va
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 00:47:55 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45698)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1el6xy-0003OU-Ix
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 00:47:50 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
	<CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
In-Reply-To: <CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
Date: Mon, 12 Feb 2018 08:47:46 +0300
Message-ID: <001b01d3a3c5$032e09f0$098a1dd0$@ru>
MIME-Version: 1.0
Content-Language: ru
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Ciro Santilli' <ciro.santilli@gmail.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, 'Peter Maydell' <peter.maydell@linaro.org>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, kraxel@redhat.com, 'Thomas Dullien' <thomas.dullien@googlemail.com>, pbonzini@redhat.com, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

I tested ARM only with =E2=80=93kernel and =E2=80=93initrd.

Can you provide the full command line and the disk image?

=20

Pavel Dovgalyuk

=20

From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
Sent: Saturday, February 10, 2018 3:09 AM
To: Pavel Dovgalyuk
Cc: Pavel Dovgalyuk; qemu-devel@nongnu.org; kwolf@redhat.com; Peter =
Maydell; war2jordan@live.com; Igor R; quintela@redhat.com; =
jasowang@redhat.com; mst@redhat.com; Aleksandr Bezzubikov; =
maria.klimushenkova@ispras.ru; kraxel@redhat.com; Thomas Dullien; =
pbonzini@redhat.com; Alex Benn=C3=A9e
Subject: Re: [RFC PATCH v6 00/20] replay additions

=20

Also, what command do you use to test on ARM? I'm a bit stuck to get the =
drive part right, e.g.:

=20

-drive =
file=3D./buildroot/output.arm~/images/rootfs.ext2,if=3Dscsi,id=3Dimg-dire=
ct,format=3Draw \

-drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay \

-device scsi-hd,drive=3Dimg-blkreplay \

=20

fails with: qemu-system-arm: -device scsi-hd,drive=3Dimg-blkreplay: =
Conflicts with use by img-direct as 'root', which does not allow 'write' =
on #block968

=20
