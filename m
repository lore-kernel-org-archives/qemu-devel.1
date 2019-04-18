Received: from eggs.gnu.org ([209.51.188.92]:48729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH58h-00050Y-Lp
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hH58g-0004yr-Pg
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hH58g-0004yB-KG
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:23:34 -0400
Date: Thu, 18 Apr 2019 13:23:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190418132327.3a6cc19d@redhat.com>
In-Reply-To: <20190418040103.15314-1-ehabkost@redhat.com>
References: <20190418040103.15314-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hppa: Delete unused hppa_cpu_list()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Thu, 18 Apr 2019 01:01:03 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> hppa_cpu_list() is dead code and is never called.  Delete it.
> 
> Cc: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  target/hppa/cpu.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
> 
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index 00bf444620..b3b1826209 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -110,28 +110,6 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>  #endif
>  }
>  
> -static void hppa_cpu_list_entry(gpointer data, gpointer user_data)
> -{
> -    ObjectClass *oc = data;
> -    CPUListState *s = user_data;
> -
> -    (*s->cpu_fprintf)(s->file, "  %s\n", object_class_get_name(oc));
> -}
> -
> -void hppa_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> -{
> -    CPUListState s = {
> -        .file = f,
> -        .cpu_fprintf = cpu_fprintf,
> -    };
> -    GSList *list;
> -
> -    list = object_class_get_list_sorted(TYPE_HPPA_CPU, false);
> -    (*cpu_fprintf)(f, "Available CPUs:\n");
> -    g_slist_foreach(list, hppa_cpu_list_entry, &s);
> -    g_slist_free(list);
> -}
> -
>  static void hppa_cpu_initfn(Object *obj)
>  {
>      CPUState *cs = CPU(obj);
