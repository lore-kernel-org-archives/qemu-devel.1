Received: from eggs.gnu.org ([209.51.188.92]:50781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH0PT-0002CQ-8w
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hH0PS-0004a9-9c
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:20:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hH0PO-0004Qj-W5
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 02:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B06353002725
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 06:20:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190417191805.28198-1-armbru@redhat.com>
	<20190417191805.28198-16-armbru@redhat.com>
	<73b3a105-a554-484b-1ba2-4107f3538584@redhat.com>
Date: Thu, 18 Apr 2019 08:20:26 +0200
In-Reply-To: <73b3a105-a554-484b-1ba2-4107f3538584@redhat.com> (Eric Blake's
	message of "Wed, 17 Apr 2019 14:35:34 -0500")
Message-ID: <874l6vrg0l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 15/17] monitor: Clean up how
 monitor_disas() funnels output to monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 4/17/19 2:18 PM, Markus Armbruster wrote:
>> INIT_DISASSEMBLE_INFO() takes an fprintf()-like callback and a FILE *
>> to pass to it.  monitor_disas() passes monitor_fprintf() and the
>> current monitor cast to FILE *.  monitor_fprintf() casts it right
>> back, and is otherwise identical to monitor_printf().  The
>> type-pinning is ugly.
>
> For consistency with other patches in the series, s/pinning/punning/

Typo, will fix.  Thanks!

>> 
>> Pass qemu_fprintf() and NULL instead.
>> 
>> monitor_fprintf() is now unused; delete it.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
