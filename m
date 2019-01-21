Received: from eggs.gnu.org ([209.51.188.92]:41686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gldFh-0000gp-H1
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gldFc-0005rd-Sa
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:20:47 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gldFb-0005lu-5D
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 12:20:44 -0500
Received: by mail-oi1-x242.google.com with SMTP id r62so15169651oie.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 09:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20190118183603.24757-1-peter.maydell@linaro.org>
	<07b9dbc7-e48d-adf7-d9cc-dc64de89e9d0@redhat.com>
In-Reply-To: <07b9dbc7-e48d-adf7-d9cc-dc64de89e9d0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 17:20:20 +0000
Message-ID: <CAFEAcA-=UYLYWgdOL_mFoSwMC5fvWFOE4YOwW8xQZjGObQMWHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/virtio/virtio-balloon: zero-initialize
 the virtio_balloon_config struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On Mon, 21 Jan 2019 at 10:42, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 1/18/19 7:36 PM, Peter Maydell wrote:
> > In virtio_balloon_get_config() we initialize a struct virtio_balloon_co=
nfig
> > which we then copy to guest memory. However, the local variable is not
> > zero initialized. This works OK at the moment because we initialize
> > all the fields in it; however an upcoming kernel header change will
> > add some new fields. If we don't zero out the whole struct then we
> > will start leaking a small amount of the contents of QEMU's stack
> > to the guest as soon as we update linux-headers/ to a set of headers
> > that includes the new fields.
>
> Is it worth Cc'ing qemu-stable@?

Good idea, that will avoid possible future problems if we backport
a headers change to stable.

I'll apply this to master directly.

thanks
-- PMM
