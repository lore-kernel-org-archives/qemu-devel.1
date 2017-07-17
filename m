Received: from eggs.gnu.org ([2001:4830:134:3::10]:39878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX8l8-00015q-OX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:20:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dX8l3-0004Dr-Qi
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:20:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dX8l3-0004DH-KZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 12:20:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87C29C0587F4
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 16:20:28 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170717110936.23314-6-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Mon, 17 Jul 2017 12:09:35 +0100")
References: <20170717110936.23314-1-dgilbert@redhat.com>
	<20170717110936.23314-6-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 17 Jul 2017 18:20:23 +0200
Message-ID: <87lgnn11dk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 5/6] migration/rdma: Safely convert
 control types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> control_desc[] is an array of strings that correspond to a
> series of message types; they're used only for error messages, but if
> the message type is seriously broken then we could go off the end of
> the array.
>
> Convert the array to a function control_desc() that bound checks.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
