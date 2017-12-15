Received: from eggs.gnu.org ([2001:4830:134:3::10]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePlGF-0004ti-5E
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ePlGB-0007Gp-Uw
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:22:27 -0500
References: <20171215034356.4449-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9670cc80-9de2-9838-a011-c9b2656e20fb@redhat.com>
Date: Fri, 15 Dec 2017 09:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171215034356.4449-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/2] remove i386/pc dependency from
 non-PC world (part 1) fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org

On 15/12/2017 04:43, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix patch 42 from previous series (v4) so patchew can build, and if a m=
aintainer
> is willing to take the previous series with the last 2 patches, I don't=
 need to
> respam a v6.
>=20
> Regards,
>=20
> Phil.

I tweaked a bit patch 1 to use LOG_UNIMP instead, and queued these two
patches.

Paolo

> Based-on: 20171215033015.738-42-f4bug@amsat.org
>           (remove i386/pc dependency from non-PC world v4)
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/i386/vmport: replace fprintf() by trace events
>   misc: drop old i386 dependency
>=20
>  hw/char/debugcon.c      | 1 -
>  hw/i386/vmport.c        | 8 +++-----
>  hw/intc/lm32_pic.c      | 1 -
>  hw/moxie/moxiesim.c     | 1 -
>  hw/sparc/sun4m.c        | 1 -
>  hw/watchdog/wdt_ib700.c | 1 -
>  hw/i386/trace-events    | 4 ++++
>  7 files changed, 7 insertions(+), 10 deletions(-)
>=20
