Received: from eggs.gnu.org ([2001:4830:134:3::10]:50978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkVtI-0004Vd-Bo
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fkVtD-0005yP-DF
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:44:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49434 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fkVtD-0005yI-8b
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 10:44:43 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180731112906.GG2476@work-vm> (David Alan Gilbert's message of
	"Tue, 31 Jul 2018 12:29:06 +0100")
References: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
	<1533026124-6740-3-git-send-email-liq3ea@gmail.com>
	<20180731112906.GG2476@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 31 Jul 2018 16:48:35 +0200
Message-ID: <87o9enqx4s.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Li Qiang <liq3ea@gmail.com>, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, eblake@redhat.com, armbru@redhat.com, liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Li Qiang (liq3ea@gmail.com) wrote:
>> The default max cpu throttle is 99, this is too big that may
>> influence the guest loads. Add a qmp to config it can make it
>> more flexible.
>> 
>> Signed-off-by: Li Qiang <liq3ea@gmail.com>
>
> This should be done as a migration parameter rather than a new command.
> For example, follow the cpu-throttle-increment parameter; and this
> should work just like it.

I was about to comment this one.

migrate_set_downtime, migrate_set_speed, migrate-set-cache-size,
query-migrate-cache-size are marked as deprecated.  Any way that we
could have make more clear that one should use
migrate_set/get_parameter/capability?

Thanks, Juan.
