Received: from eggs.gnu.org ([2001:4830:134:3::10]:59463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gSTvU-0001hM-Vd
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:32:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gSTvU-0006sx-5n
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:32:48 -0500
MIME-Version: 1.0
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-17-marcandre.lureau@redhat.com>
	<20181129160934.GM18284@habkost.net>
In-Reply-To: <20181129160934.GM18284@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Nov 2018 01:32:34 +0400
Message-ID: <CAJ+F1CKGsgxEbKS+FSgv0VNO2OqiG9cv8hpDfNV8_raZ=LP37A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 16/28] hw: apply machine compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

Hi

On Thu, Nov 29, 2018 at 8:11 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Tue, Nov 27, 2018 at 01:27:49PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Similarly to accel properties, move compat properties out of globals
> > registration, and apply the machine compat properties during
> > device_post_init().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> [...]
> > @@ -191,7 +190,7 @@ struct MachineClass {
> >      const char *default_machine_opts;
> >      const char *default_boot_order;
> >      const char *default_display;
> > -    GArray *compat_props;
> > +    GPtrArray *compat_props;
>
> What are the advantages/disadvantages of GArray vs GPtrArray vs
> GList here?  Why did you decide to change this from GArray to
> GPtrArray in v4?

GList would be less efficient than an array (extra pointer, memory
allocations/fragmentation/cache etc).

GPtrArray is similar to GArray, it is just specialized for storing void*.



--=20
Marc-Andr=C3=A9 Lureau
