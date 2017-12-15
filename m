Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePqKu-0006x0-EM
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePqKt-00048N-Kr
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:47:36 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <151331201863.120.11022156639051342885@449822a21bf0>
References: <20171215033015.738-1-f4bug@amsat.org>
	<151331201863.120.11022156639051342885@449822a21bf0>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 15 Dec 2017 10:47:34 -0300
Message-ID: <CAAdtpL6BmOx-rRJCRO4njm_mWuYgrs1i+uO_zjprj=Rm6m52hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/43] remove i386/pc dependency from
 non-PC world (part 1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Dec 15, 2017 at 1:27 AM,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series failed build test on ppc host. Please find the details below.
>
> Subject: [Qemu-devel] [PATCH v4 00/43] remove i386/pc dependency from non=
-PC world (part 1)
> Type: series
> Message-id: 20171215033015.738-1-f4bug@amsat.org
[...]
>   CC      hw/i386/xen/trace.o
>   CC      hw/i386/trace.o
> In file included from hw/i386/trace.c:4:0:
> hw/i386/trace.h: In function =E2=80=98_nocheck__trace_vmport_ioport_read_=
unknown_command=E2=80=99:
> hw/i386/trace.h:2967:9: error: too many arguments for format [-Werror=3Df=
ormat-extra-args]
>          qemu_log_mask(LOG_TRACE,
>          ^
> cc1: all warnings being treated as errors
> make: *** [hw/i386/trace.o] Error 1

This has been fixed in the '[PATCH v5 0/2] remove i386/pc dependency
from non-PC world (part 1) fix' series which Paolo already took.
