Received: from eggs.gnu.org ([209.51.188.92]:53570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIum-000570-CZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIhF-0003CS-Cw
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:15:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hEIhF-0003By-26
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:15:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id j9so4259750wrn.6
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
In-Reply-To: <1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Apr 2019 20:15:32 +0100
Message-ID: <CAJSP0QVpPGKO_NH2CXpdYtQfLsMF+OjKx2QzjtKJVkOnnoBHdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Amnon Ilan <ailan@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Apr 10, 2019 at 4:45 PM Yoni Bettan <ybettan@redhat.com> wrote:
> On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
> > On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
> The final purpose is to have:
>
> 1. device specification
>
> 2. device implementation
>
> 3. device driver
>
> 4. blog
>
> maybe I should have written it at the beginning, this is not the entire
> project but it is its start.

The way I'd design VIRTIO devices without prior knowledge is:

1. Learn the VIRTIO device model.  Understand the concepts in VIRTIO.
<-- this is hard today, there's not much good documentation

2. Design an initial version of the device spec.  Mostly configuration
layout, virtqueues, and request structs.  Not much text is necessary
at this point, but it's critical for thinking through features before
implementation.

3. Implement guest driver and device emulation.

4. Iterate on spec and implementation until it's functionally complete.

5. Submit the spec to the VIRTIO Technical Committee.

6. Submit driver and device emulation patches.  They can be merged
when the spec is approved/close to approved.

Are you jumping to #3?  This is likely to lead to poor quality
implementations and specs because the fundamental VIRTIO concepts
weren't understood.

If the point is to educate others and/or do it "the right way", then I
would really avoid hacking around without first doing the other steps.

Stefan
