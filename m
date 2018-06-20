Received: from eggs.gnu.org ([2001:4830:134:3::10]:42419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdzv-0001UF-UG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdzu-0003fB-VG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:22:11 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:32847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVdzu-0003f3-PD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:22:10 -0400
Received: by mail-oi0-x236.google.com with SMTP id c6-v6so3190209oiy.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:22:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619154435.18898-1-alex.bennee@linaro.org>
References: <20180619154435.18898-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 15:21:49 +0100
Message-ID: <CAFEAcA_QYqnSZo1yL+iYoWyvnGDvW7Lhp3pv2rPzeSfZXS3khg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/56] add check-tcg and associated machinery
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

On 19 June 2018 at 16:43, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The following changes since commit 2ef2f16781af9dee6ba6517755e9073ba5799f=
a2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-2018=
0615a' into staging (2018-06-15 18:13:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-tcg-testing-revivial-1906=
18-1
>
> for you to fetch changes up to 03c79cb5825f2e930a39839e8375dc0feef6d57d:
>
>   .travis.yml: add check-tcg test (2018-06-19 16:38:54 +0100)
>
> ----------------------------------------------------------------
> Add check-tcg machinary
>
> This restores the ability to run TCG smoke tests by using our docker
> infrastructure to support cross building simple tests. It represents
> the first step to making better cross-architecture testing available
> straight from the source tree ;-)
>

Also, I've just noticed that your commit messages are
full of the 'below-the-fold' info about changes since
v3, v4, etc. That shouldn't be in commits in pull requests,
please.

thanks
-- PMM
