Received: from eggs.gnu.org ([2001:4830:134:3::10]:57683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAb9e-00017K-Ql
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gAb9V-0003hB-AV
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gAb9R-0003eb-Nu
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:37:19 -0400
References: <1539064514-2606-1-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0f2178ab-d2fc-eb08-e804-821d9277364c@redhat.com>
Date: Thu, 11 Oct 2018 15:37:10 +0200
MIME-Version: 1.0
In-Reply-To: <1539064514-2606-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: pc_sysfw: load bios using rom API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 09/10/2018 07:55, Li Qiang wrote:
> As the bios is a ROM, just using rom API.
> AFAICS no functionality changed.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---

ROM and RAM are just the same, with the readonly flag defaulting to
either true or false.

Because the alias here:

    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
                             bios_size - isa_bios_size, isa_bios_size);
    if (!isapc_ram_fw) {
        memory_region_set_readonly(isa_bios, true);
    }

defaults to read-write (and your patch is wrong in changing the
direction of the if), it makes sense to do the same for the bios memory
region.

Thanks,

Paolo
