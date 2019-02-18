Received: from eggs.gnu.org ([209.51.188.92]:58589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvrAk-0005XG-SN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvr2E-0007ZR-Kd
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:05:11 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36245)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvr2E-0007Z0-Bi
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:05:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so20030018wrw.3
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:05:10 -0800 (PST)
References: <20190214154053.15050-1-marcel.apfelbaum@gmail.com>
	<d1b36054-424a-e492-402f-0a3019953d05@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <36096697-95c3-46c6-17f8-f40320111491@redhat.com>
Date: Mon, 18 Feb 2019 23:05:08 +0100
MIME-Version: 1.0
In-Reply-To: <d1b36054-424a-e492-402f-0a3019953d05@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/rdma: another clang compilation fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: kamalheib1@gmail.com, qemu-stable@nongnu.org, yuval.shaia@oracle.com

On 2/17/19 8:51 AM, Marcel Apfelbaum wrote:
> 
> Cc:qemu-stable@nongnu.org

I doubt this is a security issue worth Cc'ing qemu-stable :)

> Thanks,
> Marcel
> 
> On 2/14/19 5:40 PM, Marcel Apfelbaum wrote:
>> Configuring QEMU with:
>>     configure --target-list="x86_64-softmmu" --cc=clang --enable-pvrdma
>> Results in:
>>     qemu/hw/rdma/rdma_rm_defs.h:108:3: error: redefinition of typedef
>> 'RdmaDeviceResources' is a C11 feature [-Werror,-Wtypedef-redefinition]
>>     } RdmaDeviceResources;
>>       ^
>>     qemu/hw/rdma/rdma_backend_defs.h:24:36: note: previous definition
>> is here
>>     typedef struct RdmaDeviceResources RdmaDeviceResources;
>>
>> Fix by removing one of the 'typedef' definitions.
>>
>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> ---
>>   hw/rdma/rdma_rm_defs.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/rdma/rdma_rm_defs.h b/hw/rdma/rdma_rm_defs.h
>> index 0ba61d1838..5e877c1fd9 100644
>> --- a/hw/rdma/rdma_rm_defs.h
>> +++ b/hw/rdma/rdma_rm_defs.h
>> @@ -96,7 +96,7 @@ typedef struct RdmaRmPort {
>>       enum ibv_port_state state;
>>   } RdmaRmPort;
>>   -typedef struct RdmaDeviceResources {
>> +struct RdmaDeviceResources {
>>       RdmaRmPort port;
>>       RdmaRmResTbl pd_tbl;
>>       RdmaRmResTbl mr_tbl;
>> @@ -105,6 +105,6 @@ typedef struct RdmaDeviceResources {
>>       RdmaRmResTbl cq_tbl;
>>       RdmaRmResTbl cqe_ctx_tbl;
>>       GHashTable *qp_hash; /* Keeps mapping between real and emulated */
>> -} RdmaDeviceResources;
>> +};
>>     #endif
> 
> 
