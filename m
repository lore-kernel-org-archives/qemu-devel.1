Received: from eggs.gnu.org ([2001:4830:134:3::10]:51714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIGNO-0004Rr-Bd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIGNK-0008HF-K0
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dIGNK-0008H7-Dg
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:30 -0400
References: <20170606150115.17264-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e1b46b93-b3b7-baab-c387-aa71baef832e@redhat.com>
Date: Tue, 6 Jun 2017 17:26:22 +0200
MIME-Version: 1.0
In-Reply-To: <20170606150115.17264-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] docs: create config/,
 devel/ and spin/ subdirectories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, peter.maydell@linaro.org, berrange@redhat.com

On 06.06.2017 17:01, Paolo Bonzini wrote:
> Developer documentation should be its own manual.  As a start, move all
> developer-oriented files to a separate directory.
> 
> Also move non-text files to their own directories: docs/config/ for
> QEMU -readconfig input, and docs/spin/ for formal models to be used
> with the SPIN model checker.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/{ => config}/ich9-ehci-uhci.cfg       | 0
>  docs/{ => config}/mach-virt-graphical.cfg  | 0
>  docs/{ => config}/mach-virt-serial.cfg     | 0
>  docs/{ => config}/q35-emulated.cfg         | 0
>  docs/{ => config}/q35-virtio-graphical.cfg | 0
>  docs/{ => config}/q35-virtio-serial.cfg    | 0
>  docs/{ => devel}/atomics.txt               | 0
>  docs/{ => devel}/bitmaps.md                | 0
>  docs/{ => devel}/blkdebug.txt              | 0
>  docs/{ => devel}/blkverify.txt             | 0
>  docs/{ => devel}/build-system.txt          | 0
>  docs/{ => devel}/lockcnt.txt               | 0
>  docs/{ => devel}/memory.txt                | 0
>  docs/{ => devel}/migration.txt             | 0
>  docs/{ => devel}/multi-thread-tcg.txt      | 0
>  docs/{ => devel}/multiple-iothreads.txt    | 0
>  docs/{ => devel}/qapi-code-gen.txt         | 0
>  docs/{ => devel}/rcu.txt                   | 0
>  docs/{ => devel}/tracing.txt               | 0
>  docs/{ => devel}/virtio-migration.txt      | 0
>  docs/{ => devel}/writing-qmp-commands.txt  | 0
>  docs/{ => spin}/aio_notify.promela         | 0
>  docs/{ => spin}/aio_notify_accept.promela  | 0
>  docs/{ => spin}/aio_notify_bug.promela     | 0
>  docs/{ => spin}/tcg-exclusive.promela      | 0
>  docs/{ => spin}/win32-qemu-event.promela   | 0
>  26 files changed, 0 insertions(+), 0 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
