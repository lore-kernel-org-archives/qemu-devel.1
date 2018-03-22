Received: from eggs.gnu.org ([2001:4830:134:3::10]:56848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywIm-0007dX-Jc
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eywIh-0008Ie-La
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:14:28 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35948)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eywIh-0008Hy-F1
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 05:14:23 -0400
Received: by mail-wm0-f47.google.com with SMTP id x82so14604532wmg.1
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 02:14:23 -0700 (PDT)
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
	<fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
	<CABLmASEF+e-h-nKunLd6QrnKaCAiR0d=GJZq9tN+CrvZh5iL7A@mail.gmail.com>
	<035198fa-b9e1-6084-d9c2-4d344e7058d7@redhat.com>
	<CABLmASFEhaKB1Hh91p+RM+TX+zTTDuNixWy=16rUC+GC_0KKtg@mail.gmail.com>
	<397a5759-de49-33a1-300a-67e8b7022678@redhat.com>
	<CABLmASHkjz=UDbHMRRtJKhu1bF28NGTzRjTo-GKbCd6dp-6qQQ@mail.gmail.com>
	<84d2ded7-fdd5-0367-ad5d-b0443c4a945a@redhat.com>
	<CABLmASFvQED-tsDGCgmw3LYx_CkLeKTGoQ_oU9qLHpGu=a=-hg@mail.gmail.com>
	<ed9c25bd-e5be-bde1-2447-775c3bfc93ad@redhat.com>
	<20180322051938.GG32362@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b16d3da-cdd6-f18e-ed50-b5a0e25fbc59@redhat.com>
Date: Thu, 22 Mar 2018 10:14:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180322051938.GG32362@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>

On 22/03/2018 06:19, Peter Xu wrote:
> +#ifdef CONFIG_LINUX
>  /* Benchmark results from 2016 on NVMe SSD drives show max polling times around
>   * 16-32 microseconds yield IOPS improvements for both iodepth=1 and iodepth=32
>   * workloads.
>   */
>  #define IOTHREAD_POLL_MAX_NS_DEFAULT 32768ULL

POSIX, not Linux. :)   I'll fix it myself.

Paolo
