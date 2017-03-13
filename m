Received: from eggs.gnu.org ([2001:4830:134:3::10]:53623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJOX-0003BR-W2
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnJOU-0007bw-Tc
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnJOU-0007bF-NN
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 02:23:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-35-git-send-email-armbru@redhat.com>
Date: Mon, 13 Mar 2017 07:23:43 +0100
In-Reply-To: <1489385927-6735-35-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Mon, 13 Mar 2017 07:18:34 +0100")
Message-ID: <8737ehlmog.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 34/47] qapi: Move empty doc section
 checking to doc parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com

Markus Armbruster <armbru@redhat.com> writes:

> Results in a more precise error location, but the real reason is
> emptying out check_docs() step by step.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Perhaps we should simply drop this error condition.  Are empty sections
this a mistake users make accidentally?
