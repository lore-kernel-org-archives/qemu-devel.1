Received: from eggs.gnu.org ([2001:4830:134:3::10]:47309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fL1TE-00043S-Hc
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@siemens.com>) id 1fL1TB-0004OV-Bz
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:12:32 -0400
Received: from goliath.siemens.de ([192.35.17.28]:53027)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
	id 1fL1TA-0004O1-Vg
	for qemu-devel@nongnu.org; Tue, 22 May 2018 03:12:29 -0400
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <cover.1522769774.git.jan.kiszka@web.de>
Message-ID: <ca72bfeb-02c5-ac36-95d3-2ab2a02bbe3b@siemens.com>
Date: Tue, 22 May 2018 09:12:24 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1522769774.git.jan.kiszka@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] target-i386: Enhance SVM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

On 2018-04-03 17:36, Jan Kiszka wrote:
> These patches allow to run Jailhouse in emulated x86-64 mode under QEMU.
> AMD IOMMU only works with one additional hack, but that's a different
> story, and we can test these changes without it.
> 
> Change in v2:
>  - build fix for 32-bit hosts
>  - replaces NPT exitinfo magics with symbolic constants
> 
> Jan
> 
> Jan Kiszka (4):
>   target-i386: Add NMI interception to SVM
>   target-i386: Allow interrupt injection after STGI
>   target-i386: Mark cpu_vmexit noreturn
>   target-i386: Add NPT support
> 
>  target/i386/cpu.c         |   2 +-
>  target/i386/cpu.h         |  10 ++-
>  target/i386/excp_helper.c | 216 +++++++++++++++++++++++++++++++++++++++++++++-
>  target/i386/mem_helper.c  |   6 +-
>  target/i386/seg_helper.c  |   1 +
>  target/i386/svm.h         |  14 +++
>  target/i386/svm_helper.c  |  23 +++++
>  target/i386/translate.c   |   3 +-
>  8 files changed, 266 insertions(+), 9 deletions(-)
> 

Ping on this series.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
