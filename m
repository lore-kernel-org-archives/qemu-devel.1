Received: from eggs.gnu.org ([209.51.188.92]:35736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hEFPc-0001xc-Jh
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1hEFPb-00072F-CZ
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:45:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1hEFPa-00071O-V8
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 11:45:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so3591755wrp.0
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 08:45:17 -0700 (PDT)
References: <20190401111843.54528-1-ybettan@redhat.com>
	<20190409131734.GE16944@stefanha-x1.localdomain>
From: Yoni Bettan <ybettan@redhat.com>
Message-ID: <1871f593-ec5b-fede-7da5-a7ae78056249@redhat.com>
Date: Wed, 10 Apr 2019 18:45:14 +0300
MIME-Version: 1.0
In-Reply-To: <20190409131734.GE16944@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: qemu-devel@nongnu.org, ailan@redhat.com, ehabkost@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>


On 4/9/19 4:17 PM, Stefan Hajnoczi wrote:
> On Mon, Apr 01, 2019 at 02:18:43PM +0300, Yoni Bettan wrote:
>> The main goal is to add an example device to Qemu to be used as template or
>> guideline for contributors when they wish to create a new virtio device.
>>
>> Another reason for this device is to document "the right way" to write
>> a new virtio device in Qemu.
>>
>> This device is a simple device and its functionality is to increase its input
>> by 1.
>>
>> The device driver is located at:
>> https://github.com/ybettan/QemuDeviceDrivers.git
>>
>> In addition I am writing a blog to give a logical overview of the virtio
>> protocol and a step-by-step guide to write a new virtio device.
>> This blog can be found at https://howtovms.wordpress.com.
>>
>> scripts/checkpatch.pl have some errors do to "//" (old style one line comment),
>> those lines contains FIXMEs for the next version and will be removed.
>>
>> Signed-off-by: Yoni Bettan <ybettan@redhat.com>


Hi Stefan and thank you for your review.

> Where is the specification for this device?  The lack of specification
> is already not "the right way".



Another step in this process is to write a specification for this 
device. Since I am learning the virtio protocol while implementing this 
example device it was easier for me to start with the device and from 
there write its specification but take into consideration that the 
specification will be written soon.


>
> There are multiple problems with the code, but the larger issue is that
> this example device is just helping people shoot themselves in the foot
> more easily.


If you can point me to those problem I will be glad so I can update the 
code and understand those problems you are talking about.


>
> The difficulty with VIRTIO is not how to implement devices/drivers, it's
> that people don't read the specification and therefore do not understand
> the device model properly.  The spec is dry and missing information in
> some places.  I think more accessible documentation, like your blog, can
> help here.


As I said, the blog will be updated with explanations on each step of 
the communication between the device and the driver and the reason it is 
not there yet is because I preferred getting some reviews, make the code 
better and only then documenting "the write way" to not mislead peoples.


>
> If you would like to educate people about VIRTIO, then explaining the
> device model, lifecycle, how to change a device in a
> backwards-compatible way, virtqueue semantics, etc are the topics that
> deserve attention.
>
> For someone who has learnt these topics, implementing the device/driver
> is not hard.  For someone who doesn't understand these topics, no
> example device will help.  At best they will copy-paste together
> something that sort of works but has issues.


For me, reading the specification and even reading some code examples 
over the internet didn't made me understand it until I saw the related 
code so I agree with you it is not enough yet but all the other parts 
are on there way.


The final purpose is to have:

1. device specification

2. device implementation

3. device driver

4. blog

maybe I should have written it at the beginning, this is not the entire 
project but it is its start.


>
> Stefan


Thanks again for your review.
