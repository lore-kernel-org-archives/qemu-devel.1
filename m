Received: from eggs.gnu.org ([2001:4830:134:3::10]:55242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIGV3-0003d0-NO
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIGUz-0003DD-Kd
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:34:29 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:35862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dIGUz-0003Ct-EE
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:34:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id c187so10261037oig.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 08:34:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170606150115.17264-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6707bbad-8921-4612-928c-6c9fbc496d84@amsat.org>
Date: Tue, 6 Jun 2017 12:34:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170606150115.17264-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, stefanha@redhat.com

Very good idea!

On 06/06/2017 12:01 PM, Paolo Bonzini wrote:
> Developer documentation should be its own manual.  As a start, move all
> developer-oriented files to a separate directory.
>
> Also move non-text files to their own directories: docs/config/ for
> QEMU -readconfig input, and docs/spin/ for formal models to be used
> with the SPIN model checker.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
>  rename docs/{ => config}/ich9-ehci-uhci.cfg (100%)
>  rename docs/{ => config}/mach-virt-graphical.cfg (100%)
>  rename docs/{ => config}/mach-virt-serial.cfg (100%)
>  rename docs/{ => config}/q35-emulated.cfg (100%)
>  rename docs/{ => config}/q35-virtio-graphical.cfg (100%)
>  rename docs/{ => config}/q35-virtio-serial.cfg (100%)
>  rename docs/{ => devel}/atomics.txt (100%)
>  rename docs/{ => devel}/bitmaps.md (100%)
>  rename docs/{ => devel}/blkdebug.txt (100%)
>  rename docs/{ => devel}/blkverify.txt (100%)
>  rename docs/{ => devel}/build-system.txt (100%)
>  rename docs/{ => devel}/lockcnt.txt (100%)
>  rename docs/{ => devel}/memory.txt (100%)
>  rename docs/{ => devel}/migration.txt (100%)
>  rename docs/{ => devel}/multi-thread-tcg.txt (100%)
>  rename docs/{ => devel}/multiple-iothreads.txt (100%)
>  rename docs/{ => devel}/qapi-code-gen.txt (100%)
>  rename docs/{ => devel}/rcu.txt (100%)
>  rename docs/{ => devel}/tracing.txt (100%)
>  rename docs/{ => devel}/virtio-migration.txt (100%)
>  rename docs/{ => devel}/writing-qmp-commands.txt (100%)
>  rename docs/{ => spin}/aio_notify.promela (100%)
>  rename docs/{ => spin}/aio_notify_accept.promela (100%)
>  rename docs/{ => spin}/aio_notify_bug.promela (100%)
>  rename docs/{ => spin}/tcg-exclusive.promela (100%)
>  rename docs/{ => spin}/win32-qemu-event.promela (100%)
>
> diff --git a/docs/ich9-ehci-uhci.cfg b/docs/config/ich9-ehci-uhci.cfg
> similarity index 100%
> rename from docs/ich9-ehci-uhci.cfg
> rename to docs/config/ich9-ehci-uhci.cfg
> diff --git a/docs/mach-virt-graphical.cfg b/docs/config/mach-virt-graphical.cfg
> similarity index 100%
> rename from docs/mach-virt-graphical.cfg
> rename to docs/config/mach-virt-graphical.cfg
> diff --git a/docs/mach-virt-serial.cfg b/docs/config/mach-virt-serial.cfg
> similarity index 100%
> rename from docs/mach-virt-serial.cfg
> rename to docs/config/mach-virt-serial.cfg
> diff --git a/docs/q35-emulated.cfg b/docs/config/q35-emulated.cfg
> similarity index 100%
> rename from docs/q35-emulated.cfg
> rename to docs/config/q35-emulated.cfg
> diff --git a/docs/q35-virtio-graphical.cfg b/docs/config/q35-virtio-graphical.cfg
> similarity index 100%
> rename from docs/q35-virtio-graphical.cfg
> rename to docs/config/q35-virtio-graphical.cfg
> diff --git a/docs/q35-virtio-serial.cfg b/docs/config/q35-virtio-serial.cfg
> similarity index 100%
> rename from docs/q35-virtio-serial.cfg
> rename to docs/config/q35-virtio-serial.cfg
> diff --git a/docs/atomics.txt b/docs/devel/atomics.txt
> similarity index 100%
> rename from docs/atomics.txt
> rename to docs/devel/atomics.txt
> diff --git a/docs/bitmaps.md b/docs/devel/bitmaps.md
> similarity index 100%
> rename from docs/bitmaps.md
> rename to docs/devel/bitmaps.md
> diff --git a/docs/blkdebug.txt b/docs/devel/blkdebug.txt
> similarity index 100%
> rename from docs/blkdebug.txt
> rename to docs/devel/blkdebug.txt
> diff --git a/docs/blkverify.txt b/docs/devel/blkverify.txt
> similarity index 100%
> rename from docs/blkverify.txt
> rename to docs/devel/blkverify.txt
> diff --git a/docs/build-system.txt b/docs/devel/build-system.txt
> similarity index 100%
> rename from docs/build-system.txt
> rename to docs/devel/build-system.txt
> diff --git a/docs/lockcnt.txt b/docs/devel/lockcnt.txt
> similarity index 100%
> rename from docs/lockcnt.txt
> rename to docs/devel/lockcnt.txt
> diff --git a/docs/memory.txt b/docs/devel/memory.txt
> similarity index 100%
> rename from docs/memory.txt
> rename to docs/devel/memory.txt
> diff --git a/docs/migration.txt b/docs/devel/migration.txt
> similarity index 100%
> rename from docs/migration.txt
> rename to docs/devel/migration.txt
> diff --git a/docs/multi-thread-tcg.txt b/docs/devel/multi-thread-tcg.txt
> similarity index 100%
> rename from docs/multi-thread-tcg.txt
> rename to docs/devel/multi-thread-tcg.txt
> diff --git a/docs/multiple-iothreads.txt b/docs/devel/multiple-iothreads.txt
> similarity index 100%
> rename from docs/multiple-iothreads.txt
> rename to docs/devel/multiple-iothreads.txt
> diff --git a/docs/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> similarity index 100%
> rename from docs/qapi-code-gen.txt
> rename to docs/devel/qapi-code-gen.txt
> diff --git a/docs/rcu.txt b/docs/devel/rcu.txt
> similarity index 100%
> rename from docs/rcu.txt
> rename to docs/devel/rcu.txt
> diff --git a/docs/tracing.txt b/docs/devel/tracing.txt
> similarity index 100%
> rename from docs/tracing.txt
> rename to docs/devel/tracing.txt
> diff --git a/docs/virtio-migration.txt b/docs/devel/virtio-migration.txt
> similarity index 100%
> rename from docs/virtio-migration.txt
> rename to docs/devel/virtio-migration.txt
> diff --git a/docs/writing-qmp-commands.txt b/docs/devel/writing-qmp-commands.txt
> similarity index 100%
> rename from docs/writing-qmp-commands.txt
> rename to docs/devel/writing-qmp-commands.txt
> diff --git a/docs/aio_notify.promela b/docs/spin/aio_notify.promela
> similarity index 100%
> rename from docs/aio_notify.promela
> rename to docs/spin/aio_notify.promela
> diff --git a/docs/aio_notify_accept.promela b/docs/spin/aio_notify_accept.promela
> similarity index 100%
> rename from docs/aio_notify_accept.promela
> rename to docs/spin/aio_notify_accept.promela
> diff --git a/docs/aio_notify_bug.promela b/docs/spin/aio_notify_bug.promela
> similarity index 100%
> rename from docs/aio_notify_bug.promela
> rename to docs/spin/aio_notify_bug.promela
> diff --git a/docs/tcg-exclusive.promela b/docs/spin/tcg-exclusive.promela
> similarity index 100%
> rename from docs/tcg-exclusive.promela
> rename to docs/spin/tcg-exclusive.promela
> diff --git a/docs/win32-qemu-event.promela b/docs/spin/win32-qemu-event.promela
> similarity index 100%
> rename from docs/win32-qemu-event.promela
> rename to docs/spin/win32-qemu-event.promela
>
