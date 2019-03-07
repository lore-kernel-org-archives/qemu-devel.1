Received: from eggs.gnu.org ([209.51.188.92]:58013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1ugP-0007Ub-3E
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1ugJ-0002sS-JC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:11:41 -0500
Date: Thu, 7 Mar 2019 16:11:22 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307151122.GH5786@linux.fritz.box>
References: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551965640-164939-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] iotests: check whitelisted formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, armbru@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, rkagan@virtuozzo.com

Am 07.03.2019 um 14:33 hat Andrey Shinkevich geschrieben:
> Some test cases require specific formats to be supported by QEMU. The
> list of formats supported by the block layer doesn't take whitelists
> into account. This series manages this issue. The method decorator
> skip_if_unsupported() checks if requested formats are whitelisted.
> The sample output is shown with the test #139.

Thanks, applied to the block branch.

Kevin
