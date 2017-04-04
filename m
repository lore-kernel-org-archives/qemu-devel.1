Received: from eggs.gnu.org ([2001:4830:134:3::10]:55676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvJQ9-0006IA-Df
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvJQ4-0004Rt-Ez
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvJQ4-0004RV-9C
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 04:02:28 -0400
Date: Tue, 4 Apr 2017 09:02:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170404080219.GA2147@work-vm>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<1491240750.10884.10.camel@intel.com>
	<20170403173823.GD2112@work-vm>
	<1491248498.10884.16.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491248498.10884.16.camel@intel.com>
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
To: Patrick Ohly <patrick.ohly@intel.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org, stefanb@linux.vnet.ibm.com

* Patrick Ohly (patrick.ohly@intel.com) wrote:
> On Mon, 2017-04-03 at 18:38 +0100, Dr. David Alan Gilbert wrote:
> > Or you could just remove the spawning code and use existing sockets; less code!
> 
> That would be harder to use reliably in the automated testing that this
> feature is targeting.
> 
> With this mechanism, it is guaranteed that both processes notice when
> the other dies because the connection gets disconnected. There's never a
> time period where one process listens for a connection from a process
> that might have died already, or never got started.
> 
> It's also easier that the scripts calling qemu only need to deal with
> one process, as before, and just need to pass some additional
> parameters.
> 
> Can we agree that both usage models are valid and thus support both?

Yep, that's fine.

Dave

> -- 
> Best Regards, Patrick Ohly
> 
> The content of this message is my personal opinion only and although
> I am an employee of Intel, the statements I make here in no way
> represent Intel's position on the issue, nor am I authorized to speak
> on behalf of Intel on this matter.
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
