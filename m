Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewl6d-0000c3-3Q
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:52:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1ewl6Y-0004kB-8R
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:52:55 -0400
Received: from mail-it0-x235.google.com ([2607:f8b0:4001:c0b::235]:34474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1ewl6Y-0004jr-28
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:52:50 -0400
Received: by mail-it0-x235.google.com with SMTP id z7-v6so1412998iti.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 01:52:49 -0700 (PDT)
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-5-xiaoguangrong@tencent.com>
	<20180315113759.GD3062@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <7c48472f-d2b9-5b69-c427-c8f96ff71f9f@gmail.com>
Date: Fri, 16 Mar 2018 16:52:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180315113759.GD3062@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/8] migration: introduce
 control_save_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/15/2018 07:37 PM, Dr. David Alan Gilbert wrote:
> * guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Abstract the common function control_save_page() to cleanup the code,
>> no logic is changed
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 

Thank you, Dave!

>>   
>> +/*
>> + * @pages: the number of pages written by the control path,
>> + *        < 0 - error
>> + *        > 0 - number of pages written
> 
> What about 0 !
> 

The control patch does not support 0 (means duplication). :)

Based on the implementation of qemu_rdma_save_page(), if any data
is properly posted out, @bytes_sent is set to 1, otherwise a error
is detected...
