Received: from eggs.gnu.org ([2001:4830:134:3::10]:56717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gLqY0-000543-OM
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1gLqXv-0002t2-Da
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:17:08 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:34258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1gLqXv-0002sh-50
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 09:17:03 -0500
Received: by mail-it1-x144.google.com with SMTP id t189-v6so8520025itf.1
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 06:17:02 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.21071.1541921951.1283.qemu-devel@nongnu.org>
Date: Sun, 11 Nov 2018 09:16:59 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <F2462E98-6B72-4674-9A9A-6C04E6842F24@gmail.com>
References: <mailman.21071.1541921951.1283.qemu-devel@nongnu.org>
Subject: [Qemu-devel]  [Bug 1802684] Re: QEMU gui crashes on macOS 	Mojave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: 1802684@bugs.launchpad.net


> On Nov 11, 2018, at 2:39 AM, qemu-devel-request@nongnu.org wrote:
>=20
> Thanks for the bug report. It looks like Mojave is pickier about apps
> not calling various GUI update functions from the "wrong" thread. We
> probably need to figure out how to dispatch those to the main thread
> instead of whatever thread we were on. Unfortunately we don't really
> have anybody in QEMU upstream who knows much about OSX or its GUI, and =
I
> suspect we don't have anybody with Mojave (my system is still High
> Sierra and I don't plan to upgrade it for a while); help and patches
> appreciated from anybody who does...

>  	21  AppKit                              0x00007fff3c019ff8 =
-[NSWindow setFrame:display:animate:] + 567

I would use the [performSelectorOnMainThread: withObject: =
waitUntilDone:] method to fix this problem. It should go here in the =
call stack. I would make the patch myself but I don't know where this =
call takes place in qemu-system-aarch64.

>  	22  qemu-system-aarch64                 0x000000010b7b2abf =
qemu-system-aarch64 + 3668671
