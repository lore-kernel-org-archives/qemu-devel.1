Received: from eggs.gnu.org ([2001:4830:134:3::10]:50619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGThN-0006kY-Ks
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGThK-0007tF-IR
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:43:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGThK-0007sm-Cl
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:43:30 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481306681-5760-1-git-send-email-mdroth@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 16:53:28 +0100
In-Reply-To: <1481306681-5760-1-git-send-email-mdroth@linux.vnet.ibm.com>
	(Michael Roth's message of "Fri, 9 Dec 2016 12:04:39 -0600")
Message-ID: <87k2b52lfr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Fixes/tests for hmp_object_del()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, dgilbert@redhat.com, bharata.rao@gmail.com

Michael Roth <mdroth@linux.vnet.ibm.com> writes:

> hmp_object_del() followed by a subsequent hmp_object_add() can trigger a
> duplicate ID error if the previous object shared the same ID and was added
> via the command-line. Please see patch 2/2 for more details.
>
> This patchset fixes the issue in question and adds some general unit tests
> for object created via -object, which we later extend to verify the fix in
> question.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
