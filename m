Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dIG6F-00029U-9Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dIG6C-0008Nk-1h
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:08:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dIG6B-0008Mf-PM
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:08:47 -0400
Date: Tue, 6 Jun 2017 16:08:40 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170606150840.GH568@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170606150115.17264-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170606150115.17264-1-pbonzini@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, thuth@redhat.com, peter.maydell@linaro.org

On Tue, Jun 06, 2017 at 05:01:15PM +0200, Paolo Bonzini wrote:
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

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
