Received: from eggs.gnu.org ([2001:4830:134:3::10]:49461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqy0u-0007QZ-4O
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqy0q-0004xL-VL
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:27:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqy0q-0004wl-QZ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:27:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C1A2402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 09:27:00 +0000 (UTC)
Date: Wed, 28 Feb 2018 09:26:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228092656.GI31550@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228050633.7410-3-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/14] qio: rename qio_task_thread_result
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 01:06:21PM +0800, Peter Xu wrote:
> It is strange that it was called gio_task_thread_result.  Rename it to
> follow the naming rule of the file.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  io/task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/io/task.c b/io/task.c
> index 3ce556017c..1a0a1c7185 100644
> --- a/io/task.c
> +++ b/io/task.c
> @@ -80,7 +80,7 @@ struct QIOTaskThreadData {
>  };
> =20
> =20
> -static gboolean gio_task_thread_result(gpointer opaque)
> +static gboolean qio_task_thread_result(gpointer opaque)
>  {
>      struct QIOTaskThreadData *data =3D opaque;
> =20
> @@ -110,7 +110,7 @@ static gpointer qio_task_thread_worker(gpointer opa=
que)
>       * the worker results
>       */
>      trace_qio_task_thread_exit(data->task);
> -    g_idle_add(gio_task_thread_result, data);
> +    g_idle_add(qio_task_thread_result, data);
>      return NULL;
>  }
> =20
> --=20
> 2.14.3
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
