Received: from eggs.gnu.org ([2001:4830:134:3::10]:53865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eUJyQ-000849-J4
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 17:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eUJyM-0001SK-HV
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 17:14:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eUJyM-0001O3-4n
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 17:14:50 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2BEF5F755
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 22:14:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171215115123.12959-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 15 Dec 2017 11:51:23 +0000")
References: <20171215115123.12959-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 27 Dec 2017 23:14:43 +0100
Message-ID: <87o9mjbyy4.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Guard ram_bytes_remaining
 against early call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Calling ram_bytes_remaining during the early part of setup is unsafe
> because the ram_state isn't yet initialised.
>
> This can happen in the sequence:
>    migrate
>    migrate_cancel
>    info migrate
>
> if the migrate sticks trying to connect (e.g. to an unresponsive
> destination due to the connect timeout).  Here 'info migrate' sees
> a state of CANCELLING and so assumes the migrate has partially happened.
>
> partial fix for:
> RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1525899
> Reported-by: Xianxian Wang <xianwang@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
