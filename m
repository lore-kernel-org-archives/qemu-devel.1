Received: from eggs.gnu.org ([2001:4830:134:3::10]:47249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVjTq-0001xb-5A
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVjTo-0002HS-4p
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:36:38 -0500
Received: from mail-vk0-x235.google.com ([2607:f8b0:400c:c05::235]:34614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVjTo-0002HE-0m
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:36:36 -0500
Received: by mail-vk0-x235.google.com with SMTP id r136so96620292vke.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 10:36:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170123180632.28942-2-ehabkost@redhat.com>
References: <20170123180632.28942-1-ehabkost@redhat.com>
	<20170123180632.28942-2-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jan 2017 18:36:14 +0000
Message-ID: <CAFEAcA9nPFNainOcmZjKwuZh8NubevOwhcZqf76+jZtm+8G_cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-options: Rename variables on the
 -numa "cpus" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 23 January 2017 at 18:06, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Use @var{firstcpu} and @var{lastcpu} to make the metasyntatic
> variables a bit clearer. While doing this, use @var only around
> the metasyntatic variables, not including the square brackets and
> hyphen.
>
> The semantics of the "cpus" option will be clarified by rewriting
> the whole -numa documentation in a follow-up patch.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qemu-options.hx | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 80df52651a..780528d6ad 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -119,11 +119,11 @@ specifies the maximum number of hotpluggable CPUs.
>  ETEXI
>
>  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> -    "-numa node[,mem=size][,cpus=cpu[-cpu]][,nodeid=node]\n"
> -    "-numa node[,memdev=id][,cpus=cpu[-cpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
> +    "-numa node[,mem=size][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n"
> +    "-numa node[,memdev=id][,cpus=firstcpu[-lastcpu]][,nodeid=node]\n", QEMU_ARCH_ALL)
>  STEXI
> -@item -numa node[,mem=@var{size}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
> -@itemx -numa node[,memdev=@var{id}][,cpus=@var{cpu[-cpu]}][,nodeid=@var{node}]
> +@item -numa node[,mem=@var{size}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
> +@itemx -numa node[,memdev=@var{id}][,cpus=@var{firstcpu}[-@var{lastcpu}]][,nodeid=@var{node}]
>  @findex -numa
>  Simulate a multi node NUMA system. If @samp{mem}, @samp{memdev}
>  and @samp{cpus} are omitted, resources are split equally. Also, note

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
