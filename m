Received: from eggs.gnu.org ([2001:4830:134:3::10]:40271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4Vn-000873-2A
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:19:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fo4Vj-00026X-T6
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:19:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fo4Vj-00025v-MD
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 06:19:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so7788182wrt.11
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 03:19:11 -0700 (PDT)
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
Date: Fri, 10 Aug 2018 12:19:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180808114830.7169-3-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On 08/08/2018 13:48, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak       | 2 --
>  default-configs/arm-softmmu.mak         | 2 --
>  default-configs/hppa-softmmu.mak        | 3 ---
>  default-configs/i386-softmmu.mak        | 2 --
>  default-configs/mips-softmmu-common.mak | 2 --
>  default-configs/ppc-softmmu.mak         | 1 -
>  default-configs/ppcemb-softmmu.mak      | 2 --
>  default-configs/sh4-softmmu.mak         | 2 --
>  default-configs/sh4eb-softmmu.mak       | 2 --
>  default-configs/sparc64-softmmu.mak     | 2 --
>  default-configs/x86_64-softmmu.mak      | 2 --
>  11 files changed, 22 deletions(-)

I don't think CONFIG_SERIAL_ISA should be in pci.mak though, and
CONFIG_SERIAL is a dependency of both CONFIG_SERIAL and
CONFIG_SERIAL_PCI.  Perhaps introduce a superio.mak with all the legacy
ISA devices?

Paolo
