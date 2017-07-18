Received: from eggs.gnu.org ([2001:4830:134:3::10]:35643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUnr-0003I9-JU
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUnn-0005aB-OZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:52:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dXUnn-0005Zf-Il
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 55C1E90907
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 15:52:46 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170717155632.12754-1-eblake@redhat.com>
	<3070e28e-7676-3397-0f8f-8810ae1f6ece@redhat.com>
Date: Tue, 18 Jul 2017 17:52:44 +0200
In-Reply-To: <3070e28e-7676-3397-0f8f-8810ae1f6ece@redhat.com> (Eric Blake's
	message of "Mon, 17 Jul 2017 11:02:35 -0500")
Message-ID: <87iniprbcj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/5] Easier conversion from qapi to qobject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 07/17/2017 10:56 AM, Eric Blake wrote:
>> I'm not sure if I'm posted this before, or if it is a cleanup I've
>> just been sitting on locally.  In all likelihood, it will miss
>> tomorrow's freeze due to lack of review time, and thus be 2.11
>> material, but we'll see...

I had a quick glance.  Looks like a small improvement to me.  No need to
rush it into 2.10.  I suspect some (all?) of the remaining qobject
output visitor uses could also be converted.

> Answering myself, it was part of my larger (mostly-unreviewed) attempt
> to rip out dynamic JSON parsing [1]. But it is independent enough that
> it warrants its own thread for separate review.

Yes, splitting it out makes sense.  Thanks!

> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05425.html

[...]
