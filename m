Received: from eggs.gnu.org ([2001:4830:134:3::10]:48468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS9J-0006Lz-2g
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fWS9H-0005YX-Vv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 15:55:13 -0400
References: <20180622134036.23182-1-f4bug@amsat.org>
	<20180622134036.23182-15-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9e5b3eee-1335-9eae-709a-3f8d05729c03@redhat.com>
Date: Fri, 22 Jun 2018 21:55:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180622134036.23182-15-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/14] hw/arm/stellaris: Fix
 gptm_write() error message
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/arm/stellaris.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
> index d06e366402..42baa768b2 100644
> --- a/hw/arm/stellaris.c
> +++ b/hw/arm/stellaris.c
> @@ -294,7 +294,7 @@ static void gptm_write(void *opaque, hwaddr offset,
>          break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
> -                      "GPTM: read at bad offset 0x%x\n", (int)offset);
> +                      "GPTM: write at bad offset 0x%x\n", (int)offset)=
;

While you're at it, remove the cast and use HWADDR_PRIx ?

 Thomas
