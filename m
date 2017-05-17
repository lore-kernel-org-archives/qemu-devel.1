Received: from eggs.gnu.org ([2001:4830:134:3::10]:48824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAttd-0005Kv-I7
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAtta-00080e-Ex
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:01:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAtta-00080U-9i
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:01:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC9A972468
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 08:01:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170516205351.12101-1-ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:01:17 +0200
In-Reply-To: <20170516205351.12101-1-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Tue, 16 May 2017 17:53:51 -0300")
Message-ID: <87bmqrq5de.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi-schema: Remove obsolete note from
 ObjectTypeInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Eduardo Habkost <ehabkost@redhat.com> writes:

> The "This command is experimental" note in ObjectTypeInfo is obsolete
> since 2012.  Commit 5192082097549c5b3aa7c913c6853d97a68172cb removed the
> warning from the qom-list-types command documentation, but we forgot to
> remove the warning from ObjectTypeInfo.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Applied to qapi-next, thanks!
