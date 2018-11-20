Received: from eggs.gnu.org ([2001:4830:134:3::10]:47525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCjQ-0001dh-5z
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPCjM-0002ud-12
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:34:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPCjL-0002s8-Q4
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 15:34:43 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181120092542.13102-1-david@redhat.com>
	<20181120092542.13102-4-david@redhat.com>
Date: Tue, 20 Nov 2018 21:34:33 +0100
In-Reply-To: <20181120092542.13102-4-david@redhat.com> (David Hildenbrand's
	message of "Tue, 20 Nov 2018 10:25:36 +0100")
Message-ID: <87muq37ajq.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/9] qapi: Fix string-input-visitor to
 reject NaN and infinities
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

David Hildenbrand <david@redhat.com> writes:

> The string-input-visitor happily accepts NaN and inifities when parsing

Make that "infinities".

> numbers (doubles). They shouldn't. Fix that.
>
> Also, add two test cases, testing if "NaN" and "inf" is properly
> rejected.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

PS: I still owe you an analysis of backward compatibility impact.
