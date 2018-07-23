Received: from eggs.gnu.org ([2001:4830:134:3::10]:52382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhcXS-0005KG-VM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhcXP-0001oj-Pk
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:14:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38902 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhcXP-0001oT-J3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:14:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D81A401EF2A
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 15:14:15 +0000 (UTC)
References: <20180718090557.17248-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d551df25-5f8b-0148-b8d7-8a5f1e25bfeb@redhat.com>
Date: Mon, 23 Jul 2018 10:14:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180718090557.17248-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] qapi: Make 'allow-oob' optional in
 SchemaInfoCommand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com

On 07/18/2018 04:05 AM, Markus Armbruster wrote:
> Making 'allow-oob' optional in SchemaInfoCommand permits omitting it
> in the common case.  Shrinks query-qmp-schema's output from 122.1KiB
> to 118.6KiB for me.
> 
> Note that out-of-band execution is still experimental (you have to
> configure the monitor with x-oob=on to use it).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

I see you have already posted the pull request, but the idea makes sense 
to me. In general, making what was previously always output now be 
optional can risk confusing a client that depends on the value being 
present; but since allow-oob has not always been present, and since it 
is still gated by x-oob=on, any sane client using OOB can easily be 
coded to treat an absent indication as not allowing oob for that 
particular command.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
