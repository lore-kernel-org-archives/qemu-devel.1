Received: from eggs.gnu.org ([2001:4830:134:3::10]:34195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKQz-0004B1-MF
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fWKQy-0006Y2-Mb
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:40:57 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:46674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fWKQy-0006Xp-8E
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:40:56 -0400
Received: by mail-ot0-x233.google.com with SMTP id v24-v6so7136744otk.13
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 04:40:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 12:40:35 +0100
Message-ID: <CAFEAcA82QaEbD=kgnGTX9c171QxPF41AMED6EUd-qP9BL59Fsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/57] add check-tcg and associated
 machinery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>, andrzej zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>

On 21 June 2018 at 07:25, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 46012db666990ff2eed1d3dc199ab8006439a9=
3b:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180619' into =
staging (2018-06-20 09:51:30 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-2106=
18-2
>
> for you to fetch changes up to 65b26da485540ffcc1c46c9a0898f01912ee6b7a:
>
>   .travis.yml: add check-tcg test (2018-06-20 22:13:39 +0100)
>
> ----------------------------------------------------------------
> Add check-tcg machinary
>
> This restores the ability to run TCG smoke tests by using our docker
> infrastructure to support cross building simple tests. It represents
> the first step to making better cross-architecture testing available
> straight from the source tree ;-)
>
> v2
>   - fix quoting of target_compiler
>   - make docker.py Py3 safe
>   - tweak .travis.yml recipe
>   - don't probe docker when HAVE_USER_DOCKER not set
>
Applied, thanks.

-- PMM
