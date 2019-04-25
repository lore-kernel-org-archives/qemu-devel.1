Received: from eggs.gnu.org ([209.51.188.92]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJiYv-0007Lp-Kb
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hJiYu-0002Kc-Hw
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:53:33 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hJiYu-0002K8-DV
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:53:32 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so1118005qtk.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:53:31 -0700 (PDT)
Date: Thu, 25 Apr 2019 13:53:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190425135319-mutt-send-email-mst@kernel.org>
References: <20190416125912.44001-1-liran.alon@oracle.com>
	<20190418094101.GA23876@stefanha-x1.localdomain>
	<17635C1F-A477-4C0F-B052-2948D853E6CD@oracle.com>
	<20190425083819.GE30231@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425083819.GE30231@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] vhost-scsi: Support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com

On Thu, Apr 25, 2019 at 09:38:19AM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 24, 2019 at 07:38:57PM +0300, Liran Alon wrote:
> > 
> > 
> > > On 18 Apr 2019, at 12:41, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > > 
> > > On Tue, Apr 16, 2019 at 03:59:09PM +0300, Liran Alon wrote:
> > >> Hi,
> > >> 
> > >> This patch series aims to add supprot to migrate a VM with a vhost-scsi device.
> > >> 
> > >> The 1st patch fixes a bug of mistakenly not stopping vhost-scsi backend when a
> > >> VM is stopped (As happens on migratino pre-copy completion).
> > >> 
> > >> The 2nd patch adds ability to save/load vhost-scsi device state in VMState.
> > >> 
> > >> The 3rd and final paqtch adds a flag to vhost-scsi which allows admin to specify
> > >> it's setup supports vhost-scsi migratino. For more detailed information on why
> > >> this is valid, see commit message of specific patch.
> > >> 
> > >> Regards,
> > >> -Liran
> > > 
> > > Looks fine for vhost_scsi.ko.  I have not checked how this interacts
> > > with vhost-user-scsi.
> > > 
> > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > 
> > Gentle Ping.
> 
> This should go either through Michael's virtio/vhost tree or Paolo's
> SCSI tree.
> 
> Stefan

OK I'll queue it.
