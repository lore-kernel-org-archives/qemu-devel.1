Received: from eggs.gnu.org ([2001:4830:134:3::10]:44678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCHw-0007dq-6H
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etCHq-0004uj-Ih
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:05:52 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etCHq-0004uE-DQ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 08:05:46 -0500
Received: by mail-oi0-x241.google.com with SMTP id u73so14757445oie.3
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 05:05:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306120813.17537-1-sandipan@linux.vnet.ibm.com>
References: <20180306120813.17537-1-sandipan@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 13:05:25 +0000
Message-ID: <CAFEAcA-4wpJA5aANdhNepLXdpYPnWSDDr6kUjZUcbjrvk2zvWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH risu v2 0/3] Miscellaneous fixes for
 powerpc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, naveen.n.rao@linux.vnet.ibm.com, QEMU Developers <qemu-devel@nongnu.org>

On 6 March 2018 at 12:08, Sandipan Das <sandipan@linux.vnet.ibm.com> wrote:
> The first patch adds the patterns for the missing byte and
> doubleword load instructions. The second patch fixes mismatches
> encountered when using the load quadword instruction. The last
> patch fixes a minor typo in the floating-point register prefix
> shown when dumping the register values.
>
> Changelog:
> v2 -> Added a cover letter as requested by Peter.
>
> Sandipan Das (3):
>   ppc64.risu: Add missing byte and dword loads
>   ppc64.risu: Fix pattern for load qword
>   risu_reginfo_ppc64.c: Fix register name prefix
>
>  ppc64.risu           | 29 +++++++++++++++++++++++++++--
>  risu_reginfo_ppc64.c |  4 ++--
>  2 files changed, 29 insertions(+), 4 deletions(-)

Thanks; I've applied these to risu master.

-- PMM
