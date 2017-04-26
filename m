Received: from eggs.gnu.org ([2001:4830:134:3::10]:58478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3Paa-0001Xd-2M
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d3PaW-00018B-SQ
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d3PaW-000183-MG
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 12:14:44 -0400
Date: Wed, 26 Apr 2017 17:14:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170426161439.GG2098@work-vm>
References: <CAJ2SuL=qbGqwt0JCLOLZ41fLTLwKDb0KjDANLTBTb7uLK+5m-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2SuL=qbGqwt0JCLOLZ41fLTLwKDb0KjDANLTBTb7uLK+5m-w@mail.gmail.com>
Subject: Re: [Qemu-devel] VM-Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Kiruvale <pradeepkiruvale@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, quintela@redhat.com

* Pradeep Kiruvale (pradeepkiruvale@gmail.com) wrote:
> Hi All,
> 
> Is it possible to enable/disable to migration features on the fly for a
> qemu VM?
> I mean through qmp interface kind of a interface?
> 
> I am asking this because keeping the dirty memory list, this could consume
> some
> compute and memory. So, the plan is to enable when the VM needs to be
> migrated.
> 
> Please clarify.

These bitmaps should already only be allocated during the migration process,
so you shouldn't be seeing any overhead during normal running.

See migration/ram.c ram_save_setup->ram_state_init which allocates
ram_bitmap and that only happens at the start of migration.
ram_state_init also calls memory_global_dirty_log_start which does
the kernel side of it.

Dave

> Regards,
> Pradeep
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
