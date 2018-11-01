Received: from eggs.gnu.org ([2001:4830:134:3::10]:41148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gI6SN-0005ky-1L
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gI6SM-0006gI-7Q
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 02:27:50 -0400
Date: Thu, 1 Nov 2018 14:27:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181101062741.GA17770@magic>
References: <20181031053920.7565-1-famz@redhat.com>
	<87va5irwxi.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va5irwxi.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v2] file-posix: Use error API properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, 10/31 15:51, Markus Armbruster wrote:
> Fam Zheng <famz@redhat.com> writes:
> 
> > Use error_report for situations that affect user operation (i.e.  we're
> > actually returning error), and warn_report/warn_report_err when some
> > less critical error happened but the user operation can still carry on.
> >
> > For raw_normalize_devicepath, add Error parameter to propagate to
> > its callers.
> >
> > Suggested-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> Kevin, if you'd prefer this to go through my tree, let me know.

Thanks for the review. I'll respin and use error_setg_errno as suggested by
Eric, if it's okay.

Fam
