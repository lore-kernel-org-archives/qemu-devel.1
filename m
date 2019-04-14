Received: from eggs.gnu.org ([209.51.188.92]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hFdBk-0001tD-GG
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 07:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hFdBj-0006fN-KF
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 07:20:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1hFdBj-0006dW-7s
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 07:20:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so17932615wrn.6
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 04:20:39 -0700 (PDT)
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
	<1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
	<CAJSP0QWYS+UHmXyvhtLcLW9iumfi29Fa7AJdGPC9OwagwekWmg@mail.gmail.com>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <f5f1fafe-4eda-03bd-ba1f-38c08cb381a3@redhat.com>
Date: Sun, 14 Apr 2019 14:20:36 +0300
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWYS+UHmXyvhtLcLW9iumfi29Fa7AJdGPC9OwagwekWmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC-PATCH] Introducing virtio-example device.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Amnon Ilan <ailan@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


On 4/10/19 10:25 PM, Stefan Hajnoczi wrote:
> On Wed, Apr 10, 2019 at 4:45 PM Yoni Bettan <ybettan@redhat.com> wrote:
>> On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
>>> On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
>>> There are multiple problems with the code, but the larger issue is that
>>> this example device is just helping people shoot themselves in the foot
>>> more easily.
>>
>> If you can point me to those problem I will be glad so I can update the
>> code and understand those problems you are talking about.
> Please see Eduardo's reply.  I didn't review much since he already
> pointed out many things.
>
> One thing he didn't mention:
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
>
> The return value can be NULL.  Spurious notifications could happen so
> the code shouldn't crash when this returns NULL.
>
> I apologize for the critical replies.  What you're doing is valuable.
> I think explaining the VIRTIO device model and the order in which
> things are done will lead to higher quality devices so I'm making a
> lot of noise about it :).


It is OK, I will write some basic specification for the device and start 
iterating spec-device-driver according to Rustie's paper, Eduardo's 
review, and you advice.


Thanks.

>
> Stefan
