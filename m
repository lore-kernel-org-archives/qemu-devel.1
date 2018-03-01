Received: from eggs.gnu.org ([2001:4830:134:3::10]:52262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQGn-0002Xp-PV
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:37:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQGk-0008ET-MX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:37:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQGk-0008E5-Go
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:37:18 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 027368D6FB
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 15:37:18 +0000 (UTC)
Date: Thu, 1 Mar 2018 15:37:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301153706.GL14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-4-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/15] qio: introduce
 qio_channel_add_watch_{full|source}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 04:44:26PM +0800, Peter Xu wrote:
> Firstly, introduce an internal qio_channel_add_watch_full(), which
> enhances qio_channel_add_watch() that context can be specified.
>=20
> Then add a new API wrapper qio_channel_add_watch_source() to return a
> GSource pointer rather than a tag ID.
>=20
> Note that the _source() call will keep a reference of GSource so that
> callers need to unref them explicitly when finished using the GSource.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/io/channel.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  io/channel.c         | 40 ++++++++++++++++++++++++++++++++++------
>  2 files changed, 78 insertions(+), 6 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
