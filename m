Received: from eggs.gnu.org ([2001:4830:134:3::10]:45351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnkq-000401-D9
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:04:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnkl-0003la-1m
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:04:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejnkk-0003lF-RH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:04:46 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so10023533wmg.2
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:04:46 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-22-rkagan@virtuozzo.com>
	<f7e37a67-b1fc-c4cf-a7d1-a958b3b84f5c@redhat.com>
	<20180207192823.GF18247@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9697e678-91d1-7426-d648-5c0c68f6db81@redhat.com>
Date: Thu, 8 Feb 2018 16:04:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180207192823.GF18247@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 21/34] vmbus: build configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 07/02/2018 20:30, Roman Kagan wrote:
> On Wed, Feb 07, 2018 at 12:04:01PM +0100, Paolo Bonzini wrote:
>> On 06/02/2018 21:30, Roman Kagan wrote:
>>> From: Evgeny Yakovlev <eyakovlev@virtuozzo.com>
>>>
>>> Add option to configure and makefiles to enable building vmbus support
>>> (default to "on" on Linux and "off" otherwise).
>>
>> Maybe default to on if KVM is supported?  Could it just be
>>
>> CONFIG_VMBUS=$(CONFIG_KVM)
>>
>> in default-configs/ instead of having a configure option?
> 
> Then there won't be an obvious way to turn it off, will there be?

Distros can and do patch default-configs/.  It's not very obvious, I
agree, but then it's what we suggest to do in order to turn off all
those old, hardly maintained ISA devices.  So to some extent it's a
documentation problem.

Paolo
