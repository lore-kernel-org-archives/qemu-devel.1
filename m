Received: from eggs.gnu.org ([2001:4830:134:3::10]:44104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXV3i-0003Ax-HX
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fXV3g-0005Rd-Vp
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:13:46 -0400
References: <20180625165749.3910-1-f4bug@amsat.org>
	<20180625165749.3910-2-f4bug@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <f7d3b79e-de4d-6591-02a3-04a82618cb95@redhat.com>
Date: Mon, 25 Jun 2018 13:13:38 -0400
MIME-Version: 1.0
In-Reply-To: <20180625165749.3910-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 1/3] hw/block/fdc: Replace
 error_setg(&error_abort) by assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 06/25/2018 12:57 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Use assert() instead of error_setg(&error_abort),
> as suggested by the "qapi/error.h" documentation:
>=20
>     Please don't error_setg(&error_fatal, ...), use error_report() and
>     exit(), because that's more obvious.
>     Likewise, don't error_setg(&error_abort, ...), use assert().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Acked-by: John Snow <jsnow@redhat.com>

AIUI this series is to be merged by someone else currently, right?
Nothing needed on my part?
