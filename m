Received: from eggs.gnu.org ([209.51.188.92]:40332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMUd5-0001qi-T9
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMUd4-0004sJ-MF
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:37:19 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMUd4-0004rW-Af
	for qemu-devel@nongnu.org; Fri, 03 May 2019 05:37:18 -0400
Received: by mail-ot1-x332.google.com with SMTP id g24so4753510otq.2
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 02:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190502161310.15624-1-thuth@redhat.com>
In-Reply-To: <20190502161310.15624-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 10:37:05 +0100
Message-ID: <CAFEAcA_yHdQrEQaee2+gcdhGS8XYm7srrh2y43aGwgFtdrdzXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] qtest and misc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>, Eduardo Otubo <otubo@redhat.com>

On Thu, 2 May 2019 at 17:13, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-02
>
> for you to fetch changes up to aff39be0ed9753c9c323f64a14f5533dd5c43525:
>
>   hw/pci-host: Use object_initialize_child for correct reference counting (2019-05-02 16:56:33 +0200)
>
> ----------------------------------------------------------------
> - Move qtest accel code to accel/qtest.c, get rid of AccelClass->available
> - Test TCG interpreter in gitlab-ci
> - Small improvements to the configure script
> - Use object_initialize_child in hw/pci-host
> ----------------------------------------------------------------
>
> Eduardo Habkost (3):
>       qtest: Move accel code to accel/qtest.c
>       qtest: Don't compile qtest accel on non-POSIX systems
>       accel: Remove unused AccelClass::available field
>
> Helge Deller (1):
>       configure: Relax check for libseccomp
>
> Thomas Huth (4):
>       gitlab-ci.yml: Test the TCG interpreter in a CI pipeline
>       configure: Add -Wno-typedef-redefinition to CFLAGS (for Clang)
>       configure: Remove old *-config-devices.mak.d files when running configure
>       hw/pci-host: Use object_initialize_child for correct reference counting


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
