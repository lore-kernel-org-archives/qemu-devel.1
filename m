Received: from eggs.gnu.org ([2001:4830:134:3::10]:50457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYefQ-0005f2-Vi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYefN-0000LG-S4
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:04:40 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cYefN-0000Kv-Op
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:04:37 -0500
Received: by mail-ot0-x241.google.com with SMTP id 36so43014924otx.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 12:04:37 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-16-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5a5573be-fe7c-1195-e5ee-1cf9dfa3745f@twiddle.net>
Date: Tue, 31 Jan 2017 12:04:29 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 15/25] cputlb: introduce tlb_flush_*
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
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 01/27/2017 02:39 AM, Alex Bennée wrote:
> From: KONRAD Frederic <fred.konrad@greensocs.com>
>
> Some architectures allow to flush the tlb of other VCPUs. This is not a problem
> when we have only one thread for all VCPUs but it definitely needs to be an
> asynchronous work when we are in true multithreaded work.
>
> We take the tb_lock() when doing this to avoid racing with other threads
> which may be invalidating TB's at the same time. The alternative would
> be to use proper atomic primitives to clear the tlb entries en-mass.
>
> This patch doesn't do anything to protect other cputlb function being
> called in MTTCG mode making cross vCPU changes.
>
> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
> [AJB: remove need for g_malloc on defer, make check fixes, tb_lock]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>

r~
