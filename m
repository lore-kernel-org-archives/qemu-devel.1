Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fV2Zc-0002Mh-DK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fV2ZZ-000285-9E
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:24:32 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:34858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fV2ZZ-00027i-49
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 18:24:29 -0400
Received: by mail-io0-x241.google.com with SMTP id u4-v6so18317603iof.2
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 15:24:28 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA9F1sTX_9b5PJL61K5eRsP9XoY3KKje_4CNh71JKiw39w@mail.gmail.com>
Date: Mon, 18 Jun 2018 18:24:25 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BE60DE6-10C2-4B62-B34D-50F6C014EE7A@gmail.com>
References: <20180608200150.7032-1-programmingkidx@gmail.com>
	<CAFEAcA9F1sTX_9b5PJL61K5eRsP9XoY3KKje_4CNh71JKiw39w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] ui/cocoa.m: fix absolute mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


On Jun 18, 2018, at 7:18 AM, Peter Maydell wrote:

> On 8 June 2018 at 21:01, John Arbuckle <programmingkidx@gmail.com> =
wrote:
>> Fix the cocoa front-end to correctly be able to use absolute mode.
>>=20
>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>=20
> This commit message is insufficiently detailed, which makes
> it hard to review the patch. When you send patches, please
> can you provide commit messages which describe what the
> problem is, where the current code gets things wrong and
> why the changes fix the issue? It is painful to have to
> reverse-engineer your design from your code changes.

Sorry I will correct this problem now.

This should have been the commit message:

When using an usb-tablet device in QEMU, the Cocoa UI uses absolute mode =
code to handle mouse events. The absolute mode code does not correctly =
determine where QEMU's window is located. Tests indicate the current =
code thinks the window is located in the bottom left of the screen. This =
makes grabbing and ungrabbing happen at the wrong place. This patch =
fixes this problem by making mouse grabs happen only in the window and =
mouse ungrabs happen only when the mouse is moved outside the window.=
