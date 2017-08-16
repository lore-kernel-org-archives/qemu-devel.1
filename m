Received: from eggs.gnu.org ([2001:4830:134:3::10]:54845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhwmR-0005Vc-8w
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhwmM-0003P5-ER
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhwmM-0003MH-28
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:46:30 -0400
Date: Wed, 16 Aug 2017 13:46:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170816134621.0fd6eb28.cohuck@redhat.com>
In-Reply-To: <CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
	<CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, 16 Aug 2017 12:18:07 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 16 August 2017 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > On 16/08/2017 10:26, Cornelia Huck wrote:  
> >> Prefer to use the tcg accelarator if it is available: This is our only
> >> real smoke test for tcg, and fast enough to use it for that.  
> >
> > I'm not sure this is required for 2.10.  Yes, it means the coverage from
> > "make check" is worse, but that's it.  
> 
> Yes, I'd put it under "if we need to roll an rc4 anyway for
> some more significant bug we might as well put this in too,
> but it doesn't merit cutting rc4 by itself."

Yup, that sounds good to me.
