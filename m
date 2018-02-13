Received: from eggs.gnu.org ([2001:4830:134:3::10]:39374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elY9f-0006z4-2W
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elY9e-00070p-Av
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:49:43 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elY9e-00070Z-6Z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 05:49:42 -0500
Received: by mail-oi0-x22d.google.com with SMTP id 24so13564690oij.3
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 02:49:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <002201d3a4b5$2a642b80$7f2c8280$@ru>
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
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 10:49:21 +0000
Message-ID: <CAFEAcA9yO_4FX0J6hsdAmV7TwZd5kp9J-B2EPwm_KZxDO25bGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Ciro Santilli <ciro.santilli@gmail.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, war2jordan@live.com, Igor R <boost.lists@gmail.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, maria.klimushenkova@ispras.ru, Gerd Hoffmann <kraxel@redhat.com>, Thomas Dullien <thomas.dullien@googlemail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 13 February 2018 at 10:26, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> Then I added SCSI adapter with the option =E2=80=93device lsi,id=3Dscsi0 =
and QEMU
> failed with the following error:
>
> qemu: fatal: IO on conditional branch instruction

> Seems, that your kernel is incomatible with QEMU, which ARM emulation is =
not
> good enough.

It seems fairly unlikely to me that the Linux driver for this
SCSI adaptor is using weirdo self-modifying code of the kind
that would trip up that cpu_abort(). I would suggest a bit
more investigation into what's actually happening...

thanks
-- PMM
