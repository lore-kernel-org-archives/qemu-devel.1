Received: from eggs.gnu.org ([2001:4830:134:3::10]:45856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvm-0004Wb-Bq
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g7Mvi-0007HS-A7
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:50 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:52902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g7Mvg-0007Fq-AA
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:49:45 -0400
Received: from player797.ha.ovh.net (unknown [10.109.159.62])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id A2423DFEE6
	for <qemu-devel@nongnu.org>; Tue,  2 Oct 2018 17:49:39 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-2-f4bug@amsat.org>
Message-ID: <d58c1c4c-11ef-ad23-85e5-9d3ac99b1ea5@kaod.org>
Date: Tue, 2 Oct 2018 17:49:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/15] trace-events: Fix copy/paste typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 10/2/18 12:09 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Missed while reviewing 5dd85b4b486.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/timer/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index fa4213df5b..ca9ad6321a 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -56,7 +56,7 @@ systick_timer_tick(void) "systick reload"
>  systick_read(uint64_t addr, uint32_t value, unsigned size) "systick re=
ad addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  systick_write(uint64_t addr, uint32_t value, unsigned size) "systick w=
rite addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> =20
> -# hw/char/cmsdk_apb_timer.c
> +# hw/timer/cmsdk_apb_timer.c
>  cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "C=
MSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "=
CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
>=20
