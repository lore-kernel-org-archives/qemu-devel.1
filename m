Received: from eggs.gnu.org ([2001:4830:134:3::10]:43782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyud7-0000JA-Ji
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 02:55:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dyud3-0008DC-Tk
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 02:55:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dyud3-0008B0-O1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 02:55:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E17D13A91
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 06:55:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
	<7296576e-9f52-f385-7bde-d5c6d9de71b7@redhat.com>
Date: Mon, 02 Oct 2017 08:54:53 +0200
In-Reply-To: <7296576e-9f52-f385-7bde-d5c6d9de71b7@redhat.com> (Michal
	Privoznik's message of "Fri, 22 Sep 2017 15:14:47 +0200")
Message-ID: <87wp4eqbsy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 0/3] watchdog.h: Drop local redefinition
 of actions enum
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Michal Privoznik <mprivozn@redhat.com> writes:

> On 09/07/2017 10:05 AM, Michal Privoznik wrote:
>> diff to v4:
>> - in 3/3 compare passed action string case insensitively to the qapi enum
>> 
>> Michal Privoznik (3):
>>   qapi: Rename WatchdogExpirationAction enum
>>   watchdog.h: Drop local redefinition of actions enum
>>   watchdog: Allow setting action on the fly
>> 
>>  hw/watchdog/watchdog.c    | 65 ++++++++++++++++++++++++-----------------------
>>  hw/watchdog/wdt_diag288.c |  6 ++---
>>  include/sysemu/watchdog.h | 12 ++-------
>>  monitor.c                 |  4 +--
>>  qapi-schema.json          |  9 +++++++
>>  qapi/run-state.json       |  6 ++---
>>  6 files changed, 52 insertions(+), 50 deletions(-)
>> 
>
> Thanks for all the reviews. What do I need to get it pushed ;-)

Nothing, I'll take it.
