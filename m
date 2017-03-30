Received: from eggs.gnu.org ([2001:4830:134:3::10]:35021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctYWY-00023u-IP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ctYWX-0004LC-ML
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:45:54 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ctYWX-0004Km-A8
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 07:45:53 -0400
Received: by mail-wr0-x22c.google.com with SMTP id k6so51175486wre.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 04:45:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170328195206.2761-1-ehabkost@redhat.com>
References: <20170328195206.2761-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Mar 2017 12:45:31 +0100
Message-ID: <CAFEAcA887=Po4DtyB3-0vF0DzaCT7swfoah-xjf2BB=BGcWhiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] i386: Fix for "-cpu host, invtsc=on" bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 28 March 2017 at 20:52, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Last-minute fix for a bug found by Jiri Denemark. Unfortunately
> not in time for -rc2, but I would like to get this in -rc3.
>
> The following changes since commit df9046363220e57d45818312759b954c033c58ab:
>
>   Update version for v2.9.0-rc2 release (2017-03-28 19:11:16 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>
> for you to fetch changes up to d4a606b38b5d4b3689b86cc1575908e82179ecfb:
>
>   i386: Don't override -cpu options on -cpu host/max (2017-03-28 16:41:10 -0300)
>
> ----------------------------------------------------------------
> i386: Fix for "-cpu host,invtsc=on" bug
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (2):
>   i386: Replace uint32_t* with FeatureWord on feature getter/setter
>   i386: Don't override -cpu options on -cpu host/max
>
>  target/i386/cpu.h |  2 ++
>  target/i386/cpu.c | 32 ++++++++++++++++++++------------
>  2 files changed, 22 insertions(+), 12 deletions(-)

Applied, thanks.

-- PMM
