Received: from eggs.gnu.org ([2001:4830:134:3::10]:58569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGLBh-0006dj-H6
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGLBg-0002si-Op
	for qemu-devel@nongnu.org; Wed, 09 May 2018 05:15:05 -0400
Date: Wed, 9 May 2018 11:14:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180509091457.GA4714@localhost.localdomain>
References: <20180508233659.13973-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508233659.13973-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] blockjob: expose error string via query
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>

Am 09.05.2018 um 01:36 hat John Snow geschrieben:
> When we've reached the concluded state, we need to expose the error
> state if applicable. Add the new field.
> 
> This should be sufficient for determining if a job completed
> successfully or not after concluding; if we want to discriminate
> based on how it failed more mechanically, we can always add an
> explicit return code enumeration later.
> 
> I didn't bother to make it only show up if we are in the concluded
> state; I don't think it's necessary.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Thanks, applied to the block branch.

Kevin
