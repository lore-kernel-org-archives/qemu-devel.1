Received: from eggs.gnu.org ([2001:4830:134:3::10]:49860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZDpI-0007iY-9u
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:41:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZDpH-0005NV-5x
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:41:44 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:36462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZDpH-0005Kq-1U
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:41:43 -0500
Received: by mail-ot0-x232.google.com with SMTP id w4so13885011otg.3
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 02:41:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AM5P194MB0132AB1A7F3CE7E09346CDC4C8110@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<AM5P194MB0132AB1A7F3CE7E09346CDC4C8110@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2018 10:41:21 +0000
Message-ID: <CAFEAcA8u0b_+W7GBwy6knV3_zvZLc00fbbSjDT42CkS83Gb29w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>, "surajjs@au1.ibm.com" <surajjs@au1.ibm.com>

On 10 January 2018 at 10:37, luigi burdo <intermediadc@hotmail.com> wrote:
> Hi devs sorry if i enter in the discussion about.
>
> gcc gave errors in building this queue.
>
> here i paste my build log.
>
> https://pastebin.com/fXw2Whrq

Thanks. This is the relevant bit of the log:

/home/amigaone/src/new/tags/ppc-for-2.12-20180108/target/s390x/mem_helper.c:2567:1:
internal compiler error: Segmentation fault
 }
 ^
Please submit a full bug report,
with preprocessed source if appropriate.
See <file:///usr/share/doc/gcc-7/README.Bugs> for instructions.

This means that gcc crashed. This is either:
 (a) a hardware problem with your machine (eg bad memory)
or
 (b) a bug in gcc (which you can report to the gcc team
as they suggest in the error message)

You should check whether gcc reliably crashes in the
same way every time you try to build that source file.
If it does, that suggests a gcc bug is more likely. If
it sometimes works and sometimes doesn't, I would suspect
hardware problems.

thanks
-- PMM
