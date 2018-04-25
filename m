Received: from eggs.gnu.org ([2001:4830:134:3::10]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBTLQ-000417-Bm
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 18:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fBTLN-0005Sw-85
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 18:57:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47438 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fBTLN-0005S9-2z
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 18:56:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8D3F81A88BE
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 22:56:51 +0000 (UTC)
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-6-lersek@redhat.com>
	<877eovahoq.fsf@dusky.pond.sub.org>
	<5ffb031a-554a-81c1-b374-eb82f410bf83@redhat.com>
	<ccb8aaa0-c523-8360-be73-749cf08d074f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <7cc33c11-1a6f-1cf8-8115-f0cd4633a482@redhat.com>
Date: Thu, 26 Apr 2018 00:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <ccb8aaa0-c523-8360-be73-749cf08d074f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] qapi: extract CpuInfoCommon to
 mitigate schema duplication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 04/25/18 21:12, Eric Blake wrote:
> On 04/25/2018 08:20 AM, Laszlo Ersek wrote:
> 
>> ...
>>
>> and people would ask themselves ever after, "are there some common
>> fields in there that we could extract ... hmmm, @props and @arch, okay,
>> maybe, maybe not, grey area". Let's do it now and save them the thinking.
> 
> No, CpuInfo is slated for death in the next year or so; per commit
> ff9a9156.  Once it disappears (in 2.14 or 2.15?), we will ONLY have
> CpuInfoFast (although we might rename it at that time, as the name of
> QMP structs is not part of the introspection interface).
> 
> So, my personal inclination is to just live with the mindless
> near-duplication until the deprecation period ends, rather than wasting
> cycles refactoring things just to refactor it back out when removing the
> dead code later.
> 

This is an important update; thank you for it. Because, it tells me that
we might not need to add @target to CpuInfo at all. Why *extend* an
interface that is deprecated to the point that we're reluctant even to
*refactor* it?

(BTW, I had noticed the deprecation note in the schema source code, from
what you've now identified as commit ff9a9156; I didn't know what it
meant -- I didn't know it carried a removal sentence.)

The consequence is that I could drop the painful modifications for
qmp_query_cpus() altogether, and just keep the simple ones for
qmp_query_cpus_fast().

Markus, does that work for you? Forget about @CpuInfo for good?

Thanks,
Laszlo
