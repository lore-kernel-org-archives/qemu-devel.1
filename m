Received: from eggs.gnu.org ([2001:4830:134:3::10]:33219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3gfS-0003KJ-Ox
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f3gfR-0001hc-TX
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:33:30 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f3gfR-0001hQ-OK
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 07:33:29 -0400
Received: by mail-oi0-x244.google.com with SMTP id l190-v6so18898957oig.9
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 04:33:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180403140107.26125-1-ehabkost@redhat.com>
References: <20180403140107.26125-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Apr 2018 12:33:08 +0100
Message-ID: <CAFEAcA-41+=VjjcMnRo64bOHojPkPW+ooUAdjJvWc7oFPufbmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Fix memory leaks when using
 object_property_get_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 3 April 2018 at 15:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit f184de7553272223d6af731d7d623a7cebf710b5:
>
>   Merge remote-tracking branch 'remotes/riscv/tags/riscv-qemu-2.12-critical-fixes' into staging (2018-03-31 09:42:33 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 5d7bc72a4336f922ba42bab545529051c706ac4b:
>
>   sev/i386: fix memory leak in sev_guest_init() (2018-04-02 23:05:26 -0300)
>
> ----------------------------------------------------------------
> Fix memory leaks when using object_property_get_str()
>
> ----------------------------------------------------------------
>
> Greg Kurz (2):
>   exec: fix memory leak in find_max_supported_pagesize()
>   sev/i386: fix memory leak in sev_guest_init()
>
>  exec.c            | 1 +
>  target/i386/sev.c | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>

Applied, thanks.

-- PMM
