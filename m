Received: from eggs.gnu.org ([2001:4830:134:3::10]:49585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cOS5F-0000p6-6w
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cOS5B-00081G-9K
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:37:09 -0500
Received: from mail-io0-x233.google.com ([2607:f8b0:4001:c06::233]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cOS5B-00080Y-4U
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:37:05 -0500
Received: by mail-io0-x233.google.com with SMTP id h133so197342039ioe.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 08:37:03 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1483433944.24493.3.camel@redhat.com>
Date: Tue, 3 Jan 2017 11:37:00 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2287F42-8073-421D-9920-3048D63B41E3@gmail.com>
References: <376FE1EF-577A-4BE3-B398-99ACB7F280F4@gmail.com>
	<1483433944.24493.3.camel@redhat.com>
Subject: Re: [Qemu-devel] Speed menu for GTK interfaace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Jan 3, 2017, at 3:59 AM, Gerd Hoffmann wrote:

> On So, 2017-01-01 at 13:15 -0500, Programmingkid wrote:
>> Hello, I was wondering if you would accept a patch that added a Speed
>> menu to the GTK interface. This would allow the user to change how
>> much CPU time the emulated CPU would see.=20
>=20
> /me wonders what exactly would the menu entries do?
>=20
> cheers,
>  Gerd

It is quite simple, there would be a 100% to a 1% menu item. It would =
look like
this:

Speed
-------
100%
90%
80%
70%
60%
50%
40%
30%
20%
10%
1%


Each menu item would call cpu_throttle_set(). The value sent to this =
function would
be determined like this:
speed =3D -1 * menu_number + 100;

speed would be sent to the cpu_throttle_set() function. This function =
would reduce
the CPU usage of QEMU on the host.=20

Why would someone want to slow down QEMU?
- The user is using a laptop and don't want it to heat up.
- The user wants to slow down a video game that is a little too =
challenging.
- The user wants to save energy.
- The user wants to conduct some kind of stress test on a program and =
see how
it handles under low cpu resources.=20

Hope this helps. Thank you for responding.=
