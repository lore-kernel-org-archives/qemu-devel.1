Received: from eggs.gnu.org ([2001:4830:134:3::10]:47430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnoZW-0003xA-SO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnoZS-0003lN-Ur
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:41:14 -0400
Received: from [59.151.112.132] (port=29309 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fanc.fnst@cn.fujitsu.com>) id 1cnoZS-0003jc-JM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:41:10 -0400
Date: Tue, 14 Mar 2017 23:40:28 +0800
From: Chao Fan <fanc.fnst@cn.fujitsu.com>
Message-ID: <20170314154028.GA10433@localhost.localdomain>
References: <20170314102747.31395-1-fanc.fnst@cn.fujitsu.com>
	<7110d95e-d500-a1ee-c590-2f44460d9881@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7110d95e-d500-a1ee-c590-2f44460d9881@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com, caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

On Tue, Mar 14, 2017 at 09:54:34AM -0500, Eric Blake wrote:
>On 03/14/2017 05:27 AM, Chao Fan wrote:
>> In hmp, dirty-bytes-rate is more friendly than dirty-pages-rate.
>> It's also better for other tools to determine the cpu throttle
>> value in different architecture.
>> 
>> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> ---
>
>In addition to the (good) comments you've gotten on not breaking
>existing fields, and the choice between a single new field giving the
>page size (with all fields favoring pages) or lots of new fields giving
>bytes, I have another comment:
>
>> @@ -575,12 +572,15 @@
>>  # @postcopy-requests: The number of page requests received from the destination
>>  #        (since 2.7)
>>  #
>> +# @dirty-bytes-rate: how many bytes  dirtied by second by the
>> +#        guest (since 2.9)
>
>You've missed soft freeze.  Is this really bug-fix quality to be adding
>it into the release this late in the game for 2.9, or should it be
>deferred to 2.10?

Ok, I will change it.
Many thanks for your help.

Thanks,
Chao Fan

>
>And while this is just a new field to an existing command, rather than a
>new command entirely, it's also worth thinking about Markus' edict for
>testsuite coverage:
>https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg00296.html
>
>-- 
>Eric Blake   eblake redhat com    +1-919-301-3266
>Libvirt virtualization library http://libvirt.org
>
