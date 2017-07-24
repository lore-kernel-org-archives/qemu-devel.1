Received: from eggs.gnu.org ([2001:4830:134:3::10]:33612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZkln-0003sK-Ey
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:20:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZklk-0002GV-B4
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZklk-0002G9-4P
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:20:00 -0400
References: <20170724210306.18428-1-bobby.prani@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <98c62747-c020-e0f8-d0ce-c49bd05bb9d9@redhat.com>
Date: Mon, 24 Jul 2017 23:19:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170724210306.18428-1-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] tcg/softmmu: Increase size of TLB cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

On 24/07/2017 23:03, Pranith Kumar wrote:
> This patch increases the number of entries we allow in the TLB. I went
> over a few architectures to see if increasing it is problematic. Only
> armv6 seems to have a limitation that only 8 bits can be used for
> indexing these entries. For other architectures, I increased the
> number of TLB entries to a 4K-sized cache.
> 
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>

How did you benchmark this, and can you plot (at least for x86 hosts)
the results as CPU_TLB_BITS_MAX grows from 8 to 12?

Thanks,

Paolo
