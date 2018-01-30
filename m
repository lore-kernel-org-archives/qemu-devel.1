Received: from eggs.gnu.org ([2001:4830:134:3::10]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1egdxX-0007i0-40
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1egdwT-0000qW-56
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 17:00:55 -0500
Received: from mail-co1nam03on0086.outbound.protection.outlook.com
	([104.47.40.86]:13099
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1egdwS-0000nn-Dl
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 16:59:48 -0500
Date: Wed, 31 Jan 2018 04:59:36 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180130215936.GB7547@toto>
References: <20180129174132.108925-1-brijesh.singh@amd.com>
	<20180129174132.108925-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180129174132.108925-2-brijesh.singh@amd.com>
Subject: Re: [Qemu-devel] [PATCH v6 01/23] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <Thomas.Lendacky@amd.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
	Berrange" <berrange@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>

On Mon, Jan 29, 2018 at 11:41:10AM -0600, Brijesh Singh wrote:
> Extend the MemTxAttrs to include 'debug' flag. The flag can be used as
> general indicator that operation was triggered by the debugger.
> 
> Later in the patch series we set the debug=1 when issuing a memory access
> from the gdbstub or HMP commands. This patch is prerequisite to support
> debugging the encrypted guest. If we see request with debug=1 then we
> will need to use encryption APIs to access the guest memory.
> 
> Cc: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  include/exec/memattrs.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index d4a16420984b..08099e4f7e72 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
>      unsigned int user:1;
>      /* Requester ID (for MSI for example) */
>      unsigned int requester_id:16;
> +    /* Memory access request from the debugger */
> +    unsigned int debug:1;
>  } MemTxAttrs;
>  
>  /* Bus masters which don't specify any attributes will get this,
> -- 
> 2.9.5
> 
