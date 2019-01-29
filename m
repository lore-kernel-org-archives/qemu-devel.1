Received: from eggs.gnu.org ([209.51.188.92]:33027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goPEe-0006Ko-LG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goPEd-0006P9-Qp
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:59:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1goPEd-0006Nd-Ia
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 03:59:11 -0500
References: <20190129083807.11681-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ccd70de-74b4-e306-5bfd-7410a8e33c59@redhat.com>
Date: Tue, 29 Jan 2019 09:58:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190129083807.11681-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/test-qga: Reenable guest-agent qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

On 2019-01-29 09:38, Philippe Mathieu-Daud=C3=A9 wrote:
> Due to a misuse of rules.mak logical functions, commit f386df17448
> disabled the guest-agent test.
> Enable it back.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> From rules.mak:
>=20
>   # Logical functions (for operating on y/n values like CONFIG_FOO vars=
)
>   # Usage: $(call land,$(CONFIG_FOO),$(CONFIG_BAR))
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 19b4c0a696..172128b058 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -110,7 +110,7 @@ check-unit-y +=3D tests/test-crypto-secret$(EXESUF)
>  check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlscredsx509$(EXESU=
F)
>  check-unit-$(CONFIG_GNUTLS) +=3D tests/test-crypto-tlssession$(EXESUF)
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
> -check-unit-$(land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D tests/=
test-qga$(EXESUF)
> +check-unit-$(call land,$(CONFIG_LINUX),$(CONFIG_VIRTIO_SERIAL)) +=3D t=
ests/test-qga$(EXESUF)
>  endif
>  check-unit-y +=3D tests/test-timed-average$(EXESUF)
>  check-unit-y +=3D tests/test-util-sockets$(EXESUF)

Reviewed-by: Thomas Huth <thuth@redhat.com>
