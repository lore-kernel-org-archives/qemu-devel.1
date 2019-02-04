Received: from eggs.gnu.org ([209.51.188.92]:59183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZn9-0000yi-ED
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:39:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqZn8-00036D-Kz
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:39:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gqZn5-0002yW-1L
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 03:39:45 -0500
References: <20190203220744.11734-1-philmd@redhat.com>
	<20190203220744.11734-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <25d21d1e-e391-8582-a093-b268dd319842@redhat.com>
Date: Mon, 4 Feb 2019 09:39:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190203220744.11734-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] mips: Express dependencies of the r4k
 platform with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, James Hogan <jhogan@kernel.org>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2019-02-03 23:07, Philippe Mathieu-Daud=C3=A9 wrote:
> This platform use standard PC devices connected to an ISA bus.
> Networking is provided by a ne2000 chipset.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  default-configs/mips-softmmu-common.mak |  1 -
>  hw/mips/Kconfig                         | 10 ++++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>=20
> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/=
mips-softmmu-common.mak
> index a1681edec4..aa3ca196b4 100644
> --- a/default-configs/mips-softmmu-common.mak
> +++ b/default-configs/mips-softmmu-common.mak
> @@ -31,7 +31,6 @@ CONFIG_MC146818RTC=3Dy
>  CONFIG_EMPTY_SLOT=3Dy
>  CONFIG_MIPS_CPS=3Dy
>  CONFIG_MIPS_ITU=3Dy
> -CONFIG_R4K=3Dy

Keep it? Otherwise the machine is disabled by default, isn't it?

 Thomas
