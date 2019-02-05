Received: from eggs.gnu.org ([209.51.188.92]:52303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0w6-0004Hv-A1
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0hN-0005e9-6x
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:23:42 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr0hF-0005X4-70
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:23:32 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so5532178otr.10
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-15-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-15-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 13:23:05 +0000
Message-ID: <CAFEAcA-P4=no6DeKvPCDVjgPnSMQpO8vnLLs7vtmxw3Td=-5gA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/18] tests/vm: Run tests on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Tue, 29 Jan 2019 at 17:59, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Now than failing tests are commented out, let's reenable the testing
> of this OS.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/vm/openbsd | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 7c456e9706..ff6d5fa549 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -25,9 +25,7 @@ class OpenBSDVM(basevm.BaseVM):
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rsd1c;
>          ./configure --cc=3Dx86_64-unknown-openbsd6.1-gcc-4.9.4 --python=
=3Dpython2.7 {configure_opts};
> -        gmake --output-sync -j{jobs} {verbose};
> -        # XXX: "gmake check" seems to always hang or fail
> -        #gmake --output-sync -j{jobs} check {verbose};
> +        gmake --output-sync -j{jobs} check {verbose};
>      """
>
>      def build_image(self, img):
> --
> 2.20.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
