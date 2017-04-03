Received: from eggs.gnu.org ([2001:4830:134:3::10]:38748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1cv7rJ-00041E-3a
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:41:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patrick.ohly@intel.com>) id 1cv7rF-0002N2-Tu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:41:49 -0400
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:35591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patrick.ohly@intel.com>)
	id 1cv7rF-0002Mp-OJ
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:41:45 -0400
Received: by mail-io0-x22a.google.com with SMTP id z13so82773683iof.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:41:45 -0700 (PDT)
Message-ID: <1491248498.10884.16.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
Date: Mon, 03 Apr 2017 21:41:38 +0200
In-Reply-To: <20170403173823.GD2112@work-vm>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<1491240750.10884.10.camel@intel.com>
	<20170403173823.GD2112@work-vm>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

On Mon, 2017-04-03 at 18:38 +0100, Dr. David Alan Gilbert wrote:
> Or you could just remove the spawning code and use existing sockets; less code!

That would be harder to use reliably in the automated testing that this
feature is targeting.

With this mechanism, it is guaranteed that both processes notice when
the other dies because the connection gets disconnected. There's never a
time period where one process listens for a connection from a process
that might have died already, or never got started.

It's also easier that the scripts calling qemu only need to deal with
one process, as before, and just need to pass some additional
parameters.

Can we agree that both usage models are valid and thus support both?

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.
