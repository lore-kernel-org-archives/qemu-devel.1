Received: from eggs.gnu.org ([209.51.188.92]:43504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0rn-0006BB-4j
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hF0rk-0005KK-VY
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hF0rf-0005Ds-GT
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:25:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11D2E81224
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 18:25:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190411152520.10061-1-armbru@redhat.com>
	<20190411152520.10061-9-armbru@redhat.com>
	<20190412174441.GM2906@work-vm>
Date: Fri, 12 Apr 2019 20:25:16 +0200
In-Reply-To: <20190412174441.GM2906@work-vm> (David Alan Gilbert's message of
	"Fri, 12 Apr 2019 18:44:42 +0100")
Message-ID: <878swfjd2r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 08/17] memory: Clean up how mtree_info()
 prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Markus Armbruster (armbru@redhat.com) wrote:
>> dump_drift_info() takes an fprintf()-like callback and a FILE * to
>
> ^^^^^^^^^^^^^^^^^^^ looks like the wrong function for this patch?

Pasto, will fix.

>> pass to it, and so do its helper functions.  Passing around callback
>> and argument is rather tiresome.
>> 
>> Its only caller hmp_info_mtree() passes monitor_printf() cast to
>> fprintf_function and the current monitor cast to FILE *.
>> 
>> The type-punning is technically undefined behaviour, but works in
>> practice.  Clean up: drop the callback, and call qemu_printf()
>> instead.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Other than the function name above,
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!
