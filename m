Received: from eggs.gnu.org ([2001:4830:134:3::10]:57970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1g0MJj-00033r-WF
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1g0MJf-0004PO-Ca
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:45:35 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:36863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1g0MJf-0004Nl-51
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:45:31 -0400
Received: by mail-pg1-x543.google.com with SMTP id d1-v6so2358947pgo.3
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 00:45:30 -0700 (PDT)
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
	<87k1ny51nf.fsf@trasno.org>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <575ca9d8-ed64-abdf-4c88-e25da4f17b22@gmail.com>
Date: Thu, 13 Sep 2018 15:45:20 +0800
MIME-Version: 1.0
In-Reply-To: <87k1ny51nf.fsf@trasno.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/3] migration: compression optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 09/06/2018 07:03 PM, Juan Quintela wrote:
> guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Changelog in v6:
>>
>> Thanks to Juan's review, in this version we
>> 1) move flush compressed data to find_dirty_block() where it hits the end
>>     of memblock
>> 2) use save_page_use_compression instead of migrate_use_compression in
>>     flush_compressed_data
>>
>> Xiao Guangrong (3):
>>    migration: do not flush_compressed_data at the end of iteration
>>    migration: show the statistics of compression
>>    migration: use save_page_use_compression in flush_compressed_data
>>
>>   hmp.c                 | 13 +++++++++++
>>   migration/migration.c | 12 ++++++++++
>>   migration/ram.c       | 63 +++++++++++++++++++++++++++++++++++++++++++--------
>>   migration/ram.h       |  1 +
>>   qapi/migration.json   | 26 ++++++++++++++++++++-
>>   5 files changed, 105 insertions(+), 10 deletions(-)
> 
> queued
> 

Hi Juan,

Could i ask where is the place you queued these patches, i did not found
them on your git tree at
    https://github.com/juanquintela/qemu migration/next or migration.next

I am working on the next part of migration, it's more convenient to let
it be based on your place. :)

Thanks!
