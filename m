Received: from eggs.gnu.org ([2001:4830:134:3::10]:56862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL44i-000108-3F
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL44h-0004g3-3B
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:59:24 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL44g-0004fR-To
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:59:23 -0400
Received: by mail-ot0-x241.google.com with SMTP id t1-v6so20240696oth.8
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 02:59:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180521220133.17445-1-ehabkost@redhat.com>
References: <20180521220133.17445-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 10:59:01 +0100
Message-ID: <CAFEAcA--+k0aNAV+jzCPW3wx_dOuETEkrwu7HBYgA9TP8te44g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Speculative store buffer bypass
 mitigation (CVE-2018-3639)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

On 21 May 2018 at 23:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> This provides the QEMU part of the mitigations for the speculative
> store buffer bypass vulnerabilities on the x86 platform[1], and is
> the companion of the kernel patches merged in:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3b78ce4a34b761c7fe13520de822984019ff1a8f
>
> [1] https://bugs.chromium.org/p/project-zero/issues/detail?id=1528
>     https://access.redhat.com/security/vulnerabilities/ssbd
>
> The following changes since commit 9802316ed6c19fd45b4c498523df02ca370d0586:
>
>   Merge remote-tracking branch 'remotes/mjt/tags/trivial-patches-fetch' into staging (2018-05-21 10:50:32 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 403503b162ffc33fb64cfefdf7b880acf41772cd:
>
>   i386: define the AMD 'virt-ssbd' CPUID feature bit (CVE-2018-3639) (2018-05-21 18:59:08 -0300)
>
> ----------------------------------------------------------------
> Speculative store buffer bypass mitigation (CVE-2018-3639)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
