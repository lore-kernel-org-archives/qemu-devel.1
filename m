Received: from eggs.gnu.org ([2001:4830:134:3::10]:32946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsW5Q-0008RS-An
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsW5N-0005Jf-6m
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:34:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsW5N-0005JF-1X
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:34:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74F7A804BAAC
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 16:34:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <9d025405-6302-6fa0-d7fe-f4d2a0db5ea7@redhat.com> (Thomas Huth's
	message of "Wed, 22 Aug 2018 12:18:04 +0200")
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-4-quintela@redhat.com>
	<9d025405-6302-6fa0-d7fe-f4d2a0db5ea7@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 18:34:11 +0200
Message-ID: <87pnyanyws.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 03/10] check: Only test isa-testdev when
 it is compiled in
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
> On 2018-08-22 11:54, Juan Quintela wrote:
>> Once there, untangle endianness-test and boot-serial-test.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> 
>> boot-serial-test don't depend on isa-testdev.  Thanks Thomas.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Please remove the duplicated Sob.

Found the problem!!!!

As the cool man that I am, I put the signed-off line with a hook.  And I
updated the hook to the last version in git upstream, to be, you know
cool.

And the new version don't check that the line is already there.

SOB=$(git var GIT_COMMITTER_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
git interpret-trailers --in-place --trailer "$SOB" "$COMMIT_MSG_FILE"

Will try to get it right.

Later, Juan.
