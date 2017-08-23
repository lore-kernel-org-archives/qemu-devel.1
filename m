Received: from eggs.gnu.org ([2001:4830:134:3::10]:38469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkV3D-00062w-7J
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkV3C-0005Lw-KK
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:46:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkV3C-0005Lg-E5
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 651FE80F95
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 12:46:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
Date: Wed, 23 Aug 2017 14:46:21 +0200
In-Reply-To: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:01 +0200")
Message-ID: <87y3qaxxia.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/54] qapi: add #if pre-processor
 conditions to generated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

PATCH 01 is a bug fix I'll apply it to qapi-next right away.

PATCH 02-05 changes qmp-introspect.c's data structure from plain string
to recursive structure, in preparation of the real QAPI work that starts
in PATCH 15.  PATCH 03 needs splitting.  Apart from that, I only asked
for minor tweaks, I think.

I believe PATCH 06-13 can stand on their own.  Let's spin them off into
their own series.  Since I want to play with them to explore ideas to
reduce churn, I'll do that myself.

I'll return to the remainder of this series once I'm done with that.
