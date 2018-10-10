Received: from eggs.gnu.org ([2001:4830:134:3::10]:34439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanogarzarella@gmail.com>) id 1gAHYB-0005qr-4T
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:41:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanogarzarella@gmail.com>) id 1gAHYA-0001Lq-5n
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 12:41:31 -0400
MIME-Version: 1.0
References: <20181010161025.34796-1-liq3ea@163.com>
In-Reply-To: <20181010161025.34796-1-liq3ea@163.com>
From: Stefano Garzarella <stefanogarzarella@gmail.com>
Date: Wed, 10 Oct 2018 18:41:09 +0200
Message-ID: <CAO0mX5Y+FbtFa1Q0MXRf3yA4uSnPKV_GgH8z49Knzy+jvPHf=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] machine: fix a typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: liq3ea@163.com
Cc: ehabkost@redhat.com, marcel.apfelbaum@gmail.com, qemu-trivial@nongnu.org, qemu-devel@nongnu.org

Reviewed-by: Stefano Garzarella <stefanogarzarella@gmail.com>

Il giorno mer 10 ott 2018 alle ore 18:11 Li Qiang <liq3ea@163.com> ha
scritto:

> Cc: qemu-trivial@nongnu.org
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/core/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1987557833..da50ad6de7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -636,7 +636,7 @@ static void machine_class_init(ObjectClass *oc, void
> *data)
>          machine_get_memory_encryption, machine_set_memory_encryption,
>          &error_abort);
>      object_class_property_set_description(oc, "memory-encryption",
> -        "Set memory encyption object to use", &error_abort);
> +        "Set memory encryption object to use", &error_abort);
>  }
>
>  static void machine_class_base_init(ObjectClass *oc, void *data)
> --
> 2.17.1
>
>
>
>

-- 
*Stefano Garzarella*
Software Engineer

e-mail: stefano.garzarella@gmail.com
github: http://github.com/stefano-garzarella
linkedin: http://it.linkedin.com/pub/stefano-garzarella
