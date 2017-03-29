Received: from eggs.gnu.org ([2001:4830:134:3::10]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctLMc-0007Ix-0d
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ctLMX-00034u-Ul
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:42:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ctLMX-000341-PE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 17:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DBA480479
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 21:42:40 +0000 (UTC)
Date: Thu, 30 Mar 2017 00:42:37 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170330003914-mutt-send-email-mst@kernel.org>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
	<3044459b-65a3-ca78-c009-15de9823704a@redhat.com>
	<20170329164646.GD2501@work-vm>
	<0eebf55d-aeb9-5426-001d-175b0cbfc60c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0eebf55d-aeb9-5426-001d-175b0cbfc60c@redhat.com>
Subject: Re: [Qemu-devel] Deprecating old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, Juan Quintela <quintela@redhat.com>

On Wed, Mar 29, 2017 at 06:58:36PM +0200, Paolo Bonzini wrote:
> 
> 
> On 29/03/2017 18:46, Dr. David Alan Gilbert wrote:
> >> By the way, what about old machine types like "pc-0.10" ? Do we want to
> >> carry them along forever (e.g. since it is not too complicated to
> >> maintain?), or shall we get rid of those one day (e.g. with QEMU 3.0), too?
> > It seems reasonable to slowly deprecate them.
> > I'm just not sure how slowly.
> 
> Some data:
> 
> - dropping 0.12, 0.13 _and_ isapc would let us kill the code for
> rombar=0 (i.e. where QEMU copies ROM BARs directly to low memory).
> 
> - the oldest versions in use are probably 0.12 (CentOS 6) and 1.0
> (Ubuntu 12.04)
> 
> - migration from old versions is broken in various ways from at least
> QEMU 1.2 and older.
> 
> Paolo

Live-migration, yes.

But live-migrations are a minority, most people update qemu and restart
it but do not want to reinstall their guests and that is only reliable
if you keep the old machine type.

And that seems to work reasonably well. So one way would be to
mark 0.10 and 0.11 unmigrateable, and drop rombar=0 hacks.

-- 
MST
