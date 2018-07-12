Received: from eggs.gnu.org ([2001:4830:134:3::10]:55668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdbZS-0008Sv-M6
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdbZN-0006Ti-Or
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:23:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdbZN-0006T3-Ju
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:23:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01F3340122C8
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 13:23:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-6-peterx@redhat.com>
	<87po0023ah.fsf@dusky.pond.sub.org> <20180706093932.GI23001@xz-mi>
	<87a7r4zekj.fsf@dusky.pond.sub.org> <20180710042743.GM23001@xz-mi>
	<87a7qxgf1c.fsf@dusky.pond.sub.org>
Date: Thu, 12 Jul 2018 15:23:35 +0200
In-Reply-To: <87a7qxgf1c.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 12 Jul 2018 08:10:39 +0200")
Message-ID: <87a7qwlh9k.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Fri, Jul 06, 2018 at 03:19:56PM +0200, Markus Armbruster wrote:
[...]
> Marc-Andr=C3=A9, I trust you'll respin the monitor core parts of "[PATCH =
v3
> 00/38] RFC: monitor: add asynchronous command type" as a separate series
> for 3.1.  Please include a patch to rip out the response queue if you
> think it's a worthwhile simplification.  Our discussion of the response
> queue will then be grounded by working patches.

I've since (re-)found that respin in my review queue.  I even reviewed
the patch that rips out the response queue.
