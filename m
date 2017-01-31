Received: from eggs.gnu.org ([2001:4830:134:3::10]:33245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhxD-0000ss-RB
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhxC-0003oS-Sn
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:35:15 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cYhxC-0003oN-Ln
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:35:14 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so30167969pfg.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 15:35:14 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-20-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <960d0eec-03ec-1c8e-bb64-c80a60ca8149@twiddle.net>
Date: Tue, 31 Jan 2017 15:35:10 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 19/25] cputlb: introduce
 tlb_flush_*_all_cpus[_synced]
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
> This introduces support to the cputlb API for flushing all CPUs TLBs
> with one call. This avoids the need for target helpers to iterate
> through the vCPUs themselves.
>
> An additional variant of the API (_synced) do not return from the
> caller and will cause the work to be scheduled as "safe work". The
> result will be all the flush operations will be complete by the time
> the originating vCPU starts executing again. It is up to the caller to
> ensure enough state has been saved so execution can be restarted at
> the next appropriate instruction.
>
> Some guest architectures can defer completion of flush operations
> until later. If they later schedule work using the async_safe_work
> mechanism they can be sure other vCPUs will have flushed their TLBs by
> the point execution returns from the safe work.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
