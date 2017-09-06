Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick@advancedtelematic.com>) id 1dpb31-0003UP-Cl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:11:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick@advancedtelematic.com>) id 1dpb2w-0005Lp-AU
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:11:19 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick@advancedtelematic.com>)
	id 1dpb2w-0005KW-39
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:11:14 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f199so9932109wme.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:11:12 -0700 (PDT)
Received: from [192.168.1.62] (p57bf9f95.dip0.t-ipconnect.de. [87.191.159.149])
	by smtp.gmail.com with ESMTPSA id 61sm3652824wre.44.2017.09.06.07.11.10
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 06 Sep 2017 07:11:10 -0700 (PDT)
From: Patrick Vacek <patrick@advancedtelematic.com>
Message-ID: <2385fc24-dbc3-ba7c-948f-b986edb27c7a@advancedtelematic.com>
Date: Wed, 6 Sep 2017 16:11:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: [Qemu-devel] Trying to use ccid-card-emulated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I'm trying to emulate a smartcard. I found section 4 of docs/ccid.txt,
which appears to do exactly what I'm interested in. However, that
document is a few years old and references CoolKey, which at this point
seems obsolete, with OpenSC being the preferred succcessor. I've
followed the rest of steps with success, and tried registering OpenSC
with NSS (i.e. modutil -dbdir /etc/pki/nssdb -add "CAC Module" -libfile
/usr/lib/opensc-pkcs11.so), but I'm still not seeing my three
certificates listed on the device as I'd expect.

I'm using QEMU emulator version 2.8.0(Debian 1:2.8+dfsg-3ubuntu2.3).
I've also tried using QEMU emulator version 2.10.0 (built from source),
but the interface has changed and the commands from the documentation
don't work anymore.

1. Am I correct to assume that OpenSC is the logical successor to
CoolKey, and should I expect a simple substitution such as that to work?
2. Are there other steps I might be overlooking with OpenSC or with
getting the certificates recognized on the device?
3. If, as I suspect, that document is no longer up to date, what do the
steps currently look like to get smartcard emulation working?

Thanks,
Patrick

--=20
Patrick Vacek
ATS Advanced Telematic Systems GmbH
Kantstra=C3=9Fe 162, 10623 Berlin
HRB 151501 B, Amtsgericht Charlottenburg
Vertreten durch die Gesch=C3=A4ftsf=C3=BChrer
Dirk P=C3=B6schl, Armin G. Schmidt
