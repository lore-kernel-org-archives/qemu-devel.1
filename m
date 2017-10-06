Received: from eggs.gnu.org ([2001:4830:134:3::10]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0Me5-0007Zo-4B
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:02:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1e0Me1-0004v6-VP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1e0Me1-0004uN-Qt
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:02:01 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7FBCE883BA
	for <qemu-devel@nongnu.org>; Fri,  6 Oct 2017 07:02:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20171005190725.18712-1-dgilbert@redhat.com>
Date: Fri, 06 Oct 2017 09:01:58 +0200
In-Reply-To: <20171005190725.18712-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 5 Oct 2017 20:07:25 +0100")
Message-ID: <874lrc92u1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu_opt_print: Remove shadowing opt decl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> opt was declared as a separate local inside the last loop,
> shadowing the local at the top of the function.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

I can take this through my tree.
