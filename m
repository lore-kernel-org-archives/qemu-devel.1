Received: from eggs.gnu.org ([2001:4830:134:3::10]:55761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dI4fu-0008Sl-W4
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dI4fr-0005Av-QZ
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:56:55 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dI4fr-00059l-IR
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:56:51 -0400
Received: by mail-pg0-x242.google.com with SMTP id v14so8000388pgn.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 19:56:49 -0700 (PDT)
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<593509FB.3070605@huawei.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <7f5df260-63e3-7f7e-ff79-d2bc6fbf57f9@gmail.com>
Date: Tue, 6 Jun 2017 10:56:55 +0800
MIME-Version: 1.0
In-Reply-To: <593509FB.3070605@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jay Zhou <jianjay.zhou@huawei.com>, pbonzini@redhat.com, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: Xiao Guangrong <xiaoguangrong@tencent.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org



On 06/05/2017 03:36 PM, Jay Zhou wrote:

>>   /* enable ucontrol for s390 */
>>   struct kvm_s390_ucas_mapping {
>> diff --git a/memory.c b/memory.c
>> index 4c95aaf..b836675 100644
>> --- a/memory.c
>> +++ b/memory.c
>> @@ -809,6 +809,13 @@ static void address_space_update_ioeventfds(AddressSpace *as)
>>       flatview_unref(view);
>>   }
>>
>> +static write_protect_all_fn write_func;
> 
> I think there should be a declaration in memory.h,
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 7fc3f48..31f3098 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -1152,6 +1152,9 @@ void memory_global_dirty_log_start(void);
>    */
>   void memory_global_dirty_log_stop(void);
> 
> +typedef void (*write_protect_all_fn)(bool write);
> +void memory_register_write_protect_all(write_protect_all_fn func);
> +
>   void mtree_info(fprintf_function mon_printf, void *f);
> 

Thanks for your suggestion, Jay!

This code just demonstrates how to enable this feature in QEMU, i will
carefully consider it and merger your suggestion when the formal patch
is posted out.
