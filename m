Received: from eggs.gnu.org ([2001:4830:134:3::10]:52928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fCDxf-0002SL-V9
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 20:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fCDxb-0006zV-C5
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 20:43:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fCDxb-0006yi-6F
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 20:43:31 -0400
References: <20180425070103.23723-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41883964-e0fd-509e-188d-616ebb59828d@redhat.com>
Date: Sat, 28 Apr 2018 02:43:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180425070103.23723-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>

On 25/04/2018 09:01, Peter Xu wrote:
> Otherwise it can warn this:
>=20
>   ERROR: space prohibited between function name and open parenthesis '(=
'
>=20
> When with things like this:
>=20
>   typedef gboolean (*it_tree_iterator)(ITValue start, ITValue end);
>=20
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
>=20
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
> =20
>  # This can be modified by sub possible.  Since it can be empty, be car=
eful
>=20

Queued, thanks.

Paolo
