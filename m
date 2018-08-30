Received: from eggs.gnu.org ([2001:4830:134:3::10]:59669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvS2a-0002WR-LQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvS2V-0002PF-HQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fvS2V-0002Oz-Ak
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 14:51:31 -0400
Date: Thu, 30 Aug 2018 15:51:26 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180830185126.GN8359@habkost.net>
References: <20180810153223.28409-1-marcandre.lureau@redhat.com>
	<20180810153223.28409-2-marcandre.lureau@redhat.com>
	<CAJ+F1CJFOer5vAy63eQ_YKx2jnq=TC7X9ChkC-=qA=QHZv9kXA@mail.gmail.com>
	<bddfd186-b4ab-5007-4936-a31bc701d1c4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <bddfd186-b4ab-5007-4936-a31bc701d1c4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 1/6] hw/i386: add pc-i440fx-3.1 &
 pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Aug 30, 2018 at 09:54:05AM -0400, Stefan Berger wrote:
> On 08/28/2018 10:05 AM, Marc-Andr=E9 Lureau wrote:
> > ping
> > On Fri, Aug 10, 2018 at 5:34 PM Marc-Andr=E9 Lureau
> > <marcandre.lureau@redhat.com> wrote:
> > > The following patch is going to add compatiblity parameters.
> > >=20
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >   include/hw/compat.h  |  4 +++-
> > >   include/hw/i386/pc.h |  5 ++++-
> > >   hw/i386/pc_piix.c    | 13 ++++++++++++-
> > >   hw/i386/pc_q35.c     | 12 +++++++++++-
> > >   4 files changed, 30 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > > index c08f4040bb..f8e596969a 100644
> > > --- a/include/hw/compat.h
> > > +++ b/include/hw/compat.h
> > > @@ -1,7 +1,9 @@
> > >   #ifndef HW_COMPAT_H
> > >   #define HW_COMPAT_H
> > >=20
> > > -#define HW_COMPAT_2_12 \
> > > +#define HW_COMPAT_3_0
> Should probably be 3_1 now?

*_COMPAT_3_1 will exist only on QEMU 3.2, just like *_COMPAT_2_12
exists only on QEMU 3.0 and newer.

We need the compat macros to implement compatibility with older
QEMU versions.  We don't need compat macros for the current QEMU
version.


--=20
Eduardo
