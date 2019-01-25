Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn36R-0003Ng-BB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn36Q-0004QG-Hp
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:09:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gn36P-0004PK-8K
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:09:05 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-9-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <21168ede-9a56-7d08-21ad-4fa2b486ad07@redhat.com>
Date: Fri, 25 Jan 2019 16:08:59 +0100
MIME-Version: 1.0
In-Reply-To: <1548410831-19553-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/52] hw/m68k/Makefile.objs: Conditionally
 build boards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>

On 2019-01-25 11:06, Paolo Bonzini wrote:
> From: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
>=20
> CONFIG_AN5206, CONFIG_MCF5206 and CONFIG_MCF5208 make
> variables created for m68k boards, and added to
> default-configs/m86k-softmmu.mak.
>=20
> Signed-off-by: =C3=81kos Kov=C3=A1cs <akoskovacs@gmx.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20190123065618.3520-6-yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/m68k-softmmu.mak | 2 ++
>  hw/m68k/Makefile.objs            | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-so=
ftmmu.mak
> index 60f7cdf..27f5274 100644
> --- a/default-configs/m68k-softmmu.mak
> +++ b/default-configs/m68k-softmmu.mak
> @@ -2,3 +2,5 @@
> =20
>  CONFIG_COLDFIRE=3Dy
>  CONFIG_PTIMER=3Dy
> +CONFIG_AN5206=3Dy
> +CONFIG_MCF5208=3Dy
> diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
> index d1f089c..482f847 100644
> --- a/hw/m68k/Makefile.objs
> +++ b/hw/m68k/Makefile.objs
> @@ -1,2 +1,2 @@
> -obj-y +=3D an5206.o mcf5208.o
> -obj-y +=3D mcf5206.o mcf_intc.o
> +obj-$(CONFIG_AN5206) +=3D an5206.o mcf5206.o
> +obj-$(CONFIG_MCF5208) +=3D mcf5208.o mcf_intc.o

Still:
Reviewed-by: Thomas Huth <thuth@redhat.com>
