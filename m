Received: from eggs.gnu.org ([2001:4830:134:3::10]:34304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9kC-0006xL-D4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fV9k9-0008Ja-9k
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:03:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44888 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fV9k9-0008J5-4b
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:03:53 -0400
Date: Tue, 19 Jun 2018 14:03:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180619060332.GJ16790@xz-mi>
References: <20180619053426.13065-1-peterx@redhat.com>
	<92641a09-a750-e4bd-bb88-d022e4c0591f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92641a09-a750-e4bd-bb88-d022e4c0591f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 19, 2018 at 07:51:47AM +0200, Thomas Huth wrote:
> On 19.06.2018 07:34, Peter Xu wrote:
> > v4:
> > - collect some r-bs
> > - remove one extra s-o-b of mine in one patch [Thomas, Markus]
> 
> FYI: You've still got a duplicated s-o-b line in patch 3 and 4.
> 
>  Thomas

Thanks.  I think it's caused by the lines in commit messages like

"""
--- /home/peterx/git/qemu/tests/qemu-iotests/087.out
+++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad
"""

Then git-format-patch does not work as expected (so the extra s-o-bs
are not in my local tree).

I remove these lines then git-format-patch works fine.

If to repost, I'll double confirm with these matters.

Regards,

-- 
Peter Xu
