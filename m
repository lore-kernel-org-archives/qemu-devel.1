Received: from eggs.gnu.org ([2001:4830:134:3::10]:34318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYi5s-0005vI-2C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYi5q-0006qF-Q5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:44:12 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cYi5q-0006py-KG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:44:10 -0500
Received: by mail-pf0-x241.google.com with SMTP id 19so30235894pfo.3
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 15:44:10 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <56f0e8fe-294f-6076-ac1d-20064c0fcc8e@twiddle.net>
Date: Tue, 31 Jan 2017 15:44:07 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 00/25] Remaining MTTCG Base patches and
 ARM enablement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, mttcg@greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com
Cc: mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, peter.maydell@linaro.org, claudio.fontana@huawei.com, bamvor.zhangjian@linaro.org

On 01/27/2017 02:38 AM, Alex Bennée wrote:
> Hi,
>
> All of the changes in this revision are addressing comments from v7
> posted last week. A new pre-cursor patch was added:
>
>   cputlb and arm/sparc targets: convert mmuidx flushes from varg to
>     bitmap
>
> To change the cputlb API to use a bitmap instead of vargs. This has
> generated quite a bit of churn in the ARM target but it is pretty
> mechanical.
>
> I also folded the BQL irq protection patches from v7 into:
>
>   tcg: drop global lock during TCG code execution
>
> This is required to keep the series bisectable although the BQL safety
> is only really relevant to guests using MTTCG. I didn't think it was
> worth making the asserts conditional on parallel_cpus although it does
> mean this patch gets a little bigger.
>
> The other big change was to:
>
>   cputlb: introduce tlb_flush_*_all_cpus[_synced]
>
> Where I replaced the wait flag with an expanded set of API calls. The
> *_synced variants which are marked as QEMU_NORETURN to make their
> behaviour clear.
>
> The series applies to origin/master as of today and you can find my
> tree at:
>
>   https://github.com/stsquad/qemu/tree/mttcg/base-patches-v8
>
> There is the usual collection of r-b tags and minor merge/re-base
> fixes all documented in the --- sections of the commit messages.
>
> In terms of merging strategy I would appreciate some thoughts. While I
> think the series is ready to go I appreciate it is quite a chunk to
> merge in one go. That said an early merge gives us plenty of time to
> shake out any lingering issues before feature freeze.

As far as I'm concerned, I'm done with my review and this can go in.

Those remaining nits in target/arm are extremely minor and ought to be between 
you and PMM as ARM maintainer -- whatever he's happy with should go.

Once this is in I'll send a patch to enable mttcg for Alpha, which has also 
tested well.


r~
