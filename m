Received: from eggs.gnu.org ([2001:4830:134:3::10]:33064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eOogW-0002fL-6T
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eOogT-0006pb-3G
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:49:40 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:37335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eOogS-0006od-Sr
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:49:36 -0500
Received: by mail-it0-x22e.google.com with SMTP id d137so306750itc.2
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:49:36 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171212143421.GD26971@redhat.com>
Date: Tue, 12 Dec 2017 12:49:34 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
Subject: Re: [Qemu-devel] Adding more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>


> On Dec 12, 2017, at 9:34 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
>> On Macintosh keyboards there is a key called fn that is used to give =
the
>> function keys more functionality. Does this key exist in the keyboard =
keys
>> database?
>=20
> When you say "Macintosh keyboards" are you talking about the old style
> keyboards with Apple's custom ADB connector, or simply Apple branded
> USB keyboards ?=20

USB keyboards.

>=20
> If its the latter (USB), then please plug it into a Linux machine, and
> in a text console (ie not X11) run 'showkey' and press this 'fn' key =
on
> its own and tell me what (if any) hex code gets printed.

There was no response to the fn key.

>=20
> Also, under OS-X run this app:
>=20
>  https://manytricks.com/keycodes/
>=20
> and again let me know what it reports when the fn key is pressed on =
its
> on.

Yes the Key Codes application does report the fn key being pressed.=20

Modifier Change
	Keys:	=09
	Key Code:	65535 / 0xffff
	Modifiers:	8388864 / 0x800100 =E2=93=98

Modifier Change
	Keys:	=09
	Key Code:	65535 / 0xffff
	Modifiers:	256 / 0x100 =E2=93=98

> Then also do the same but press 'fn' in combination with another =
function
> key.

The value did not change.

>=20
> The key thing we need to understand is whether this magic behaviour of
> the 'fn' key is actually changing what the main function keys send as
> scancodes.

This is hard to figure out. If the function key is mapped to a function =
like Volume Up, then no event is logged in the Key Codes application. So =
this probably means the operating system catches the key and does not =
share it with other applications.

>=20
>> Also could keys F16 to F24 (Q_KEY_CODE_F16 to Q_KEY_CODE_F24) be =
added to
>> the database?
>=20
> Those are already defined in keycodemapdb, so we just need to give =
them
> names in the qapi schema, and then add the name mapping to =
keycodemapdb.

I have a vague memory of doing something like this a long time ago. =
Hopefully I can find the path if it exists.
