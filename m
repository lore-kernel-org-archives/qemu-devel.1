Received: from eggs.gnu.org ([2001:4830:134:3::10]:45243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fRJRL-0006y9-Rw
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:36:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ross.zwisler@linux.intel.com>) id 1fRJRI-0003oT-Ot
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:36:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:12141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ross.zwisler@linux.intel.com>)
	id 1fRJRI-0003o8-Eu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 11:36:32 -0400
Date: Fri, 8 Jun 2018 09:36:30 -0600
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Message-ID: <20180608153630.GB27156@linux.intel.com>
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
	<edcae62f-e3b6-6e25-60a5-843eeae89396@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edcae62f-e3b6-6e25-60a5-843eeae89396@redhat.com>
Subject: Re: [Qemu-devel] [qemu PATCH 1/5] gitignore: ignore generated qapi
 job files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri, Jun 08, 2018 at 09:59:00AM -0500, Eric Blake wrote:
> On 06/07/2018 05:31 PM, Ross Zwisler wrote:
> > With a fully built QEMU I currently see the following with "git status":
> > 
> >    Untracked files:
> >      (use "git add <file>..." to include in what will be committed)
> > 
> >    	qapi/qapi-commands-job.c
> >    	qapi/qapi-commands-job.h
> >    	qapi/qapi-events-job.c
> >    	qapi/qapi-events-job.h
> >    	qapi/qapi-types-job.c
> >    	qapi/qapi-types-job.h
> >    	qapi/qapi-visit-job.c
> >    	qapi/qapi-visit-job.h
> > 
> > These are all generated files.  Ignore them.
> > 
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Eric Blake <eblake@redhat.com>
> > Fixes: commit bf42508f24ee ("job: Introduce qapi/job.json")
> 
> You're the third to post this:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07280.html
> https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01624.html

I pulled your master branch yesterday before posting the series.  If multiple
people are sending fixes to the same issue and the fixes are correct, the
easiest way to stop getting those fixes is probably to merge one of the
patches.
