Received: from eggs.gnu.org ([2001:4830:134:3::10]:56042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dafQH-0006Ge-V6
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dafQH-00034Z-2Z
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:49:37 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:38785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dafQG-00032P-RE
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:49:37 -0400
Received: by mail-wr0-x229.google.com with SMTP id f21so84973263wrf.5
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 02:49:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726183646.14088-1-ehabkost@redhat.com>
References: <20170726183646.14088-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 10:49:15 +0100
Message-ID: <CAFEAcA_6dLVE0Vac0cM429Fnz=F9ndQ7=dBzv1Z52SHN_odS_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] x86 bug fix for -rc1
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

On 26 July 2017 at 19:36, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 522fd24ca030c27c591dafedd65c1dfd51e40450:
>
>   Update version for v2.10.0-rc0 release (2017-07-25 17:13:09 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>
> for you to fetch changes up to bd1820227ecc0c77cc2aeba7c7c25b2d0a72ff3c:
>
>   target/i386: Don't use x86_cpu_load_def() on "max" CPU model (2017-07-26 14:55:12 -0300)
>
> ----------------------------------------------------------------
> x86 bug fix for -rc1
>
> Fix for a bug in "-cpu max" that breaks libvirt usage of
> query-cpu-model-expansion.
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (3):
>   target/i386: Use host_vendor_fms() in max_x86_cpu_initfn()
>   target/i386: Define CPUID_MODEL_ID_SZ macro
>   target/i386: Don't use x86_cpu_load_def() on "max" CPU model
>
>  target/i386/cpu.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
>

Applied, thanks.

-- PMM
