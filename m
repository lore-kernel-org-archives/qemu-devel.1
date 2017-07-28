Received: from eggs.gnu.org ([2001:4830:134:3::10]:49266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1db3Kx-0008Cy-Da
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:21:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1db3Ku-0001WJ-KN
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 07:21:43 -0400
References: <20170727143040.7236-1-otubo@redhat.com>
	<9858302e-566c-2ce8-45a1-29a5551bc367@msgid.tls.msk.ru>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <df7e23a4-540d-fa1c-86e5-a527503d3247@mail.uni-paderborn.de>
Date: Fri, 28 Jul 2017 13:20:41 +0200
MIME-Version: 1.0
In-Reply-To: <9858302e-566c-2ce8-45a1-29a5551bc367@msgid.tls.msk.ru>
Content-Type: text/plain; charset=windows-1251
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] qemu-system-tricore: segfault when entering "x 0"
 on the monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Eduardo Otubo <otubo@redhat.com>, qemu-trivial@nongnu.org
Cc: thuth@redhat.com, qemu-devel@nongnu.org

On 07/28/2017 01:19 PM, Michael Tokarev wrote:
> 27.07.2017 17:30, Eduardo Otubo wrote:
>> Starting Qemu with "qemu-system-tricore -nographic -M tricore_testboard -S"
>> and entering "x 0" at the monitor prompt leads to Segmentation fault. This happens
>> because tricore_cpu_get_phys_page_debug() is not implemented yet, this
>> is a temporary workaround to avoid the crash.
> 
> Applied to -trivial, without the extra newline in target/tricore/cpu.h
> 
> /mjt
> 

Thanks for picking this up :)

Cheers,
Bastian
