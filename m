Received: from eggs.gnu.org ([2001:4830:134:3::10]:38575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBGm7-0007rz-D6
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBGm3-0007Ci-8K
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:31:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fBGm3-0007CS-4O
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 05:31:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180425070103.23723-1-peterx@redhat.com>
Date: Wed, 25 Apr 2018 11:31:29 +0200
In-Reply-To: <20180425070103.23723-1-peterx@redhat.com> (Peter Xu's message of
	"Wed, 25 Apr 2018 15:01:03 +0800")
Message-ID: <87lgdb8wem.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch.pl: add common glib defines
 to typelist
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Otherwise it can warn this:
>
>   ERROR: space prohibited between function name and open parenthesis '('
>
> When with things like this:
>
>   typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> CC: Fam Zheng <famz@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v2:
> - add more missing glib types [Markus]
> ---
>  scripts/checkpatch.pl | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index d52207a3cc..4954150e87 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -266,6 +266,33 @@ our @typeList =3D (
>  	qr{target_(?:u)?long},
>  	qr{hwaddr},
>  	qr{xml${Ident}},
> +	# Glib definitions
> +	qr{gchar},
> +	qr{gshort},
> +	qr{glong},
> +	qr{gint},
> +	qr{gboolean},
> +	qr{guchar},
> +	qr{gushort},
> +	qr{gulong},
> +	qr{guint},
> +	qr{gfloat},
> +	qr{gdouble},
> +	qr{gpointer},
> +	qr{gconstpointer},
> +	qr{gint8},
> +	qr{guint8},
> +	qr{gint16},
> +	qr{guint16},
> +	qr{gint32},
> +	qr{guint32},
> +	qr{gint64},
> +	qr{guint64},
> +	qr{gsize},
> +	qr{gssize},
> +	qr{goffset},
> +	qr{gintptr},
> +	qr{guintptr},
>  );
>=20=20
>  # This can be modified by sub possible.  Since it can be empty, be caref=
ul

We could quibble about order, but since this is unlikely to need
maintenance, let's just take it and move on.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
