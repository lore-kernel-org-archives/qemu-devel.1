Received: from eggs.gnu.org ([2001:4830:134:3::10]:54653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVyPD-0001pQ-8e
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVyPB-0008Sc-BF
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:32:51 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:35076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cVyPB-0008S8-6H
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 05:32:49 -0500
Received: by mail-yw0-x242.google.com with SMTP id l16so68898ywb.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 02:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20170124043941.GA12671@tungsten.ozlabs.ibm.com>
In-Reply-To: <20170124043941.GA12671@tungsten.ozlabs.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 24 Jan 2017 10:32:36 +0000
Message-ID: <CAJ+F1C+fnnFtmjhf6eSS3aO+_fQmi-yETj0V7DmLb2Gb9Mi_WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] update-linux-headers.sh fails on clean kernel dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-devel@nongnu.org

Hi

On Tue, Jan 24, 2017 at 8:41 AM Sam Bobroff <sam.bobroff@au1.ibm.com> wrote=
:

> Hi QEMU developers,
>
> If I run scripts/update-linux-headers.sh from a clean checkout of QEMU
> and point it at a clean checkout of a recent linux kernel (4.10-rc1 or
> later), it fails:
>
> $ scripts/update-linux-headers.sh ~/tmp/linux/
>
> ...
>
> scripts/Makefile.headersinst:62: *** Missing generated UAPI file
> ./arch/arm/include/generated/uapi/asm/unistd-common.h.  Stop.
>
> This seems to be because the script passes the arch to the kernel
> makefile using "SRCARCH" rather than "ARCH".
>
> (SRCARCH seems to be intended as an internal value, and setting it does
> not propagate the setting to ARCH. Because ARCH is left empty, the
> prerequisites that should generate unistd-common.h fail. If ARCH is set,
> SRCARCH is set automatically and everything works.)
>
> Changing the script to use "ARCH" seems to fixe the problem.
>

That's also what Documentation/kbuild/headers_install.txt documents.


> (Note: when testing this be careful: unistd-common.h is not removed by
> "make clean" in the kernel directory.)
>
> Does this seem correct?
>
> Should I send a patch even though it's a very small change?
>
>
I think so, thanks

> Cheers,
> Sam.
>
>
> --
Marc-Andr=C3=A9 Lureau
