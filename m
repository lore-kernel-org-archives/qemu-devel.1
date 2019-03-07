Received: from eggs.gnu.org ([209.51.188.92]:56540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1xsH-0007wj-55
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1xsC-0003u9-KJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:36:06 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1xsA-0003pa-Ur
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:36:03 -0500
Received: by mail-ot1-x343.google.com with SMTP id b3so15027245otp.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 10:35:59 -0800 (PST)
MIME-Version: 1.0
References: <1551968191-10821-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1551968191-10821-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Mar 2019 18:35:47 +0000
Message-ID: <CAFEAcA9=eKhnL40T8nZuktoVGabq8MoGoYLiRO1fjg9dsNXLXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu, 7 Mar 2019 at 14:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 1ba530a4ecba6015d52d8f392fd327cfa07bc3=
7a:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190304' into =
staging (2019-03-04 13:38:54 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-kconfig
>
> for you to fetch changes up to 1f749c0626f6f79cfc27fc3e6b910a6df03d3488:
>
>   kconfig: add documentation (2019-03-07 15:06:29 +0100)
>
> ----------------------------------------------------------------
> Initial Kconfig work, excluding ARM and MIPS

This passes my build tests, but something in your workflow
has mangled a Cc: line in one of the commit messages.
In commit 11db78e98317e1a0c the accented character in
Herv=C3=A9 Poussineau's name has been mangled and isn't correct
UTF-8. Could you fix that up and resend, please?

PS: since the sphinx patchset just got in ahead of
yours, Sphinx now warns:
docs/devel/kconfig.rst: WARNING: document isn't included in any toctree

I'll send a followup patch which adds 'kconfig' to
docs/devel/index.rst once this is merged.

thanks
-- PMM
