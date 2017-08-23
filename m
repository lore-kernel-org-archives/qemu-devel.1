Received: from eggs.gnu.org ([2001:4830:134:3::10]:35565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkQby-0003ux-1A
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:02:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkQbu-0003lm-Bx
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:02:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dkQbu-0003lU-5w
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 04:01:58 -0400
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
	<CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
	<3f0dc918-0f55-e2f4-bf47-fe4abf5453bb@redhat.com>
	<CAFEAcA_ezKWweEuUB-cXTer0LLaeuiGDkSdfhApedhw4ykDT0Q@mail.gmail.com>
	<20170822112046.GC12356@umbus.fritz.box>
	<20170822134815.77020eb8.cohuck@redhat.com>
	<20170823002907.GC5379@umbus.fritz.box>
	<20170823091650.48e7c44e.cohuck@redhat.com>
	<54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5b0ff74a-08d6-558d-4c79-a93758e6302a@redhat.com>
Date: Wed, 23 Aug 2017 10:01:38 +0200
MIME-Version: 1.0
In-Reply-To: <54526d47-b436-79d5-7a38-9516eaa727a6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] make check speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 23/08/2017 09:49, Thomas Huth wrote:
> While we're at it: I'd like to have a "make check-fast", too. Sometimes
> the normal "make check" is already too slow, e.g. while developing new
> patches, I sometimes just want to do a very quick sanity test to see
> whether I broke some basic things or not, and only do the "make check"
> before I submit my patches.
> So we would get three stages:
> 
> - make check-fast => For very, very quick sanity tests only
> 
> - make check => E.g. has to be run before submitting patches
> 
> - make check-harder => might run a very long time, so best suited for
>                        nightly regression tests etc.?
> 
> Does that sound reasonable? And the crucial question: Who is going to
> implement the basic framework for this?

There's already make check-unit or make check-qtest-x86_64 depending on
what you're working on.

If you have a many-core machine, of course, there's no simpler solution
than throwing more CPUs at it. :)

Paolo
