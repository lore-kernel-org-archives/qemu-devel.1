Received: from eggs.gnu.org ([2001:4830:134:3::10]:47390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceOaH-0003Ks-SR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceOaG-0003s5-KP
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:07:05 -0500
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceOaG-0003rx-DL
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:07:04 -0500
Received: by mail-wr0-x231.google.com with SMTP id 89so10323691wrr.3
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 08:07:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170216143816.2384-1-laurent@vivier.eu>
References: <20170216143816.2384-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:06:42 +0000
Message-ID: <CAFEAcA8MXwZcp3uBwHfQRLUJvvK7pxhOEnoaVTqkpw_DzhBAtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/14] Linux user for upstream patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 16 February 2017 at 14:38, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 5dae13cd71f0755a1395b5a4cde635b8a6ee3f58:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-or-20170214' into staging (2017-02-14 09:55:48 +0000)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-upstream-pull-request
>
> for you to fetch changes up to 21992cb6794a5f8edb0cee01bdfe0b03d0438dac:
>
>   linux-user: Add FICLONE and FICLONERANGE ioctls (2017-02-16 15:29:30 +0100)
>
> ----------------------------------------------------------------
> To help Riku in his maintainer role of linux-user, I've proposed
> to help him to manage this pull request.
>
> This series is based on his branch linux-user-for-upstream at:
>
>     https://git.linaro.org/people/riku.voipio/qemu.git
>
> I have added some reviewed patches from the mailing list since
> the last pull request.
>
> I have tested this series by creating some containers:
>
> ppc64   fedora-21
> ppc     debian-8
> aarch64 centos-7.2
>
> All these containers can boot and run as expected
> (create an user, log in as this user, install packages with yum/dnf/apt-get
> using sudo)
>
> I have tested the LTP-20170116 in the ppc container (big-endian 32bit)
> on an x86_64 host (little-endian 64bit). The result is:
>
> Total Tests: 1111
> Total Skipped Tests: 174
> Total Failures: 68
> Kernel Version: 4.9.5-200.fc25.x86_64
> Machine Architecture: ppc
> Hostname: debian-8-ppc
>
> v2:
>     Fix John Paul Adrian Glaubitz author name
> ----------------------------------------------------------------

Sorry, I applied v1 before I noticed you'd done this respin :-(

thanks
-- PMM
