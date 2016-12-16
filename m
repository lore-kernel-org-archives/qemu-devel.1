Received: from eggs.gnu.org ([2001:4830:134:3::10]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cHoNV-0002t2-MH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ossman@cendio.se>) id 1cHoNP-0003jC-Kw
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:00:33 -0500
Received: from lists.cendio.se ([2a00:801:107:f000::b]:37044
	helo=mail.cendio.se)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ossman@cendio.se>) id 1cHoNP-0003h3-Em
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:00:27 -0500
References: <3fcc534530370027118377dc24d4049a1cef590e.1481807806.git.ossman@cendio.se>
	<1481820076.21413.23.camel@redhat.com>
From: Pierre Ossman <ossman@cendio.se>
Message-ID: <9ef03a73-2139-e586-7c2d-c234863bdcac@cendio.se>
Date: Fri, 16 Dec 2016 10:00:24 +0100
MIME-Version: 1.0
In-Reply-To: <1481820076.21413.23.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: track LED state separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On 15/12/16 17:41, Gerd Hoffmann wrote:
>>
>> -    caps =3D ledstate & QEMU_CAPS_LOCK_LED ? 1 : 0;
>> -    num  =3D ledstate & QEMU_NUM_LOCK_LED  ? 1 : 0;
>> -    scr  =3D ledstate & QEMU_SCROLL_LOCK_LED ? 1 : 0;
>> +    if (ledstate !=3D vd->ledstate)
>> +        return;
>
> Hmm?  Shouldn't that be (ledstate =3D=3D vd->ledstate)?
>

Right, sorry. Brain fart. :)

Can you fix that up before commit or do you want a new patch?

Regards
--=20
Pierre Ossman           Software Development
Cendio AB               https://cendio.com
Teknikringen 8          https://twitter.com/ThinLinc
583 30 Link=C3=B6ping        https://facebook.com/ThinLinc
Phone: +46-13-214600    https://plus.google.com/+CendioThinLinc

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
