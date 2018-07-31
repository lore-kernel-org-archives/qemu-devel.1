Received: from eggs.gnu.org ([2001:4830:134:3::10]:37070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkWj1-0006dm-6G
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fkWiw-0005R8-7v
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:38:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fkWiw-0005Q9-36
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:38:10 -0400
Date: Tue, 31 Jul 2018 16:38:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180731153805.GL2476@work-vm>
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
	<20180731112906.GG2476@work-vm> <87o9enqx4s.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com, liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
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

A big hairy comment?

Dave

> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
