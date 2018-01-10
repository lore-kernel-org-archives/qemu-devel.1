Received: from eggs.gnu.org ([2001:4830:134:3::10]:58586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZMmi-0004NP-7U
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:15:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eZMmd-0002eK-56
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:15:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eZMmc-0002dG-AW
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 15:15:34 -0500
Date: Wed, 10 Jan 2018 20:15:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180110201519.GF2451@work-vm>
References: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
	<20180109153538.GC1197@stefanha-x1.localdomain>
	<20180109195517.GD2708@work-vm>
	<CAJSP0QVm+AoRoFNYx-r1k0WTPPopm60dmD7OhGZozm9ARfMwRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVm+AoRoFNYx-r1k0WTPPopm60dmD7OhGZozm9ARfMwRQ@mail.gmail.com>
Subject: Re: [Qemu-devel] Some question about savem/qcow2 incremental
 snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "He, Junyan" <junyan.he@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Tue, Jan 9, 2018 at 7:55 PM, Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >> Certain guest operations like rebooting or zeroing memory will defeat
> >> the incremental guest RAM snapshot feature.  It's worth thinking about
> >> these cases to make sure this feature would be worth it in real use
> >> cases.
> >
> > But those probably wouldn't upset an NVDimm?
> 
> If the guest dirties all RAM then the incremental snapshot feature
> degrades to a full snapshot.  I'm asking if there are common
> operations where that happens.
> 
> I seem to remember Windows guests zero all pages on cold boot.  Maybe
> that's not the case anymore.
> 
> Worth checking before embarking on this feature because it could be a
> waste of effort if it turns out real-world guests dirty all memory in
> common cases.

Right, but I'm hoping that there's some magic somewhere where an NVDimm doesn't
get zero'd because of a cold boot since that would seem to make it
volatile.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
