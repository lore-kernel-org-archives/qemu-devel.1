Received: from eggs.gnu.org ([2001:4830:134:3::10]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epFkG-0006ua-QO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epFkB-0003pg-RE
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:58:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1epFkB-0003oe-Mf
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:58:43 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f4673d80-32a6-1324-8a20-9ce845ed6e49@redhat.com>
Date: Fri, 23 Feb 2018 16:58:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 1/7] SecurityPkg/Tcg2Pei: drop
 Tcg2PhysicalPresenceLib dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Apparently, unnecessary. Avoids extra build dependency and churn.
>=20
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c   | 2 --
>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf | 1 -
>  2 files changed, 3 deletions(-)
>=20
> diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c b/SecurityPkg/Tcg/Tcg2Pe=
i/Tcg2Pei.c
> index a7ae3354b5..3758fc6a41 100644
> --- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
> +++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.c
> @@ -18,7 +18,6 @@ WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EI=
THER EXPRESS OR IMPLIED.
>  #include <IndustryStandard/UefiTcgPlatform.h>
>  #include <Ppi/FirmwareVolumeInfo.h>
>  #include <Ppi/FirmwareVolumeInfo2.h>
> -#include <Ppi/LockPhysicalPresence.h>
>  #include <Ppi/TpmInitialized.h>
>  #include <Ppi/FirmwareVolume.h>
>  #include <Ppi/EndOfPeiPhase.h>
> @@ -44,7 +43,6 @@ WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EI=
THER EXPRESS OR IMPLIED.
>  #include <Library/MemoryAllocationLib.h>
>  #include <Library/ReportStatusCodeLib.h>
>  #include <Library/ResetSystemLib.h>
> -#include <Library/Tcg2PhysicalPresenceLib.h>
> =20
>  #define PERF_ID_TCG2_PEI  0x3080
> =20
> diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf b/SecurityPkg/Tcg/Tcg2=
Pei/Tcg2Pei.inf
> index f7b85444d9..bc910c3baf 100644
> --- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
> +++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
> @@ -58,7 +58,6 @@
>    PerformanceLib
>    MemoryAllocationLib
>    ReportStatusCodeLib
> -  Tcg2PhysicalPresenceLib
>    ResetSystemLib
> =20
>  [Guids]
>=20

Good catch.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
