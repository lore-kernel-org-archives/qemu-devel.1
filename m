Received: from eggs.gnu.org ([2001:4830:134:3::10]:52311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQsmK-0008O3-39
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dQsmJ-0001wQ-9T
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:03:56 -0400
References: <cover.1498756113.git.alistair.francis@xilinx.com>
	<199bd37fe51c4b240da9834673c065ea042b9897.1498756113.git.alistair.francis@xilinx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7af9fffb-c5e4-adac-c0a3-21d739b6a22a@redhat.com>
Date: Fri, 30 Jun 2017 12:03:39 +0200
MIME-Version: 1.0
In-Reply-To: <199bd37fe51c4b240da9834673c065ea042b9897.1498756113.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/3] util/oslib-win32: Remove invalid
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, stefanha@redhat.com, famz@redhat.com
Cc: alistair23@gmail.com, edgar.iglesias@xilinx.com, qemu-block@nongnu.org, philippe@mathieu-daude.net



On 29/06/2017 19:16, Alistair Francis wrote:
> There is no way nhandles can be zero in this section so that part of th=
e
> if statement will always be false. Let's just remove it to make the cod=
e
> easier to read.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Acked-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>=20
>  util/oslib-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 80e4668935..7ec0f8e083 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -414,7 +414,7 @@ static int poll_rest(gboolean poll_msgs, HANDLE *ha=
ndles, gint nhandles,
>          /* If we have a timeout, or no handles to poll, be satisfied
>           * with just noticing we have messages waiting.
>           */
> -        if (timeout !=3D 0 || nhandles =3D=3D 0) {
> +        if (timeout !=3D 0) {
>              return 1;
>          }
> =20

Can you explain this better?

Paolo
