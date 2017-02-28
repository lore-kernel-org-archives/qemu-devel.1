Received: from eggs.gnu.org ([2001:4830:134:3::10]:53397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikfR-0000df-5R
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:30:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikfQ-0000id-Bq
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:30:25 -0500
Date: Tue, 28 Feb 2017 11:30:17 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170228163017.GE15696@localhost.localdomain>
References: <20170228161553.28142-1-jcody@redhat.com>
	<20170228161553.28142-6-jcody@redhat.com>
	<d24c1aa4-c433-feab-38cf-1e1a82a7a1e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d24c1aa4-c433-feab-38cf-1e1a82a7a1e8@redhat.com>
Subject: Re: [Qemu-devel] [PULL 5/5] block/rbd: add support for 'mon_host',
 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Tue, Feb 28, 2017 at 10:26:49AM -0600, Eric Blake wrote:
> On 02/28/2017 10:15 AM, Jeff Cody wrote:
> > This adds support for three additional options that may be specified
> > by QAPI in blockdev-add:
> > 
> >     server: host, port
> >     auth method: either 'cephx' or 'none'
> > 
> > The "server" and "auth-supported" QAPI parameters are arrays.  To conform
> > with the rados API, the array items are join as a single string with a ';'
> > character as a delimiter when setting the configuration values.
> > 
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> What happened to Signed-off-by? You'll have to resubmit the pull request
>

Argh, thanks - that is what happens when I go outside my normal workflow.
Will send a v2 pr

> > ---
> >  block/rbd.c          | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  qapi/block-core.json |  29 +++++++++++
> >  2 files changed, 163 insertions(+)
> > 
> 
> 
> -- 
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
> 
