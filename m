Received: from eggs.gnu.org ([2001:4830:134:3::10]:50908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQd7y-0004uC-Sp
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cQd7x-0007SU-Qb
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:48:58 -0500
Received: from mail-yw0-x234.google.com ([2607:f8b0:4002:c05::234]:34127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cQd7x-0007SJ-KI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:48:57 -0500
Received: by mail-yw0-x234.google.com with SMTP id w75so31949608ywg.1
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 08:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20170105043743.14700.719.malonedeb@wampee.canonical.com>
	<20170106133959.14243.54408.malone@soybean.canonical.com>
	<CAJ+F1CKPMn=P3HOroDnr50owUPBSSLqgGAfbi33RvjVHNL4cAw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKPMn=P3HOroDnr50owUPBSSLqgGAfbi33RvjVHNL4cAw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 09 Jan 2017 16:48:45 +0000
Message-ID: <CAJ+F1CL7__0K6q5J59RgV7DynDYWSRCp+wXqeVGBMLrSij50aA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1654137] Re: Ctrl-A b not working in 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1654137 <1654137@bugs.launchpad.net>, qemu-devel@nongnu.org

Hi

On Mon, Jan 9, 2017 at 4:39 PM Marc-Andr=C3=A9 Lureau <marcandre.lureau@gma=
il.com>
wrote:

> Hi
>
> On Fri, Jan 6, 2017 at 2:46 PM Andreas Gustafsson <gson@gson.org> wrote:
>
> I am also seeing this problem.  In case it was not clear from Paul's
> original report, it affects guests using a serial console.
>
> Also, it is not specific to NetBSD.  I can reproduce it using a Linux
> guest on a Linux host, by running the following on a Debian 8 system:
>
>   wget
> http://landley.net/aboriginal/downloads/old/binaries/1.4.5/system-image-i=
686.tar.gz
>   tar xfz system-image-i686.tar.gz
>   cd system-image-i686
>   sh run-emulator.sh
>
> and typing Control-A b m once the guest has started.
>
> Using qemu 2.1.2, this successfully causes the guest to print a memory
> usage summary.  Using current qemu sources from git
> (dbe2b65566e76d3c3a0c3358285c0336ac61e757), nothing happens.
>
> --
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1654137
>
> Title:
>   Ctrl-A b not working in 2.8.0
>
> Status in QEMU:
>   New
>
> Bug description:
>   With a recent update from 2.7.0 to 2.8.0 I have discovered that I can
>   no longer send a "break" to the VM.  Ctrl-A b is simply ignored.
>   Other Ctrl-A sequences seem to work correctly.
>
>
> It could be related to the chardev changes in 2.8, I am bisecting and
> looking at it.
>
>
it's a regression from commit a4afa548fc6dd9842ed866, I will send a fix
asap.


> thanks
>
>
>   This is on a NetBSD amd64 system, version 7.99.53, and qemu was
>   installed on this system from source.
>
>   Reverting to the previous install restores "break" capability.
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1654137/+subscriptions
>
> --
> Marc-Andr=C3=A9 Lureau
>
--=20
Marc-Andr=C3=A9 Lureau
