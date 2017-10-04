Received: from eggs.gnu.org ([2001:4830:134:3::10]:51357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziVc-0006gt-6k
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:10:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dziVb-0007bB-9Z
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:10:40 -0400
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-28-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-28-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 14:10:36 +0200
Message-ID: <CAJ+F1CLManx1hv5vEuHC+J6R-GLJiUC2XWOti0nwakBDDAoEhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 27/32] os-posix: Drop misleading comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu trival <qemu-trivial@nongnu.org>

CC qemu-trivial

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Comments explaining why we include a header tend to go bad.  This
> one's almost comical: not only doesn't qemu-options.hx use
> MAP_POPULATE anymore (since commit ef36fa1, v2.0.0, 2013), even the
> include it applies to got moved away in commit 02d0e09 (v2.7.0).
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  os-posix.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/os-posix.c b/os-posix.c
> index 92e9d85215..b9c2343b1e 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -25,7 +25,6 @@
>
>  #include "qemu/osdep.h"
>  #include <sys/wait.h>
> -/*needed for MAP_POPULATE before including qemu-options.h */
>  #include <pwd.h>
>  #include <grp.h>
>  #include <libgen.h>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
