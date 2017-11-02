Received: from eggs.gnu.org ([2001:4830:134:3::10]:48172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAH3c-0004OS-Bq
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAH3V-0002og-Vc
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:05:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:47064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAH3V-0002me-OU
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:05:17 -0400
Received: by mail-wm0-x242.google.com with SMTP id m72so11801529wmc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 08:05:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171031223830.4608-1-Andrew.Baumann@microsoft.com>
References: <20171031223830.4608-1-Andrew.Baumann@microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 15:04:55 +0000
Message-ID: <CAFEAcA9rbXTwts2bfWmbT8sL91zCgL6u6D8xxdWgAh+06eef6Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Baumann <Andrew.Baumann@microsoft.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 22:38, Andrew Baumann
<Andrew.Baumann@microsoft.com> wrote:
> On a successful address translation instruction, PAR is supposed to
> contain cacheability and shareability attributes determined by the
> translation. We previously returned 0 for these bits (in line with the
> general strategy of ignoring caches and memory attributes), but some
> guest OSes may depend on them.
>
> This patch collects the attribute bits in the page-table walk, and
> updates PAR with the correct attributes for all LPAE translations.
> Short descriptor formats still return 0 for these bits, as in the
> prior implementation.
>
> Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
> ---
> v2:
>  * return attrs via out parameter from get_phys_addr, rather than MemTxAttrs
>  * move MAIR lookup/index inline, since it turned out to be simple
>  * implement attributes for stage 2 translations
>  * combine attributes from stages 1 and 2 when required
>
> v3:
>  * implement S2 allocation hints and check for cache-disabled
>  * fix stage 2 shareability bits
>  * fix combined allocation hints (always use stage 1 hints)
>  * remove LOG_UNIMP message
>
> v4:
>  * fix hihint shift buglet in convert_stage2_attrs
>  * remove TODO comment (what was there is complete)
>  * mention relevant pseudocode procedures in comments
>



Applied to target-arm.next, thanks.

-- PMM
