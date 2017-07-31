Received: from eggs.gnu.org ([2001:4830:134:3::10]:33932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc8Tn-00017a-4Y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dc8Tj-0000r1-8C
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dc8Tj-0000p7-1o
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 07:03:15 -0400
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-2-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <dcdf9095-507c-a097-957a-5bcf269ac76a@redhat.com>
Date: Mon, 31 Jul 2017 14:03:00 +0300
MIME-Version: 1.0
In-Reply-To: <1501285073-2215-2-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/5] hw/i386: allow SHPC for Q35 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, kevin@koconnor.net, lersek@redhat.com, seabios@seabios.org, kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

On 29/07/2017 2:37, Aleksandr Bezzubikov wrote:
> Unmask previously masked SHPC feature in _OSC method.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   hw/i386/acpi-build.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade..2ab32f9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1848,9 +1848,9 @@ static Aml *build_q35_osc_method(void)
>   
>       /*
>        * Always allow native PME, AER (no dependencies)
> -     * Never allow SHPC (no SHPC controller in this system)
> +     * Allow SHPC (PCI bridges can have SHPC controller)
>        */
> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
>   
>       if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>       /* Unknown revision */
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
