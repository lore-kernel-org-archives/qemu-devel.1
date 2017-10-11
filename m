Received: from eggs.gnu.org ([2001:4830:134:3::10]:60293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1e2K55-00081h-P4
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jag.raman@oracle.com>) id 1e2K52-00049q-JV
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:42:03 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jag.raman@oracle.com>)
	id 1e2K52-000492-AI
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:42:00 -0400
From: Jag Raman <jag.raman@oracle.com>
Message-ID: <ea8f7d8d-9f07-517f-68cd-bdc87b900fa4@oracle.com>
Date: Wed, 11 Oct 2017 12:42:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] QEMU migration cancellation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, peterx@redhat.com, Karl Heubaum <karl.heubaum@oracle.com>, Sunit Jain <sunit.jain@oracle.com>

Hi,

I'd like to check about the behavior of a QEMU instance when live
migration is cancelled.

If the migration of a guest OS from source QEMU instance to destination
instance is cancelled, the destination instance exits with a failure
code. Could you please explain why this design decision was taken?

I'm wondering if it's OK to change the behavior of the destination
instance in this case. Would it be OK for the destination instance to
not exit with the failure code, and instead retry processing incoming
migration? I'm dealing with an internal bug report that's asking whether
it would make more sense for the destination process to hang around for
another attempt at migration than to be killed.

We came across Peter's planned changes to migration postcopy[1] which
indicate that migration-cancellation is planned to be enhanced during
the postcopy phase. Are there any such enhancements planned for the
active phase as well?

I'd also like to know the difference between qemu_fclose() &
qemu_file_shutdown(). The source instance currently uses the shutdown
function to terminate the connection between source & destination. But
it seems to disconnect the connection abruptly. Whereas fclose function
seems to disconnect it more gracefully. When I dug deeper, I couldn't
specifically tell the difference between the two. I'd like to know if I
could substitute the shutdown function with fclose function in
migrate_fd_cancel().

[1]: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05892.html

Thanks!
--
Jag
