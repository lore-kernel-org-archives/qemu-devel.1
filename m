Received: from eggs.gnu.org ([209.51.188.92]:57453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2Cy4-0002qS-En
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2Cy3-0007p6-Qw
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:43:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2Cy3-0007nH-Gw
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:43:07 -0500
References: <20190225133744.7095-1-weijiang.yang@intel.com>
	<20190225133744.7095-6-weijiang.yang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dbd5a58-2735-91c7-a169-c56c15846953@redhat.com>
Date: Fri, 8 Mar 2019 11:43:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190225133744.7095-6-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] Add CET MSR save/restore support
 for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Weijiang <weijiang.yang@intel.com>, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 25/02/19 14:37, Yang Weijiang wrote:
> +#define MSR_IA32_PL0_SSP                0x6a4
> +#define MSR_IA32_PL3_SSP                0x6a7

Please add PL1 and PL2 SSP too.

Paolo
