Received: from eggs.gnu.org ([2001:4830:134:3::10]:48305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX3FU-0002m9-Ar
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gX3FO-0001Rq-FZ
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:04:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <154115285434.11300.8459925605672823399.stgit@dhcp-3-135.uk.xensource.com>
	<20181102110412.GD7521@dhcp-200-186.str.redhat.com>
	<20181212085951.GA7604@aepfle.de>
Date: Wed, 12 Dec 2018 13:04:04 +0100
In-Reply-To: <20181212085951.GA7604@aepfle.de> (Olaf Hering's message of "Wed,
	12 Dec 2018 09:59:51 +0100")
Message-ID: <87y38vhryj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Xen-devel] xen_disk qdevification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org, Tim Smith <tim.smith@citrix.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Paul Durrant <Paul.Durrant@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Olaf Hering <olaf@aepfle.de> writes:

> On Fri, Nov 02, Kevin Wolf wrote:
>
>> A while ago, a downstream patch review found out that there are some QMP
>> commands that would immediately crash if a xen_disk device were present
>> because of the lacking qdevification. This is not the code quality
>> standard I envision for QEMU. It's time for non-qdev devices to go.
>
> Do you have that backwards by any chance? IMO the presence of assert()
> contributes to bad code quality, not the drivers that trigger those
> asserts. It is bad enough that two QEMU releases went out while being in
> bad shape.

Converting block devices to the qdev infrastructure (introduced in 2009)
has been a longwinded affair.  We've repeatedly reminded people in
charge of the stragglers to update their code.

Neglecting to update code to current infrastructure creates a burden and
a risk.  The burden is on the maintainers of the infrastructure: they
get to drag along outmoded infrastructure.  The risk is on the users of
the code: it becomes a special case, and eventually acquires its special
bugs.

Putting the blame for them entirely on the maintainers of the
infrastructure is not fair.

> Anyway, hopefully Paul or whoever will find the time and energy to
> convert the code at some point.

Yes, Paul's taking care of it.  Much appreciated.
