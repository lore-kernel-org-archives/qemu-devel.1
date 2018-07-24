Received: from eggs.gnu.org ([2001:4830:134:3::10]:43392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhrlM-0003cg-EE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fhrlJ-0003x7-9J
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:29:40 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:37421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fhrlJ-0003vS-3A
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 03:29:37 -0400
Received: by mail-pl0-x244.google.com with SMTP id 31-v6so1366655plc.4
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 00:29:36 -0700 (PDT)
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-9-xiaoguangrong@tencent.com>
	<20180723054903.GH2491@xz-mi>
	<5447275f-fe48-ec8f-399c-1a5530417f65@gmail.com>
	<20180723083551.GK2491@xz-mi>
	<b4c7fc2c-5cfe-c207-9c35-060ad0d35f59@gmail.com>
	<20180723090121.GL2491@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <b0f34c1c-df64-6696-e2b0-5050f5388873@gmail.com>
Date: Tue, 24 Jul 2018 15:29:27 +0800
MIME-Version: 1.0
In-Reply-To: <20180723090121.GL2491@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] migration: do not
 flush_compressed_data at the end of each iteration
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



On 07/23/2018 05:01 PM, Peter Xu wrote:

>> Yes, it's sufficient for current thread model, will drop it for now
>> and add it at the time when the lockless mutilthread model is applied. :)
> 
> Ah I think I see your point.  Even if so I would think it better to do
> any extra cleanup directly in compress_threads_save_cleanup() if
> possible.
> 

Okay, got it.
