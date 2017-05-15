Received: from eggs.gnu.org ([2001:4830:134:3::10]:34752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dADnv-0002sm-Nb
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dADns-00029M-Jw
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dADns-00029E-Dp
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42BFD76FF
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 11:04:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170512175105.GI2069@work-vm> (David Alan Gilbert's message of
	"Fri, 12 May 2017 18:51:06 +0100")
References: <20170512160055.9081-1-quintela@redhat.com>
	<20170512160055.9081-6-quintela@redhat.com>
	<20170512175105.GI2069@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 15 May 2017 13:04:36 +0200
Message-ID: <87h90mfkjf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: Move colo.h to migration/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
D> * Juan Quintela (quintela@redhat.com) wrote:
>> There are functions only used by migration code.
>
> That's only mostly true; see the current 'integrate colo frame with
> block replication and net compare' series (posted 22nd April).
> That adds colo_handle_shutdown to this header and calls it from vl.c
> ( https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03901.html )
> where should that go?

Dropped.

It compiled, but who knows O:-)

> There's also a net/colo.h as well, so using the
>   #include "colo.h" in migration is correct but that's
> really scary when there are two files of the same name.

Yeap, it is scary ...
