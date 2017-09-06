Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpbX7-0001wW-6P
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dpbX3-00047S-Vz
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:42:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dpbX3-00045u-QI
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:42:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADA41C047B67
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 14:42:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com> (Eric Blake's
	message of "Wed, 6 Sep 2017 09:00:51 -0500")
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-2-quintela@redhat.com>
	<7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 06 Sep 2017 16:42:18 +0200
Message-ID: <87pob351o5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 01/22] Revert "io: add new
 qio_channel_{readv, writev, read, write}_all functions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 09/06/2017 06:51 AM, Juan Quintela wrote:
>> This reverts commit d4622e55883211072621958d39ddaa73483d201e.
>
> But with no reason why?  What bugs are you fixing by reverting this?

I put it on the cover letter.  I am investigating *why* it fails on me.
It got the thread handed.

>
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/io/channel.h       |  90 ---------------------------------------
>>  io/channel.c               |  94 -----------------------------------------
>>  tests/io-channel-helpers.c | 102 +++++++++++++++++++++++++++++++++++++++++----
>>  3 files changed, 93 insertions(+), 193 deletions(-)
>>
>
> Looking ahead, I see 8/22 recreates qio_channel_readv_all (but not
> qio_channel_read_all); how does that differ from this one?
>
> Should you be squashing 1/22 and 8/22 into a single non-revert patch
> that just fixes bugs on top of what is already in the tree?

My plan is to fix whatever is there and see why it is failing.

> Also, have you seen my patches, that also fix bugs in the _all functions?
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01053.html

No, I have to take a look, thanks.

Thanks, Juan.
