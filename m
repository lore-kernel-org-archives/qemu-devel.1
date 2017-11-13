Received: from eggs.gnu.org ([2001:4830:134:3::10]:43188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eEGdu-0007fP-C2
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eEGdo-0002p8-BP
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:27:22 -0500
Received: from mail-it0-x233.google.com ([2607:f8b0:4001:c0b::233]:37894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eEGdo-0002on-5k
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:27:16 -0500
Received: by mail-it0-x233.google.com with SMTP id n134so1247283itg.3
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 07:27:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAJ+F1CLxYBq7zfzMSrhnxb+9Np7ZDnrbLqf+e=FoZyC=bZFA+Q@mail.gmail.com>
Date: Mon, 13 Nov 2017 10:27:14 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <77699873-C42D-4678-9E29-432D2A36BCCE@gmail.com>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
	<20171113145041.GI18828@redhat.com>
	<CAJ+F1CLxYBq7zfzMSrhnxb+9Np7ZDnrbLqf+e=FoZyC=bZFA+Q@mail.gmail.com>
Subject: Re: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Nov 13, 2017, at 10:20 AM, Marc-Andr=C3=A9 Lureau =
<marcandre.lureau@gmail.com> wrote:
>=20
> Hi
>=20
> On Mon, Nov 13, 2017 at 3:50 PM, Daniel P. Berrange =
<berrange@redhat.com> wrote:
>> On Mon, Nov 13, 2017 at 09:29:25AM -0500, Programmingkid wrote:
>>> Would you accept a patch that allows the user to change the mouse =
ungrab key(s) in QEMU?
>>>=20
>>> It would look something like this:
>>>=20
>>> -ungrab <key>
>>>=20
>>> or
>>>=20
>>> -ungrab <key>,<key>,...
>>>=20
>>> If the user wanted the F19 key to be the ungrab key, this is what =
would be sent to QEMU:
>>>=20
>>> -ungrab F19
>>>=20
>>> If the user wanted F16 and F17 held down to ungrab the mouse, this =
is what would be sent to QEMU:
>>>=20
>>> -ungrab F16,F17
>>>=20
>>>=20
>>> Would this feature be something you would consider adding to QEMU?
>>=20
>> As context, virt-manager allows customization for the ungrab =
sequence, and
>> so do spice-gtk/gtk-vnc at the API level. So conceptually I think it =
is
>> reasonable for any UI console that is intended as more than just a =
toy.
>=20
> Would it make sense to share the virt-viewer/remote-viewer --hotkeys
> option format ? (see man remote-viewer / virt-viewer)

I think you are referring to information found on this page: =
https://www.mankier.com/1/remote-viewer

The command-line option for changing hotkey actions would be:
--hotkeys=3D<action1>=3D<key1>[+<key2>][,<action2>=3D<key3>[+<key4>]]

So this means changing the mouse ungrab would look something like this:

--hotkeys=3Drelease-cursor=3DF19 (or some other key)

Gerd what you think of this idea?=
