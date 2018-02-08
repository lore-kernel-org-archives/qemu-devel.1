Received: from eggs.gnu.org ([2001:4830:134:3::10]:45490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnlZ-0004ky-K2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:05:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnlU-00047c-Il
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:05:37 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejnlU-00047H-Cj
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:05:32 -0500
Received: by mail-wm0-f41.google.com with SMTP id f3so10574197wmc.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:05:32 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-30-rkagan@virtuozzo.com>
	<b9ee4d69-130e-74bc-42f7-0ab372d0070b@redhat.com>
	<20180207201517.GE19541@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f6008d15-32fc-8c64-46da-707769ccc423@redhat.com>
Date: Thu, 8 Feb 2018 16:05:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180207201517.GE19541@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 29/34] net: add Hyper-V/VMBus network
 protocol definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 07/02/2018 21:15, Roman Kagan wrote:
>> Hmm, these are a bit harder to unify with hw/usb/dev-network.c.  Still
>> not _that_ hard, just that the USB version has two fields for message
>> type/length at the beginning.
> This is my "fault".  At some point I got tired of this pattern so I
> factored out the header and the payload.  I'll reconsider with this
> unification in mind.

It's okay, we can also do it the other way round.

Paolo
