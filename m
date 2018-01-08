Received: from eggs.gnu.org ([2001:4830:134:3::10]:35531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYMH0-00036F-AC
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 20:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eYMGv-0003zI-Ie
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 20:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:40792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eYMGv-0003yy-CN
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 20:30:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eYMGu-0003GG-9K
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 01:30:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 454DA2E80C3
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 01:30:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jan 2018 01:23:38 -0000
From: oscarbg <rtfss1@gmail.com>
Reply-To: Bug 1717708 <1717708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
	<151121950412.2413.13382031046765109618.malone@chaenomeles.canonical.com>
Message-Id: <CAM26bSUTe9a9KgLgt+y=zBz3SBaPQuyOhq5aq_9AvaZYJ3oVzg@mail.gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1717708] Re: QEMU aarch64 can't run Windows
 ARM64 iso's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

@Andrew can you upload these three drivers somewhere for the lazy people?
thanks..

2017-11-21 0:11 GMT+01:00 Andrew Baumann <launchpad.net@ab.id.au>:

> @Laszlo, I got the binaries from someone else, but they from a parallel
> build system... nothing particularly special: some preprocessor rules to
> build against the newer WDK, and also it was just those three drivers
> (netkvm, vioinput, viostor). I imagine you can get the same result by
> tweaking the VS-based build (sln/vcxproj files), but haven't tried.
> Sorry that's not terribly helpful.
>
> --
> You received this bug notification because you are subscribed to the bug
> report.
> https://bugs.launchpad.net/bugs/1717708
>
> Title:
>   QEMU aarch64 can't run Windows ARM64 iso's
>
> Status in QEMU:
>   New
>
> Bug description:
>   Hi,
>   recently Windows ARM64 ISOs have been posted on the internet..
>   just checked with latest QEMU 2.10 release from
>   https://qemu.weilnetz.de/w64/qemu-w64-setup-20170830.exe
>   "h:\qemu\qemu-system-aarch64.exe" -boot d -cdrom
> h:\iso\16353.1000.170825-1423.RS_PRERELEASE_CLIENTPRO_OEMRET_ARM64FRE_ES-=
ES.ISO
> -m 2048 -cpu cortex-a57 -smp 1 -machine virt
>   seems no video output..
>   checked various machine options for example versatilepb (says guest has
> not initialized the guest)..
>
>   so don't know if it's a QEMU bug or lacking feature but can support
>   running Windows ARM64 builds (would be nice if you can add a
>   Snapdragon835 machine type which is which first machines will be
>   running..)
>
>
>   note running a Windows x64 ISO with similar parameters works (removing
> -cpu and -machine as not needed)
>
>   thanks..
>
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1717708/+subscriptions
>

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717708

Title:
  QEMU aarch64 can't run Windows ARM64 iso's

Status in QEMU:
  New

Bug description:
  Hi,
  recently Windows ARM64 ISOs have been posted on the internet..
  just checked with latest QEMU 2.10 release from =

  https://qemu.weilnetz.de/w64/qemu-w64-setup-20170830.exe =

  "h:\qemu\qemu-system-aarch64.exe" -boot d -cdrom h:\iso\16353.1000.170825=
-1423.RS_PRERELEASE_CLIENTPRO_OEMRET_ARM64FRE_ES-ES.ISO -m 2048 -cpu cortex=
-a57 -smp 1 -machine virt
  seems no video output..
  checked various machine options for example versatilepb (says guest has n=
ot initialized the guest)..

  so don't know if it's a QEMU bug or lacking feature but can support
  running Windows ARM64 builds (would be nice if you can add a
  Snapdragon835 machine type which is which first machines will be
  running..)

  =

  note running a Windows x64 ISO with similar parameters works (removing -c=
pu and -machine as not needed)

  thanks..

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1717708/+subscriptions
