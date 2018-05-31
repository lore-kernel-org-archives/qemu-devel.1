Received: from eggs.gnu.org ([2001:4830:134:3::10]:42462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOG0c-0002g3-5C
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOG0Y-0007dx-Nz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:20:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOG0Y-0007dk-Ie
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:20:18 -0400
Date: Thu, 31 May 2018 13:20:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180531052009.GL27442@xz-mi>
References: <20180531051641.8473-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180531051641.8473-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 0/4] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 31, 2018 at 01:16:37PM +0800, Peter Xu wrote:
> Patch 1: some more comment suggested by Markus on Out-Of-Band
> handlers.
> 
> Patch 2: touch up iotests to make sure after enabling OOB the randomly
> generated SHUTDOWN event won't fail any tests.  Without this change,
> iotests (raw) will success but iotests (qcow2) may fail 2 tests out of
> 100+.  With this patch applied, all tests pass.  Kevin, Max, please
> help have a look on this one.
> 
> Patch 3: revert the x-oob parameter, turn OOB on.
> 
> Patch 4: revert the x-oob parameter usage in test.  We can consider
> squash this patch into patch 3 to make sure no test will break.
> However I kept it separate at least for review.
> 
> Tests passed:
> 
> - make check
> - iotests on both raw and qcow2

Considering that I didn't get any objection in my RFC post for some
time, I should be able to mark the whole series as non-RFC (which I
forgot to change).  Please treat them as non-RFC patches.

-- 
Peter Xu
