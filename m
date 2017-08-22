Received: from eggs.gnu.org ([2001:4830:134:3::10]:47574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk4qp-0001V1-Sn
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dk4qp-0003YC-4N
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:47:55 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dk4qo-0003Xk-UW
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 04:47:55 -0400
Received: by mail-wr0-x22c.google.com with SMTP id f8so82861985wrf.3
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 01:47:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822010917.GO12356@umbus.fritz.box>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
	<20170822010917.GO12356@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2017 09:47:33 +0100
Message-ID: <CAFEAcA8wbRjjJYtk-65NJEsu-ELVdKgtwreipabSaMtLTfS--Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 22 August 2017 at 02:09, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Wed, Aug 16, 2017 at 12:18:07PM +0100, Peter Maydell wrote:
>> On 16 August 2017 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> > On 16/08/2017 10:26, Cornelia Huck wrote:
>> >> Prefer to use the tcg accelarator if it is available: This is our only
>> >> real smoke test for tcg, and fast enough to use it for that.
>> >
>> > I'm not sure this is required for 2.10.  Yes, it means the coverage from
>> > "make check" is worse, but that's it.
>>
>> Yes, I'd put it under "if we need to roll an rc4 anyway for
>> some more significant bug we might as well put this in too,
>> but it doesn't merit cutting rc4 by itself."
>
> It does entirely break "make check" on a ppc host.  And that in turn
> has held up my testing cycle for a couple of ppc regressions from 2.9
> that I was hoping to squeeze in.  Does that change your calculations?

I have a PPC64 box in my standard set of build tests, and it
runs 'make check' without problems...

thanks
-- PMM
