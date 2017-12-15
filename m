Received: from eggs.gnu.org ([2001:4830:134:3::10]:35861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePoOx-00036Z-J6
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:43:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ePoOt-0005bk-Lq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:43:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ePoOt-0005aA-GH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 06:43:35 -0500
Date: Fri, 15 Dec 2017 11:43:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171215114317.GB2358@work-vm>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171215104101.GE15187@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215104101.GE15187@lemon>
Subject: Re: [Qemu-devel] [RFC v5 00/26] QMP: out-of-band (OOB) execution
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, armbru@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

* Fam Zheng (famz@redhat.com) wrote:
> On Tue, 12/05 13:51, Peter Xu wrote:
> > This version is mostly document update, and dropped the single patch
> > that is migration related (will be put into postcopy recovery
> > series).
> 
> Sorry if I'm asking an already answered question, if so please remind me with
> some pointers..
> 
> Can we completely hide the "OOB" concept from QMP to avoid the interface
> complication? In other words, the new "migrate-recover" command can be
> implemented in a way that it always try to run out of band as if it has
> "run-oob=true", without user specifying it or even negotiating it.
> 
> Because it seems "migrate-recover" is only useful with "run-oob=true".
> 
> Of course without introducing the whole OOB concept in QMP, what this command
> does will sound very hacky, but the bahavior can be documented just well on the
> single command. I don't see a big advantage in generalizing OOB at the QMP level
> so far. Do we have a list of other commands to be made OOB?

Many of the status commands can be converted to OOB, and the important
thing is that the management layer can tell whether OOB can tell which
commands are OOBable.

Dave

> Fam
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
