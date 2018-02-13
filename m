Received: from eggs.gnu.org ([2001:4830:134:3::10]:34181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elbih-000694-9N
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:38:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elbig-0001Jx-Ck
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:38:07 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:46635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elbig-0001J4-8B
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 09:38:06 -0500
Received: by mail-oi0-x233.google.com with SMTP id x21so14001782oie.13
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 06:38:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
References: <1518523252-49106-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 14:37:45 +0000
Message-ID: <CAFEAcA9ENQR7k9G95X_N6B5NzAam0OfQeA_XnO4t-R-LCyhn0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/48] Misc patches for 2018-02-13
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

On 13 February 2018 at 12:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 7d848450b6e2a3e14a776b4c93704710e7f3d233:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180212' into staging (2018-02-12 14:52:48 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ef07edfd51c4bf375a3185c8a263dd89f2b5b9db:
>
>   travis: use libgcc-4.8-dev (libgcc-6-dev is not available on Ubuntu 14.04) (2018-02-13 11:44:15 +0100)
>
> ----------------------------------------------------------------
> * CAN bus (will be under network maintainner)
> * scsi-block opblockers (myself)
> * Dirty log bitmap cleanup (myself)
> * SDHCI improvements and tests (Philippe)
> * HAX support for larger guest sizese (Yu Ning)
>

Hi. This fails tests on Linux/ppc64, Linux/s390x
and Linux/sparc:

TEST: tests/sdhci-test... (pid=63141)
  /x86_64/sdhci/pc:                                                    **
ERROR:/home/pm215/qemu/tests/sdhci-test.c:118:check_specs_version:
assertion failed (v == version): (1 == 2)
FAIL
GTester: last random seed: R02Sfc2909dc6cf031163b43c8bd23c9b9e3
(pid=63154)
FAIL: tests/sdhci-test

Given the set of failing hosts I suspect an endianness bug.

thanks
-- PMM
