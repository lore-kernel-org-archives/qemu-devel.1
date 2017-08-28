Received: from eggs.gnu.org ([2001:4830:134:3::10]:56057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dmHzB-0003TQ-65
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dmHz8-00060T-0L
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:13:41 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Mon, 28 Aug 2017 11:13:36 +0000
Message-ID: <AM5P194MB0132429A2A1999FEF3251524C89E0@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
	<AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
	<ffb13f14-0a72-f3cc-baa7-c17355d00730@redhat.com>
In-Reply-To: <ffb13f14-0a72-f3cc-baa7-c17355d00730@redhat.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] Qemu 2.10 rc4 build issue on BE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

Hi Thomas,

i will check again and report.

Luigi



In your log there is:


But if you have a look at the freshly unpacked sources, that line
clearly reads "goto out;" and not "gCto out;" ... so it looks like
something messed up your sources very badly.
Can you reproduce this problem when starting again from scratch?

 Thomas
