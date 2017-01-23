Received: from eggs.gnu.org ([2001:4830:134:3::10]:55985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVk0R-0008MJ-Ac
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVk0Q-000559-8u
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:10:19 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVk0Q-000550-4G
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 14:10:18 -0500
Received: by mail-qt0-x241.google.com with SMTP id l7so19443305qtd.3
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 11:10:18 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170119170507.16185-1-alex.bennee@linaro.org>
	<20170119170507.16185-16-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5f23ca41-ef38-9b91-79ab-c5931d414de3@twiddle.net>
Date: Mon, 23 Jan 2017 11:10:13 -0800
MIME-Version: 1.0
In-Reply-To: <20170119170507.16185-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 15/27] cputlb: introduce tlb_flush_*
 async work.
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
> +/* NOTE:
> + * If flush_global is true (the usual case), flush all tlb entries.
> + * If flush_global is false, flush (at least) all tlb entries not
> + * marked global.
> + *
> + * Since QEMU doesn't currently implement a global/not-global flag
> + * for tlb entries, at the moment tlb_flush() will also flush all
> + * tlb entries in the flush_global == false case. This is OK because
> + * CPU architectures generally permit an implementation to drop
> + * entries from the TLB at any time, so flushing more entries than
> + * required is only an efficiency issue, not a correctness issue.
> + */
> +void tlb_flush(CPUState *cpu)
> +{

Merge error re-adding the comment for flush_global?

Otherwise,

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
