Received: from eggs.gnu.org ([2001:4830:134:3::10]:50358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCOw2-0003b1-9L
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCOvv-0004GS-U3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:58:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCOvs-000410-NC
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 08:58:46 -0400
Date: Tue, 16 Oct 2018 09:58:30 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181016125830.GM31060@habkost.net>
References: <7328fb16c394eaf5d65437d11c2a9343647b6d3d.1535471899.git.yi.z.zhang@linux.intel.com>
	<20180829175009.GD17213@habkost.net>
	<CAFEAcA8t0YrF04NZwdPUsW4+WWV7n=wNKS+eenJsKF+YdiKwiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8t0YrF04NZwdPUsW4+WWV7n=wNKS+eenJsKF+YdiKwiw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hostmem-file: fixed the memory leak
 while get pmem path.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, yu.c.zhang@linux.intel.com, Igor Mammedov <imammedo@redhat.com>, Junyan He <junyan.he@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>

On Tue, Oct 16, 2018 at 12:55:08PM +0100, Peter Maydell wrote:
> On 29 August 2018 at 18:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Wed, Aug 29, 2018 at 12:14:22AM +0800, Zhang Yi wrote:
> >> object_get_canonical_path_component() returns a string which
> >> must be freed using g_free().
> >>
> >> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> >
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >
> > Queueing on machine-next, thanks.
> 
> Ping? This patch doesn't seem to have made it to master...

Sorry for the delay.  I have a few patches queued on machine-next
that I will include in a pull request this week (today or
tomorrow).

-- 
Eduardo
