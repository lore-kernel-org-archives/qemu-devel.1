Received: from eggs.gnu.org ([2001:4830:134:3::10]:57635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXHGw-0005s9-3V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXHGt-0005Dt-06
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:25:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXHGs-0005Dj-PG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:25:54 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F11C356F2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 01:25:53 +0000 (UTC)
Date: Tue, 18 Jul 2017 09:25:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170718012546.GY27284@pxdev.xzpeter.org>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-2-git-send-email-peterx@redhat.com>
	<f34cae70-00f7-9058-c5aa-1f209b742172@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f34cae70-00f7-9058-c5aa-1f209b742172@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/11] qdev: provide DEFINE_PROP_INT64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Jul 17, 2017 at 11:30:47AM -0500, Eric Blake wrote:
> On 07/17/2017 03:26 AM, Peter Xu wrote:
> > We have merely all the stuff, but this one is missing. Add it in.
>=20
> s/merely/nearly/

Will fix this without removing r-bs.  Thanks,

>=20
> >=20
> > Am going to use this new helper for MigrationParameters fields, since
> > most of them are int64_t.
> >=20
> > CC: Markus Armbruster <armbru@redhat.com>
> > CC: Eduardo Habkost <ehabkost@redhat.com>
> > CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > CC: Peter Xu <peterx@redhat.com>
> > CC: Juan Quintela <quintela@redhat.com>
> > CC: Marcel Apfelbaum <marcel@redhat.com>
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  hw/core/qdev-properties.c    | 32 ++++++++++++++++++++++++++++++++
> >  include/hw/qdev-properties.h |  3 +++
> >  2 files changed, 35 insertions(+)
> >=20
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>=20




--=20
Peter Xu
