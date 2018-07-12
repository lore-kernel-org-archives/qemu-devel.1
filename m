Received: from eggs.gnu.org ([2001:4830:134:3::10]:50474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZgj-00079N-1p
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fdZgf-0003pq-L4
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:23:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fdZgf-0003pE-Ga
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:23:05 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180712111221.20326-16-armbru@redhat.com> (Markus Armbruster's
	message of "Thu, 12 Jul 2018 13:12:16 +0200")
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-16-armbru@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 12 Jul 2018 13:22:59 +0200
Message-ID: <87pnzslmuk.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 15/20] tests: New helper
 qtest_qmp_receive_success()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Markus Armbruster <armbru@redhat.com> wrote:
> Commit b21373d0713 copied wait_command() from tests/migration-test.c
> to tests/tpm-util.c.  Replace both copies by new libqtest helper
> qtest_qmp_receive_success().  Also use it to simplify
> qtest_qmp_device_del().
>
> Bonus: gets rid of a non-literal format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Juan Quintela <quintela@redhat.com>
