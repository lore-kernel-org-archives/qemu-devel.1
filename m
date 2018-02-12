Received: from eggs.gnu.org ([2001:4830:134:3::10]:47190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1el7zk-0005sZ-Vn
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 01:53:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1el7zg-00014s-Un
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 01:53:45 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50752)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1el7zg-00012u-Lv
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 01:53:40 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
In-Reply-To: <CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
Date: Mon, 12 Feb 2018 09:53:37 +0300
Message-ID: <002601d3a3ce$35aee080$a10ca180$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
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
To: 'Ciro Santilli' <ciro.santilli@gmail.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, 'Peter Maydell' <peter.maydell@linaro.org>, war2jordan@live.com, 'Igor R' <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, kraxel@redhat.com, 'Thomas Dullien' <thomas.dullien@googlemail.com>, pbonzini@redhat.com, =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>

> From: Ciro Santilli [mailto:ciro.santilli@gmail.com]=20
> Awesome! This worked with my test procedure described at: =
https://stackoverflow.com/questions/46970215/how-to-use-qemus-determinist=
ic-record-and-replay-feature-for-a-linux-kernel-boo
> While we are a it, can we clarify the following points the docs?
> 1) Usage of the record/replay: mentions that `-net none` is required, =
unless a network patch is applied.
> But the network section that follows explains how to record network =
requests, and I've tested it, so I think the `-net none` / patch =
requirement is just outdated and should be removed.
> 2) There are mentions of "reverse execution" and "reverse debugging" =
on the "Record/replay" section.
> Are those supported? If yes, explain there how to use them. Otherwise, =
remove the mentions.
> I would love to see that feature!

Not yet, but they are the next to apply after this series.
I'll update the docs.

> 3) Is the snapshot feature mentioned in the "Snapshotting" section =
something specific to record and replay?
> If yes, can we detail further how to use it besides passing =
`rrsnapshot=3Dsnapshot_name`? How to create and restore the snapshots?
> If not, why does the `rrsnapshot=3Dsnapshot_name` option exist?
> 4) Maybe give the required disk and network commands under "Usage of =
the record/replay:"
> -drive file=3Ddisk.qcow,if=3Dnone,id=3Dimg-direct
> -drive =
driver=3Dblkreplay,if=3Dnone,image=3Dimg-direct,id=3Dimg-blkreplay
> -device ide-hd,drive=3Dimg-blkreplay
> -netdev user,id=3Dnet1 -device rtl8139,netdev=3Dnet1
> -object filter-replay,id=3Dreplay,netdev=3Dnet1
> People likely always want those, but it currently requires reading =
through the whole doc file to put everything together.

Thanks for reviewing, I'll add the documentation update to the series.


Pavel Dovgalyuk
