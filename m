Received: from eggs.gnu.org ([2001:4830:134:3::10]:40945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clB7n-00021i-Jb
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clB7m-0003G5-KU
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:09:43 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clB7m-0003Fn-Cw
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:09:42 -0500
Received: by mail-wm0-x22a.google.com with SMTP id v186so84014784wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 01:09:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Mar 2017 09:09:20 +0000
Message-ID: <CAFEAcA_wYK3YVX8J=GxF1m2-SEzqHvhUoShQcvTU_gqTczbc2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL for-2.9 0/3] qemu-ga patch queue for 2.9
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

On 6 March 2017 at 08:03, Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> The following changes since commit 17783ac828adc694d986698d2d7014aedfeb48c6:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.9-20170303' into staging (2017-03-04 16:31:14 +0000)
>
> are available in the git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2017-03-06-tag
>
> for you to fetch changes up to ec72c0e271f2b13953079a4f4dadb49ac5910b54:
>
>   tests: check path to avoid a failing qga/get-vcpus test (2017-03-06 00:54:19 -0600)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for 2.9
>
> * fix fsfreeze for filesystems mounted in multiple locations
> * fix test failure when running in a chroot
> * support for socket-based activation
>
> ----------------------------------------------------------------
> Bruce Rogers (1):
>       tests: check path to avoid a failing qga/get-vcpus test
>
> Peter Lieven (1):
>       qga: ignore EBUSY when freezing a filesystem
>
> Stefan Hajnoczi (1):
>       qga: add systemd socket activation support
>
>  qga/channel-posix.c  | 68 ++++++++++++++++++++++++++---------------------
>  qga/channel-win32.c  |  2 +-
>  qga/channel.h        |  3 ++-
>  qga/commands-posix.c |  5 +++-
>  qga/main.c           | 74 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  tests/test-qga.c     |  4 ++-
>  6 files changed, 117 insertions(+), 39 deletions(-)
>

Applied, thanks.

-- PMM
