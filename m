Received: from eggs.gnu.org ([2001:4830:134:3::10]:34707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6X8x-00072r-Tj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6X8u-0006Jj-Ra
	for qemu-devel@nongnu.org; Fri, 05 May 2017 02:55:11 -0400
Date: Fri, 5 May 2017 14:55:04 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170505065504.GA21435@lemon.lan>
References: <20170428022329.30726-1-eblake@redhat.com>
	<20170428085407.GC23819@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170428085407.GC23819@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] tests: Ignore another built executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, thuth@redhat.com, dgilbert@redhat.com

On Fri, 04/28 09:54, Daniel P. Berrange wrote:
> On Thu, Apr 27, 2017 at 09:23:29PM -0500, Eric Blake wrote:
> > Commit 78f86a2b7 added a new test, but forgot to exclude the built
> > binary from version control.
> 
> CC Fam
> 
> I wonder if the patchew test system could be made to report an error
> if git identifies built files that are not ignored.
> 

If we had .git in the docker tests that patchew uses, it would be easy.  That's
an unfortunate dependency for a number of other features, I'll see what I can
do.

Fam
