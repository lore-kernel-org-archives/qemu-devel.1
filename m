Received: from eggs.gnu.org ([209.51.188.92]:60711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2Imr-0004wF-IF
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2Imq-0007IK-R6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:55:57 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h2Imq-0007HA-F5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:55:56 -0500
Received: by mail-wm1-x341.google.com with SMTP id f65so13167312wma.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:55:55 -0800 (PST)
References: <20190308162906.10491-1-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190308162906.10491-1-philmd@redhat.com>
Date: Fri, 08 Mar 2019 16:55:52 +0000
Message-ID: <875zstfgpz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] travis-ci: Test installing Sphinx
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <fam@euphon.net>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi,
>
> This series improve the Travis CI to test installing the Sphinx
> generated documentation in in-tree and out-of-tree builds.
>
> It is based on Peter's "Fix various issues with Sphinx build
> machinery" series:
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02625.html

Hmm I'd just combined the docs and out of tree build:

  https://github.com/stsquad/qemu/commit/c4d5ae98005bc8a3cd0224321d3d593865=
0c3ef6

>
> Regards,
>
> Phil.
>
> Based-on: <20190308135744.6480-1-peter.maydell@linaro.org>
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   .travis.yml: Reduce the out-of-tree target list
>   .travis.yml: Test the documentation installation process
>   .travis.yml: Test installing Sphinx documentation in out-of-tree build
>
>  .travis.yml | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)


--
Alex Benn=C3=A9e
