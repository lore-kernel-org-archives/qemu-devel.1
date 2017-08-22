Received: from eggs.gnu.org ([2001:4830:134:3::10]:59104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk7fW-0004Tm-P2
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dk7fT-00052V-N7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dk7fT-00052J-GO
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:48:23 -0400
Date: Tue, 22 Aug 2017 13:48:15 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170822134815.77020eb8.cohuck@redhat.com>
In-Reply-To: <20170822112046.GC12356@umbus.fritz.box>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 22 Aug 2017 21:20:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Obviously it's not a thing to fix right now, but I've really been
> thinking that none of the tests should use this "TCG or KVM" stuff.
> They should instead be run with *both* options - or at least the ones
> that are available on the host.

Having one test as a 'smoke test' that is run for everything available
sounds like a good idea, and the boot-serial test may be a good
candidate for that.

I would not want to run every test with every accelerator, however, as
this makes 'make check' even slower than it is now. (Although it may be
useful to be able to trigger 'run everything' tests on some dedicated
test machines.)

> 
> That would have caught the bug in the pull request I sent you, and
> would at least have given you a chance at seeing the problem with
> boot-serial-test.

I don't think that would have been caught unless you have the right
host available... and given that most developers will only have a
x86_64 machine and whatever other architecture they are working on (if
any) available, they will run most of 'make check' with tcg only.
