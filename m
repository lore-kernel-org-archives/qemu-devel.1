Received: from eggs.gnu.org ([2001:4830:134:3::10]:59762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQtHT-0002Fx-Ew
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQtHS-0002TG-9r
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:40:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQtHS-0002T2-4r
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 07:40:38 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-4-peterx@redhat.com>
Date: Thu, 07 Jun 2018 13:40:22 +0200
In-Reply-To: <20180531051641.8473-4-peterx@redhat.com> (Peter Xu's message of
	"Thu, 31 May 2018 13:16:40 +0800")
Message-ID: <87efhizuxl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC v2 3/4] monitor: remove "x-oob",
 turn oob on by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr
	. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> There was a regression reported by Eric Auger before with OOB:
>
>   http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html
>
> The fix is 951702f39c ("monitor: bind dispatch bh to iohandler context",
> 2018-04-10), which is in master already.
>
> For the bug, we turned Out-Of-Band feature of monitors off for 2.12
> release.  Now we turn that on again after the 2.12 release.
>
> This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
> meanwhile turn it on again by default for non-MUX QMPs.

Please add a brief explanation why OOB isn't turned on for MUX.  Pointer
to existing explanation would be fine.

> Signed-off-by: Peter Xu <peterx@redhat.com>
