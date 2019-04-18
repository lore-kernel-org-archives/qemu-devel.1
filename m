Received: from eggs.gnu.org ([209.51.188.92]:47487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDU1-0007eS-0i
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDU0-0006vj-9n
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:18:09 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
Date: Thu, 18 Apr 2019 22:18:03 +0200
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com> (Kevin Wolf's message of
	"Mon, 8 Apr 2019 16:35:39 +0200")
Message-ID: <871s1zjcec.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> writes:

> This series adds optional feature lists to struct definitions in the
> QAPI schema and makes use of them to advertise the new behaviour of
> auto-read-only=on in file-posix.

General approach looks good to me.  It's just a first step, however.
One that is already useful.
