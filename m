Received: from eggs.gnu.org ([2001:4830:134:3::10]:57663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVk7R-0004WI-UF
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVk7Q-0006aX-3c
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:17:33 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVk7P-0006aN-W5
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:17:32 -0500
Received: by mail-qt0-x241.google.com with SMTP id a29so19449509qtb.1
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:17:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-18-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f78c3bdc-6cd9-1f3d-fe7c-1e39bd6f8a86@twiddle.net>
Date: Mon, 23 Jan 2017 11:17:27 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 17/27] cputlb: atomically update tlb
 fields used by tlb_reset_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: peter.maydell@linaro.org, claudio.fontana@huawei.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>, jan.kiszka@siemens.com, mark.burton@greensocs.com, serge.fdrv@gmail.com, pbonzini@redhat.com, bamvor.zhangjian@linaro.org

On 01/19/2017 09:04 AM, Alex Bennée wrote:
> The main use case for tlb_reset_dirty is to set the TLB_NOTDIRTY flags
> in TLB entries to force the slow-path on writes. This is used to mark
> page ranges containing code which has been translated so it can be
> invalidated if written to. To do this safely we need to ensure the TLB
> entries in question for all vCPUs are updated before we attempt to run
> the code otherwise a race could be introduced.
> 
> To achieve this we atomically set the flag in tlb_reset_dirty_range and
> take care when setting it when the TLB entry is filled.
> 
> On 32 bit systems attempting to emulate 64 bit guests we don't even
> bother as we might not have the atomic primitives available. MTTCG is
> disabled in this case and can't be forced on. The copy_tlb_helper
> function helps keep the atomic semantics in one place to avoid
> confusion.
> 
> The dirty helper function is made static as it isn't used outside of
> cputlb.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
