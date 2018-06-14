Received: from eggs.gnu.org ([2001:4830:134:3::10]:56683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTMf2-0002gP-GY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTMex-0006pT-IZ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:27:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTMex-0006pD-Dw
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 03:27:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528905228-25694-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1528905228-25694-3-git-send-email-anton.nefedov@virtuozzo.com>
Date: Thu, 14 Jun 2018 09:27:05 +0200
In-Reply-To: <1528905228-25694-3-git-send-email-anton.nefedov@virtuozzo.com>
	(Anton Nefedov's message of "Wed, 13 Jun 2018 18:53:48 +0300")
Message-ID: <87r2l9omk6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 2/2] qapi: remove empty flat union
 branches and types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mdroth@linux.vnet.ibm.com

Anton Nefedov <anton.nefedov@virtuozzo.com> writes:

> Flat unions may now have uncovered branches, so it is possible to get rid
> of empty types defined for that purpose only.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

I observe a nice shrinking of generated code:

 qapi-doc.texi           |  134 -----
 qapi-introspect.c       | 1124 +++++++++++++++++++++++-------------------------
 qapi-types-block-core.c |   26 -
 qapi-types-block-core.h |   43 -
 qapi-types-crypto.c     |   13 
 qapi-types-crypto.h     |    9 
 qapi-types-misc.c       |   13 
 qapi-types-misc.h       |   40 -
 qapi-types-net.c        |   13 
 qapi-types-net.h        |   10 
 qapi-types-ui.c         |   13 
 qapi-types-ui.h         |   14 
 qapi-visit-block-core.c |  185 +------
 qapi-visit-block-core.h |    6 
 qapi-visit-core.d       |   15 
 qapi-visit-crypto.c     |   38 -
 qapi-visit-crypto.h     |    3 
 qapi-visit-misc.c       |   71 ---
 qapi-visit-misc.h       |    3 
 qapi-visit-net.c        |   43 -
 qapi-visit-net.h        |    3 
 qapi-visit-ui.c         |   45 -
 qapi-visit-ui.h         |    3 
 23 files changed, 607 insertions(+), 1260 deletions(-)

Reviewed-by: Markus Armbruster <armbru@redhat.com>
