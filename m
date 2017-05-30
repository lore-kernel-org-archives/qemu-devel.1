Received: from eggs.gnu.org ([2001:4830:134:3::10]:49703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFcNr-0003RO-SA
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dFcNo-0008RN-PE
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:20:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dFcNo-0008R1-JG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:20:04 -0400
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-3-aurelien@aurel32.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <def8df90-33e4-1ed3-5dbc-e8f9e872e671@redhat.com>
Date: Tue, 30 May 2017 10:20:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-3-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/29] target/s390x: remove some Linux
 assumptions from IPTE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 29.05.2017 21:24, Aurelien Jarno wrote:
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/s390x/cpu.h        |  2 ++
>  target/s390x/mem_helper.c | 17 ++++++++++-------
>  target/s390x/mmu_helper.c |  4 +---
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 79235cfa45..d89ad83e71 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -1033,6 +1033,8 @@ struct sysib_322 {
>  #define _SEGMENT_ENTRY_RO       0x200     /* page protection bit      =
        */
>  #define _SEGMENT_ENTRY_INV      0x20      /* invalid segment table ent=
ry      */
> =20
> +#define _VADDR_PX               0xff000   /* page index bits          =
        */

Even though the other #defines start with an underscore, we should not
use this for new code anymore. #defines that start with an underscore +
capital letter are reserved for the C compiler. If you're afraid that
this "VADDR_PX" is not unique enough, maybe rename it to "MMU_VADDR_PX"
instead?

>  #define _PAGE_RO        0x200            /* HW read-only bit  */
>  #define _PAGE_INVALID   0x400            /* HW invalid bit    */
>  #define _PAGE_RES0      0x800            /* bit must be zero  */
[...]

 Thomas
