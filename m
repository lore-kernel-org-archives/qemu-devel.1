Received: from eggs.gnu.org ([2001:4830:134:3::10]:44634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhrub-0005pH-5M
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:39:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhruY-0007as-16
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:39:13 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:40867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhruX-0007ae-Pc
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:39:09 -0400
Received: by mail-pg1-x543.google.com with SMTP id x5-v6so2271845pgp.7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 00:39:09 -0700 (PDT)
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-7-xiaoguangrong@tencent.com>
	<20180723050325.GF2491@xz-mi>
	<d0e8afdb-dafb-709b-15d5-7b33c086d6c7@gmail.com>
	<20180723082838.GJ2491@xz-mi>
	<bf5df13e-5b2a-ab5e-4cef-9e417b40347c@gmail.com>
	<20180723094021.GN2491@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <0647863e-dd2e-a761-9c3c-7a24b11a5f01@gmail.com>
Date: Tue, 24 Jul 2018 15:39:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180723094021.GN2491@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/8] migration: move handle of zero page
 to the thread
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



On 07/23/2018 05:40 PM, Peter Xu wrote:
> On Mon, Jul 23, 2018 at 04:44:49PM +0800, Xiao Guangrong wrote:
> 
> [...]
> 
>>>>
>>>> However, it is not safe to do ram_release_pages in the thread as it's
>>>> not protected it multithreads. Fortunately, compression will be disabled
>>>> if it switches to post-copy, so i preferred to keep current behavior and
>>>> deferred to fix it after this patchset has been merged.
>>>
>>> Do you mean ram_release_pages() is not thread-safe?  Why?  I didn't
>>> notice it before but I feel like it is safe.
>>
>> bitmap_clear() called in the function is not safe.
> 
> Yeah, and the funny thing is that I don't think ram_release_pages()
> should even touch the receivedmap...  It's possible that the
> release-ram feature for postcopy is broken.
> 
> Never mind on that.  I'll post a patch to fix it, then I think the
> ram_release_pages() will be thread safe.
> 
> Then this patch shouldn't be affected and it should be fine after that
> fix

That would be great, thanks for your work.
