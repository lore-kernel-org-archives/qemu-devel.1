Received: from eggs.gnu.org ([2001:4830:134:3::10]:36539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzj4b-0008HY-Ag
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:46:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dzj4X-00022u-D2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dzj4X-00020d-6g
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F29E94E33E
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 12:46:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <18ba5f7e-0d7e-fc5e-6cff-36ede10233f0@redhat.com> (Thomas Huth's
	message of "Wed, 4 Oct 2017 14:33:55 +0200")
References: <20171004103933.7898-1-quintela@redhat.com>
	<20171004103933.7898-2-quintela@redhat.com>
	<18ba5f7e-0d7e-fc5e-6cff-36ede10233f0@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 04 Oct 2017 14:46:34 +0200
Message-ID: <87infvgjx1.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/6] tests: Add basic migration precopy test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 04.10.2017 12:39, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>
> Looks like a lot of this code is the same or very similar to the code in
> postcopy-test.c ... would it make sense to factor-out that code there
> into a separate file that could be used by both tests, so that we do not
> have to maintain the code twice?


I think I put that on the cover letter,  my idea is to add the postcopy
test here.  This is a streamlined version of the postcopy-test, just a
barebones, and insntead of doing things by hand, I added helpers like:

migrate_set_parameter(...);

You can see that on the following patches I added support for:
- tcp
- precopy with deprecated commands
- xbzrle
- compression threads (not working at the momment, have to investigate
  why).

Idea is if people like the approach to add on top of that:
- exec: migration (needs changes because command line option on source
  and destination are different)
- fd: Dunno how difficult is, I have really never passed fd's around.
- postocpy: It needs additional commandsn to be added.

- Probably move to use events, instead of "waiting" for 1st stage to
  finish.

Right now, the three tests on my laptop require around 14 seconds (not
running in parallel).  I want to "optimize" the tests to take a bit less
time.

Later, Juan.
