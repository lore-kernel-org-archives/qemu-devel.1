Received: from eggs.gnu.org ([2001:4830:134:3::10]:47613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnkaE-0006XL-Cd
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnka8-0004D0-NA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:02:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnka8-0004Cm-Gk
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:02:24 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <cb63d852-df80-a894-9290-9147a55554ab@redhat.com>
Date: Thu, 9 Aug 2018 15:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/34] tests/qgraph: pci-spapr driver
 and interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> +void qpci_init_spapr(QPCIBusSPAPR *ret, QTestState *qts, QGuestAllocator *alloc)
> +{
>      assert(qts);
>  
> +    /* tests cannot use spapr, needs to be fixed first */
> +    ret->bus.has_buggy_msi = TRUE;
> +

Perhaps you can revert the logic and call that "msi_is_available"?
It's more generic than "buggy". It says if we can or not use MSI.

Thanks,
Laurent
