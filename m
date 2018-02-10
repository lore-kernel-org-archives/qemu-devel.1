Received: from eggs.gnu.org ([2001:4830:134:3::10]:44162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1ekIjl-0004Og-II
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ciro.santilli@gmail.com>) id 1ekIjk-0007AL-NA
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:09:49 -0500
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:33671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ciro.santilli@gmail.com>)
	id 1ekIjk-00079r-Hv
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 19:09:48 -0500
Received: by mail-io0-x234.google.com with SMTP id n7so11547874iob.0
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 16:09:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
References: <20180207120353.5389.54531.stgit@pasha-VirtualBox>
	<CAFXrp_fenK2mzLSOUUcWLTR1r4_jUEN07QDqfkRDpTFEo4oHpQ@mail.gmail.com>
	<002401d3a010$8d551280$a7ff3780$@ru>
	<CAFXrp_c09S6e9EnT7LOYox2YMiOXN_suFo30wfqcmzwRB8zx2A@mail.gmail.com>
From: Ciro Santilli <ciro.santilli@gmail.com>
Date: Sat, 10 Feb 2018 00:09:26 +0000
Message-ID: <CAFXrp_dUAZDYLUTqY0nxbGg7w4TEqD2+rNRPT+47a0B8N1Y6Aw@mail.gmail.com>
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

Also, what command do you use to test on ARM? I'm a bit stuck to get the
drive part right, e.g.:

-drive
file=./buildroot/output.arm~/images/rootfs.ext2,if=scsi,id=img-direct,format=raw
\
-drive driver=blkreplay,if=none,image=img-direct,id=img-blkreplay \
-device scsi-hd,drive=img-blkreplay \

fails with: qemu-system-arm: -device scsi-hd,drive=img-blkreplay: Conflicts
with use by img-direct as 'root', which does not allow 'write' on #block968
