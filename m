Received: from eggs.gnu.org ([2001:4830:134:3::10]:45086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyGzi-0006dp-Dd
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyGza-0006Z2-Oe
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:40:18 -0400
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
	<20180907073155.26200-2-david@gibson.dropbear.id.au>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ae5af64-c452-9d7d-ea81-6d9035a30697@redhat.com>
Date: Fri, 7 Sep 2018 08:39:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180907073155.26200-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 01/14] ppc: Remove deprecated ppcemb target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org

On 09/07/2018 02:31 AM, David Gibson wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> There is no known available OS for ppc around anymore that uses page
> sizes below 4k, so it does not make much sense that we keep wasting
> our time on building and testing the ppcemb-softmmu target. It has
> been deprecated since two releases, and nobody complained, so let's
> remove this now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

> +++ b/qapi/common.json
> @@ -146,6 +146,6 @@
>     'data' : [ 'aarch64', 'alpha', 'arm', 'cris', 'hppa', 'i386', 'lm32',
>                'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>                'mips64el', 'mipsel', 'moxie', 'nios2', 'or1k', 'ppc',
> -             'ppc64', 'ppcemb', 'riscv32', 'riscv64', 's390x', 'sh4',
> +             'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>                'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>                'x86_64', 'xtensa', 'xtensaeb' ] }

Can we also get documentation that this was deleted (probably as a 
followup, since I'm only now noticing this in the pull request)?  See 
QKeyCode in qapi/ui.json for an example of documenting 'altgr: dropped 
in 2.10'

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
