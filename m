Received: from eggs.gnu.org ([2001:4830:134:3::10]:45405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXhp-00069Z-3X
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXhk-0008Dw-5A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:22:49 -0500
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-23-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1fc0d0cb-dead-be57-e4d1-590eed9929a7@redhat.com>
Date: Tue, 27 Nov 2018 08:22:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181125205000.10324-23-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 22/25] MAINTAINERS: Add a missing
 entry to the New World machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org

On 2018-11-25 21:49, Philippe Mathieu-Daud=C3=A9 wrote:
> The CHRP NVRAM has his own section, but since the New World
> section contains the mac_nvram.c, it makes sens to also monitor
> the corresponding header.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 92691589b1..a248c8c564 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -930,6 +930,7 @@ F: hw/nvram/mac_nvram.c
>  F: include/hw/misc/macio/
>  F: include/hw/misc/mos6522.h
>  F: include/hw/ppc/mac_dbdma.h
> +F: include/hw/nvram/chrp_nvram.h

I don't see the point why we should add duplicated entries here? The
header is also used by the Sparc machines, so why should this be added
additionally to the Mac machines only here, too? I suggest to drop this
patch.

 Thomas
