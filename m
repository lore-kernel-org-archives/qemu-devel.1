Received: from eggs.gnu.org ([2001:4830:134:3::10]:59216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUs7v-00072S-3w
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUs7t-0005ST-TO
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:15:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUs7t-0005S5-ON
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:15:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1529311206-76847-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1529311206-76847-2-git-send-email-anton.nefedov@virtuozzo.com>
Date: Mon, 18 Jun 2018 13:15:11 +0200
In-Reply-To: <1529311206-76847-2-git-send-email-anton.nefedov@virtuozzo.com>
	(Anton Nefedov's message of "Mon, 18 Jun 2018 11:40:05 +0300")
Message-ID: <87efh45osg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 1/2] qapi: allow empty branches in flat
 unions
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

> It often happens that just a few discriminator values imply extra data in
> a flat union. Existing checks did not make possible to leave other values
> uncovered. Such cases had to be worked around by either stating a dummy
> (empty) type or introducing another (subset) discriminator enumeration.
>
> Both options create redundant entities in qapi files for little profit.
>
> With this patch it is not necessary anymore to add designated union
> fields for every possible value of a discriminator enumeration.
>
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
