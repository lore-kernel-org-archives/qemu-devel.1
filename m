Received: from eggs.gnu.org ([2001:4830:134:3::10]:57771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz4LB-0005Z7-N5
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:17:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz4L8-0005mH-IU
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:17:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz4L8-0005ly-CW
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 13:17:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DD4B3DE40
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 17:17:09 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <150694455954.126.4260615671927745603@b58463cdfd5f>
	<37ea08c6-ec95-2ab6-13dd-db9d270bfe5a@redhat.com>
Date: Mon, 02 Oct 2017 19:17:05 +0200
In-Reply-To: <37ea08c6-ec95-2ab6-13dd-db9d270bfe5a@redhat.com> (Eric Blake's
	message of "Mon, 2 Oct 2017 09:36:03 -0500")
Message-ID: <87lgkt1nce.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/3] QAPI patches for 2017-10-02
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com
List-ID: <qemu-devel.nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/02/2017 06:42 AM, no-reply@patchew.org wrote:
>> Hi,
>> 
>> This series seems to have some coding style problems. See output below for
>> more information:
>> 
>
>> Checking PATCH 2/3: watchdog.h: Drop local redefinition of actions enum...
>> ERROR: braces {} are necessary for all arms of this statement
>> #57: FILE: hw/watchdog/watchdog.c:86:
>> +    if (action < 0)
>> [...]
>
> Pre-existing problem, but would indeed be easy to fix up as part of this
> series.  I don't know if that means Markus should respin the pull request?

I would've touched it up in my tree had I seen it in time, but I doubt
it's worth the bother now.
