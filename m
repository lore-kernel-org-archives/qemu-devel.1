Received: from eggs.gnu.org ([209.51.188.92]:40463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gw48G-0008Uk-0A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:04:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gw48D-0007v4-4r
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:04:15 -0500
References: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
	<d1b36054-424a-e492-402f-0a3019953d05@gmail.com>
	<36096697-95c3-46c6-17f8-f40320111491@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <79797be5-38c3-13ff-80e3-6cf6d98e418e@gmail.com>
Date: Tue, 19 Feb 2019 14:04:39 +0200
MIME-Version: 1.0
In-Reply-To: <36096697-95c3-46c6-17f8-f40320111491@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: another clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: kamalheib1@gmail.com, qemu-stable@nongnu.org, yuval.shaia@oracle.com


Hi Philippe,

On 2/19/19 12:05 AM, Philippe Mathieu-Daudé wrote:
> On 2/17/19 8:51 AM, Marcel Apfelbaum wrote:
>> Cc:qemu-stable@nongnu.org
> I doubt this is a security issue worth Cc'ing qemu-stable :)
>

I thought it worth adding a compilation fix to the stable branch.

Thanks,
Marcel

>> Thanks,
>> Marcel
>>
>> On 2/14/19 5:40 PM, Marcel Apfelbaum wrote:
>>> Configuring QEMU with:
>>>      configure --target-list="x86_64-softmmu" --cc=clang --enable-pvrdma
>>> Results in:
>>>      qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef
>>> 'RdmaDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
>>>      } RdmaDeviceResources;
>>>        ^
>>>      qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition
>>> is here
>>>      typedef struct RdmaDeviceResources RdmaDeviceResources;
>>>
>>> Fix by removing one of the 'typedef' definitions.
>>>
>>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>
>>> ---
>>>    hw/rdma/rdma_rm_defs.h | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
>>> index 0ba61d1838..5e877c1fd9 100644
>>> --- a/hw/rdma/rdma_rm_defs.h
>>> +++ b/hw/rdma/rdma_rm_defs.h
>>> @@ -96,7 +96,7 @@ typedef struct RdmaRmPort {
>>>        enum ibv_port_state state;
>>>    } RdmaRmPort;
>>>    -typedef struct RdmaDeviceResources {
>>> +struct RdmaDeviceResources {
>>>        RdmaRmPort port;
>>>        RdmaRmResTbl pd_tbl;
>>>        RdmaRmResTbl mr_tbl;
>>> @@ -105,6 +105,6 @@ typedef struct RdmaDeviceResources {
>>>        RdmaRmResTbl cq_tbl;
>>>        RdmaRmResTbl cqe_ctx_tbl;
>>>        GHashTable *qp_hash; /* Keeps mapping between real and emulated */
>>> -} RdmaDeviceResources;
>>> +};
>>>      #endif
>>
