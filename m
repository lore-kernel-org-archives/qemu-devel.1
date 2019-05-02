Received: from eggs.gnu.org ([209.51.188.92]:46510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMFeM-00072Z-D4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMFeL-0005mk-BH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:37:38 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55138)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMFeL-0005lX-4L
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:37:37 -0400
Received: by mail-wm1-x342.google.com with SMTP id b10so4011254wmj.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 10:37:36 -0700 (PDT)
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-2-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502084506.8009-2-thuth@redhat.com>
Date: Thu, 02 May 2019 18:37:34 +0100
Message-ID: <87y33o4v1d.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/7] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>, Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> "check -raw 005" fails when running on certain filesystems - these do not
> support such large sparse files. Use the same check as in test 220 to
> skip the test in this case.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/qemu-iotests/005 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
> index 2fef63af88..9c7681c19b 100755
> --- a/tests/qemu-iotests/005
> +++ b/tests/qemu-iotests/005
> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>      _notrun "image protocol $IMGPROTO does not support large image sizes"
>  fi
>
> +# Sanity check: For raw, we require a file system that permits the creat=
ion
> +# of a HUGE (but very sparse) file. Check we can create it before contin=
uing.
> +if [ "$IMGFMT" =3D "raw" ]; then
> +    if ! truncate --size=3D5T "$TEST_IMG"; then
> +        _notrun "file system on $TEST_DIR does not support large enough =
files"
> +    fi
> +    rm "$TEST_IMG"
> +fi
> +
>  echo
>  echo "creating large image"
>  _make_test_img 5000G


--
Alex Benn=C3=A9e
