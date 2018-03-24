Received: from eggs.gnu.org ([208.118.235.92]:43817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezork-00018r-Sk
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ezolY-00057K-3S
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:24:54 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:38832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ezolX-00057C-Uq
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:23:48 -0400
Received: by mail-oi0-x234.google.com with SMTP id c3-v6so12993884oib.5
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:23:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180323155306.83812-1-marcel@redhat.com>
References: <20180323155306.83812-1-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 24 Mar 2018 19:23:26 +0000
Message-ID: <CAFEAcA_kMpogkoXKZV37DYJ_v5jUXEHhKA-_Y-AyFh0_7-Zr4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH PULL 0/8] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 23 March 2018 at 15:52, Marcel Apfelbaum <marcel@redhat.com> wrote:
> The following changes since commit 4c2c1015905fa1d616750dfe024b4c0b35875950:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20180323' into staging (2018-03-23 10:20:54 +0000)
>
> are available in the git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to 6f559013c86d16255991ca23e47bd161407b95c8:
>
>   hw/rdma: Fix 32-bit compilation (2018-03-23 18:38:55 +0300)
>
> ----------------------------------------------------------------
> * fix PVRDMA compilation errors and warnings
> * implement query_qp for the PVRDMA device
> * fix make - switch from -I to -iquote
>
> ----------------------------------------------------------------
> Marcel Apfelbaum (1):
>       hw/rdma: fix clang compilation errors
>
> Michael S. Tsirkin (2):
>       rdma: fix up include directives
>       make: switch from -I to -iquote
>
> Yuval Shaia (5):
>       hw/rdma: Add Query QP operation
>       hw/rdma: Add support for Query QP verb to pvrdma device
>       hw/rdma: Change host_virt to void *
>       hw/rdma: Use correct print format in CHK_ATTR macro
>       hw/rdma: Fix 32-bit compilation
>

Applied, thanks.

-- PMM
