Received: from eggs.gnu.org ([209.51.188.92]:39558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gwuYv-0002Ov-S2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gwuTs-0002vn-H1
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:58:07 -0500
Received: from mail-it1-x12b.google.com ([2607:f8b0:4864:20::12b]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gwuTr-0002iq-Q7
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 14:58:04 -0500
Received: by mail-it1-x12b.google.com with SMTP id z124so23825474itc.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 11:57:42 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <fdec6838-6051-427d-6192-f68a76171915@redhat.com>
Date: Thu, 21 Feb 2019 14:57:38 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
	<87imxfssq1.fsf@dusky.pond.sub.org>
	<E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu>
	<87y36boe78.fsf@dusky.pond.sub.org>
	<fdec6838-6051-427d-6192-f68a76171915@redhat.com>
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org



> On Feb 20, 2019, at 03:55, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> I would strongly prefer if the guest-side view wouldn't change at all.

It sounds like sector protection isn't something you want and it's not =
something I currently need so unless that changes, I probably won't do =
anything with it.

My goal is merely to implement some missing flash functionality that I =
need to emulate some hardware that I have. My plan for doing this is to =
not change any defaults (except for a few bug fixes) while doing so. I'm =
happy for the qemu community to take as much or as little as it finds =
useful.

I'll send a patch series for review in the normal fashion, but if anyone =
wants to see my in-progress work, including tests, the diff is available =
here =
<https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02>.

For my own edification, I'm curious how you're currently dealing with =
some regions of flash that are protected. I believe Markus mentioned =
using multiple flash devices. Are you overlapping the address ranges?

The current pflash_cfi02.c code assumes, but doesn't check that both the =
total size of the chip as well as the size of each sector is a power of =
two. If you wanted say 7 MB of read/write flash and 1 MB of read-only =
flash, qemu might be willing to create a device with say 7 MB of =
storage, but it will definitely misbehave. (I added a check for that =
here =
<https://github.com/qemu/qemu/compare/master...stevecheckoway:pflash02#dif=
f-d33881bd0ef099e2f46ebd4797c653bcR738>.)

Cheers,

Steve

--=20
Stephen Checkoway
