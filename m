Received: from eggs.gnu.org ([2001:4830:134:3::10]:35212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNUs-0002cs-3s
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNUp-0000HB-3a
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:02:38 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNUo-0000Gl-Sg
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:02:35 -0500
Received: by mail-wm0-f42.google.com with SMTP id b21so2496853wme.4
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:02:34 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-20-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8632174f-5f30-da41-adc0-545bcbde8eb0@redhat.com>
Date: Wed, 7 Feb 2018 12:02:30 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-20-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 19/34] vmbus: add vmbus protocol
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 06/02/2018 21:30, Roman Kagan wrote:
> +#ifndef _INCLUDE_HYPERV_VMBUS_H_
> +#define _INCLUDE_HYPERV_VMBUS_H_

Please do not start guards with _ (e.g. QEMU_HYPERV_VMBUS_H).

Paolo
