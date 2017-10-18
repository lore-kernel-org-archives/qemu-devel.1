Received: from eggs.gnu.org ([2001:4830:134:3::10]:52271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nCz-0005UN-US
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4nCw-00027b-Pj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:12:25 -0400
References: <20171017164426.25277-1-f4bug@amsat.org>
	<20171017164426.25277-17-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2466fbb7-ab33-26bf-9605-e5fa339abdf5@redhat.com>
Date: Wed, 18 Oct 2017 14:12:18 +0200
MIME-Version: 1.0
In-Reply-To: <20171017164426.25277-17-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 16/42] i386/hax: remove duplicated
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yu Ning <yu.ning@linux.intel.com>, Vincent Palatin <vpalatin@chromium.org>, Corey Minyard <cminyard@mvista.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 17.10.2017 18:44, Philippe Mathieu-Daud=C3=A9 wrote:
> this file in include in "target/i386/hax-i386.h":
>=20
>     #ifdef CONFIG_WIN32
>     #include "target/i386/hax-windows.h"
>     #endif
>=20
> which guaranty than sysemu/os-win32.h is previously included (CONFIG_WI=
N32)

which guaranties that ... ?

 Thomas
