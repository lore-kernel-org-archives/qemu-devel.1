Received: from eggs.gnu.org ([2001:4830:134:3::10]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1eDrbL-0006Yr-Og
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:43:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <somlo@cmu.edu>) id 1eDrbI-0007Y7-Mw
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:43:03 -0500
Received: from smtp.andrew.cmu.edu ([128.2.157.37]:54791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <somlo@cmu.edu>) id 1eDrbI-0007Y2-IC
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 07:43:00 -0500
Date: Sun, 12 Nov 2017 07:42:58 -0500
From: "Gabriel L. Somlo" <somlo@cmu.edu>
Message-ID: <20171112124257.GE19857@hedwig.ini.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171031151938.14982-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] crash: export
 paddr_vmcoreinfo_note()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: linux-kernel@vger.kernel.org, somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com

On Tue, Oct 31, 2017 at 04:19:37PM +0100, Marc-Andr=E9 Lureau wrote:
> The following patch is going to use the symbol from the fw_cfg module.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Gabriel Somlo <somlo@cmu.edu>

> ---
>  kernel/crash_core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 6db80fc0810b..47541c891810 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -375,6 +375,7 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
>  {
>  	return __pa(vmcoreinfo_note);
>  }
> +EXPORT_SYMBOL(paddr_vmcoreinfo_note);
> =20
>  static int __init crash_save_vmcoreinfo_init(void)
>  {
> --=20
> 2.15.0.rc0.40.gaefcc5f6f
>=20
