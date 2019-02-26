Received: from eggs.gnu.org ([209.51.188.92]:60760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyfuW-0006sD-Tb
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyfuV-0008EX-QS
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:48:52 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyfuU-00088h-3n
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 11:48:51 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so10878508oic.5
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 08:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 16:48:32 +0000
Message-ID: <CAFEAcA__1qZP3M97Wah_=1mCAJ9f3WA=Nx7GcoAf28sZBap_sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL 00/11] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, kamal heib <kamalheib1@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Sat, 23 Feb 2019 at 14:16, Marcel Apfelbaum
<marcel.apfelbaum@gmail.com> wrote:
>
> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to e1038e22f7b3ade2e46cf168fa7486414c424e94:
>
>   hw/rdma: another clang compilation fix (2019-02-23 15:28:25 +0200)
>
> ----------------------------------------------------------------
> RDMA queue
>
>  * Another Clang compilation fix
>  * Various fixes for the pvrdma device
>

Format string issues for 32-bit hosts:

In file included from hw/rdma/trace.c:4:0:
hw/rdma/trace.h: In function '_nocheck__trace_rdma_mad_message':
hw/rdma/trace.h:231:18: error: format '%ld' expects argument of type
'long int', but argument 6 has type 'size_t {aka unsigned int}'
[-Werror=format=]
         qemu_log("%d@%zu.%06zu:rdma_mad_message " "mad %s (%ld): %s" "\n",
                  ^
In file included from hw/rdma/trace.c:4:0:
hw/rdma/trace.h: In function '_nocheck__trace_rdma_rm_alloc_mr':
hw/rdma/trace.h:507:18: error: format '%ld' expects argument of type
'long int', but argument 8 has type 'size_t {aka unsigned int}'
[-Werror=format=]
         qemu_log("%d@%zu.%06zu:rdma_rm_alloc_mr " "mr_handle=%d,
host_virt=%p, guest_start=0x%"PRIx64", length=%ld, access_flags=0x%x"
"\n",
                  ^

thanks
-- PMM
