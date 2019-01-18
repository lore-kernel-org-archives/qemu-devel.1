Received: from eggs.gnu.org ([209.51.188.92]:36599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkQS1-0002qx-Nh
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gkQRz-0005dZ-Lk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:28:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gkQRx-0005Yx-S3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:28:31 -0500
Date: Fri, 18 Jan 2019 10:28:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190118102823.30178f3b@redhat.com>
In-Reply-To: <20190117211138-mutt-send-email-mst@kernel.org>
References: <20190115200252.25911-1-mst@redhat.com>
	<CAFEAcA_CurRe0i7pU10OkNBFi53ayA4Y01HtF27qN1xo5nJqxg@mail.gmail.com>
	<20190117084350-mutt-send-email-mst@kernel.org>
	<CAFEAcA_G_og2AXsDKYnPVhRXsvMUb8MnR0yc8JzCwS4xaPJpGg@mail.gmail.com>
	<20190117211138-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 17 Jan 2019 21:12:53 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

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
> 
> Igor, in the future pls remember to be conscious of size of integers:
> it's not safe to cast uint32_t* to gsize *!
sure,
Thanks for fixing it up!

> 
> Thanks!
> 
