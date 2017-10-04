Received: from eggs.gnu.org ([2001:4830:134:3::10]:42392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzjOy-0001HT-CN
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzjOx-0006FV-Fm
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:07:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzjOx-0006Ej-9B
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:07:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D103780D6
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 13:07:50 +0000 (UTC)
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
	<18ba5f7e-0d7e-fc5e-6cff-36ede10233f0@redhat.com>
	<87infvgjx1.fsf@secure.laptop>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2031be1e-62d1-1605-1f11-24868fbbc635@redhat.com>
Date: Wed, 4 Oct 2017 15:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <87infvgjx1.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com

On 04.10.2017 14:46, Juan Quintela wrote:
> Thomas Huth <thuth@redhat.com> wrote:
>> On 04.10.2017 12:39, Juan Quintela wrote:
>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
>>
>> Looks like a lot of this code is the same or very similar to the code in
>> postcopy-test.c ... would it make sense to factor-out that code there
>> into a separate file that could be used by both tests, so that we do not
>> have to maintain the code twice?
> 
> 
> I think I put that on the cover letter,  my idea is to add the postcopy
> test here.
OK, then I think you should remove the duplicated functions from
postcopy-test.c in the same patch here, so that it is more obvious that
this is a code movement.

 Thomas

PS: Please also add an entry to MAINTAINERS for the new files if feasible.
