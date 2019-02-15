Received: from eggs.gnu.org ([209.51.188.92]:51329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gug8S-0001Cy-R4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:14:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gug8S-0001x9-1g
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:14:44 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-6-philmd@redhat.com>
Date: Fri, 15 Feb 2019 17:14:41 +0100
In-Reply-To: <20181218115615.1499-6-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	18 Dec 2018 12:56:08 +0100")
Message-ID: <87o97dyqoe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/12] MAINTAINERS: Add missing entries
 for the QObject section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Removed qdist
> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a94b0dab3..a381882c27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1900,10 +1900,14 @@ F: include/qapi/qmp/
>  X: include/qapi/qmp/dispatch.h
>  F: scripts/coccinelle/qobject.cocci
>  F: tests/check-qdict.c
> -F: tests/check-qnum.c
>  F: tests/check-qjson.c
>  F: tests/check-qlist.c
> +F: tests/check-qlit.c
> +F: tests/check-qnull.c
> +F: tests/check-qnum.c
> +F: tests/check-qobject.c
>  F: tests/check-qstring.c
> +F: qdict-test-data.txt
>  T: git https://repo.or.cz/qemu/armbru.git qapi-next
>=20=20
>  QEMU Guest Agent

Reviewed-by: Markus Armbruster <armbru@redhat.com>
