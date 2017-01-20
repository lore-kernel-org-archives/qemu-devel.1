Received: from eggs.gnu.org ([2001:4830:134:3::10]:40218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUYLp-0007oO-TB
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:31:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUYLp-0007uP-8H
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:31:29 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:33485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUYLo-0007u2-QR
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 07:31:29 -0500
Received: by mail-vk0-x235.google.com with SMTP id k127so50333845vke.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 04:31:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484914681-2986-1-git-send-email-thuth@redhat.com>
References: <1484914681-2986-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 12:31:07 +0000
Message-ID: <CAFEAcA-fY53-z2awJ_e9738A+MNgYiaVQEn=xJkWn3Xj60nCMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Introduce DEVICE_CATEGORY_CPU for CPU
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 20 January 2017 at 12:18, Thomas Huth <thuth@redhat.com> wrote:
> Now that the hot-pluggable CPUs show up in the help text of
> "-device ?", we should group them into an appropriate category.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/ppc/pnv_core.c       | 1 +
>  hw/ppc/spapr_cpu_core.c | 1 +
>  include/hw/qdev-core.h  | 1 +
>  qdev-monitor.c          | 1 +
>  target/i386/cpu.c       | 2 ++
>  5 files changed, 6 insertions(+)

Can we just set the category bit in the class init functions
for the TYPE_CPU and TYPE_CPU_CORE superclasses, rather
than having to do it in a subclass for each architecture
(and thus potentially forgetting to do it for other archs) ?

thanks
-- PMM
