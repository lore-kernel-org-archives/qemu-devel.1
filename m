Received: from eggs.gnu.org ([2001:4830:134:3::10]:33176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cw4lu-0007kI-Li
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cw4lt-0001fv-RR
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:36:10 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cw4lt-0001fn-Jk
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:36:09 -0400
Received: by mail-wr0-x22e.google.com with SMTP id g19so10929065wrb.0
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 03:36:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170405152633.6824-1-pbonzini@redhat.com>
References: <20170405152633.6824-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Apr 2017 11:35:47 +0100
Message-ID: <CAFEAcA-dW=DB=V7ej6+_1-4m+5J5UOUwn7J-ZxvszQtiR-L_6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] PC fix for 2.9.0-rc4
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

On 5 April 2017 at 16:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 87cc4c61020addea6a001b94b662596b1896d1b3:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-04-04 11:40:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 8c9f42f3cf3598e8bb612b3f81cd12632efd3ca4:
>
>   tco: do not generate an NMI (2017-04-05 17:23:52 +0200)
>
> ----------------------------------------------------------------
> * TCO watchdog fix
>
> ----------------------------------------------------------------
> Paolo Bonzini (1):
>       tco: do not generate an NMI
>
>  hw/acpi/tco.c          | 2 --
>  hw/isa/lpc_ich9.c      | 5 -----
>  include/hw/i386/ich9.h | 1 -
>  3 files changed, 8 deletions(-)

Applied, thanks.

-- PMM
