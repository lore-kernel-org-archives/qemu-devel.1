Received: from eggs.gnu.org ([2001:4830:134:3::10]:54902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0SHa-0003mY-Rr
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0SHX-0002Pb-NX
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:30:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0SHX-0002PU-AE
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 08:30:55 -0400
References: <20170405190024.27581-1-dgilbert@redhat.com>
	<20170413205525.GD4376@thinpad.lan.raisama.net>
	<20170418110047.GD2205@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4cc1cc6a-1aaa-c996-08c9-93690c2b2cf9@redhat.com>
Date: Tue, 18 Apr 2017 14:30:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170418110047.GD2205@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3 for 2.10] migration/i386 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, quintela@redhat.com



On 18/04/2017 13:00, Dr. David Alan Gilbert wrote:
>> It would be nice if we could allow kvm-unit-tests test cases
>> trigger a migration operation at a specific instruction. I assume
>> we don't have an existing mechanism that could be used for that?
> Not that I know of, do we have any type of breakpoint type thing
> we could use?

What about the gdbstub support?

Paolo
