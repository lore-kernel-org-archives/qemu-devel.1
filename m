Received: from eggs.gnu.org ([2001:4830:134:3::10]:38732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW4Kn-0006Uw-CS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fW4Kk-0007hV-9V
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fW4Kk-0007hD-3M
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 14:29:26 -0400
Date: Thu, 21 Jun 2018 15:29:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180621182920.GW7451@localhost.localdomain>
References: <1529443919-67509-1-git-send-email-babu.moger@amd.com>
	<1529443919-67509-3-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529443919-67509-3-git-send-email-babu.moger@amd.com>
Subject: Re: [Qemu-devel] [PATCH v16 2/3] i386: Enable TOPOEXT feature on
 AMD EPYC CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Babu Moger <babu.moger@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, mtosatti@redhat.com, kvm@vger.kernel.org, kash@tripleback.net, geoff@hostfission.com

On Tue, Jun 19, 2018 at 05:31:58PM -0400, Babu Moger wrote:
> Enable TOPOEXT feature on EPYC CPU. This is required to support
> hyperthreading on VM guests. Also extend xlevel to 0x8000001E.
> 
> Disable topoext on PC_COMPAT_2_12 and keep xlevel 0x8000000a.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  include/hw/i386/pc.h |  8 ++++++++
>  target/i386/cpu.c    | 10 ++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index fc8dedc..d0ebeb9 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -303,6 +303,14 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>          .driver   = TYPE_X86_CPU,\
>          .property = "legacy-cache",\
>          .value    = "on",\
> +    },{\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "topoext",\
> +        .value    = "off",\
> +    },{\
> +        .driver   = "EPYC-" TYPE_X86_CPU,\
> +        .property = "xlevel",\
> +        .value    = stringify(0x8000000a),\
>      },

EPYC-IBPB is missing, I will add it when committing.  Thanks!

-- 
Eduardo
