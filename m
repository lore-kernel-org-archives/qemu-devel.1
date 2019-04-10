Received: from eggs.gnu.org ([209.51.188.92]:46608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5TT-0006lY-JX
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5TS-0000dU-OI
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:08:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hE5TS-0000d9-Gf
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96F2E821D8
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 05:08:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-13-armbru@redhat.com>
	<20190409180028.GE2964@work-vm>
Date: Wed, 10 Apr 2019 07:08:35 +0200
In-Reply-To: <20190409180028.GE2964@work-vm> (David Alan Gilbert's message of
	"Tue, 9 Apr 2019 19:00:29 +0100")
Message-ID: <87h8b64fcc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 12/15] qemu-print: New qemu_printf(),
 qemu_vprintf() etc.
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
>> We commonly want to print to the current monitor if we have one, else
>> to stdout/stderr.  For stderr, have error_printf().  For stdout, all
>> we have is monitor_vfprintf(), which is rather unwieldy.  We often
>> print to stderr just because error_printf() is easier.
>> 
>> New qemu_printf() and qemu_vprintf() do exactly what's needed.  The
>> next commits will put them to use.
>> 
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> OK, it seems a little odd not to have the fprintf as well, but OK.

Wait for my next series touching this :)

> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!
