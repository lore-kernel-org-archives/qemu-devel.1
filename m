Received: from eggs.gnu.org ([209.51.188.92]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFxrd-0006tb-Qs
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFxrc-0007M1-Pq
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:25:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hFxra-0007Jn-7S
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 05:25:18 -0400
Date: Mon, 15 Apr 2019 10:25:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190415092500.GD5718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1555124080-27089-1-git-send-email-puwen@hygon.cn>
Subject: Re: [Qemu-devel] [PATCH v2] i386: Add new Hygon 'Dhyana' CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pu Wen <puwen@hygon.cn>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com

On Sat, Apr 13, 2019 at 10:54:40AM +0800, Pu Wen wrote:
> Add a new base CPU model called 'Dhyana' to model processors from Hygon
> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
> 
> The following features bits have been removed compare to AMD EPYC:
> aes, pclmulqdq, sha_ni
> 
> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> CPU model.
> 
> Reference:
> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
> 
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
> v1->v2:
>   - Remove CPU model 'Dhyana' and rename the CPU model 'Dhyana-IBPB' to
>     'Dhyana' because Dhyana CPUs already have the IBPB feature.
> 
>  hw/i386/pc.c      |  3 +++
>  target/i386/cpu.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h |  2 ++
>  3 files changed, 55 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f2c15bf..551bec9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -128,6 +128,8 @@ GlobalProperty pc_compat_3_1[] = {
>      { "EPYC" "-" TYPE_X86_CPU, "nrip-save", "off" },
>      { "EPYC-IBPB" "-" TYPE_X86_CPU, "npt", "off" },
>      { "EPYC-IBPB" "-" TYPE_X86_CPU, "nrip-save", "off" },
> +    { "Dhyana" "-" TYPE_X86_CPU, "npt", "off" },
> +    { "Dhyana" "-" TYPE_X86_CPU, "nrip-save", "off" },
>      { "Skylake-Client" "-" TYPE_X86_CPU,      "mpx", "on" },
>      { "Skylake-Client-IBRS" "-" TYPE_X86_CPU, "mpx", "on" },
>      { "Skylake-Server" "-" TYPE_X86_CPU,      "mpx", "on" },
> @@ -152,6 +154,7 @@ GlobalProperty pc_compat_2_12[] = {
>      { TYPE_X86_CPU, "topoext", "off" },
>      { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>      { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
> +    { "Dhyana-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
>  };
>  const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);

You can drop the changes in this file. This CPU model didn't exist
in any older QEMU releases, so there's no machine type backcompat
required, at least from upstream QEMU POV.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
