Received: from eggs.gnu.org ([2001:4830:134:3::10]:45830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fk8Fe-0000q4-Mt
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fk8Fa-00045t-Nf
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:30:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fk8Fa-00045d-IB
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:30:14 -0400
Date: Mon, 30 Jul 2018 14:30:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180730133010.GK1626@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8yrNzEaL5_D79OjHCUUwPQnS4MnQhU9gumR7fpTThyuQ@mail.gmail.com>
Subject: Re: [Qemu-devel] 'make vm-build-freebsd' &c don't work if KVM isn't
 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On Mon, Jul 30, 2018 at 02:23:50PM +0100, Peter Maydell wrote:
> The tests in tests/vm/ seem to make some attempt to cope with the
> host system not allowing the user to use KVM, but it doesn't quite
> work. The problem is that tests/vm/basevm.py always uses "-cpu host"
> in the QEMU options it uses to run the VM, and that only works if
> KVM is enabled. If the user can't run KVM then we correctly avoid
> passing it "-enable-kvm" but then QEMU doesn't run because "-cpu host"
> isn't supported...
> 
> I guess the right fix here is to use "-cpu max" ?

Yes, sounds like exactly the kind of scenario that 'max' was intended
to support.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
