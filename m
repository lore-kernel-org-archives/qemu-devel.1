Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1svO-000526-H9
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e1svL-0003uX-Ck
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1e1svL-0003sl-6E
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:42:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1952025786
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:42:08 +0000 (UTC)
Date: Tue, 10 Oct 2017 13:42:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171010134204.135a9425@nial.brq.redhat.com>
In-Reply-To: <20171006132502.9191-1-ehabkost@redhat.com>
References: <20171006132502.9191-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] isapc: Remove unnecessary migration
 compatibility code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>

On Fri,  6 Oct 2017 10:25:02 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> We don't touch isapc when we change guest ABI and add new entries
> to PC_COMPAT_* or new PCMachineClass compat flags.  This means
> isapc never guaranteed guest ABI and cross-QEMU-version live
> migration compatibility.  There's no point in keeping code for
> kvm-pv-eoi and APIC ID compatibility in pc_init_isa().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_piix.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 9ff79b1fd9..31646e63c4 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -378,8 +378,6 @@ static void pc_compat_0_13(MachineState *machine)
>  
>  static void pc_init_isa(MachineState *machine)
>  {
> -    x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
> -    enable_compat_apic_id_mode();
>      pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
>  }
>  
