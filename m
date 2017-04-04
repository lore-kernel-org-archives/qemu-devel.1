Received: from eggs.gnu.org ([2001:4830:134:3::10]:40783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvMPm-0000rt-L5
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cvMPk-0004UA-0D
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:14:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cvMPj-0004Qo-QY
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 07:14:19 -0400
Date: Tue, 4 Apr 2017 12:14:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170404111412.GI25661@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <C885D0FF6A27744DB0B822E32DF6EF029B1CA14A@SESTOEX04.enea.se>
	<9b05e60a-f8c2-ea4f-6be4-f17c0adec510@redhat.com>
	<20170403081542.GA5036@noname.str.redhat.com>
	<33ced3d3-acd7-2945-518d-465a4621b151@redhat.com>
	<4d684062-be31-153e-3f94-b1193440c8e3@redhat.com>
	<e2fb3ffd-006c-5908-9201-d3182edc4c04@enea.com>
	<778c2cbf-536e-8349-dbd4-23cf30ac4e43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <778c2cbf-536e-8349-dbd4-23cf30ac4e43@redhat.com>
Subject: Re: [Qemu-devel] nbd: Possible regression in 2.9 RCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "ciprian.barbu" <ciprian.barbu@enea.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com, svc-armband <armband@enea.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alexandru Avadanii <Alexandru.Avadanii@enea.com>

On Tue, Apr 04, 2017 at 01:00:08PM +0200, Paolo Bonzini wrote:
> 
> 
> On 04/04/2017 10:17, ciprian.barbu wrote:
> >>
> >> but we do NOT make any guarantees of supporting
> >>
> >> new qemu, old libvirt
> > 
> > Sounds reasonable enough, I guess we didn't look at it this way.
> 
> Yes, but usually it's "new qemu, very old libvirt", like several years
> old.  I think this should be treated as a regression.
> 
> Between this issue and the problem with snapshots, it seems to me that
> the op blockers was really, really premature.

I think this kind of issue is inevitable when introducing this kind of
feature in to QEMU - no matter how well we think we've identified the
edge cases during development, this kind of issue would inevitably crop
up somewhere.

Even if we had libvirt support already, chances are we would have missed
handling of this edge case.

This feels like a case where the new feature needs to have a different
default - ie default to old behavior and require explicit opt-in to use
of the op-blockers. This allows people to opt-in to test the feature in
real-world & identify problems without risk of breaking the everyone else
out of the box.

Can we get this disabled by default to 2.9, with a view to having some
time for testing before enabling it by default in 2.10 / 2.11

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
