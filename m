Received: from eggs.gnu.org ([2001:4830:134:3::10]:47529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCp37-0006YI-Ar
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gCp32-0005Cq-Oq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:51:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gCp31-00050F-7M
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 12:51:51 -0400
Date: Wed, 17 Oct 2018 17:51:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181017165139.GK15162@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181016232201.16829-1-crosa@redhat.com>
	<CAFEAcA_KFOay7zBoYMSqqEYd0ZhTcW5wp3bs28cr=oK4W4FL3A@mail.gmail.com>
	<4e595639-5920-255e-04de-067280ceb477@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e595639-5920-255e-04de-067280ceb477@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Acceptance tests: host arch to target arch
 name mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Caio Carrara <ccarrara@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Oct 17, 2018 at 12:31:56PM -0400, Cleber Rosa wrote:
> 
> 
> On 10/17/18 8:34 AM, Peter Maydell wrote:
> > On 17 October 2018 at 00:22, Cleber Rosa <crosa@redhat.com> wrote:
> >> The host arch name is not always the target arch name, so it's
> >> necessary to have a mapping.
> >>
> >> The configure scripts contains what is the authoritative and failproof
> >> mapping, but, reusing it is not straightforward, so it's replicated in
> >> the acceptance tests supporting code.
> > 
> > So, why does the test code need to care? It's not clear
> > from the patch... My expectation would be that you'd
> > just test all the testable target architectures,
> > regardless of what the host architecture is.
> > 
> 
> That's a good question, and now I realize that I could have given more
> information on the commit message (fixing it).
> 
> The core issue is that when running tests and a QEMU binary is not
> explicitly chosen, we pick one first from the build tree (then from
> system) that matches the host architecture.
> 
> Without such a mapping, when running tests say on a host arch ppc64le, a
> QEMU binary will not be found.  This was first mentioned here:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00865.html

The configure script knows what the matching target for this host
arch is. Can you just make it set a makefile variable you can then
pick up ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
