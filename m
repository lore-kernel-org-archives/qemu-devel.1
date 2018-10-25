Received: from eggs.gnu.org ([2001:4830:134:3::10]:59438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFn9r-0008BG-QW
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 17:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gFn9o-0007aV-87
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 17:27:11 -0400
References: <38b0df70-338e-c842-95bb-c1a5fbd54b7b@vivier.eu>
	<f0a16cde-5fbc-b3b2-f5c6-105855d356c8@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <39f0aaff-ba05-ffe9-8321-182f096c031e@vivier.eu>
Date: Thu, 25 Oct 2018 22:26:56 +0100
MIME-Version: 1.0
In-Reply-To: <f0a16cde-5fbc-b3b2-f5c6-105855d356c8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Call for patches for the qemu-trivial pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 25/10/2018 21:13, Thomas Huth wrote:
> On 2018-10-23 11:04, Laurent Vivier wrote:
>> Hi,
>>
>> I'm going to collect patches for the next pull request for the
>> qemu-trivial I'd like to do before the softfreeze.
>>
>> As we didn't have any pull request for more than 3 months and some of
>> the patches have been pushed through another maintainer branches, it's a
>> little bit difficult to collect correctly the patches to send.
>>
>> So, it would be helpful if any of you knowing that some patches have to
>> be added to the pull request send me their list.
> 
> For June to September, I'd like to suggest:
> 
>  cpu.h: fix a typo in comment
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-09/msg00021.html

applied

> 
>  linux-user: fix comment s/atomic_write/atomic_set
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-08/msg00017.html

applied

> 
>  tests: Fix typos in comments and help message (found by codespell)
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00039.html

applied

> 
>  configure: Support pkg-config for zlib
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00032.html
>  (this had a suggestion for dropping the fallback test, but I think
>  that could be done as an additional patch after the next release instead)
> 

applied

>  qobject: Catch another straggler for use of qdict_put_str()
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00006.html

applied

> 
>  xen: Use the PCI_DEVICE macro
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00008.html

applied

> 
>  tests/bios-tables-test: Remove an useless cast
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00009.html

applied

> 
>  hw/pci-host: Remove useless parenthesis around DIV_ROUND_UP macro
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00011.html
> 

applied

>  hw/intc/gicv3: Remove useless parenthesis around DIV_ROUND_UP macro
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00012.html

applied

> 
>  dump: fix a typo
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00002.html

I don't find it in patchwork.

> 
>  milkymist-minimac2: Use qemu_log_mask(GUEST_ERROR) instead of error_report
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-07/msg00001.html

applied

> 
>  Makefile: Remove qemu-version.h and qemu-options.def during 'make distclean'
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-06/msg00050.html
> 

doesn't apply cleanly. not applied.

>  ppc: move at24c to its own CONFIG_ symbol
>  https://lists.nongnu.org/archive/html/qemu-trivial/2018-05/msg00118.html

applied

> 
> Additionally you could also include the reviewed patches from the the
> "use qemu_log_mask instead of fprintf" series here:
> https://lists.nongnu.org/archive/html/qemu-trivial/2018-06/msg00276.html

I'll see later for these ones...

Thanks
Laurent
