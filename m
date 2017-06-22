Received: from eggs.gnu.org ([2001:4830:134:3::10]:41640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO2o2-0001aN-28
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO2o0-0001rt-NY
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:09:58 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO2o0-0001rc-FF
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 10:09:56 -0400
Received: by mail-wr0-x22a.google.com with SMTP id 77so25204098wrb.1
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 07:09:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 15:09:34 +0100
Message-ID: <CAFEAcA91jcDezunfEKwB+DBdzrEAFYWHKRyFmPyCNYSs_4N4JA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/21] Docker and shippable updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 June 2017 at 15:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 8dfaf23ae1f2273a9730a9b309cc8471269bb5=
24:
>
>   tcg/tci: fix tcg-interpreter build (2017-06-20 18:39:15 +0100)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-ci-updates-210617-2
>
> for you to fetch changes up to 32b9ca986855a5d56daf47fdb516743008788b71:
>
>   MAINTAINERS: self-appoint me as reviewer in build/test automation (2017=
-06-21 15:03:06 +0100)
>
> ----------------------------------------------------------------
> This is mostly Philippe's updates
>
> We add the following cross-compile targets:
>   - mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
>   - armeb-linux-user
>
> While I was rolling I discovered we could also back out a bunch of the
> emdebian hacks as the newly released stretch handles cross compilers
> as first class citizens. Unfortunately this also meant I had to drop
> the powerpc support as that is no longer in Debian stable.
>

Applied, thanks.

-- PMM
