Received: from eggs.gnu.org ([2001:4830:134:3::10]:46049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eP9V8-0007tA-DK
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eP9V5-0003bF-AI
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:03:18 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:39318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eP9V5-0003a8-4c
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 11:03:15 -0500
Received: by mail-it0-x22e.google.com with SMTP id 68so4160387ite.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 08:03:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171213091458.GA28379@redhat.com>
Date: Wed, 13 Dec 2017 11:03:11 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D487247-C5DA-4902-A21E-B16861F763C8@gmail.com>
References: <20B182CA-4FA6-444D-87B1-46B04FFC81AE@gmail.com>
	<20171212143421.GD26971@redhat.com>
	<11216FAC-3F62-43AF-ACD8-00F28B7AD886@gmail.com>
	<20171213091458.GA28379@redhat.com>
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


> On Dec 13, 2017, at 4:14 AM, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>=20
> On Tue, Dec 12, 2017 at 12:49:34PM -0500, Programmingkid wrote:
>>=20
>>> On Dec 12, 2017, at 9:34 AM, Daniel P. Berrange =
<berrange@redhat.com> wrote:
>>>=20
>>> On Sun, Dec 10, 2017 at 02:10:41AM -0500, Programmingkid wrote:
>>>> On Macintosh keyboards there is a key called fn that is used to =
give the
>>>> function keys more functionality. Does this key exist in the =
keyboard keys
>>>> database?
>>>=20
>>> When you say "Macintosh keyboards" are you talking about the old =
style
>>> keyboards with Apple's custom ADB connector, or simply Apple branded
>>> USB keyboards ?=20
>>=20
>> USB keyboards.
>>=20
>>>=20
>>> If its the latter (USB), then please plug it into a Linux machine, =
and
>>> in a text console (ie not X11) run 'showkey' and press this 'fn' key =
on
>>> its own and tell me what (if any) hex code gets printed.
>>=20
>> There was no response to the fn key.
>=20
> Doh, I made a mistake - you need to run   'showkey -s'  to get raw =
scancodes.
> Can you try this again, pressing 'fn' on its own, and also press 'fn' =
in
> combination with some function keys.

Sorry but showkey still did not register the fn key being pushed.

>=20
>=20
>>>> Also could keys F16 to F24 (Q_KEY_CODE_F16 to Q_KEY_CODE_F24) be =
added to
>>>> the database?
>>>=20
>>> Those are already defined in keycodemapdb, so we just need to give =
them
>>> names in the qapi schema, and then add the name mapping to =
keycodemapdb.
>>=20
>> I have a vague memory of doing something like this a long time ago.
>> Hopefully I can find the path if it exists.
>=20
> In qapi/ui.json you need to edit the enum 'QKeyCode' to define the
> extra keys.

Thank you. I will make a patch that adds these keys.=
