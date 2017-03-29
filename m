Received: from eggs.gnu.org ([2001:4830:134:3::10]:48446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctGkM-0005RY-6I
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctGkJ-0006hn-37
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctGkI-0006hZ-TP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D70A2C04B310
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 16:46:53 +0000 (UTC)
Date: Wed, 29 Mar 2017 17:46:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170329164646.GD2501@work-vm>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
	<fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
	<3044459b-65a3-ca78-c009-15de9823704a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3044459b-65a3-ca78-c009-15de9823704a@redhat.com>
Subject: Re: [Qemu-devel] Deprecating old machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> On 27.03.2017 21:04, John Snow wrote:
> > 
> > On 03/27/2017 04:06 AM, Thomas Huth wrote:
> >> On 24.03.2017 23:10, John Snow wrote:
> [...]
> >>> I have a list of things I want to axe...
> >>
> >> I've started a Wiki page with such a list here:
> >>
> >> http://wiki.qemu-project.org/Features/LegacyRemoval
> >>
> >> Feel free to amend!
> > 
> > Absolutely!
> 
> By the way, what about old machine types like "pc-0.10" ? Do we want to
> carry them along forever (e.g. since it is not too complicated to
> maintain?), or shall we get rid of those one day (e.g. with QEMU 3.0), too?

It seems reasonable to slowly deprecate them.
I'm just not sure how slowly.

Dave

> 
>  Thomas
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
