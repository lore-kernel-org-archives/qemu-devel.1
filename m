Received: from eggs.gnu.org ([2001:4830:134:3::10]:45620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDR72-0002YE-Vu
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDR6z-0007Bo-U3
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:58:17 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:50471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDR6z-0007BG-ND
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:58:13 -0400
Received: by mail-wm0-x243.google.com with SMTP id t11so16936364wmt.0
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 01:58:13 -0700 (PDT)
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
	<20180430200223.4119-8-marcel.apfelbaum@gmail.com>
	<f68ec311-91fb-4823-2138-9e884343f2a2@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <8d9e3b42-8c46-5ef8-70fe-80366b464d0a@gmail.com>
Date: Tue, 1 May 2018 11:58:10 +0300
MIME-Version: 1.0
In-Reply-To: <f68ec311-91fb-4823-2138-9e884343f2a2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 7/7] hw/rdma: Fix possible out of bounds
 access to port GID index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, yuval.shaia@oracle.com



On 05/01/2018 12:14 AM, Eric Blake wrote:
> On 04/30/2018 03:02 PM, Marcel Apfelbaum wrote:
>> Make sure the backend GID index is less then port's
>> git table length.
>
> s/git/gid/
>

Thanks, I will fix in the pull request
Marcel

>>
>> Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>> Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
>> ---
>>   hw/rdma/rdma_backend.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
>> index 5c7b3d8949..e9ced6f9ef 100644
>> --- a/hw/rdma/rdma_backend.c
>> +++ b/hw/rdma/rdma_backend.c
>> @@ -774,7 +774,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev,
>>           goto out_destroy_comm_channel;
>>       }
>>   -    if (backend_dev->backend_gid_idx > port_attr.gid_tbl_len) {
>> +    if (backend_dev->backend_gid_idx >= port_attr.gid_tbl_len) {
>>           error_setg(errp, "Invalid backend_gid_idx, should be less 
>> than %d",
>>                      port_attr.gid_tbl_len);
>>           goto out_destroy_comm_channel;
>>
>
