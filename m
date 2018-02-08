Received: from eggs.gnu.org ([2001:4830:134:3::10]:36883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1ejgjw-0001VP-HW
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1ejgju-0002l0-W9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:35:28 -0500
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:45501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1ejgju-0002km-Op
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 02:35:26 -0500
Received: by mail-io0-x234.google.com with SMTP id p188so4818389ioe.12
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 23:35:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002401d3a010$8d551280$a7ff3780$@ru>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Thu, 8 Feb 2018 07:35:05 +0000
Message-ID: <CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v6 00/20] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>, war2jordan@live.com, Igor R <boost.lists@gmail.com>, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, Aleksandr Bezzubikov <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, kraxel@redhat.com, Thomas Dullien <thomas.dullien@googlemail.com>, pbonzini@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Wed, Feb 7, 2018 at 12:38 PM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:

> > From: Ciro Santilli [mailto:ciro.santilli@gmail.com]
> > Can you provide a test branch somewhere so I can easily test it out?
>
> Here it is: https://github.com/ispras/qemu/tree/rr-180207
>
> Pavel Dovgalyuk
>
> Awesome! This worked with my test procedure described at:
https://stackoverflow.com/questions/46970215/how-to-use-qemus-deterministic-record-and-replay-feature-for-a-linux-kernel-boo

While we are a it, can we clarify the following points the docs?

1) Usage of the record/replay: mentions that `-net none` is required,
unless a network patch is applied.

But the network section that follows explains how to record network
requests, and I've tested it, so I think the `-net none` / patch
requirement is just outdated and should be removed.

2) There are mentions of "reverse execution" and "reverse debugging" on the
"Record/replay" section.

Are those supported? If yes, explain there how to use them. Otherwise,
remove the mentions.

I would love to see that feature!

3) Is the snapshot feature mentioned in the "Snapshotting" section
something specific to record and replay?

If yes, can we detail further how to use it besides passing
`rrsnapshot=snapshot_name`? How to create and restore the snapshots?

If not, why does the `rrsnapshot=snapshot_name` option exist?

4) Maybe give the required disk and network commands under "Usage of the
record/replay:"

 -drive file=disk.qcow,if=none,id=img-direct
 -drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay
 -device ide-hd,drive=img-blkreplay

 -netdev user,id=net1 -device rtl8139,netdev=net1
 -object filter-replay,id=replay,netdev=net1

People likely always want those, but it currently requires reading through
the whole doc file to put everything together.
