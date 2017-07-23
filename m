Received: from eggs.gnu.org ([2001:4830:134:3::10]:48552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZJIH-0002be-1f
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 11:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZJID-0005O0-5r
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 11:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZJIC-0005Nl-VZ
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 11:59:41 -0400
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-3-git-send-email-zuban32s@gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <64a3e4dd-3021-c033-0a55-2408a6c07fae@redhat.com>
Date: Sun, 23 Jul 2017 18:59:32 +0300
MIME-Version: 1.0
In-Reply-To: <1500761743-1669-3-git-send-email-zuban32s@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/6] hw/i386: allow SHPC for Q35
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kraxel@redhat.com, seabios@seabios.org

On 23/07/2017 1:15, Aleksandr Bezzubikov wrote:
> Unmask previously masked SHPC feature in _OSC method.
> 
> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
> ---
>   hw/i386/acpi-build.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 6b7bade..0d99585 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1850,7 +1850,7 @@ static Aml *build_q35_osc_method(void)
>        * Always allow native PME, AER (no dependencies)
>        * Never allow SHPC (no SHPC controller in this system)

Seems the above comment is not longer correct :)

Thanks,
Marcel

>        */
> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
>   
>       if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>       /* Unknown revision */
> 
