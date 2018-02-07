Received: from eggs.gnu.org ([2001:4830:134:3::10]:36048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNYC-0005Mv-9h
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejNY9-00040q-5Y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:06:04 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejNY8-00040O-VV
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:06:01 -0500
Received: by mail-wm0-f47.google.com with SMTP id b21so2518295wme.4
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:06:00 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-24-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ddb843f-445b-6c9b-8979-433285dafae6@redhat.com>
Date: Wed, 7 Feb 2018 12:05:57 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-24-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 23/34] i386: en/disable vmbus by a
 machine property
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
> Hyper-V VMBus logically belongs to the machine, so make its presence be
> controlled by a boolean property of the machine.
> 
> TODO: consider doing this through adding the vmbus-bridge device instead

Yeah, that would be nicer.

Paolo



> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
