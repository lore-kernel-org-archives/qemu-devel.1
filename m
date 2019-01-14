Received: from eggs.gnu.org ([209.51.188.92]:48436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj4Wh-0007d4-9e
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gj4Wd-0002Qd-Op
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:51:45 -0500
Date: Mon, 14 Jan 2019 10:51:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114105015-mutt-send-email-mst@kernel.org>
References: <20190114131015.52967-1-lifei1214@126.com>
	<ac0015a7-5fcf-f5f6-a1a5-6c3846459b8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ac0015a7-5fcf-f5f6-a1a5-6c3846459b8c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/misc/edu: add msi_uninit() for
 pci_edu_uninit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Fei Li <lifei1214@126.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Jiri Slaby <jslaby@suse.cz>, qemu-devel@nongnu.org, shirley17fei@gmail.com

On Mon, Jan 14, 2019 at 02:28:39PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing qemu-trivial
>=20
> On 1/14/19 2:10 PM, Fei Li wrote:
> > From: Fei Li <shirley17fei@gmail.com>
> >=20
> > Let's supplement the msi_uninit() when failing to realize
> > the pci edu device.
> >=20
> > Reported-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Fei Li <shirley17fei@gmail.com>
> > Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/misc/edu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/misc/edu.c b/hw/misc/edu.c
> > index cdcf550dd7..ceaf688bfb 100644
> > --- a/hw/misc/edu.c
> > +++ b/hw/misc/edu.c
> > @@ -377,6 +377,7 @@ static void pci_edu_uninit(PCIDevice *pdev)
> >      qemu_mutex_destroy(&edu->thr_mutex);
> > =20
> >      timer_del(&edu->dma_timer);
> > +    msi_uninit(pdev);
> >  }
> > =20
> >  static void edu_obj_uint64(Object *obj, Visitor *v, const char *name=
,
> >=20

That's not trivial material IMHO. I put it in my tree for now.

--=20
MST
