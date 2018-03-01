Received: from eggs.gnu.org ([2001:4830:134:3::10]:55590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQQe-0008Ar-30
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1erQQa-00055B-3z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:47:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1erQQZ-000556-Vt
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 10:47:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8080280AD238
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 15:47:27 +0000 (UTC)
Date: Thu, 1 Mar 2018 15:47:24 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180301154724.GP14643@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-10-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301084438.13594-10-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/15] qio: non-default context for
 threaded qtask
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

On Thu, Mar 01, 2018 at 04:44:32PM +0800, Peter Xu wrote:
> qio_task_run_in_thread() allows main thread to run blocking operations
> in the background. However it has an assumption on that it's always
> working with the default context. This patch tries to allow the threade=
d
> QIO task framework to run with non-default gcontext.
>=20
> Currently no functional change so far, so the QIOTasks are still always
> running on main context.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/io/task.h    |  6 ++++--
>  io/channel-socket.c  |  9 ++++++---
>  io/dns-resolver.c    |  3 ++-
>  io/task.c            | 20 ++++++++++++++++++--
>  tests/test-io-task.c |  2 ++
>  5 files changed, 32 insertions(+), 8 deletions(-)
>=20

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
