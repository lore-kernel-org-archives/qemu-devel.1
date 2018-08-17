Received: from eggs.gnu.org ([2001:4830:134:3::10]:55477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqdG4-0007ci-8i
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:49:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqdG3-0001j5-I0
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:49:36 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqdG3-0001iD-58
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 07:49:35 -0400
Received: by mail-oi0-x242.google.com with SMTP id n21-v6so13499782oig.3
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 04:49:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180817013400.13353-1-ehabkost@redhat.com>
References: <20180817013400.13353-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 12:49:13 +0100
Message-ID: <CAFEAcA8mvriW3AVrH4Bqt99e6ErYt3KPLoY2qNM41Zjfjwv_tw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-08-16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 17 August 2018 at 02:33, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit bb16c0412a572c2c9cd44496deb3ad430bc49c1a:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20180816' into staging (2018-08-16 14:35:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 7210a02c58572b2686a3a8d610c6628f87864aed:
>
>   i386: Disable TOPOEXT by default on "-cpu host" (2018-08-16 13:43:01 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2018-08-16
>
> Bug fix:
> * Some guests may crash when using "-cpu host" due to TOPOEXT,
>   disable it by default
>
> Features:
> * PV_SEND_IPI feature bit
> * Icelake-{Server,Client} CPU models
> * New CPUID feature bits: PV_SEND_IPI, WBNOINVD, PCONFIG, ARCH_CAPABILITIES
>
> Documentation:
> * docs/qemu-cpu-models.texi

Applied, thanks.

-- PMM
