Received: from eggs.gnu.org ([2001:4830:134:3::10]:40574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2NW-0000b8-2G
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds2NS-0001od-4p
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:46:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds2NR-0001nr-VX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:46:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 012238553E
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 07:46:29 +0000 (UTC)
Date: Wed, 13 Sep 2017 09:46:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913094623.6bd4eb07.cohuck@redhat.com>
In-Reply-To: <20170911110623.24981-48-marcandre.lureau@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-48-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 47/50] target.json: add a note about
 query-cpu* not being s390x-specific
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Mon, 11 Sep 2017 13:06:20 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qapi/target.json | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/qapi/target.json b/qapi/target.json
> index 3b73a9202f..12002b54d5 100644
> --- a/qapi/target.json
> +++ b/qapi/target.json
> @@ -77,6 +77,9 @@
>  #          an unknown cpu definition name, unknown properties or propert=
ies
>  #          with wrong types.
>  #
> +# Note: this command isn't specific to s390x, but is only implemented
> +# on this architecture currently.
> +#
>  # Since: 2.8.0
>  ##
>  { 'command': 'query-cpu-model-comparison',
> @@ -117,6 +120,9 @@
>  #          an unknown cpu definition name, unknown properties or propert=
ies
>  #          with wrong types.
>  #
> +# Note: this command isn't specific to s390x, but is only implemented
> +# on this architecture currently.
> +#
>  # Since: 2.8.0
>  ##
>  { 'command': 'query-cpu-model-baseline',

Acked-by: Cornelia Huck <cohuck@redhat.com>
