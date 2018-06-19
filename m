Received: from eggs.gnu.org ([2001:4830:134:3::10]:59680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVH6Y-0005mL-KE
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fVH6V-0003fX-GD
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:55:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fVH6V-0003fI-8z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:55:27 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180619053426.13065-1-peterx@redhat.com>
	<20180619053426.13065-4-peterx@redhat.com>
	<20180619055348.GI16790@xz-mi>
Date: Tue, 19 Jun 2018 15:55:12 +0200
In-Reply-To: <20180619055348.GI16790@xz-mi> (Peter Xu's message of "Tue, 19
	Jun 2018 13:53:48 +0800")
Message-ID: <87602evq2n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/7] monitor: flush qmp responses when
 CLOSED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jun 19, 2018 at 01:34:22PM +0800, Peter Xu wrote:
>
> [...]
>
>> Fixes: 6d2d563f8c ("qmp: cleanup qmp queues properly", 2018-03-27)
>> Suggested-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>> 
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> I am pretty sure this time that this 2nd line is not there in my local
> tree. :)
>
> I think it's a git-format-patch bug, otherwise I must have misused it
> for a long time.  Instead of figuring this out and repost again, I'll
> see how far the rest of the series can go.

Do you use git-format-patch -s, or have format.signOff set in
.git/config or ~/.gitconfig?
