Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dvVO3-0007Zz-1F
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dvVNz-0006k2-TV
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:21:27 -0400
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:48177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dvVNz-0006ij-Nh
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 17:21:23 -0400
Received: by mail-oi0-x230.google.com with SMTP id v188so264657oia.5
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:21:23 -0700 (PDT)
References: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e906f0e8-57c1-b520-e1d0-4db24c9a30ff@linaro.org>
Date: Fri, 22 Sep 2017 16:21:18 -0500
MIME-Version: 1.0
In-Reply-To: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com

On 09/22/2017 07:18 AM, Mark Cave-Ayland wrote:
> Whilst the underlying PCI bridge implementation supports 32-bit PCI IO
> accesses, unfortunately they are truncated at the legacy 64K limit.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci/pci_bridge.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
