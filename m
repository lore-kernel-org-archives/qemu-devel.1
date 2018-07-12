Received: from eggs.gnu.org ([2001:4830:134:3::10]:50078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZev-0005jj-4P
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZer-00019D-RU
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:21:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fdZer-00016j-Mb
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:21:13 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9BF040122C8
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:21:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180712111221.20326-15-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 12 Jul 2018 13:12:15 +0200")
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-15-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 12 Jul 2018 13:21:06 +0200
Message-ID: <87tvp4lmxp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 14/20] migration-test: Make wait_command()
 return the "return" member
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Markus Armbruster <armbru@redhat.com> wrote:
> All callers of wait_command() are only interested in the success
> response's "return" member.  Lift its extraction into wait_command().
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Nice simplification.
