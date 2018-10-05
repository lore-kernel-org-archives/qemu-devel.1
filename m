Received: from eggs.gnu.org ([2001:4830:134:3::10]:52575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8TWe-0003Dk-64
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8TWZ-0002Oo-B3
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:04:27 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1g8TWY-0002OP-GU
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 13:04:22 -0400
Received: by mail-pg1-x544.google.com with SMTP id a5-v6so4973516pgv.13
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 10:04:22 -0700 (PDT)
References: <20181005160147.892-1-kraxel@redhat.com>
	<20181005160147.892-2-kraxel@redhat.com>
	<CAKmqyKNY+Yziwq_82Oz4yueAvYAzrOev5=0taNm6qpUFcGZcnA@mail.gmail.com>
	<20181005164800.klw6siygbyk2ipbx@sirius.home.kraxel.org>
From: Alistair <alistair23@gmail.com>
Message-ID: <c91440d4-f8ef-7701-f280-995dd63a0988@gmail.com>
Date: Fri, 5 Oct 2018 10:04:18 -0700
MIME-Version: 1.0
In-Reply-To: <20181005164800.klw6siygbyk2ipbx@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] display: add separate config option
 for bochs-display
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 10/05/2018 09:48 AM, Gerd Hoffmann wrote:
> On Fri, Oct 05, 2018 at 09:22:29AM -0700, Alistair Francis wrote:
>> On Fri, Oct 5, 2018 at 9:13 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>
>>> This allows modern architectures which don't care about vga
>>> compatibility (risc-v for example) build bochs-display without
>>> including all vga emulation too.
>>
>> For RISC-V we end up including pci.mak anyway for other things such as
>> NVMe drives. So we don't really need this, but it still seems useful.
> 
> Hmm, maybe we should split pci.mak into pci-legacy.mak and pci-express.mak
> then?

That sounds like a good idea.

Alistair

> 
> cheers,
>    Gerd
> 
