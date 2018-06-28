Received: from eggs.gnu.org ([2001:4830:134:3::10]:55135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYaEf-0006EZ-17
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYaEe-0003kb-8z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:57:33 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu, 28 Jun 2018 17:57:23 +0100
Message-Id: <20180628165724.17009-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v4] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

v4:

 - This addresses points raised by Eric and Dan's reviews.

The only thing I didn't change was using --object in qemu-options.hx,
since that would really be different from everything else in the file.
(However I did change -object -> --object in the header docs)

This version uses g_file_get_contents to read the whole PSK file into
memory, rather than using either fgets or getline.

Rich.
