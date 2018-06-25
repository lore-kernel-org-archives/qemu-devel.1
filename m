Received: from eggs.gnu.org ([2001:4830:134:3::10]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXOK1-0005wV-5q
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXOK0-0005qH-Co
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:02:09 -0400
Received: from mail-ot0-x231.google.com ([2607:f8b0:4003:c0f::231]:38677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXOK0-0005pd-6O
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:02:08 -0400
Received: by mail-ot0-x231.google.com with SMTP id w16-v6so5741794otk.5
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 03:02:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180622154042.GS23296@redhat.com>
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622154042.GS23296@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 11:01:46 +0100
Message-ID: <CAFEAcA9ksxY+CkGFhD=cGK=zoAvtGAdd_hG1L91js_SKK0RCxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 25/26] block: Remove deprecated -drive
 option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>, Qemu-block <qemu-block@nongnu.org>, Libvirt <libvir-list@redhat.com>, Jeff Cody <jcody@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Peter Krempa <pkrempa@redhat.com>

On 22 June 2018 at 16:40, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
>  - SD card - requires -drive with if=3Dsd, no -device support AFAICT

Hmm? You can use -device if you want:
  -drive if=3Dnone,id=3Dmydrive,... -device sd-card,...,drive=3Dmydrive
(the sd-card device then plugs into the sd controller device
via the sd-bus bus).

Most command lines floating around on the web use if=3Dsd, though
(which doesn't require explicit creation of the sd-card device.)

I think one or two controllers might not yet have been converted
to use sd-bus.

thanks
-- PMM
