Received: from eggs.gnu.org ([2001:4830:134:3::10]:48871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciheX-0008CB-Bg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ciheT-0002o7-Bg
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:17:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ciheT-0002nk-5L
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:17:13 -0500
References: <1488271971-12624-1-git-send-email-thuth@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <2bdeedaa-294f-5395-680f-ffb912ecfe74@redhat.com>
Date: Tue, 28 Feb 2017 15:17:09 +0200
MIME-Version: 1.0
In-Reply-To: <1488271971-12624-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/null-machine: Print error message
 when using the -kernel parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>

On 02/28/2017 10:52 AM, Thomas Huth wrote:
> If the user currently tries to use the -kernel parameter, simply nothing
> happens, and the user might get confused that there is nothing loaded
> to memory, but also no error message has been issued. Since there is no
> real generic way to load a kernel on all CPU types (but on some targets,
> the generic loader can be used instead), issue an appropriate error
> message here now to avoid the possible confusion.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/core/null-machine.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
> index 27c8369..864832d 100644
> --- a/hw/core/null-machine.c
> +++ b/hw/core/null-machine.c
> @@ -40,6 +40,12 @@ static void machine_none_init(MachineState *mch)
>          memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
>          memory_region_add_subregion(get_system_memory(), 0, ram);
>      }
> +
> +    if (mch->kernel_filename) {
> +        error_report("The -kernel parameter is not supported "
> +                     "(use the generic 'loader' device instead).");
> +        exit(1);
> +    }
>  }
>
>  static void machine_none_machine_init(MachineClass *mc)
>


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
