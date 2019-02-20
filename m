Received: from eggs.gnu.org ([209.51.188.92]:33910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwODw-0006Gt-SH
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gwODv-0004MQ-Vk
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:31:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gwODv-0004Ll-Ph
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:31:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3081A10C6D
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 09:31:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190219195928.12289-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Tue, 19 Feb 2019 19:59:28 +0000")
References: <20190219195928.12289-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 20 Feb 2019 10:34:39 +0100
Message-ID: <87wolurefk.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migration: Fix cancel state
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
> During a cancelled migration there's a race where the fd can
> go into an error state before we get back around the migration loop
> and migration_detect_error transitions from cancelling->failed.
>
> Check for cancelled/cancelling and don't change the state.
>
> Red Hat bug: https://bugzilla.redhat.com/show_bug.cgi?id=1608649
>
> Fixes: b23c2ade250
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
