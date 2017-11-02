Received: from eggs.gnu.org ([2001:4830:134:3::10]:35600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eA4xn-0004IO-1l
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 22:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eA4xi-0002uT-1h
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 22:10:35 -0400
Received: from smtp8.web4u.cz ([81.91.87.88]:59873 helo=mx-8.mail.web4u.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pisa@cmp.felk.cvut.cz>)
	id 1eA4xh-0002tf-R0
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 22:10:29 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Thu, 2 Nov 2017 03:10:27 +0100
References: <cover.1509583771.git.pisa@cmp.felk.cvut.cz>
	<844921c2-2855-207a-2f9f-7c2ad28187e6@amsat.org>
In-Reply-To: <844921c2-2855-207a-2f9f-7c2ad28187e6@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201711020310.27240.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH 0/5 v2] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hello Philippe,

On Thursday 02 of November 2017 02:27:18 Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/01/2017 10:00 PM, pisa@cmp.felk.cvut.cz wrote:
> > Some page about the project
> >
> >   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/wikis/home
> >
> > FEE CTU GitLab repository with can-pci branch for 2.3, 2.4, 2.7, 2.8 and
> > 2.10 version if QEMU is available there
> >
> >   https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci
>
> This GitLab seems to be restricted to your university :(

Thanks fort the report, I have moved work from GitHub to local GitLab
for future continuous integration support.

Repository has been public from beginning, but I forgot
to make wiki public. It should be OK now.

Unfortunately, my attempt to follow suggestion to ensure
that even conditionalized debug code is build always
leads to patchew.org problem report because now exposed
static function is not used in non Linux builds

/tmp/qemu-test/src/hw/can/can_core.c:153:13: error: 'can_display_msg' defin=
ed but not used [-Werror=3Dunused-function]
 static void can_display_msg(struct qemu_can_frame *msg)
             ^~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


It is used for connection to the host CAN bus interface
and that is implemented only for SocketCAN on Linux.

So patches v3 series is necessary anyway.

I would be happy if I receive some review remarks
for this reorganized series to lower iteration count.

Thanks in advance,

Pavel
