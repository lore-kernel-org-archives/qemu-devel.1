Received: from eggs.gnu.org ([2001:4830:134:3::10]:60969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vbK-0000yB-PO
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1e2vbF-0000T6-UK
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 04:45:50 -0400
Date: Fri, 13 Oct 2017 16:45:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171013084542.GB2756@lemon>
References: <20171013012455.10737-1-famz@redhat.com>
	<20171013012455.10737-2-famz@redhat.com>
	<2d524426-1467-8d9b-f216-1014d5b18f00@redhat.com>
	<20171013082046.GA2756@lemon>
	<048daae2-370a-e8cf-ef75-aee2e7a6508a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048daae2-370a-e8cf-ef75-aee2e7a6508a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] MAINTAINERS: Fix scsi path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Fri, 10/13 10:30, Thomas Huth wrote:
> On 13.10.2017 10:20, Fam Zheng wrote:
> > On Fri, 10/13 10:04, Thomas Huth wrote:
> >> On 13.10.2017 03:24, Fam Zheng wrote:
> >>> Signed-off-by: Fam Zheng <famz@redhat.com>
> >>> ---
> >>>  MAINTAINERS | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 772ac209e1..da3c78df47 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -982,7 +982,7 @@ S: Supported
> >>>  F: include/hw/scsi/*
> >>>  F: include/scsi/*
> >>>  F: hw/scsi/*
> >>> -F: util/scsi*
> >>> +F: scsi/*
> >>
> >> scsi/* is already covered by the new "Block SCSI subsystem" section, so
> >> I think you can also simply remove that line instead.
> > 
> > I didn't notice that section existing, should the two be merged into one?
> 
> I don't think so. One section is about the emulated SCSI devices, and
> the other one about the SCSI block backend code, so that's two different
> parts.
> 
> Some other ideas though:
> 
> 1) I think "include/scsi/*" should be removed from the SCSI devices
> section, it is already handled in the "Block SCSI subsystem" - and
> headers that are related to devices should go into include/hw/scsi/
> anyway instead.
> 
> 2) The orphan LSI53C895A section could maybe be removed from the
> MAINTAINERS file? It's of no use in its current "Orphan" state, and the
> file is already covered by the generic SCSI devices section.

OK, that sounds good to me.

Fam
