Received: from eggs.gnu.org ([2001:4830:134:3::10]:45047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnjN-0002jJ-PL
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:03:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejnjI-0002Ao-1E
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:03:21 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:54377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejnjH-00028p-Ql
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 10:03:15 -0500
Received: by mail-wm0-f49.google.com with SMTP id i186so10016037wmi.4
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 07:03:15 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-19-rkagan@virtuozzo.com>
	<4d74329a-8797-a476-60ff-539f95245131@redhat.com>
	<20180207191915.GE18247@rkaganb.sw.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66825e0f-2cab-4acd-2b2e-010d9fd5d604@redhat.com>
Date: Thu, 8 Feb 2018 16:03:12 +0100
MIME-Version: 1.0
In-Reply-To: <20180207191915.GE18247@rkaganb.sw.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 18/34] hyperv: add support for
 KVM_HYPERV_EVENTFD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 07/02/2018 20:19, Roman Kagan wrote:
>> As before, I wouldn't mind dropping userspace SIGNAL_EVENT altogether.
> That would mean not allowing vmbus stuff on a range of otherwise usable
> kernels, including 4.14 which AFAIK has been declared LTS.
> Note that HYPERV_EVENTFD hasn't even landed in the mainline kernel yet
> (with any luck it'll make 4.16).

Fair enough.

Paolo
