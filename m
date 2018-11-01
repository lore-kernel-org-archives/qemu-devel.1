Received: from eggs.gnu.org ([2001:4830:134:3::10]:56168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIHhz-00042w-BL
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:28:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIHhx-0008E3-4K
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:28:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIHhw-0008CZ-Pw
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:28:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id h23-v6so17425419oih.9
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 11:28:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
References: <20181031141925.30026-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 18:28:16 +0000
Message-ID: <CAFEAcA_MYOUZ5EFMtfasaOzOuWPs+H546BkkXs_sB0eV2nPY=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/24] qemu-ga patch queue for soft-freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2018 at 14:19, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2018-10-30-v3-tag
>
> for you to fetch changes up to b70d6afe4d7f252259d3344e12daa2d6baf006e2:
>
>   qga-win: changing --retry-path option behavior (2018-10-31 09:04:20 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for soft-freeze
>
> * support for --retry-path option for recovering from communication
>   path failures
> * support for serial/device name in guest-get-fsinfo for linux/w32
> * support for freezing individual mount points in guest-fsfreeze-*
> * fixes for unicode paths on w32, not-present vcpus in guest-get-vcpus,
>   buffer overflow in guest-get-fsinfo for w32, and other minor fixes
>
> v3:
> * remove redundant check for --static in configure
> * correct authorship on "qga-win: add debugging information"
>
> v2:
> * set libudev=off in configure for static builds
>

Applied, thanks.

-- PMM
