Received: from eggs.gnu.org ([2001:4830:134:3::10]:53170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwiAO-0000BF-SP
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwiAL-00016N-0i
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:12:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwiAK-00015r-QS
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 01:12:16 -0400
Date: Tue, 26 Sep 2017 13:12:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926051206.GA25267@pxdev.xzpeter.org>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
	<1506401532-25274-2-git-send-email-peterx@redhat.com>
	<20170926045824.GC31924@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926045824.GC31924@lemon.lan>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manos Pitsidianakis <el13635@mail.ntua.gr>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Sep 26, 2017 at 12:58:24PM +0800, Fam Zheng wrote:
> On Tue, 09/26 12:52, Peter Xu wrote:
> > We have object_get_objects_root() to keep user created objects, howev=
er
> > no place for objects that will be used internally.  Create such a
> > container for internal objects.
> >=20
> > CC: Andreas F=C3=A4rber <afaerber@suse.de>
> > CC: Markus Armbruster <armbru@redhat.com>
> > CC: Paolo Bonzini <pbonzini@redhat.com>
> > Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/qom/object.h | 10 ++++++++++
> >  qom/object.c         | 11 +++++++++++
> >  2 files changed, 21 insertions(+)
> >=20
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index f3e5cff..f567052 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
> >  Object *object_get_objects_root(void);
> > =20
> >  /**
> > + * object_get_internal_root:
> > + *
> > + * Get the container object that holds internally used object
> > + * instances. This is the object at path "/internal-objects"
>=20
> Does this comment need update?

Definitely. :)

--=20
Peter Xu
