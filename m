Received: from eggs.gnu.org ([209.51.188.92]:39494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3QtA-0001rn-W1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3QtA-0005eT-C0
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:47:08 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:46502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3QtA-0005Yc-2Z
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:47:08 -0400
Received: by mail-lj1-x243.google.com with SMTP id v16so151438ljg.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190311180216.18811-1-jandryuk@gmail.com>
	<20190311180216.18811-2-jandryuk@gmail.com>
	<d7fb0cfd-9573-028c-5631-be9df4102fcc@redhat.com>
In-Reply-To: <d7fb0cfd-9573-028c-5631-be9df4102fcc@redhat.com>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 15:46:55 -0400
Message-ID: <CAKf6xps8=0eMyZJ=qGeYhHu7yea56PXTxEBPQZePRdznnqHQZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/6] xen: Introduce -xen-stubdom option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel <xen-devel@lists.xenproject.org>, =?UTF-8?Q?Marek_Marczykowski=2DG=C3=B3recki?= <marmarek@invisiblethingslab.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>

On Mon, Mar 11, 2019 at 2:06 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 11/03/19 19:02, Jason Andryuk wrote:
> > With Xen, QEMU can run isolated in a dedicated service VM - a stubdom.
> > There are a few differences when running in a stubdom compared to dom0.
> > Add the -xen-stubdom option to select this mode at runtime.  The default
> > is off.
>
> This should be "-accel xen,stubdom=on".  You should find examples for
> tcg that explain how to add a suboption to -accel.

Thanks, Paolo.  I'll re-work the option as you suggest.

Regards,
Jason
