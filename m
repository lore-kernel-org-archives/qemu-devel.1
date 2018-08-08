Received: from eggs.gnu.org ([2001:4830:134:3::10]:38005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnHyu-0008L8-5r
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fnHyr-0001I5-3J
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:30:04 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fnHyq-0001Ha-Qj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:30:01 -0400
Received: by mail-pf1-x442.google.com with SMTP id l9-v6so615417pff.9
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 23:30:00 -0700 (PDT)
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-9-xiaoguangrong@tencent.com>
	<20180808050846.GG24415@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <503d7733-e2e7-09c5-75a3-1e250f549065@gmail.com>
Date: Wed, 8 Aug 2018 14:29:52 +0800
MIME-Version: 1.0
In-Reply-To: <20180808050846.GG24415@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 08/10] migration: handle the error
 condition properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 08/08/2018 01:08 PM, Peter Xu wrote:
> On Tue, Aug 07, 2018 at 05:12:07PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> ram_find_and_save_block() can return negative if any error hanppens,
>> however, it is completely ignored in current code
> 
> Could you hint me where we'll return an error?
> 

I think control_save_page() may return a error condition but i am not
good at it ... Other places look safe _currently_. These functions were
designed to have error returned anyway.

> (Anyway I agree that the error handling is not that good, mostly
>   because the QEMUFile APIs does not provide proper return code, e.g.,
>   qemu_put_be64 returns void)
> 

Yes, it is, the returned error condition is mixed in file's API and
function's return value... :(
