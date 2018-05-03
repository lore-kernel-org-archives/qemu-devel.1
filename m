Received: from eggs.gnu.org ([2001:4830:134:3::10]:36709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fE4hJ-0000ya-6K
	for qemu-devel@nongnu.org; Wed, 02 May 2018 23:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fE4hE-0006uy-5a
	for qemu-devel@nongnu.org; Wed, 02 May 2018 23:14:21 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:44803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fE4hD-0006st-Tw
	for qemu-devel@nongnu.org; Wed, 02 May 2018 23:14:16 -0400
Received: by mail-pf0-x241.google.com with SMTP id q22so13491972pff.11
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 20:14:15 -0700 (PDT)
References: <20180428081045.8878-1-xiaoguangrong@tencent.com>
	<20180502024653.GB25938@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <6e4363d3-3d66-547f-a374-fb82fb890607@gmail.com>
Date: Thu, 3 May 2018 11:13:40 +0800
MIME-Version: 1.0
In-Reply-To: <20180502024653.GB25938@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] migration: fix saving normal page even if
 it's been compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/02/2018 10:46 AM, Peter Xu wrote:
> On Sat, Apr 28, 2018 at 04:10:45PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Fix the bug introduced by da3f56cb2e767016 (migration: remove
>> ram_save_compressed_page()), It should be 'return' rather than
>> 'res'
>>
>> Sorry for this stupid mistake :(
>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> So is that only a performance degradation without this fix (since
> AFAIU the compressing pages will be sent twice)?  Thanks,

Yes, that's why we did not detect it in our test.　:(
