Received: from eggs.gnu.org ([209.51.188.92]:35352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gyheB-0000G7-76
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:40:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gyhe9-0004aV-VI
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:40:07 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gyhe7-0004VY-QX
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:40:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id y15so3269380wma.0
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:40:01 -0800 (PST)
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
	<CAFEAcA__1qZP3M97Wah_=1mCAJ9f3WA=Nx7GcoAf28sZBap_sw@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <57ceff35-e9d9-616e-0d1b-e6879cfedbf4@gmail.com>
Date: Tue, 26 Feb 2019 20:40:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA__1qZP3M97Wah_=1mCAJ9f3WA=Nx7GcoAf28sZBap_sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH PULL 00/11] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia@oracle.com>, kamal heib <kamalheib1@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Peter,

On 2/26/19 6:48 PM, Peter Maydell wrote:
> On Sat, 23 Feb 2019 at 14:16, Marcel Apfelbaum
> <marcel.apfelbaum@gmail.com> wrote:
>> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62be116:
>>
>>    Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190221.0' into staging (2019-02-22 15:48:04 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/marcel-apf/qemu tags/rdma-pull-request
>>
>> for you to fetch changes up to e1038e22f7b3ade2e46cf168fa7486414c424e94:
>>
>>    hw/rdma: another clang compilation fix (2019-02-23 15:28:25 +0200)
>>
>> ----------------------------------------------------------------
>> RDMA queue
>>
>>   * Another Clang compilation fix
>>   * Various fixes for the pvrdma device
>>
> Format string issues for 32-bit hosts:
>
> In file included from hw/rdma/trace.c:4:0:
> hw/rdma/trace.h: In function '_nocheck__trace_rdma_mad_message':
> hw/rdma/trace.h:231:18: error: format '%ld' expects argument of type
> 'long int', but argument 6 has type 'size_t {aka unsigned int}'
> [-Werror=format=]
>           qemu_log("%d@%zu.%06zu:rdma_mad_message " "mad %s (%ld): %s" "\n",
>                    ^
> In file included from hw/rdma/trace.c:4:0:
> hw/rdma/trace.h: In function '_nocheck__trace_rdma_rm_alloc_mr':
> hw/rdma/trace.h:507:18: error: format '%ld' expects argument of type
> 'long int', but argument 8 has type 'size_t {aka unsigned int}'
> [-Werror=format=]
>           qemu_log("%d@%zu.%06zu:rdma_rm_alloc_mr " "mr_handle=%d,
> host_virt=%p, guest_start=0x%"PRIx64", length=%ld, access_flags=0x%x"
> "\n",
>                    ^

Will fix and resend (and add 32-bit compilation to my set of tests).

Thanks,
Marcel

> thanks
> -- PMM
