Received: from eggs.gnu.org ([209.51.188.92]:51485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtncJ-0002eK-W4
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:01:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gtncC-00059W-KM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:01:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gtnc4-00052u-Co
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 01:01:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <RO1P152MB1483088A66FD63B63FD7279A97650@RO1P152MB1483.LAMP152.PROD.OUTLOOK.COM>
	<20190212131136.GH9386@redhat.com>
Date: Wed, 13 Feb 2019 07:01:35 +0100
In-Reply-To: <20190212131136.GH9386@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Tue, 12 Feb 2019 13:11:36 +0000")
Message-ID: <875ztokz0g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Key repeat is no longer working on TTY and grub
 menu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Leonardo Soares =?utf-8?Q?M=C3=BCller?= <leozinho29_eu@hotmail.com>, Gerd Hoffmann <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Yes, this is another regression accidentally introduced by the keyboard
> state tracker.
>
> When GTK does key repeat it omits the Up event for repeated keys.
>
> IOW, you get
>
>     Press (a)
>     Press (a)
>     Press (a)
>     Release (a)

This is how keyboards commonly do it, if I remember correctly.

> Not
>
>     Press (a)
>     Release (a)
>     Press (a)
>     Release (a)
>     Press (a)
>     Release (a)
>
> The keyboard state tracker doesn't take this into account, so it is
> surpressing all except the first Press event.
>
> This might affect other frontends too if they use the same trick for
> key repeat

Plausible.
