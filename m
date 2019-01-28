Received: from eggs.gnu.org ([209.51.188.92]:54033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2XD-0007SS-UV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2XC-00083R-Up
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:44:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1go2XC-00082R-Ll
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:44:50 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EA9781DF1
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:44:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-122.ams2.redhat.com [10.36.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 855BF627DD
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:44:48 +0000 (UTC)
References: <20190125192719.15339-1-philmd@redhat.com>
	<20190125192719.15339-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <154f8a45-723d-6f3c-a278-1767361bc94e@redhat.com>
Date: Mon, 28 Jan 2019 09:44:47 +0100
MIME-Version: 1.0
In-Reply-To: <20190125192719.15339-4-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] WIP tests/vm: Run tests on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 2019-01-25 20:27, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/vm/openbsd | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index cfe0572c59..de907dd21c 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -25,9 +25,7 @@ class OpenBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rsd1c;
>          ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --pytho=
n=3Dpython2.7 {configure_opts};
> -        gmake --output-sync -j{jobs} {verbose};
> -        # XXX: "gmake check" seems to always hang or fail
> -        #gmake --output-sync -j{jobs} check {verbose};
> +        gmake --output-sync -j{jobs} check {verbose};
>      """
> =20
>      def build_image(self, img):
>=20

Please add a proper patch description and remove the WIP from the subject=
.

 Thanks,
  Thomas
