Received: from eggs.gnu.org ([2001:4830:134:3::10]:36615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eguUt-0007jP-84
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eguUp-0006q4-Bx
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:40:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eguUp-0006mX-5h
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 10:40:23 -0500
References: <20180131144846.31697-1-armbru@redhat.com>
	<20180131144846.31697-2-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1fed5cb6-e8c7-e289-ef56-08abca0913c9@redhat.com>
Date: Wed, 31 Jan 2018 16:40:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180131144846.31697-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/19] Use #include "..." for our own
 headers, <...> for others
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: f4bug@amsat.org

On 31.01.2018 15:48, Markus Armbruster wrote:
> System headers should be included with <...>, our own headers with
> "...". Offenders tracked down with an ugly, brittle and probably
> buggy Perl script.  Previous iteration was commit a9c94277f0.
>=20
> Put the cleaned up system header includes first, except for the ones
> the next commit will delete.

That's a little bit of code churn ... why not delete them here
immediately, or simply ignore these headers here and just delete them in
the next patch?

> While there, separate #include from file comment with a blank line,
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
[...]
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 0570f597ec..9968974fbe 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -13,8 +13,8 @@
>   */
> =20
> =20

While you're at it, remove one of the two blank lines?

> -#include "inttypes.h"
> -#include "stdio.h"
> +#include <inttypes.h>
> +#include <stdio.h>
>  #include "cpu_features_def.h"

Above remarks are just nits, anyway patch looks fine, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
