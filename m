Received: from eggs.gnu.org ([2001:4830:134:3::10]:41688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cQui6-00045N-AY
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cQui5-0008R9-Dt
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:35:26 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:36177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cQui5-0008QW-76
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:35:25 -0500
Received: by mail-it0-x229.google.com with SMTP id c7so39310308itd.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 03:35:25 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <148404721690.208.4742704020877143303@790289a7ca88>
References: <cover.1484045952.git.vpalatin@chromium.org>
	<148404721690.208.4742704020877143303@790289a7ca88>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Tue, 10 Jan 2017 12:35:03 +0100
Message-ID: <CAP_ceTz3=9twm47Yw8h4Wv5KoXWO5Rfz5YvBtUTNjTeRvFaNaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Add HAX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: famz@redhat.com, Yu Ning <yu.ning@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 10, 2017 at 12:20 PM,  <no-reply@patchew.org> wrote:
> Hi,
>
> Your series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
[...]
> /tmp/qemu-test/src/target/i386/hax-mem.c:268:33: error: unknown type name 'RAMBlockNotifier'
>  static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t size)
>                                  ^~~~~~~~~~~~~~~~
> /tmp/qemu-test/src/target/i386/hax-mem.c:281:15: error: variable 'hax_ram_notifier' has initializer but incomplete type
>  static struct RAMBlockNotifier hax_ram_notifier = {
>                ^~~~~~~~~~~~~~~~
> /tmp/qemu-test/src/target/i386/hax-mem.c:282:5: error: unknown field 'ram_block_added' specified in initializer
>      .ram_block_added = hax_ram_block_added,
>      ^
> /tmp/qemu-test/src/target/i386/hax-mem.c:282:24: error: 'hax_ram_block_added' undeclared here (not in a function)
>      .ram_block_added = hax_ram_block_added,
>                         ^~~~~~~~~~~~~~~~~~~
> /tmp/qemu-test/src/target/i386/hax-mem.c:282:24: error: excess elements in struct initializer [-Werror]
> /tmp/qemu-test/src/target/i386/hax-mem.c:282:24: note: (near initialization for 'hax_ram_notifier')
> /tmp/qemu-test/src/target/i386/hax-mem.c: In function 'hax_memory_init':
> /tmp/qemu-test/src/target/i386/hax-mem.c:287:5: error: implicit declaration of function 'ram_block_notifier_add' [-Werror=implicit-function-declaration]
>      ram_block_notifier_add(&hax_ram_notifier);
>      ^~~~~~~~~~~~~~~~~~~~~~
> /tmp/qemu-test/src/target/i386/hax-mem.c:287:5: error: nested extern declaration of 'ram_block_notifier_add' [-Werror=nested-externs]
> /tmp/qemu-test/src/target/i386/hax-mem.c: At top level:
> /tmp/qemu-test/src/target/i386/hax-mem.c:281:32: error: storage size of 'hax_ram_notifier' isn't known
>  static struct RAMBlockNotifier hax_ram_notifier = {
>                                 ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/rules.mak:64: recipe for target 'target/i386/hax-mem.o' failed

it failed on the dependency to the unsubmitted Paolo's ramblock-notifier patch.

-- 
Vincent
