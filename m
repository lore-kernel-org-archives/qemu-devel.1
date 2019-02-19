Received: from eggs.gnu.org ([209.51.188.92]:51501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gw6bP-0004OB-Ss
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gw6bN-0007gw-QL
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:42:31 -0500
Received: from mail-it1-x12e.google.com ([2607:f8b0:4864:20::12e]:51518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gw6bK-0007e3-Nr
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:42:28 -0500
Received: by mail-it1-x12e.google.com with SMTP id y184so6546373itc.1
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:42:24 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <87ef84z4v6.fsf@dusky.pond.sub.org>
Date: Tue, 19 Feb 2019 09:42:21 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On Feb 19, 2019, at 01:09, Markus Armbruster <armbru@redhat.com> wrote:

> Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:
>=20
>> On Feb 18, 2019, at 13:08, Markus Armbruster <armbru@redhat.com> =
wrote:
>>=20
>>> Any chance you could do multiple region support, too?
>>=20
>> Can you point me at the data sheet for a flash chip with multiple =
region support? For my purposes, I only need the features I mentioned, =
but if it's a simple change, I'll consider it.
>=20
> I'm not familiar with CFI pflash, but I can operate a search engine.
> Have a look at page 27 and 56 of
>=20
> =
https://media.digikey.com/pdf/Data%20Sheets/Intel%20PDFs/28F160C3,320C3,64=
0C3,800C3%20(x16).pdf
>=20
> and tell us whether it's helpful.

That's a flash chip that uses the Intel command set (pflash_cfi01.c in =
qemu), I'm only touching the AMD command set (pflash_cfi02.c). Also =
those pages seem to be about block locking, not multiple regions.

I'm not entirely sure what you meant by multiple regions. If you meant =
blocks* having different sizes (usually in the top or bottom of the =
flash as boot blocks), then I've implemented that (the nonuniform =
sectors* I mentioned in my first email).

* Some flash chips differentiate between sectors and blocks. E.g., the =
flash chip used by hw/arm/musicpal.c =
<http://ww1.microchip.com/downloads/en/DeviceDoc/SST39VF6401B-SST39VF6402B=
-64-Mbit-x16-Multi-Purpose-Flash-Plus-Data-Sheet-DS20005008C.pdf> has =
sectors and blocks with separate erase commands. Qemu treats these the =
same and does not support separate erase commands.

> I think a test would be quite welcome even if it only tests what's
> testable now with reasonable effort.

I used Thomas Huth's suggestion for testing the autoselect, CFI, sector =
erase, chip erase, programming, and reset commands. I'll see how much I =
can test.

--=20
Stephen Checkoway
