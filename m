Received: from eggs.gnu.org ([2001:4830:134:3::10]:56461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gOT34-0001rv-M7
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 14:48:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gOT31-0006sQ-IO
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 14:48:02 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gOT31-0006rm-61
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 14:47:59 -0500
Received: by mail-wr1-x443.google.com with SMTP id j17-v6so29777391wrq.11
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 11:47:58 -0800 (PST)
References: <154238824601.3534.13597728205342770469.stgit@wayrath>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <154238824601.3534.13597728205342770469.stgit@wayrath>
Date: Sun, 18 Nov 2018 19:47:55 +0000
Message-ID: <87k1lai2vo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docker: dockerfile for openSUSE Leap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dario Faggioli <dfaggioli@suse.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Dario Faggioli <dfaggioli@suse.com> writes:

> Dockerfile for building an openSUSE Leap container.
>
> Tracks the latest release (at the time of writing this
> patch, it is Leap 15).
>
> Signed-off-by: Dario Faggioli <dfaggioli@suse.com>
> ---
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/opensuse-leap.docker |   62 +++++++++++++++++++=
++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/opensuse-leap.docker
>
> diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker=
/dockerfiles/opensuse-leap.docker
> new file mode 100644
> index 0000000000..9d00861e66
> --- /dev/null
> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
> @@ -0,0 +1,62 @@
> +FROM opensuse/leap
> +ENV PACKAGES \
<snip>
> +    tar \
> +    usbredir-devel \
> +    virglrenderer-devel \
> +    vte-devel \
> +    which \
> +    xen-devel
> +    zlib-devel \

This hasn't been tested because the docker image fails to build due to
continuation breakage.

--
Alex Benn=C3=A9e
