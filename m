Received: from eggs.gnu.org ([2001:4830:134:3::10]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcRu-0004MU-1Q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcRr-0001It-DD
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:24:50 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1elcRr-0001IA-8P
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:24:47 -0500
Received: by mail-qt0-f193.google.com with SMTP id f18so3982824qth.11
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:24:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-2-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-2-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 16:24:46 +0100
Message-ID: <CAMxuvaxr_Qg0FydGDp-+wOa=YNnQ+59=4wpa-NkRCZY0tROQhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/29] Include qapi/qmp/qerror.h exactly
 where needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:35 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  block.c                 | 1 -
>  block/qcow2.c           | 1 -
>  chardev/char-fe.c       | 1 +
>  chardev/char.c          | 1 +
>  qom/object_interfaces.c | 1 +
>  scripts/qapi-visit.py   | 2 +-
>  6 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/block.c b/block.c
> index f94585b230..05a484b4b8 100644
> --- a/block.c
> +++ b/block.c
> @@ -32,7 +32,6 @@
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> -#include "qapi/qmp/qerror.h"
>  #include "qapi/qmp/qjson.h"
>  #include "qapi/qmp/qstring.h"
>  #include "sysemu/block-backend.h"
> diff --git a/block/qcow2.c b/block/qcow2.c
> index a64a572785..9245deac19 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -30,7 +30,6 @@
>  #include "block/qcow2.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -#include "qapi/qmp/qerror.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi-event.h"
> diff --git a/chardev/char-fe.c b/chardev/char-fe.c
> index c611b3fa3e..e5f870e4d2 100644
> --- a/chardev/char-fe.c
> +++ b/chardev/char-fe.c
> @@ -24,6 +24,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "qapi-visit.h"
>  #include "sysemu/replay.h"
>
> diff --git a/chardev/char.c b/chardev/char.c
> index 01d979a1da..c9a4da5516 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -32,6 +32,7 @@
>  #include "qmp-commands.h"
>  #include "qapi-visit.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "sysemu/replay.h"
>  #include "qemu/help_option.h"
>  #include "qemu/option.h"
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index 80d09139be..43d9aa0946 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -1,6 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qerror.h"
>  #include "qom/object_interfaces.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index 7e1cfc13f0..bc2b8b581a 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -371,13 +371,13 @@ fdef.write(mcgen('''
>  #include "qemu/osdep.h"
>  #include "qemu-common.h"
>  #include "qapi/error.h"
> +#include "qapi/qmp/qerror.h"
>  #include "%(prefix)sqapi-visit.h"
>  ''',
>                   prefix=3Dprefix))
>
>  fdecl.write(mcgen('''
>  #include "qapi/visitor.h"
> -#include "qapi/qmp/qerror.h"
>  #include "%(prefix)sqapi-types.h"
>
>  ''',
> --
> 2.13.6
>
