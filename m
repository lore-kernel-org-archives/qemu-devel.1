Received: from eggs.gnu.org ([2001:4830:134:3::10]:48803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsoI3-0001Vc-7s
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsoI2-0005Jy-Cf
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:56:07 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:44953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsoI2-0005Iz-5q
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:56:06 -0400
Received: by mail-wm0-x22e.google.com with SMTP id 189so2255044wmh.1
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 03:56:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170915090253.12201-1-famz@redhat.com>
References: <20170915090253.12201-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2017 11:55:44 +0100
Message-ID: <CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 September 2017 at 10:02, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 04ef33052c205170c92df21ca0b4be4f3b1021=
88:
>
>   tcg/tci: do not use ldst label (never implemented) (2017-09-11 19:24:05=
 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/test-and-build-pull-request
>
> for you to fetch changes up to be78fe670401af14e6d63fce5c5467f751207871:
>
>   buildsys: Move rdma libs to per object (2017-09-15 15:05:24 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Alex Benn=C3=A9e (4):
>   docker: ensure NOUSER for travis images
>   docker: docker.py make --no-cache skip checksum test
>   docker: don't install device-tree-compiler build-deps in travis.docker
>   docker: reduce noise when building travis.docker
>
> Fam Zheng (34):
>   docker: Update ubuntu image
>   docker: Enable features explicitly in test-full
>   tests/docker: Clean up paths
>   gitignore: Ignore vm test images
>   qemu.py: Add "wait()" method
>   scripts: Add archive-source.sh
>   tests: Add a test key pair

So, before I commit an ssh private key to our git repo,
can you explain why it's ok that this is public? The
commit message for the relevant patch doesn't really say.

thanks
-- PMM
