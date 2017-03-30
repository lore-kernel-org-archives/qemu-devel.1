Received: from eggs.gnu.org ([2001:4830:134:3::10]:32872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ctWnG-0006GS-Lh
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:55:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1ctWnG-0008Kx-3F
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:55:02 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33077)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ctWnF-0008KJ-TI
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:55:02 -0400
Received: by mail-wr0-x244.google.com with SMTP id u18so10516274wrc.0
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 02:55:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170330050924.22134-1-iwona260909@gmail.com>
References: <20170330050924.22134-1-iwona260909@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 30 Mar 2017 10:55:00 +0100
Message-ID: <CAJSP0QUd_QfM0iChPvPov0+1BcnoPqQGLcnRxDe2mT2huC-qVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] hmp: fix "info cpu" segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Iwona Kotlarska <iwona260909@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, Mar 30, 2017 at 6:09 AM, Iwona Kotlarska <iwona260909@gmail.com> wrote:
> Running QEMU with "qemu-system-x86_64 -M none -nographic -m 256" and executing
> "dump-guest-memory /dev/null 0 8192" results in segfault.
> Fix by checking if we have CPU.
>
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>
> ---
>  target/i386/arch_dump.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
