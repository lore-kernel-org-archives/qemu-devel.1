Received: from eggs.gnu.org ([209.51.188.92]:42670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gj9gJ-000427-5F
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gj9gI-0004et-FR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 16:22:03 -0500
References: <20190112150225.20294-1-marcel.apfelbaum@gmail.com>
	<20190112150225.20294-3-marcel.apfelbaum@gmail.com>
	<20190114124738.547739c3.cohuck@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <149c3c9c-f8b4-5700-3678-1a31b753b720@gmail.com>
Date: Mon, 14 Jan 2019 23:22:10 +0200
MIME-Version: 1.0
In-Reply-To: <20190114124738.547739c3.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/rdma: modify struct initialization
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

On 1/14/19 1:47 PM, Cornelia Huck wrote:
> On Sat, 12 Jan 2019 17:02:24 +0200
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>
>> Do not initialize structs with {0} since some
>> CLANG versions do not support it.
>>
>> Use memset instead.
> Can't you use {} instead? (See, for example, commit ebf2a499a5c).

I'll try it.

Thanks,
Marcel

>
>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> ---
>>   contrib/rdmacm-mux/main.c | 12 +++++++++---
>>   hw/rdma/rdma_backend.c    | 16 ++++++++++++----
>>   2 files changed, 21 insertions(+), 7 deletions(-)
