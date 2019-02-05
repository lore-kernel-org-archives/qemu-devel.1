Received: from eggs.gnu.org ([209.51.188.92]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr3IX-0004UL-O9
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr3IF-0003ZU-Ui
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:10:03 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr3IF-0003NJ-LQ
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:09:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id d15so4241424wmb.3
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 08:09:27 -0800 (PST)
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190129175403.18017-10-philmd@redhat.com>
Date: Tue, 05 Feb 2019 16:09:24 +0000
Message-ID: <87imxy43pn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Various iotests scripts (run via 'make check-block')  use bash
> specific extentions.  OpenBSD comes with the Korn shell as default.
> Install bash to be able to run those tests.

Hmmm given we use plain POSIX shell for configure portability is there a
reason the check-block test scripts use bash? I guess it doesn't get
picked up as check-block isn't run normally.

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


--
Alex Benn=C3=A9e
