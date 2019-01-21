Received: from eggs.gnu.org ([209.51.188.92]:40660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glSvz-0004Eq-Ty
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:19:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glSvx-0008UO-AU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:19:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glSvw-0008PO-TD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 01:19:45 -0500
References: <20190118185402.3065-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <75f3486c-a1a9-6025-16af-e9a34cc4a663@redhat.com>
Date: Mon, 21 Jan 2019 07:19:22 +0100
MIME-Version: 1.0
In-Reply-To: <20190118185402.3065-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Corey Minyard <minyard@acm.org>

On 2019-01-18 19:54, Peter Maydell wrote:
> The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
> The frequency of this failure has recently gone up sharply to the
> point that I'm having to retry the NetBSD build multiple times
> to get a pass when merging pull requests.
>=20
> Disable the test until we can figure out why it's failing.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Fed up with this failing all the time so let's just turn it off.
> Feel free to investigate what's actually going wrong with it...
>=20
>  tests/Makefile.include | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index eaa81ee1d07..5e6b2c7058d 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -186,7 +186,8 @@ check-qtest-i386-$(CONFIG_SGA) +=3D tests/boot-seri=
al-test$(EXESUF)
>  check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/rtc-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/ipmi-kcs-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/ipmi-bt-test$(EXESUF)
> +# Disabled temporarily as it fails intermittently especially under Net=
BSD VM
> +# check-qtest-i386-y +=3D tests/ipmi-bt-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
>  check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)

Acked-by: Thomas Huth <thuth@redhat.com>
