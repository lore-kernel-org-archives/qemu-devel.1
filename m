Received: from eggs.gnu.org ([209.51.188.92]:53358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIuX-0004sO-6p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hEIrM-0003Sj-H3
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:26:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hEIrK-0003RC-EQ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 15:26:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id v14so3832786wmf.2
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
In-Reply-To: <1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 10 Apr 2019 20:25:57 +0100
Message-ID: <CAJSP0QWYS+UHmXyvhtLcLW9iumfi29Fa7AJdGPC9OwagwekWmg@mail.gmail.com>
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
> > There are multiple problems with the code, but the larger issue is that
> > this example device is just helping people shoot themselves in the foot
> > more easily.
>
>
> If you can point me to those problem I will be glad so I can update the
> code and understand those problems you are talking about.

Please see Eduardo's reply.  I didn't review much since he already
pointed out many things.

One thing he didn't mention:
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));

The return value can be NULL.  Spurious notifications could happen so
the code shouldn't crash when this returns NULL.

I apologize for the critical replies.  What you're doing is valuable.
I think explaining the VIRTIO device model and the order in which
things are done will lead to higher quality devices so I'm making a
lot of noise about it :).

Stefan
