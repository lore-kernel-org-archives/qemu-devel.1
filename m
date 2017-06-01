Received: from eggs.gnu.org ([2001:4830:134:3::10]:38294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGN0C-000828-Gt
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGN09-0007Qc-D0
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dGN09-0007QC-87
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 06:06:45 -0400
Date: Thu, 1 Jun 2017 11:06:39 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170601100639.GA26162@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAGKXQycLBOd4EXQBQB+KfDnHs7i4ymBRFQo7pJ0QFomTGYu8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGKXQycLBOd4EXQBQB+KfDnHs7i4ymBRFQo7pJ0QFomTGYu8Eg@mail.gmail.com>
Subject: Re: [Qemu-devel] qemu, kvm and qemu-kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Jun 01, 2017 at 02:30:13PM +0430, ali saeedi wrote:
> Hello
> what are the difference between kvm, qemu and kvm-qemu?

QEMU is the core project which provides the userspace emulation, that is
used in conjunction with KVM hardware acceleration from the kernel.

Originally (many years ago now), KVM relied on a fork of the QEMU codebase,
which operating system vendors often packaged up as a binary called
'qemu-kvm' or 'kvm'.

These days, all KVM support is directly integrated in normal QEMU binaries.
So Best practice is to just use the "qemu-system-$ARCH" binaries for KVM
support directly. Any 'qemu-kvm' or 'kvm' binaries that you still see in
any OS distros are merely there for back compat. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
