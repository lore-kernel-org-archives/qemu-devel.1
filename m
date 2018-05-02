Received: from eggs.gnu.org ([2001:4830:134:3::10]:36520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDuy5-0008Qc-7r
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fDuy4-0006Ij-81
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:51:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37148 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fDuy4-0006IZ-3G
	for qemu-devel@nongnu.org; Wed, 02 May 2018 12:51:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180430124651.10340-1-stefanha@redhat.com>
Date: Wed, 02 May 2018 18:50:45 +0200
In-Reply-To: <20180430124651.10340-1-stefanha@redhat.com> (Stefan Hajnoczi's
	message of "Mon, 30 Apr 2018 13:46:46 +0100")
Message-ID: <87y3h2uhlm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/5] checkpatch: backport UTF-8 fixes
 and MAINTAINERS check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>

Stefan Hajnoczi <stefanha@redhat.com> writes:

> v2:
>  * Resolve missing CHK() [Thomas]
>  * Drop first argument to WARN() to match QEMU function arguments
>
> This series cherry picks checkpatch UTF-8 fixes and the MAINTAINERS file check
> from Linux.  Thomas Huth original did the backport in January 2017 but the
> series was forgotten (<1485436265-12573-1-git-send-email-thuth@redhat.com>).  I
> did the cherry pick again from scratch.
>
> The MAINTAINERS file check prints a warning when new files are added without a
> modification to ./MAINTAINERS.  It is easy to forget to update ./MAINTAINERS
> and this check should help us stay on top of new source files.

The matching is a bit sloppy in places, but if it's good enough for the
kernel...

Series:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
