Received: from eggs.gnu.org ([2001:4830:134:3::10]:54732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1faMtt-0006R4-7j
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1faMto-0002db-QE
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:07:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1faMto-0002dK-KZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:07:24 -0400
Date: Tue, 3 Jul 2018 17:07:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180703170720.72a210b2@redhat.com>
In-Reply-To: <20180703011026.18650-1-ehabkost@redhat.com>
References: <20180703011026.18650-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc: Fix typo on PC_COMPAT_2_12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Mon,  2 Jul 2018 22:10:26 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> I forgot a hyphen when amending the compat code on commit
> e0051647 ("i386: Enable TOPOEXT feature on AMD EPYC CPU").
> 
> Fixes: e00516475c270dcb6705753da96063f95699abf2
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Bug detected by compat_checker:
> https://github.com/ehabkost/gdb-qemu
> ---
>  include/hw/i386/pc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 4d99d69681..654003f44c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -309,7 +309,7 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .property = "xlevel",\
>          .value    = stringify(0x8000000a),\
>      },{\
> -        .driver   = "EPYC-IBPB" TYPE_X86_CPU,\
> +        .driver   = "EPYC-IBPB-" TYPE_X86_CPU,\
>          .property = "xlevel",\
>          .value    = stringify(0x8000000a),\
>      },

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
