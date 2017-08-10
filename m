Received: from eggs.gnu.org ([2001:4830:134:3::10]:36512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfkSo-0002YG-VV
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dfkSn-0001P2-RX
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:13:14 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:34293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dfkSn-0001OJ-LP
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 06:13:13 -0400
Received: by mail-wr0-x22c.google.com with SMTP id c24so1329893wra.1
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 03:13:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502241852-6302-1-git-send-email-mst@redhat.com>
References: <1502241852-6302-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2017 11:12:51 +0100
Message-ID: <CAFEAcA9Wwnc3nK3TjwCyi71QKmhyY_5256nD1XfAJP2onok78g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] pc, vhost: fixes for rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 August 2017 at 02:50, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 54affb3a3623b1d36c95e34faa722a5831323a74:
>
>   Update version for v2.10.0-rc2 release (2017-08-08 19:07:46 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 24dd1e17696fbd11b3df50718dddcbdfe2c45f24:
>
>   libqtest: always set up signal handler for SIGABRT (2017-08-09 04:22:14 +0300)
>
> ----------------------------------------------------------------
> pc, vhost: fixes for rc3
>
> Fix up bugs and warnings in tests. Revert an experimental commit that I
> put in by mistake: harmless but useless.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Jens Freimann (3):
>       net: fix -netdev socket,fd= for UDP sockets
>       libvhost-user: quit when no more data received
>       libqtest: always set up signal handler for SIGABRT
>
> Michael S. Tsirkin (2):
>       acpi-test: update expected DSDT files
>       Revert "cpu: add APIs to allocate/free CPU environment"
>

Applied, thanks.

-- PMM
