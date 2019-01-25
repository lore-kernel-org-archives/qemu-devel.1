Received: from eggs.gnu.org ([209.51.188.92]:44515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7hc-00038W-Ix
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7hb-0006p0-Qr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:03:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gn7hb-0006oS-Jc
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 15:03:47 -0500
Date: Fri, 25 Jan 2019 15:03:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190125150133-mutt-send-email-mst@kernel.org>
References: <78014185dc40dea43750eaa50ae093806e3dab66.1548136274.git.yi.z.zhang@linux.intel.com>
	<20190123145050.GU4136@habkost.net>
	<20190124112102.GA9821@tiger-server>
	<20190124165926.GY4136@habkost.net>
	<20190124123824-mutt-send-email-mst@kernel.org>
	<20190124182839.GZ4136@habkost.net>
	<20190124140522-mutt-send-email-mst@kernel.org>
	<20190124191443.GB4136@habkost.net>
	<20190124220423-mutt-send-email-mst@kernel.org>
	<20190125032653.GC4136@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125032653.GC4136@habkost.net>
Subject: Re: [Qemu-devel] [PATCH V10 4/4] docs: Added MAP_SYNC documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, richardw.yang@linux.intel.com, qemu-devel@nongnu.org, imammedo@redhat.com, dan.j.williams@intel.com

On Fri, Jan 25, 2019 at 01:26:53AM -0200, Eduardo Habkost wrote:
> > I think we need not be purists here. Most people don't lose power and
> > then it's fine and compatible. People who want more robustness need to
> > use more modern kernels, that is all.
> 
> I don't think that's being purist.

Right I thought that you want to prevent kernel running this
on old kernels. Why it's nice to stay up to date this
flag was not backported into stable kernels so many users
can't really update.


> I want to avoid hidden bugs


Makes total sense, I posted a proposal.

> if we ignore that MAP_SYNC failed for any unexpected reason.  If
> we need to ignore errors in some cases, let's at least limit that
> to cases where we absolutely have to.
> 
> But I would also be happy with just a warning.
> 
> -- 
> Eduardo
