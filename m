Received: from eggs.gnu.org ([2001:4830:134:3::10]:47593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0rCF-0007JC-1D
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0rCE-0005lw-4u
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:11:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0rCD-0005lp-VX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 12:11:38 -0400
Received: by mail-oi0-x241.google.com with SMTP id q71-v6so19662844oic.6
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 09:11:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327045646.21112-1-jsnow@redhat.com>
References: <20180327045646.21112-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 17:11:16 +0100
Message-ID: <CAFEAcA_=tFOJQ2ifATinnqyeMYCZ_1KNgUcCD6jwCpvir=2Dcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 March 2018 at 05:56, John Snow <jsnow@redhat.com> wrote:
> The following changes since commit 7b93d78a04aa242d377ae213b79db6c319c71847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-03-26 15:17:25 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/ide-pull-request
>
> for you to fetch changes up to eb69953ecb1cbe7b4c4093a97a4dab3daa315d4e:
>
>   macio: fix NULL pointer dereference when issuing IDE trim (2018-03-27 00:38:00 -0400)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
>
> Anton Nefedov (1):
>   ide: fix invalid TRIM range abortion for macio
>
> Mark Cave-Ayland (1):
>   macio: fix NULL pointer dereference when issuing IDE trim
>
>  hw/ide/core.c  | 17 +++++++++--------
>  hw/ide/macio.c |  2 +-
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
Applied, thanks.

-- PMM
