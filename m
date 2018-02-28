Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1er1FR-00080c-6M
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:54:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1er1FO-0002yE-5H
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:54:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47014 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1er1FO-0002y1-0u
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 07:54:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74158404084B
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 12:54:13 +0000 (UTC)
Date: Wed, 28 Feb 2018 20:54:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228125400.GI27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-11-peterx@redhat.com>
	<20180228091659.GD31550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228091659.GD31550@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/14] qio: refcount QIOTask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 09:16:59AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 01:06:29PM +0800, Peter Xu wrote:
> > It will be used in multiple threads in follow-up patches.  Let it sta=
rt
> > to have refcounts.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/io/task.h |  3 +++
> >  io/task.c         | 23 ++++++++++++++++++++++-
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/include/io/task.h b/include/io/task.h
> > index 9dbe3758d7..c6acd6489c 100644
> > --- a/include/io/task.h
> > +++ b/include/io/task.h
> > @@ -322,4 +322,7 @@ gpointer qio_task_get_result_pointer(QIOTask *tas=
k);
> >   */
> >  Object *qio_task_get_source(QIOTask *task);
> > =20
> > +void qio_task_ref(QIOTask *task);
> > +void qio_task_unref(QIOTask *task);
>=20
> It should just be turned back into a QObject as it was originally,
> so we get refcounting for free.

Could you point me the commit that has the original code?  I would be
glad to revert to that, or yeah I can switch to QObject too.  Thanks,

--=20
Peter Xu
