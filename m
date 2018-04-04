Received: from eggs.gnu.org ([2001:4830:134:3::10]:55835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3i1S-0005KO-EY
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3i1M-0000Fx-Vg
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:00:18 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34826)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3i1M-0000Fn-QL
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 09:00:12 -0400
Received: by mail-oi0-x241.google.com with SMTP id z8-v6so19136566oix.2
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 06:00:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403161324.24514-1-jcody@redhat.com>
References: <20180403161324.24514-1-jcody@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 13:59:51 +0100
Message-ID: <CAFEAcA_dT1mrpbhpM84X=pVPTTdzEuzx48OKSkN_xH9FsoSLsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Block patches for 2.12-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 3 April 2018 at 17:13, Jeff Cody <jcody@redhat.com> wrote:
> The following changes since commit f184de7553272223d6af731d7d623a7cebf710=
b5:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critic=
al-fixes' into staging (2018-03-31 09:42:33 +0100)
>
> are available in the git repository at:
>
>   git://github.com/codyprime/qemu-kvm-jtc.git tags/block-pull-request
>
> for you to fetch changes up to 9dae635afa98f83688806861cefe77ff1b4d76a8:
>
>   gluster: Fix blockdev-add with server.N.type=3Dunix (2018-04-03 09:57:1=
4 -0400)
>
> ----------------------------------------------------------------
> Blockjob and Gluster patches
> ----------------------------------------------------------------
>
> Kevin Wolf (1):
>   gluster: Fix blockdev-add with server.N.type=3Dunix
>
> Marc-Andr=C3=A9 Lureau (2):
>   blockjob: leak fix, remove from txn when failing early
>   blockjob: use qapi enum helpers
>
>  block/gluster.c | 21 +++++++++++++++++----
>  blockjob.c      | 28 +++++++++++++++++-----------
>  2 files changed, 34 insertions(+), 15 deletions(-)

Applied, thanks.

-- PMM
