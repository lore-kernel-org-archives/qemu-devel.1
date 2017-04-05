Received: from eggs.gnu.org ([2001:4830:134:3::10]:49372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cvgC2-0006ZN-M8
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cvgBz-0001h9-Gz
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:21:30 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:48199 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cvgBy-0001gh-TC
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 04:21:27 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
Date: Wed, 05 Apr 2017 11:15:58 +0300
In-Reply-To: <4712D8F4B26E034E80552F30A67BE0B1A4E5F6@ORSMSX112.amr.corp.intel.com>
	(Anthony Xu's message of "Tue, 4 Apr 2017 21:39:39 +0000")
Message-ID: <87y3vf9sn5.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Put all trace.o into libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xu, Anthony" <anthony.xu@intel.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, 'Stefan Hajnoczi' <stefanha@gmail.com>, 'Paolo Bonzini' <pbonzini@redhat.com>

Xu, Anthony writes:

> Put all trace.o into libqemuutil.a
> Currently all trace.o are linked into qemu-system, qemu-img, 
> qemu-nbd, qemu-io etc., even the corresponding components 
> are not included.
> Put all trace.o into libqemuutil.a that the linker would only pull in .o 
> files containing symbols that are actually referenced by the 
> program.

I think this change conflicts with some of the guest code tracing patches I have
in the queue (I won't be able to send the new series until the end of the month,
sorry).

AFAIR, some of my patches need to link different code for utils and qemu's main
binaries. Although there might be a better way of doing it that I missed.


Cheers,
  Lluis
