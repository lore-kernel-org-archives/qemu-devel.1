Received: from eggs.gnu.org ([2001:4830:134:3::10]:58871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH67s-0007Pb-6A
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH67q-0007ht-Q0
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:54:32 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH67q-0007bz-EL
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:54:30 -0400
Received: by mail-oi1-x243.google.com with SMTP id k19-v6so6742185oic.11
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:54:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 11:54:06 +0000
Message-ID: <CAFEAcA-8sN2MGK6OcK5uMbMuw33MMOAgsdr9y4Uj2qmpbTkeig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/20] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, Jason Wang <jasowang@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>

On 26 October 2018 at 16:31, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99cf2:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf0' into staging (2018-10-25 17:41:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-patches-pull-request
>
> for you to fetch changes up to 4b03da6e87c34793137a231b558231fd406c05e8:
>
>   ppc: move at24c to its own CONFIG_ symbol (2018-10-26 17:17:32 +0200)
>
> ----------------------------------------------------------------
> QEMU trivial patches collected between June and October 2018
> (Thank you to Thomas Huth)
>
> ----------------------------------------------------------------

Hi; I get a compile error due to a format string issue:

In file included from
/home/petmay01/qemu-for-merges/hw/net/milkymist-minimac2.c:33:0:
/home/petmay01/qemu-for-merges/hw/net/milkymist-minimac2.c: In
function 'minimac2_write':
/home/petmay01/qemu-for-merges/hw/net/milkymist-minimac2.c:420:23:
error: format '%lx' expects
 argument of type 'long unsigned int', but argument 4 has type
'uint64_t {aka long long unsign
ed int}' [-Werror=format=]
                       "milkymist_minimac2_wr%d: 0x%" HWADDR_PRIx " = 0x%lx\n",
                       ^
/home/petmay01/qemu-for-merges/include/qemu/log.h:85:22: note: in
definition of macro 'qemu_lo
g_mask'
             qemu_log(FMT, ## __VA_ARGS__);              \
                      ^
cc1: all warnings being treated as errors

(affects windows crossbuilds, OSX and 32-bit hosts).

thanks
-- PMM
