Received: from eggs.gnu.org ([209.51.188.92]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1goPYV-0003Ka-0Y
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1goPYS-0003Km-Ld
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:19:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1goPYQ-0003CA-Ij
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:19:39 -0500
References: <20190129083807.11681-1-philmd@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <241b135b-6a10-8fcf-9733-4aaac639a531@redhat.com>
Date: Tue, 29 Jan 2019 10:11:49 +0100
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>

On 29/01/2019 09:38, Philippe Mathieu-Daud=C3=A9 wrote:
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
>=20

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
