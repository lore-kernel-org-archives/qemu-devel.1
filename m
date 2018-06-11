Received: from eggs.gnu.org ([2001:4830:134:3::10]:46293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSNNy-000833-RS
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSNNu-0007es-OB
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:01:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fSNNu-0007ed-JD
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:01:26 -0400
References: <20180611125633.32755-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ec9adb7-d325-faaa-3339-315e28280dbf@redhat.com>
Date: Mon, 11 Jun 2018 16:01:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180611125633.32755-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] cputlb: document iotlb.addr,
 fix txfail physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 11/06/2018 14:56, Peter Maydell wrote:
> This patchset is two vaguely related patches that I wrote
> while I was trying to understand the cputlb code enough to
> add support for small-MPU-regions for v7M/v8M.
> 
> Patch 1 is just a docs comment patch, describing what the
> CPUIOTLBEntry 'addr' field actually contains.
> 
> Patch 2 fixes a bug that doesn't yet have any visible effects
> (we were passing cpu_transaction_failed() the wrong value for
> the physaddr) roughly as suggested by Paolo back in
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg02419.html
> 
> thanks
> -- PMM

Both patches

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
