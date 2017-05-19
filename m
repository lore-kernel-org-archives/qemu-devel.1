Received: from eggs.gnu.org ([2001:4830:134:3::10]:40156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBfYT-0003qu-8A
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dBfYQ-0007dQ-5R
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dBfYP-0007d4-Vm
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:54:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D3AF37EEC
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:54:40 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518111837.29212-4-quintela@redhat.com>
Date: Fri, 19 May 2017 12:54:36 +0200
In-Reply-To: <20170518111837.29212-4-quintela@redhat.com> (Juan Quintela's
	message of "Thu, 18 May 2017 13:18:35 +0200")
Message-ID: <8760gxce1f.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Juan Quintela <quintela@redhat.com> writes:

> We have change in the previous patch to use migration capabilities for
> it.  Notice that we continue using the old command line flags from
> migrate command from the time being.  Remove the set_params method as
> now it is empty.
>
> For savevm, one can't do a:
>
> savevm -b/-i foo

Yes (savem has no such options).

> but now one can do:
>
> migrate_set_capability block on
> savevm foo
>
> And we can't use block migration. We could disable block capability
> unconditionally, but it would not be much better.

This leaves me confused: what does the example do?  Reading ahead...
looks like it fails with "Block migration and snapshots are
incompatible".  What are you trying to say here?

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Patch looks good to me.
