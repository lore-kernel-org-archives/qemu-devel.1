Received: from eggs.gnu.org ([209.51.188.92]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbjo-0005Os-RP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMbjn-0007t6-2j
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:12:44 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52185)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hMbjl-0007r7-8w
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:12:41 -0400
References: <20181210165636.28366-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <98f62d5c-0c2a-9651-0dd6-961a243c4519@vivier.eu>
Date: Fri, 3 May 2019 19:12:38 +0200
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 10/12/2018 17:56, Peter Maydell wrote:
> This patchset converts the m68k target from the deprecated
> unassigned_access hook to the new transaction_failed hook.
> It's RFC for a couple of reasons:
>   * it's untested, since I don't have an m68k test image
>   * the second patch just makes "bus error while trying to
>     read page tables" be treated as a page fault, when it
>     should probably cause a fault reporting it as a bus error
>     of some kind
>   * I don't understand why the old unassigned_access hook
>     set the ATC bit in the MMU SSW, since the docs I have say
>     this should be set if the fault happened during a table
>     search, but cleared if it's just an ordinary bus-errored
>     data or insn access. Probably this is a pre-existing bug?

I think you're right. It must be cleared on bus error.

Thanks,
Laurent
