Received: from eggs.gnu.org ([2001:4830:134:3::10]:58545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG1Hx-0002IE-67
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG1Ht-00086h-7k
	for qemu-devel@nongnu.org; Wed, 31 May 2017 06:55:41 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170531061150.15755-1-sjitindarsingh@gmail.com>
Date: Wed, 31 May 2017 12:55:33 +0200
In-Reply-To: <20170531061150.15755-1-sjitindarsingh@gmail.com> (Suraj Jitindar
	Singh's message of "Wed, 31 May 2017 16:11:50 +1000")
Message-ID: <87vaohcn2y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] help: Add newline to end of thread option
 help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Cc: qemu-trivial

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> The help text for the thread sub option of the accel option is missing
> a newline at the end. This is annoying as it makes it hard to see the
> help text for the next option.
>
> Add the new line so that the following option help text (-smp) is
> displayed on a new line rather on the same line and directly after
> the thread help.
>
> Before patch:
>
> -accel [accel=]accelerator[,thread=single|multi]
>                 select accelerator (kvm, xen, hax or tcg; use 'help' for a list)
>                 thread=single|multi (enable multi-threaded TCG)-smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]
>                 set the number of CPUs to 'n' [default=1]
>                 maxcpus= maximum number of total cpus, including
>                 offline CPUs for hotplug, etc
>                 cores= number of CPU cores on one socket
>                 threads= number of threads on one CPU core
>                 sockets= number of discrete sockets in the system
>
> After patch:
>
> -accel [accel=]accelerator[,thread=single|multi]
>                 select accelerator (kvm, xen, hax or tcg; use 'help' for a list)
>                 thread=single|multi (enable multi-threaded TCG)
> -smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]
>                 set the number of CPUs to 'n' [default=1]
>                 maxcpus= maximum number of total cpus, including
>                 offline CPUs for hotplug, etc
>                 cores= number of CPU cores on one socket
>                 threads= number of threads on one CPU core
>                 sockets= number of discrete sockets in the system
>
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  qemu-options.hx | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index a6c9b9e..8515db8 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -102,7 +102,7 @@ ETEXI
>  DEF("accel", HAS_ARG, QEMU_OPTION_accel,
>      "-accel [accel=]accelerator[,thread=single|multi]\n"
>      "                select accelerator (kvm, xen, hax or tcg; use 'help' for a list)\n"
> -    "                thread=single|multi (enable multi-threaded TCG)", QEMU_ARCH_ALL)
> +    "                thread=single|multi (enable multi-threaded TCG)\n", QEMU_ARCH_ALL)
>  STEXI
>  @item -accel @var{name}[,prop=@var{value}[,...]]
>  @findex -accel
