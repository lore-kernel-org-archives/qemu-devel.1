Received: from eggs.gnu.org ([2001:4830:134:3::10]:40155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezXYz-0000mm-GA
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ezXYw-0007vP-GK
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:01:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42292 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ezXYw-0007up-C6
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 21:01:38 -0400
Date: Sat, 24 Mar 2018 09:01:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180324010115.GA10831@xz-mi>
References: <20180323140821.28957-1-peterx@redhat.com>
	<20180323140821.28957-2-peterx@redhat.com>
	<bcea82bf-0ff8-4af6-add9-2f4f283ba833@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcea82bf-0ff8-4af6-add9-2f4f283ba833@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/4] Revert "monitor: enable IO
 thread for (qmp & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Mar 23, 2018 at 10:49:31AM -0500, Eric Blake wrote:
> On 03/23/2018 09:08 AM, Peter Xu wrote:
> > This reverts commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Not fatal to taking this patch as-is, but it's always nice to include a
> rationale when reverting, something along the lines of:
> 
> It turns out that enabling OOB caused several iotests to break; disabling
> OOB is the fastest and safest approach for reducing the risk of a broken
> release, while working on the fixes for the problems uncovered.
> 
> (Probably similar comments will be needed on the remaining patches...)

Yes.  I saw the pull, thanks for adding those info into commit messages.

-- 
Peter Xu
