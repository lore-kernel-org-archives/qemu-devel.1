Received: from eggs.gnu.org ([2001:4830:134:3::10]:34549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fST4D-0004H0-08
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fST49-0003qx-Lm
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 16:05:28 -0400
References: <20180611195607.3015-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e40b530-d59b-5d4e-8b34-9ebb0ce142b1@redhat.com>
Date: Mon, 11 Jun 2018 15:05:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180611195607.3015-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Add missing newline to
 -accel help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

On 06/11/2018 02:56 PM, Eduardo Habkost wrote:
> The newline was removed by commit c97d6d2c, and broke -help output:

-help output is not supposed to be parsed by machine, in part because of 
stuff like this ;)

> 
> Before this patch:
> 
>    $ qemu-system-x86_64 -help | grep smp
>                    thread=single|multi (enable multi-threaded TCG)-smp [...]
> 
> After this patch:
> 
>    $ qemu-system-x86_64 -help  | grep smp
>    -smp [cpus=]n[,maxcpus=cpus][,cores=cores][,threads=threads][,sockets=sockets]
> 
> Fixes: c97d6d2cdf97edb4aebe832fdba65d701ad7bcb6
> Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---

But for the humans, this is a definite mistake worth fixing.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
