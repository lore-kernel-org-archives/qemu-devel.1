Received: from eggs.gnu.org ([209.51.188.92]:44665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtCqM-0002DV-CH
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtCqL-0003E3-Ks
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:45:58 -0500
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
	<1549694366-1284-24-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <de235124-9bea-6f22-ad15-34d3b98f500f@redhat.com>
Date: Mon, 11 Feb 2019 15:45:35 +0100
MIME-Version: 1.0
In-Reply-To: <1549694366-1284-24-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/25] hw/arm: Express dependencies of the
 ZynqMP zcu102 machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-arm@nongnu.org, philmd@redhat.com

On 09/02/19 07:39, Thomas Huth wrote:
> +    select PCI      # TODO: Currently required for SDHCI and AHCI, remove later

I think SDHCI and AHCI should select it instead, similar to how FDC
selects ISA_BUS (see patch 25 of the Kconfig series).

Paolo
