Received: from eggs.gnu.org ([209.51.188.92]:58642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtaix-0004wA-VA
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtaZ0-0007ke-UO
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:05:40 -0500
References: <1549694366-1284-1-git-send-email-thuth@redhat.com>
	<1549694366-1284-24-git-send-email-thuth@redhat.com>
	<de235124-9bea-6f22-ad15-34d3b98f500f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a16e2d91-5a0b-e327-e74d-6b8b82baff2f@redhat.com>
Date: Tue, 12 Feb 2019 17:05:21 +0100
MIME-Version: 1.0
In-Reply-To: <de235124-9bea-6f22-ad15-34d3b98f500f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-arm@nongnu.org, philmd@redhat.com

On 2019-02-11 15:45, Paolo Bonzini wrote:
> On 09/02/19 07:39, Thomas Huth wrote:
>> +    select PCI      # TODO: Currently required for SDHCI and AHCI, remove later
> 
> I think SDHCI and AHCI should select it instead, similar to how FDC
> selects ISA_BUS (see patch 25 of the Kconfig series).

Yes, that's likely the better way to work-around this issue. I'll add
that in v2 ...

 Thomas
