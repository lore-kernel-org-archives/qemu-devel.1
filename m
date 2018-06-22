Received: from eggs.gnu.org ([2001:4830:134:3::10]:49809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHWw-0006Rf-72
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWHWv-0004eH-7r
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 04:34:54 -0400
References: <20180621180224.8312-1-f4bug@amsat.org>
	<20180621180224.8312-9-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e8e5e2ff-9576-402d-1502-9b584b0295f7@redhat.com>
Date: Fri, 22 Jun 2018 10:34:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180224.8312-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/11] hw/arm/omap: Use
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
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 21.06.2018 20:02, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/arm/omap.h | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
[...]
> @@ -997,14 +998,17 @@ enum {
> =20
>  # ifdef TCMI_VERBOSE
>  #  define OMAP_8B_REG(paddr)		\
> -        fprintf(stderr, "%s: 8-bit register " OMAP_FMT_plx "\n",	\
> -                        __func__, paddr)
> +        qemu_log_mask(LOG_GUEST_ERROR, \
> +                      "%s: 8-bit register " OMAP_FMT_plx "\n", \
> +                      __func__, paddr)
>  #  define OMAP_16B_REG(paddr)		\
> -        fprintf(stderr, "%s: 16-bit register " OMAP_FMT_plx "\n",	\
> -                        __func__, paddr)
> +        qemu_log_mask(LOG_GUEST_ERROR, \
> +                      "%s: 16-bit register " OMAP_FMT_plx "\n", \
> +                      __func__, paddr)
>  #  define OMAP_32B_REG(paddr)		\
> -        fprintf(stderr, "%s: 32-bit register " OMAP_FMT_plx "\n",	\
> -                        __func__, paddr)
> +        qemu_log_mask(LOG_GUEST_ERROR, \
> +                      "%s: 32-bit register " OMAP_FMT_plx "\n", \
> +                      __func__, paddr)
>  # else
>  #  define OMAP_8B_REG(paddr)
>  #  define OMAP_16B_REG(paddr)
>=20

Since the qemu_log_mask(LOG_GUEST_ERROR, ...) calls are not shown up by
default anymore, I think it would rather be better to get rid of this
#ifdef TCMI_VERBOSE ... #endif block now and put the qemu_log_mask()
statements directly into the omap_badwidth_* functions instead.

 Thomas
