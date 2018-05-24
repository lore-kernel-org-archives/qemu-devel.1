Received: from eggs.gnu.org ([2001:4830:134:3::10]:42562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLvLn-00074n-M7
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLvLl-0001Uv-2t
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:52:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59190 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fLvLk-0001Uh-Uc
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F58C4022407
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 18:52:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <64410e07-30ba-c714-e3f4-99149ad22a76@redhat.com> (John Snow's
	message of "Thu, 24 May 2018 13:50:08 -0400")
References: <20180523091411.1073-1-quintela@redhat.com>
	<64410e07-30ba-c714-e3f4-99149ad22a76@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 24 May 2018 20:52:27 +0200
Message-ID: <87603cvqc4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: fix exec/fd migrations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

John Snow <jsnow@redhat.com> wrote:
> On 05/23/2018 05:14 AM, Juan Quintela wrote:
>> Commit:
>> 
>> commit 36c2f8be2c4eb0003ac77a14910842b7ddd7337e
>> Author: Juan Quintela <quintela@redhat.com>
>> Date:   Wed Mar 7 08:40:52 2018 +0100
>> 
>>     migration: Delay start of migration main routines
>> 
>> Missed tcp and fd transports.  This fix its.
>> 
>> Reported-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Fixes things for me, but I see that Peter Xu has more concerns.
>
> Would be happy with checking this in for now and following up with
> better refactors so that iotests works again in the meantime.
>
> Tested-by: John Snow <jsnow@redhat.com>

That is my plan.  Will send a pull request Tomorrow, and we can go from
there.  Peter suggestion is good but requires developtemt and testing.

Thanks, Juan.
