Received: from eggs.gnu.org ([2001:4830:134:3::10]:57999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhbY-0006YV-0x
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cYhbX-0007C4-7J
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:12:51 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:33409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cYhbX-0007Bs-1i
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:12:51 -0500
Received: by mail-pf0-x243.google.com with SMTP id e4so30092936pfg.0
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 15:12:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170127103922.19658-1-alex.bennee@linaro.org>
	<20170127103922.19658-18-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1a954e90-214c-f2bc-9597-be7cf0cd945b@twiddle.net>
Date: Tue, 31 Jan 2017 15:12:47 -0800
MIME-Version: 1.0
In-Reply-To: <20170127103922.19658-18-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v8 17/25] cputlb: add tlb_flush_by_mmuidx
 async routines
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
> This converts the remaining TLB flush routines to use async work when
> detecting a cross-vCPU flush. The only minor complication is having to
> serialise the var_list of MMU indexes into a form that can be punted
> to an asynchronous job.
>
> The pending_tlb_flush field on QOM's CPU structure also becomes a
> bitfield rather than a boolean.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
