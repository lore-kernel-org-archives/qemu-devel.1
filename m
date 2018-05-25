Received: from eggs.gnu.org ([2001:4830:134:3::10]:55265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMJlf-0004rx-IF
	for qemu-devel@nongnu.org; Fri, 25 May 2018 16:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMJle-0006gm-Qr
	for qemu-devel@nongnu.org; Fri, 25 May 2018 16:56:55 -0400
Date: Fri, 25 May 2018 23:56:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180525235613-mutt-send-email-mst@kernel.org>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-16-git-send-email-mst@redhat.com>
	<df745a8b-a48b-3e9a-f44f-ebff27111847@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df745a8b-a48b-3e9a-f44f-ebff27111847@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/20] migration: use local path for
 local headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On Fri, May 25, 2018 at 01:24:08PM -0500, Eric Blake wrote:
> On 05/25/2018 11:48 AM, Michael S. Tsirkin wrote:
> > When pulling in headers that are in the same directory as C file (as
> 
> s/as C/as the C/ (here and in many other messages)

Will fix, thanks.

> > opposed to one in include/), we should use its relative path, without a
> > directory. Directory based path works more or less by accident.
> 
> Missed trimming this out of your commit message.

Will fix, thanks.

> Or, if you want, on many of these commits, you could be more explicit about
> intention:
> 
> When pulling in headers that are in the same directory as the C file (as
> opposed to one in include/), we prefer to use its relative path without a
> directory, rather than relying on the global -I$(SRC_DIR) that may be
> removed in a later patch.

I'm no longer sure we'll be able to.

> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
