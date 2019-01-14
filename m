Received: from eggs.gnu.org ([209.51.188.92]:43619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gj9k1-0005qR-IT
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gj9k0-0006ZC-PK
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:25:53 -0500
References: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
	<20190114124246.6de38d67.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <ae958b25-8b96-75f0-0973-453a20af556e@gmail.com>
Date: Mon, 14 Jan 2019 23:26:02 +0200
MIME-Version: 1.0
In-Reply-To: <20190114124246.6de38d67.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/3] contrib/rdmacm-mux: fix clang
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, yuval.shaia@oracle.com, qemu-stable@nongnu.org

Hi Cornelia,

On 1/14/19 1:42 PM, Cornelia Huck wrote:
> On Sat, 12 Jan 2019 17:02:22 +0200
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>
>> Fix Commit a5d2f6f877 (contrib/rdmacm-mux: Add implementation
>>                         of RDMA User MAD multiplexer).
>>
>> The above commit introduces a new contrib target, adding a global dependency
>> to libumad library in case pvrdma configuration option is enabled.
>> Clang forbids it:
>>      clang-6.0: error: -libumad: 'linker' input unused
>>                [-Werror,-Wunused-command-line-argument]
>>
>> Fix by limiting the scope to the rdmacm-mux target itself.
>> Fix related clang errors while at it.
>>
>> Marcel Apfelbaum (3):
>>    contrib/rdmacm-mux: remove Wno-format-truncation flag
>>    hw/rdma: modify struct initialization
>>    contrib/rdmacm-mux: fix clang compilation
>>
>>   Makefile                         |  2 ++
>>   contrib/rdmacm-mux/Makefile.objs |  1 -
>>   contrib/rdmacm-mux/main.c        | 18 +++++++++++++-----
>>   hw/rdma/rdma_backend.c           | 16 ++++++++++++----
>>   4 files changed, 27 insertions(+), 10 deletions(-)
>>
> This fixes building on x86 with clang 6 for me. On s390x with clang 7,
> I run into further problems when building the s390-ccw bios (the
> maintainers are aware of that), but the rdma-related errors are gone.
>
> Tested-by: Cornelia Huck <cohuck@redhat.com>

Appreciated,
Marcel
