Received: from eggs.gnu.org ([2001:4830:134:3::10]:45219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnkqY-00080w-Un
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnkqU-0008Ck-Ah
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:14:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnkqU-0008CP-54
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:14:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1714515552
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:14:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-10-git-send-email-armbru@redhat.com>
	<20170825160838.GL2090@work-vm> <87y3q42aym.fsf@dusky.pond.sub.org>
Date: Fri, 01 Sep 2017 14:14:40 +0200
In-Reply-To: <87y3q42aym.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 28 Aug 2017 13:22:41 +0200")
Message-ID: <87r2vq62fj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 09/16] qapi-schema: Collect migration
 stuff in qapi/migration.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
>
>> * Markus Armbruster (armbru@redhat.com) wrote:
>>> Cc: Juan Quintela <quintela@redhat.com>
>>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>>
>> Two thoughts:
>>   a) Do you actually want that as migration/migration.json?
>
> I'd prefer to keep the QAPI schema together.  But that could be my
> schema maintainer bias talking :)
>
>>   b) I'd prefer StrOrNull to be somewhere more central; Migration may be
>>   the only user, but it's not logically migration specific.
>
> Makes sense.  I'll move it to common.json.

Err, this patch already moves it there.

>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Thanks!
