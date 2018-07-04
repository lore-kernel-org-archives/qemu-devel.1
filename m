Received: from eggs.gnu.org ([2001:4830:134:3::10]:57738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fabpM-0008NB-0Y
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 03:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fabpI-0002Py-Rm
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 03:03:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fabpI-0002PO-N8
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 03:03:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B6BE81A4EB9
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 07:03:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87sh52b3bp.fsf_-_@dusky.pond.sub.org> <20180704054405.GB2568@xz-mi>
Date: Wed, 04 Jul 2018 09:03:40 +0200
In-Reply-To: <20180704054405.GB2568@xz-mi> (Peter Xu's message of "Wed, 4 Jul
	2018 13:44:05 +0800")
Message-ID: <871scjiisz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jul 02, 2018 at 07:43:06AM +0200, Markus Armbruster wrote:
>> More lose ends:
>> 
>> * scripts/qmp/ doesn't support OOB, yet.  qmp-shell.py in particular
>> 
>> * test-qmp-cmds neglects to cover the OOB additions to qmp-dispatch.c
>
> Would you mind I put these aside for now?
>
> I'm afraid things grow then we lose control, so not sure whether I can
> just focus on the bugs first (e.g., the COMMAND_DROP event
> broadcasting, and also the response queue flow control issue).

I agree we need to focus and prioritize.

Any lose ends we can't fix right away we should document with suitable
TODO or FIXME comments.

We can also try to spread the load onto more shoulders.  Perhaps
qmp-shell could be updated by someone who actually uses it.
