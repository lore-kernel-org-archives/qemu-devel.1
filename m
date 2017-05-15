Received: from eggs.gnu.org ([2001:4830:134:3::10]:39353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAHcV-0006Wr-VX
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dAHcQ-0007bl-VX
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:09:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13557)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dAHcQ-0007bO-Pd
	for qemu-devel@nongnu.org; Mon, 15 May 2017 11:09:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF724A3277
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 15:09:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170515140529.23264-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 15 May 2017 15:05:29 +0100")
References: <20170515140529.23264-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 17:08:45 +0200
Message-ID: <87vap2duo2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] block migration: Allow compile time
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kashyap@redhat.com, eblake@redhat.com, jcody@redhat.com, kwolf@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Many users now prefer to use drive_mirror over NBD as an
> alternative to the older migrate -b option; drive_mirror is
> more complex to setup but gives you more options (e.g. only
> migrating some of the disks if some of them are shared).
>
> Allow the large chunk of block migration code to be compiled
> out for those who don't use it.
>
> Based on a downstream-patch we've had for a while by Jeff Cody.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
