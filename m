Received: from eggs.gnu.org ([2001:4830:134:3::10]:46194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRvm-00086q-BI
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:41:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWRvl-0000qm-IY
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:41:14 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-9-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a2889a3-681f-487e-828b-89cb6f59d9d9@redhat.com>
Date: Fri, 22 Jun 2018 21:41:04 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/14] hw/arm/omap1: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

On 22.06.2018 15:40, Philippe Mathieu-Daud=C3=A9 wrote:
> TCMI_VERBOSE is no more used, drop the OMAP_8/16/32B_REG macros.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/omap.h | 18 ------------------
>  hw/arm/omap1.c        | 18 ++++++++++++------
>  2 files changed, 12 insertions(+), 24 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
