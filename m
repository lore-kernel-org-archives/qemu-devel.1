Received: from eggs.gnu.org ([2001:4830:134:3::10]:42605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTS7x-0006Lg-6z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTS7w-0002VJ-AY
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:17:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180614095544.31549-1-kwolf@redhat.com>
	<20180614095544.31549-2-kwolf@redhat.com>
Date: Thu, 14 Jun 2018 15:17:16 +0200
In-Reply-To: <20180614095544.31549-2-kwolf@redhat.com> (Kevin Wolf's message
	of "Thu, 14 Jun 2018 11:55:41 +0200")
Message-ID: <87r2l9ik2r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block: Remove deprecated -drive
 geometry options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> The -drive options cyls, heads, secs and trans were deprecated in
> QEMU 2.10. It's time to remove them.
>
> hd-geo-test tested both the old version with geometry options in -drive
> and the new one with -device. Therefore the code using -drive doesn't
> have to be replaced there, we just need to remove the -drive test cases.
> This in turn allows some simplification of the code.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
