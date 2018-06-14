Received: from eggs.gnu.org ([2001:4830:134:3::10]:37160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTXB7-0005Fx-Mt
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTXB3-000806-QR
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:41:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTXB3-0007zw-Ju
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:40:57 -0400
Date: Thu, 14 Jun 2018 15:40:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180614184051.GW7451@localhost.localdomain>
References: <1528939107-17193-1-git-send-email-babu.moger@amd.com>
	<1528939107-17193-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528939107-17193-4-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v14 3/6] i386: Disable TOPOEXT feature on
 pc-2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Wed, Jun 13, 2018 at 09:18:24PM -0400, Babu Moger wrote:
> Disable TOPOEXT feature for older machines.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/pc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 04d1f8c..ecccf6b 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -303,6 +303,10 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = TYPE_X86_CPU,\
>          .property = "legacy-cache",\
>          .value    = "on",\
> +    },{\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "topoext",\
> +        .value    = "off",\
>      },

This is OK, if combined with the first hunks of patch 2/6.

-- 
Eduardo
