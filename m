Received: from eggs.gnu.org ([2001:4830:134:3::10]:54186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTT75-0002cb-OH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTT71-0004eh-8X
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:16:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTT71-0004dL-3M
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:15:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499368127-19855-1-git-send-email-chugh.ishani@research.iiit.ac.in>
Date: Fri, 07 Jul 2017 15:15:50 +0200
In-Reply-To: <1499368127-19855-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	(Ishani Chugh's message of "Fri, 7 Jul 2017 00:38:47 +0530")
Message-ID: <87eftswfp5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] Python3 Support for qmp.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

Ishani Chugh <chugh.ishani@research.iiit.ac.in> writes:

> This patch intends to make qmp.py compatible with both python2 and python3.
>
>  * Python 3 does not have dict.has_key(key), use key in dict instead
>  * Avoid line-based I/O since Python 2/3 have different character
>    encoding behavior.  Explicitly encode/decode JSON UTF-8.
>  * Replace print by print function.
>
> Signed-off-by: Ishani Chugh <chugh.ishani@research.iiit.ac.in>

$ scripts/get_maintainer.pl -f $your_patch
Markus Armbruster <armbru@redhat.com> (supporter:QMP)
qemu-devel@nongnu.org (open list:All patches CC here)

Just sayin' :)
