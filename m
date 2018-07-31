Received: from eggs.gnu.org ([2001:4830:134:3::10]:40346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fkWvD-0003UV-8G
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fkWvA-0004cL-MD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:50:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fkWvA-0004bj-GN
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:50:48 -0400
Date: Tue, 31 Jul 2018 16:50:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180731155043.GK29167@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
	<20180731112906.GG2476@work-vm> <87o9enqx4s.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o9enqx4s.fsf@trasno.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Add qmp command for
 migrate_set_max_cpu_throttle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, crosthwaite.peter@gmail.com, Li Qiang <liq3ea@gmail.com>, armbru@redhat.com, qemu-devel@nongnu.org, liqiang02@corp.netease.com, pbonzini@redhat.com, hzliuyingdong@corp.netease.com, rth@twiddle.net

On Tue, Jul 31, 2018 at 04:48:35PM +0200, Juan Quintela wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Li Qiang (liq3ea@gmail.com) wrote:
> >> The default max cpu throttle is 99, this is too big that may
> >> influence the guest loads. Add a qmp to config it can make it
> >> more flexible.
> >> 
> >> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >
> > This should be done as a migration parameter rather than a new command.
> > For example, follow the cpu-throttle-increment parameter; and this
> > should work just like it.
> 
> I was about to comment this one.
> 
> migrate_set_downtime, migrate_set_speed, migrate-set-cache-size,
> query-migrate-cache-size are marked as deprecated.  Any way that we
> could have make more clear that one should use
> migrate_set/get_parameter/capability?

Where are they marked as deprecated ?

They're not included in our official list of deprecated features, so per
our deprecation policy, they are still considered supported.

  https://qemu.weilnetz.de/doc/qemu-doc.html#Deprecated-features

To deprecate something it needs to be added to qemu-deprecated.texi, and
ideally also made to print a message to stderr when triggered.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
