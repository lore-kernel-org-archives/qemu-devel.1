Received: from eggs.gnu.org ([2001:4830:134:3::10]:37771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW6ih-0000Dc-Gm
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW6ig-0003OT-Jd
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:25:31 -0500
Received: from mail-vk0-x230.google.com ([2607:f8b0:400c:c05::230]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW6ig-0003OP-FB
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:25:30 -0500
Received: by mail-vk0-x230.google.com with SMTP id r136so119158565vke.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 11:25:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
References: <20170124150823.30162-1-cornelia.huck@de.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 19:25:08 +0000
Message-ID: <CAFEAcA-eqcoJ91w4Y4-kGfe0uB8UZ_h0A20WJU-ft8hPbX15Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] s390x fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 24 January 2017 at 15:08, Cornelia Huck <cornelia.huck@de.ibm.com> wrote:
> The following changes since commit 48cef39bf39846ce4aaf79d4a2ae620373b3e181:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20170123' into staging (2017-01-24 09:52:42 +0000)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170124
>
> for you to fetch changes up to 0cf4d747cb8d053e6a6161aadfd3531fa1a62be1:
>
>   s390x/kvm: fix cmma reset for KVM (2017-01-24 15:47:31 +0100)
>
> ----------------------------------------------------------------
> Two s390x fixes: One for the kvm.c build failure, and one for a bug
> that might cause random guest crashes with zeroed out pages on host
> kernels with working cmma (< 4.6 and likely >= 4.10).
>
> ----------------------------------------------------------------
>
> Christian Borntraeger (1):
>   s390x/kvm: fix cmma reset for KVM
>
> Cornelia Huck (1):
>   s390x/kvm: include hw_accel.h instead of kvm.h
>
>  target/s390x/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
