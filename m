Received: from eggs.gnu.org ([2001:4830:134:3::10]:60029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNfHQ-0004TS-2O
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fNfHG-0008Cp-9r
	for qemu-devel@nongnu.org; Tue, 29 May 2018 10:07:16 -0400
Date: Tue, 29 May 2018 15:06:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180529140646.GB2578@work-vm>
References: <20180518180440-mutt-send-email-mst@kernel.org>
	<20180518170956.GI8615@redhat.com>
	<20180518174133.GC25013@localhost.localdomain>
	<87bmdc18q5.fsf@dusky.pond.sub.org>
	<20180521182928.GO25013@localhost.localdomain>
	<20180521184440.GB8214@redhat.com>
	<20180521190112.GP25013@localhost.localdomain>
	<87o9h6hb59.fsf@dusky.pond.sub.org>
	<20180523121344.GB8988@localhost.localdomain>
	<874liycoto.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874liycoto.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, kwolf@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

* Markus Armbruster (armbru@redhat.com) wrote:

> Seriously, though: are disk images a sane way to package software?

They're not actually terrible.
You can just start a VM with them straight away, no unpacking required,
no installation time.  Especially when used with something like
-snapshot.
It's also easy for the person packaging them.

Dave
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
