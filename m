Received: from eggs.gnu.org ([2001:4830:134:3::10]:48820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fRzRP-0001q6-FU
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fRzRM-00080w-Ch
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:27:27 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:38235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fRzRM-00080m-4d
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 08:27:24 -0400
Received: by mail-wr0-x244.google.com with SMTP id e18-v6so9312139wrs.5
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 05:27:24 -0700 (PDT)
References: <20180608192940.19548-1-ehabkost@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <7b88043b-1eae-48b4-49e7-55491b200811@gmail.com>
Date: Sun, 10 Jun 2018 15:27:20 +0300
MIME-Version: 1.0
In-Reply-To: <20180608192940.19548-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] pc: Remove PC_COMPAT_2_12 from 3.0
 machine-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Babu Moger <babu.moger@amd.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Juan Quintela <quintela@redhat.com>



On 06/08/2018 10:29 PM, Eduardo Habkost wrote:
> commit f548222c added PC_COMPAT_2_12 to the 3.0 PC machine-types.
> I believe this happened during manual conflict resolution when
> applying the patch.
>
> Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Fixes: f548222c24342ca74689de7794f9006b43f86a54
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>   hw/i386/pc_piix.c | 1 -
>   hw/i386/pc_q35.c  | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3d81136065..b4c5b03274 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -430,7 +430,6 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
>       pc_i440fx_machine_options(m);
>       m->alias = "pc";
>       m->is_default = 1;
> -    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>   }
>   
>   DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index b60cbb9266..83d6d75efa 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -312,7 +312,6 @@ static void pc_q35_3_0_machine_options(MachineClass *m)
>   {
>       pc_q35_machine_options(m);
>       m->alias = "q35";
> -    SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
>   }
>   
>   DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
