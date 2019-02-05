Received: from eggs.gnu.org ([209.51.188.92]:48244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0e9-0000Qr-W7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:20:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr0e9-0003hB-4J
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:20:17 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42299)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr0e8-0003gj-Vf
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 08:20:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id v23so5532376otk.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 05:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-10-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Feb 2019 13:20:04 +0000
Message-ID: <CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
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

On Tue, 29 Jan 2019 at 17:57, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Various iotests scripts (run via 'make check-block')  use bash
> specific extentions.  OpenBSD comes with the Korn shell as default.
> Install bash to be able to run those tests.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/vm/openbsd | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
> index 6263c8956b..e9c2a3f2c8 100755
> --- a/tests/vm/openbsd
> +++ b/tests/vm/openbsd
> @@ -45,6 +45,8 @@ class OpenBSDVM(basevm.BaseVM):
>          self.wait_ssh()
>          sys.stderr.write("Disabling W^X on the build partition...\n")
>          self.ssh_root_check("sed -E -i 's_(/tmp\ ffs)\ ([^\ ]*)_\\1 \\2,=
wxallowed_' /etc/fstab")
> +        sys.stderr.write("Installing bash...\n")
> +        self.ssh_root_check("PKG_PATH=3Dhttps://ftp.openbsd.org/pub/Open=
BSD/6.1/packages/amd64 pkg_add bash")
>          self.ssh_root("shutdown -p now")
>          self.wait()
>

Wouldn't it make more sense to just update the image to include
the necessary package, the same way we do with all QEMU's
other build dependencies ?

thanks
-- PMM
