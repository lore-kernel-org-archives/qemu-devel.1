Received: from eggs.gnu.org ([2001:4830:134:3::10]:49231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRDcX-00026j-KC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gRDcO-0004TS-C1
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 04:55:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-19-philmd@redhat.com>
Date: Mon, 26 Nov 2018 10:55:44 +0100
In-Reply-To: <20181125205000.10324-19-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun,
	25 Nov 2018 21:49:53 +0100")
Message-ID: <87o9acnowv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 18/25] MAINTAINERS: Add missing
 entries for the QObject section
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 28e5038c73..ac5d25491f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1846,12 +1846,18 @@ S: Supported
>  F: qobject/
>  F: include/qapi/qmp/
>  X: include/qapi/qmp/dispatch.h
> +F: include/qemu/qdist.h

This isn't part of QObject.

>  F: scripts/coccinelle/qobject.cocci
>  F: tests/check-qdict.c
> -F: tests/check-qnum.c
>  F: tests/check-qjson.c
>  F: tests/check-qlist.c
> +F: tests/check-qlit.c
> +F: tests/check-qnull.c
> +F: tests/check-qnum.c
> +F: tests/check-qobject.c

There are good.

>  F: tests/check-qstring.c
> +F: tests/test-qdist.c

Not part of QObject.

> +F: qdict-test-data.txt

Good.  Should be moved to tests/, but not in this series.

>  T: git https://repo.or.cz/qemu/armbru.git qapi-next
>=20=20
>  QEMU Guest Agent
