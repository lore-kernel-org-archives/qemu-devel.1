Received: from eggs.gnu.org ([2001:4830:134:3::10]:42704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etthE-00037q-U6
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etthE-0005IZ-8H
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:52 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520507908-16743-2-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Thu, 8 Mar 2018 12:18:24 +0100")
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-2-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Thu, 08 Mar 2018 12:27:20 +0100
Message-ID: <87efkuerjb.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/5] migration: do not transfer ram during
 bulk storage migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com

Peter Lieven <pl@kamp.de> wrote:
> this patch makes the bulk phase of a block migration to take
> place before we start transferring ram. As the bulk block migration
> can take a long time its pointless to transfer ram during that phase.
>
> Signed-off-by: Peter Lieven <pl@kamp.de>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
