Received: from eggs.gnu.org ([2001:4830:134:3::10]:51972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chHNq-0002sK-Jv
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1chHNn-0004eA-Ia
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1chHNn-0004dh-DU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 10:02:07 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7538580496
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 15:02:07 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-18-git-send-email-armbru@redhat.com>
	<6ab9e2cd-edbe-b167-8a16-bf9c00c110ac@redhat.com>
Date: Fri, 24 Feb 2017 16:02:03 +0100
In-Reply-To: <6ab9e2cd-edbe-b167-8a16-bf9c00c110ac@redhat.com> (Paolo
	Bonzini's message of "Fri, 24 Feb 2017 10:27:15 +0100")
Message-ID: <87bmtraaz8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 17/21] qapi: Drop unused non-strict qobject
 input visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 23/02/2017 22:45, Markus Armbruster wrote:
>> The split between tests/test-qobject-input-visitor.c and
>> tests/test-qobject-input-strict.c now makes less sense than ever.  The
>> next commit will take care of that.
>
> I'm actually adding a use for non-strict visitors (and one that makes
> sense IMHO, with comments, testcases and all that :)).  See
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg432069.html.

I replied.

> For what it's worth, however, I believe that even non-strict visits
> should detect unvisited list tails.

Bit of an asymmetry.  Not sure it matters, because to not visit list
tails, you have to put in some effort.
