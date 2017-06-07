Received: from eggs.gnu.org ([2001:4830:134:3::10]:37509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIchU-0002Va-0s
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIchT-0007L1-21
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:16:47 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:33383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIchS-0007Kk-RH
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 11:16:46 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m7so33759974wmg.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 08:16:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170607135511.1312-1-pbonzini@redhat.com>
References: <20170607135511.1312-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 16:16:25 +0100
Message-ID: <CAFEAcA-1a5f7g=6+xwyVFHzSABLUnPYVj_zR1Nn5-yeyOiEAjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v4 00/33] Misc patches for 2017-06-01
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

On 7 June 2017 at 14:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 1f09d49f581f313d374edd2a14f0ce9a825d9556:
>
>   docs: create config/, devel/ and spin/ subdirectories (2017-06-07 15:39:06 +0200)
>
> ----------------------------------------------------------------
> * virtio-scsi use-after-free fix (Fam)
> * vhost-user-scsi support (Felipe)
> * SMM fixes and improvements for TCG (myself, Mihail)
> * irqchip and AddressSpaceDispatch cleanups and fixes (Peter)
> * Coverity fix (Stefano)
> * NBD cleanups and fixes (Vladimir, Eric, myself)
> * RTC accuracy improvements and code cleanups (Guangrong+Yunfang)
> * socket error reporting improvement (Daniel)
> * GDB XML description for SSE registers (Abdallah)
> * kvmclock update fix (Denis)
> * SMM memory savings (Gonglei)
> * -cpu 486 fix (myself)
> * various bugfixes (Roman, Peter, myself, Thomas)
> * rtc-test improvement (Guangrong)
> * migration throttling fix (Felipe)
> * create docs/ subdirectories (myself)
>
> ----------------------------------------------------------------

Fails to build: vhost-user-scsi.c still trying to use the
no-longer-present register_savevm function.

thanks
-- PMM
