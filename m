Received: from eggs.gnu.org ([2001:4830:134:3::10]:50483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Q8N-0003ev-TK
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:13:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Q8N-0004GL-3S
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:13:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Q8M-0004G8-TQ
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 06:13:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E7C1F63E3B
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 10:13:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <ef836dcc-8482-9749-5597-0806704ebd26@redhat.com> (Paolo
	Bonzini's message of "Tue, 18 Apr 2017 11:45:14 +0200")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-6-quintela@redhat.com>
	<ef836dcc-8482-9749-5597-0806704ebd26@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 12:13:16 +0200
Message-ID: <87d1cahvlv.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/19] migration: Export exec.c functions
 in its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 17/04/2017 22:00, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/exec.h      | 20 ++++++++++++++++++++
>
> Good cleanup, but please move it to migration/exec.h and include it with
> "exec.h".  This is the standard for files that are not needed outside
> that particular directory.

Aha, thanks.  I was thinking about creating something "internal", but
that makes sense.

Later, Juan.
