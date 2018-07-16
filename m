Received: from eggs.gnu.org ([2001:4830:134:3::10]:38615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fex8J-0005OY-IN
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:37:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fex8G-0003QA-Es
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:37:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fex8G-0003Pm-9N
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 02:37:16 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6B898315E
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:37:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-18-armbru@redhat.com>
	<87h8l4lmqw.fsf@secure.mitica>
Date: Mon, 16 Jul 2018 08:37:14 +0200
In-Reply-To: <87h8l4lmqw.fsf@secure.mitica> (Juan Quintela's message of "Thu,
	12 Jul 2018 13:25:11 +0200")
Message-ID: <87pnznit45.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/20] migration-test: Clean up string
 interpolation into QMP, part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Juan Quintela <quintela@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> wrote:
>> Leaving interpolation into JSON to qmp() is more robust than building
>> QMP input manually, as explained in the recent commit "tests: Clean up
>> string interpolation into QMP input (simple cases)".
>>
>> migrate_recover() builds QMP input manually because wait_command()
>> can't interpolate.  Well, it can since the previous commit.  Simplify
>> accordingly.
>>
>> Bonus: gets rid of a non-literal format string.  A step towards
>> compile-time format string checking without triggering
>> -Wformat-nonliteral.
>>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> Why, o why it needs to be so difficult!!!

At least the series improves the interface from Rusty's API level -4
"Follow common convention and you'll get it wrong" to API level 4
"Follow common convention and you'll get it right", and for some kind of
mistakes even to API level 8 "The compiler will warn if you get it
wrong."

Thanks!
