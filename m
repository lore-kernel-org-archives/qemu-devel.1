Received: from eggs.gnu.org ([2001:4830:134:3::10]:50632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZhY-0007p8-Hx
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZhX-0004pM-P8
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:24:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fdZhX-0004pB-KD
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:23:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DFAF401EF07
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 11:23:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180712111221.20326-17-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 12 Jul 2018 13:12:17 +0200")
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-17-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 12 Jul 2018 13:23:53 +0200
Message-ID: <87lgaglmt2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 16/20] migration-test: Make wait_command()
 cope with '%'
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
> wait_command() passes its argument @command to qtest_qmp_send().
> Falls apart if @command contain '%'.  Two ways to disarm this trap:
> suppress interpretation of '%' by passing @command as argument to
> format string "%s", or fix it by having wait_command() take the
> variable arguments to go with @command.  Do the latter.
>
> This is another step towards compile-time format string checking
> without triggering -Wformat-nonliteral.
>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

much better.
