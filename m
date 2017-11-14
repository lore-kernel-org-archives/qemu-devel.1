Received: from eggs.gnu.org ([2001:4830:134:3::10]:41574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eEbYd-0004H1-HR
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eEbYa-0007bk-Sr
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:47:19 -0500
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:53723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eEbYa-0007aa-OB
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:47:16 -0500
Received: by mail-it0-x22e.google.com with SMTP id m191so13571755itg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 05:47:16 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171114072159.nx77jscj22xzikuv@sirius.home.kraxel.org>
Date: Tue, 14 Nov 2017 08:47:12 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <82E2A9D3-FF38-4BBF-ADCE-3494505F0E8D@gmail.com>
References: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
	<20171113145041.GI18828@redhat.com>
	<CAJ+F1CLxYBq7zfzMSrhnxb+9Np7ZDnrbLqf+e=FoZyC=bZFA+Q@mail.gmail.com>
	<77699873-C42D-4678-9E29-432D2A36BCCE@gmail.com>
	<20171114072159.nx77jscj22xzikuv@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Nov 14, 2017, at 2:21 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>=20
>  Hi,
>=20
>>>>> Would this feature be something you would consider adding to QEMU?
>>>>=20
>>>> As context, virt-manager allows customization for the ungrab =
sequence, and
>>>> so do spice-gtk/gtk-vnc at the API level. So conceptually I think =
it is
>>>> reasonable for any UI console that is intended as more than just a =
toy.
>>>=20
>>> Would it make sense to share the virt-viewer/remote-viewer --hotkeys
>>> option format ? (see man remote-viewer / virt-viewer)
>>=20
>> I think you are referring to information found on this page: =
https://www.mankier.com/1/remote-viewer
>>=20
>> The command-line option for changing hotkey actions would be:
>> --hotkeys=3D<action1>=3D<key1>[+<key2>][,<action2>=3D<key3>[+<key4>]]
>>=20
>> So this means changing the mouse ungrab would look something like =
this:
>>=20
>> --hotkeys=3Drelease-cursor=3DF19 (or some other key)
>>=20
>> Gerd what you think of this idea?
>=20
> Certainly not this way.

Did you have an idea on how something like this should look like? This =
feature would only change the old mouse ungrab keys to a user-specified =
one. So the basic algorithm would be change the text that displays at =
the top of the QEMU window to say (Press <user specified key(s)> to =
release mouse. Then tell the code that looks for the ungrab keys which =
keys to look out for.

>  The display configuration we have right now is
> pretty messy already.  I want clean this up (draft patch series at
> https://www.kraxel.org/cgit/qemu/log/?h=3Dlupin/display-cmdline), and =
this
> should be done before adding new stuff.

My original idea was to make a patch that would only change the cocoa.m =
file. I'm thinking you want this code to be elsewhere. Somewhere where =
other UI code like GTK would be able to use. Is that what you prefer?

> Also when making this configurable it should be consistent across all
> user interfaces we have, which surely is a non-trivial amount of work.

I know Cocoa but my lack of GTK experience would not permit me to make a =
patch for that UI code. When you are done with your display =
configuration work, would there even be a need to patch the Cocoa/GTK =
code? I'm under the impression you are trying to consolidate some of the =
UI code under one file. This does sound like a logic move to make. It =
would help to keep things consistent across different hosts.
