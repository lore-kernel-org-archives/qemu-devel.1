Received: from eggs.gnu.org ([2001:4830:134:3::10]:55879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnmNv-0001Ov-LG
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:21:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnmNr-0000ix-U2
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:21:07 -0400
Received: from [59.151.112.132] (port=23903 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnmNr-0000eI-IH
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:21:03 -0400
Date: Tue, 14 Mar 2017 21:20:25 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Message-ID: <20170314132025.GB2473@localhost.localdomain>
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
	<87o9x4t51k.fsf@secure.mitica> <20170314123730.GO2652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170314123730.GO2652@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Output dirty-bytes-rate instead of
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, eblake@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Mar 14, 2017 at 12:37:30PM +0000, Daniel P. Berrange wrote:
>On Tue, Mar 14, 2017 at 01:29:43PM +0100, Juan Quintela wrote:
>> Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>> > In hmp, dirty-bytes-rate is more friendly than dirty-pages-rate.
>> > It's also better for other tools to determine the cpu throttle
>> > value in different architecture.
>> >
>> > Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> 
>> I agree with Daniel here, you can't change the meaning of a field.  Look
>> at skipped pages.  It is zero know because it is not used anymore, but
>> we can't drop it.
>> 
>> I think it is better to expose page_size.  We have now
>> 
>> trasferred: bytes
>> total: bytes
>> duplicate: number of zero pages
>> skipped: always zero.
>> normal: number of normal pages
>> normal_bytes: the same  in bytes
>> mbps: megabytes per second?  I can't even remember this one
>> dirty_sync_count: number of times we have go through the whole memory
>> postcopy_requests = number of pages asked by postcopy faults?
>> dirty_pages_rate = pages by some kind of unit
>> 
>> And we haven't yet started with compression or xbzrle.  I think that the
>> best approach at this point is putting everything in pages except the
>> things that don't make sense.
>> 
>> We can put everything on bytes, but then everything is HUGE.
>> 
>> Anyways, what do libvirt/management apps preffer?
>
>Since we have many fields already which are reported as page counts, I
>think just adding page size would be preferrable to having twice as many
>fields reported duplicating bytes + pages.
OK.

>
>The only reason to favour duplicating all fields to report bytes, is if
>we needed to vary page size to deal with huge pages (eg if some reported
>pages were 4kb and other reported pages with 2MB). You can easily just
>scale huge pages counts to be "normal"  pages for purpose of reporting

Thank you very much for your help!

Thanks,
Chao Fan
>though.
>Regards,
>Daniel
>-- 
>|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
>|: http://libvirt.org              -o-             http://virt-manager.org :|
>|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
>
>
