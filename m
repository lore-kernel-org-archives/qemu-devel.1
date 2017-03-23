Received: from eggs.gnu.org ([2001:4830:134:3::10]:48786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqxPC-0000sX-Sf
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cqxP9-0004XU-Rw
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 03:43:34 -0400
Message-ID: <1490255007.463.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Mar 2017 08:43:27 +0100
In-Reply-To: <87y3vw1o94.fsf@dusky.pond.sub.org>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-2-f4bug@amsat.org>
	<87y3vw1o94.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND 1/3] usb-ccid: make
 ccid_write_data_block() cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

  Hi,

> > +    if (len =3D=3D 0) {
> > +        return;
>=20
> Correct only if messages without data always have the same meaning as no
> message.  Gerd?

Not a ccid expert, but looking through the code it seems writing a
(reply) data block with status and without payload (data =3D NULL and len
=3D 0) is perfectly fine and can happen in case no (virtual) smartcard is
inserted into the card reader.  Which this patch breaks.  So,

NACK.

cheers,
  Gerd
