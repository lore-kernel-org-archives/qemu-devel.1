Received: from eggs.gnu.org ([209.51.188.92]:53509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gxBA0-0005qL-UL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gxAz2-0008I6-14
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:35:20 -0500
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f]:40984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gxAz1-0008G2-Eb
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:35:19 -0500
Received: by mail-io1-xd2f.google.com with SMTP id i5so1713299ioq.8
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 05:35:19 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <55f4fb09-6751-01f0-5946-f2297dc24b24@redhat.com>
Date: Fri, 22 Feb 2019 08:35:16 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <BA80C412-62C1-4969-ACF9-F2E2ABCC56D9@oberlin.edu>
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
	<FBD3F2EA-638A-4B52-826B-7307B1D821C9@oberlin.edu>
	<55f4fb09-6751-01f0-5946-f2297dc24b24@redhat.com>
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



> On Feb 22, 2019, at 02:55, Laszlo Ersek <lersek@redhat.com> wrote:
>=20
> OVMF and the q35/i440fx boards use cfi01. The 4KB sector size is =
assumed
> by both QEMU board code and OVMF. The 4KB sector size is not assumed =
(to
> my knowledge) by cfi01.pflash device model code.
>=20
> Regarding the full size of each cfi01.pflash chip, i440fx/q35 board =
code
> determines that dynamically from the file size (the only requirement =
is
> that the size be a multiple of the sector size). There is no =
assumption
> in the device model. In OVMF, the assumed/expected full size is
> hard-coded (build-time constant).

Gotcha, thanks for the info. It sounds like the code for the Intel =
command set chips (cfi01) and the AMD command set chips (cfi02) have =
different requirements for their use.

Regards,

Steve

--=20
Stephen Checkoway
