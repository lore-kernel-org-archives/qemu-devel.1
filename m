Received: from eggs.gnu.org ([2001:4830:134:3::10]:54903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWjhC-0000Xy-KF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gWjh9-0004Gc-EP
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:11:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gWjh9-0004Fe-6j
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:11:35 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FD0181F13
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 15:11:34 +0000 (UTC)
Date: Tue, 11 Dec 2018 16:11:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181211161131.01828311@redhat.com>
In-Reply-To: <20181210173932.GH4669@habkost.net>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181210170718.GE4669@habkost.net>
	<20181210183159.7613d08d@Igors-MacBook-Pro.local>
	<20181210173932.GH4669@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 00/19] Generalize machine
 compatibility properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Mon, 10 Dec 2018 15:39:32 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Dec 10, 2018 at 06:31:59PM +0100, Igor Mammedov wrote:
> > On Mon, 10 Dec 2018 15:07:18 -0200
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >  =20
> > > On Tue, Dec 04, 2018 at 06:20:04PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > [...] =20
> > > > Marc-Andr=C3=A9 Lureau (19):
> > > >   tests: qdev_prop_check_globals() doesn't return "all_used"
> > > >   qom: make interface types abstract
> > > >   qom: make user_creatable_complete() specific to UserCreatable
> > > >   accel: register global_props like machine globals
> > > >   qdev: move qdev_prop_register_global_list() to tests
> > > >   qom: remove unimplemented class_finalize =20
> > >=20
> > > Patches 1-6 (above) queued on machine-next.  Thanks! =20
> > let's drop patch 6 for now until we decide what to do with GPtrArray le=
aks =20
>=20
> I appreciate your effort to make sure there are no memory
> allocations that could make Valgrind complain, but I don't see
> the point of keeping dead code that was never called in the tree.
ps:
it looks like machine_finalize() isn't called either,
but it at least documents what should be cleaned up.
Maybe we should keep code removed by 6, for the same reasons.=20


> Are the new GPtrArray allocations different from the g_malloc0()
> calls in type_new() and type_initialize()?  Doesn't Valgrind
> complain about them today?
Currently we don't clean a bunch of onetime allocations,
so I guess we can continue to ignore them in this case as well.
