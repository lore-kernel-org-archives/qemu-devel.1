Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eZLrX-0006lb-7F
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eZLrW-00073H-6O
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:16:35 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37471)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eZLrW-00072h-0O
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:16:34 -0500
Received: by mail-wm0-x231.google.com with SMTP id f140so1026328wmd.2
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 11:16:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180109195517.GD2708@work-vm>
References: <EC8A4E314CF1574AB62C80421BD9833933FEE069@SHSMSX104.ccr.corp.intel.com>
	<20180109153538.GC1197@stefanha-x1.localdomain>
	<20180109195517.GD2708@work-vm>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Jan 2018 19:16:32 +0000
Message-ID: <CAJSP0QVm+AoRoFNYx-r1k0WTPPopm60dmD7OhGZozm9ARfMwRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "He, Junyan" <junyan.he@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>

On Tue, Jan 9, 2018 at 7:55 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>> Certain guest operations like rebooting or zeroing memory will defeat
>> the incremental guest RAM snapshot feature.  It's worth thinking about
>> these cases to make sure this feature would be worth it in real use
>> cases.
>
> But those probably wouldn't upset an NVDimm?

If the guest dirties all RAM then the incremental snapshot feature
degrades to a full snapshot.  I'm asking if there are common
operations where that happens.

I seem to remember Windows guests zero all pages on cold boot.  Maybe
that's not the case anymore.

Worth checking before embarking on this feature because it could be a
waste of effort if it turns out real-world guests dirty all memory in
common cases.
