Received: from eggs.gnu.org ([2001:4830:134:3::10]:59289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0ReM-0002ug-7a
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1g0ReI-0000iJ-9W
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1g0ReI-0000fr-1k
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:27:10 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <575ca9d8-ed64-abdf-4c88-e25da4f17b22@gmail.com> (Xiao
	Guangrong's message of "Thu, 13 Sep 2018 15:45:20 +0800")
References: <20180906070101.27280-1-xiaoguangrong@tencent.com>
	<87k1ny51nf.fsf@trasno.org>
	<575ca9d8-ed64-abdf-4c88-e25da4f17b22@gmail.com>
Reply-To: quintela@redhat.com
Date: Thu, 13 Sep 2018 15:26:56 +0200
Message-ID: <877ejpr0in.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 0/3] migration: compression optimization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

Xiao Guangrong <guangrong.xiao@gmail.com> wrote:
> On 09/06/2018 07:03 PM, Juan Quintela wrote:
>> guangrong.xiao@gmail.com wrote:
>>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>>
>>> Changelog in v6:
>>>
>>> Thanks to Juan's review, in this version we
>>> 1) move flush compressed data to find_dirty_block() where it hits the end
>>>     of memblock
>>> 2) use save_page_use_compression instead of migrate_use_compression in
>>>     flush_compressed_data
>>>
>>> Xiao Guangrong (3):
>>>    migration: do not flush_compressed_data at the end of iteration
>>>    migration: show the statistics of compression
>>>    migration: use save_page_use_compression in flush_compressed_data
>>>
>>>   hmp.c                 | 13 +++++++++++
>>>   migration/migration.c | 12 ++++++++++
>>>   migration/ram.c       | 63 +++++++++++++++++++++++++++++++++++++++++++--------
>>>   migration/ram.h       |  1 +
>>>   qapi/migration.json   | 26 ++++++++++++++++++++-
>>>   5 files changed, 105 insertions(+), 10 deletions(-)
>>
>> queued
>>
>
> Hi Juan,
>
> Could i ask where is the place you queued these patches, i did not found
> them on your git tree at
>    https://github.com/juanquintela/qemu migration/next or migration.next
>
> I am working on the next part of migration, it's more convenient to let
> it be based on your place. :)

They are there now, I send the pull request already.  I am going to be
on vacation for the following four weeks.  Migration issues will be
handled by David.

Thanks, Juan.
