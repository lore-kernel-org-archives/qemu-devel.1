Received: from eggs.gnu.org ([209.51.188.92]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj7u1-0002BP-I3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:28:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj7u0-0005Eg-LC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:28:05 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:36287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj7tx-00056P-RC
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 14:28:03 -0500
Received: by mail-ot1-x32c.google.com with SMTP id k98so191655otk.3
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 11:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20190114143432.4771-1-ehabkost@redhat.com>
In-Reply-To: <20190114143432.4771-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 19:27:47 +0000
Message-ID: <CAFEAcA_Yq9nD8UgBzXc3tuHhpG6og9eVRHC8_83HNFn9EjqrNA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] x86 queue, 2019-01-14
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, 14 Jan 2019 at 14:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 7260438b7056469610ee166f7abe9ff8a26b8b16:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/riscv-for-master-3.2-part2' into staging (2019-01-14 11:41:43 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to abd5fc4c862d033a989552914149f01c9476bb16:
>
>   i386/kvm: add a comment explaining why .feat_names are commented out for Hyper-V feature bits (2019-01-14 12:28:44 -0200)
>
> ----------------------------------------------------------------
> x86 queue, 2019-01-14
>
> * Reenable RDTSCP support on Opteron_G[345] CPU models CPU models
>   (Borislav Petkov)
> * host-phys-bits-limit option for better control of 5-level EPT
>   (Eduardo Habkost)
> * Disable MPX support on named CPU models (Paolo Bonzini)
> * expose HV_CPUID_ENLIGHTMENT_INFO.EAX and HV_CPUID_NESTED_FEATURES.EAX
>   as feature words (Vitaly Kuznetsov)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
