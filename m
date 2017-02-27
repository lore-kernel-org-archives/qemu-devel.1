Received: from eggs.gnu.org ([2001:4830:134:3::10]:43150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciQmY-0003Di-Fd
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:16:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciQmX-0002YH-H7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:16:26 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciQmX-0002Xl-Af
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:16:25 -0500
Received: by mail-wr0-x22c.google.com with SMTP id u48so9278283wrc.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 11:16:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170227162501.29280-1-ehabkost@redhat.com>
References: <20170227162501.29280-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 19:16:03 +0000
Message-ID: <CAFEAcA8b_tdQAP6YVDRaZKzHLed5xKbfABtJUV0U43HpkTiBdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/11] x86 queue, 2017-02-27
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

On 27 February 2017 at 16:24, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit 3b1d8169844fafee184366b0e0d7080534758b4d:
>
>   tests-aio-multithread: use atomic_read properly (2017-02-27 12:54:08 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>
> for you to fetch changes up to b8097deb359bbbd92592b9670adfe9e245b2d0bd:
>
>   i386: Improve query-cpu-model-expansion full mode (2017-02-27 13:23:35 -0300)
>
> ----------------------------------------------------------------
> x86 queue, 2017-02-27
>
> "-cpu max" and query-cpu-model-expansion support for x86. This
> should be the last x86 pull request before 2.9 soft freeze.
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (11):
>   i386: Unset cannot_destroy_with_object_finalize_yet on "host" model
>   i386: Add ordering field to CPUClass
>   i386: Rename X86CPU::host_features to X86CPU::max_features
>   i386: Reorganize and document CPUID initialization steps
>   qapi-schema: Comment about full expansion of non-migration-safe models
>   i386: Create "max" CPU model
>   i386: Make "max" model not use any host CPUID info on TCG
>   i386: Don't set CPUClass::cpu_def on "max" model
>   i386: Define static "base" CPU model
>   i386: Implement query-cpu-model-expansion QMP command
>   i386: Improve query-cpu-model-expansion full mode

This seemed to hang in 'make check' on x86. I didn't have time to
investigate, so I'll have another go with it later.

thanks
-- PMM
