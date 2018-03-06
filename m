Received: from eggs.gnu.org ([2001:4830:134:3::10]:55916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etAwn-0006HF-Ba
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etAwm-0005bJ-Jk
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:39:57 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etAwm-0005ae-EZ
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:39:56 -0500
Received: by mail-ot0-x243.google.com with SMTP id t2so18048411otj.4
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:39:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
References: <20180306064210.26157-1-sandipan@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Mar 2018 11:39:35 +0000
Message-ID: <CAFEAcA-M1smCAVg3OwK0W7vNXiJBadh8sehHbLmDa7NuYb7tLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH risu 1/3] ppc64.risu: Add missing byte and
 dword loads
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

On 6 March 2018 at 06:42, Sandipan Das <sandipan@linux.vnet.ibm.com> wrote:
> The patterns for the following instructions are added:
>  * Load Byte and Zero (lbz)
>  * Load Byte and Zero with Update (lbzu)
>  * Load Byte and Zero Indexed (lbzx)
>  * Load Byte and Zero with Update Indexed (lbzux)
>  * Load Doubleword (ld)
>
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>

Hi -- this patchset doesn't seem to have a cover letter. Could
you resend it with one, please? Our automated patch handling
tools all expect a cover letter if there's more than one patch
in a set.

thanks
-- PMM
