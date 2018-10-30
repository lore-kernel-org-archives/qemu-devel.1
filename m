Received: from eggs.gnu.org ([2001:4830:134:3::10]:43128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHV4U-00066O-5Q
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHV4S-0007BM-2T
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:32:42 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44633)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHV4R-00076u-PN
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:32:39 -0400
Received: by mail-ot1-x343.google.com with SMTP id p23so11255175otf.11
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:32:35 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <1539828637-2907-1-git-send-email-liq3ea@gmail.com>
References: <1539828637-2907-1-git-send-email-liq3ea@gmail.com>
Message-ID: <154090989284.20054.765071955666358201@sif>
Date: Tue, 30 Oct 2018 09:31:32 -0500
Subject: Re: [Qemu-devel] [PATCH] qga: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, qemu-devel@nongnu.org

Quoting Li Qiang (2018-10-17 21:10:37)
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 98d9735..e3842d1 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -465,7 +465,7 @@ static STORAGE_BUS_TYPE win2qemu[] =3D {
> =

>  static GuestDiskBusType find_bus_type(STORAGE_BUS_TYPE bus)
>  {
> -    if (bus > ARRAY_SIZE(win2qemu) || (int)bus < 0) {
> +    if (bus >=3D ARRAY_SIZE(win2qemu) || (int)bus < 0) {
>          return GUEST_DISK_BUS_TYPE_UNKNOWN;
>      }
>      return win2qemu[(int)bus];
> -- =

> 1.8.3.1
>=20
