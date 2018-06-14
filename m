Received: from eggs.gnu.org ([2001:4830:134:3::10]:45668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fTJ2g-0004lG-D8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fTJ2b-00038Y-Bk
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:35:22 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fTJ2a-00038N-Rc
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 23:35:17 -0400
Received: by mail-pf0-x242.google.com with SMTP id a63-v6so2497368pfl.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 20:35:16 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-5-xiaoguangrong@tencent.com>
	<20180613161723.GL2676@work-vm>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <f336272c-1922-800c-d8c1-9d3eb7fffd26@gmail.com>
Date: Thu, 14 Jun 2018 11:35:08 +0800
MIME-Version: 1.0
In-Reply-To: <20180613161723.GL2676@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/12] migration: introduce
 migration_update_rates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/14/2018 12:17 AM, Dr. David Alan Gilbert wrote:
> * guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> It is used to slightly clean the code up, no logic is changed
> 
> Actually, there is a slight change; iterations_prev is always updated
> when previously it was only updated with xbzrle on; still the change
> makes more sense.

Yes, indeed. I will update the changelog.
