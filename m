Received: from eggs.gnu.org ([209.51.188.92]:59219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkWVg-0006Cw-RP
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkWVe-00060K-Py
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:56:44 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:38659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkWVc-0005xz-Sv
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 10:56:41 -0500
Received: by mail-oi1-x233.google.com with SMTP id a77so9297342oii.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 07:56:38 -0800 (PST)
MIME-Version: 1.0
References: <20190115200252.25911-1-mst@redhat.com>
	<CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
	<20190117084350-mutt-send-email-mst@kernel.org>
	<CAFEAcA_G_og2AXsDKYnPVhRXsvMUb8MnR0yc8JzCwS4xaPJpGg@mail.gmail.com>
	<20190117211138-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190117211138-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 15:56:26 +0000
Message-ID: <CAFEAcA_ZpxcfG7zVO31zWJifYBNFvwa15Z2eSXUeYVg7XsaZiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/49] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>

On Fri, 18 Jan 2019 at 02:12, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 17, 2019 at 04:21:24PM +0000, Peter Maydell wrote:
> > On Thu, 17 Jan 2019 at 13:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jan 17, 2019 at 12:48:22PM +0000, Peter Maydell wrote:
> > > > This fails 'make check' on s390x host:
> >
> > > Oh. I am pretty sure it's endian-ness :(
> > >
> > > Any chance you can quickly test the below?
> >
> > Yes, that change allows the tests to pass on the s390 box.
> >
> > thanks
> > -- PMM
>
> Re-pushed a fixed patch to the same tag.

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
