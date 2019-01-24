Received: from eggs.gnu.org ([209.51.188.92]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg86-0003Cc-JP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:37:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gmg85-000353-Tz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:37:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gmg84-0002wj-3d
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:37:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB9932498C
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 14:37:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190102140535.11512-1-cfergeau@redhat.com>
Date: Thu, 24 Jan 2019 15:37:12 +0100
In-Reply-To: <20190102140535.11512-1-cfergeau@redhat.com> (Christophe
	Fergeau's message of "Wed, 2 Jan 2019 15:05:35 +0100")
Message-ID: <87fttidsvb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] json: Fix % handling when not interpolating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Fergeau <cfergeau@redhat.com>
Cc: qemu-devel@nongnu.org

Christophe Fergeau <cfergeau@redhat.com> writes:

> commit 8bca4613 added support for %% in json strings when interpolating,
> but in doing so, this broke handling of % when not interpolating as the
> '%' is skipped in both cases.
> This commit ensures we only try to handle %% when interpolating.
>
> Signed-off-by: Christophe Fergeau <cfergeau@redhat.com>

Queued with commit message improvements, thanks!
