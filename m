Received: from eggs.gnu.org ([2001:4830:134:3::10]:54918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqxtp-0007Sg-Rr
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqxto-0005pd-Qm
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 04:15:13 -0400
MIME-Version: 1.0
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-2-f4bug@amsat.org>
	<87y3vw1o94.fsf@dusky.pond.sub.org>
	<1490255007.463.11.camel@redhat.com>
In-Reply-To: <1490255007.463.11.camel@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Mar 2017 08:14:49 +0000
Message-ID: <CAJ+F1CJNy+e83EHR_8uzAHURxDk6idnNTTL_FoD-krWPue7Lww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

Hi

On Thu, Mar 23, 2017 at 11:44 AM Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>
> > > +    if (len =3D=3D 0) {
> > > +        return;
> >
> > Correct only if messages without data always have the same meaning as n=
o
> > message.  Gerd?
>
> Not a ccid expert, but looking through the code it seems writing a
> (reply) data block with status and without payload (data =3D NULL and len
> =3D 0) is perfectly fine and can happen in case no (virtual) smartcard is
> inserted into the card reader.  Which this patch breaks.  So,
>
> NACK.
>

 oops, there are hard-coded calls with NULL/0. I suppose to fix clang
warning, it would need to check if data !=3D null for memcpy.
--=20
Marc-Andr=C3=A9 Lureau
