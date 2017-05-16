Received: from eggs.gnu.org ([2001:4830:134:3::10]:40205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAfwe-0005Xq-3L
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAfwZ-00012o-6S
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAfwZ-00012Y-0H
	for qemu-devel@nongnu.org; Tue, 16 May 2017 13:07:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C30663DBED
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 17:07:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516111123.17692-1-quintela@redhat.com>
	<20170516111123.17692-3-quintela@redhat.com>
	<87shk4g9yb.fsf@dusky.pond.sub.org> <87o9usdg6e.fsf@secure.mitica>
	<87h90kbxmd.fsf@dusky.pond.sub.org>
	<09f00bd1-df05-c6b3-8423-cb790feddcc2@redhat.com>
	<87k25g92i8.fsf@dusky.pond.sub.org>
	<24a363d9-a395-325c-ff6c-f79211c773fb@redhat.com>
Date: Tue, 16 May 2017 19:07:25 +0200
In-Reply-To: <24a363d9-a395-325c-ff6c-f79211c773fb@redhat.com> (Eric Blake's
	message of "Tue, 16 May 2017 11:48:01 -0500")
Message-ID: <87a86c7msy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] migration: Create block capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: lvivier@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, Juan Quintela <quintela@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 05/16/2017 11:42 AM, Markus Armbruster wrote:
>
>>>> Well, to suggest something, I'd first have to figure out WTF incremental
>>>> block migration does.  Your text helps me some, but not enough.  What
>>>> exactly is being migrated, and what exactly is assumed to be shared
>>>> between source and destination?
>>>>
>>>> Block migration is scandalously underdocumented.
>>>
>
>> Can you draft a documentation comment for @block-incremental?
>
> How about:
>
> @block-incremental: Affects how much storage is migrated when the block
> migration capability is enabled.  When false, the entire storage backing
> chain is migrated into a flattened image at the destination; when true,
> only the active qcow2 layer is migrated and the destination must already
> have access to the same backing chain as was used on the source.
> (since 2.10)

Works for me, thanks!
