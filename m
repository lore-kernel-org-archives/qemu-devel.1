Received: from eggs.gnu.org ([2001:4830:134:3::10]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejOOd-00056R-W7
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejOOZ-0000em-2i
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:16 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejOOY-0000dg-Qo
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:00:11 -0500
Received: by mail-wr0-f176.google.com with SMTP id v31so713911wrc.11
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:00:10 -0800 (PST)
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-21-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b68ff4bb-3c1e-04b7-16c6-25ce75806163@redhat.com>
Date: Wed, 7 Feb 2018 13:00:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180206203048.11096-21-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 20/34] vmbus: vmbus implementation
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
> Add the VMBus infrastructure -- bus, devices, root bridge, vmbus state
> machine, vmbus channel interactions, etc.
> 
> TODO:
>  - split into smaller palatable pieces
>  - more comments
>  - check and handle corner cases
> 
> Kudos to Evgeny Yakovlev (formerly eyakovlev@virtuozzo.com) and Andrey
> Smetatin (formerly asmetanin@virtuozzo.com) for research and
> prototyping.

I admit I haven't looked at this patch almost at all, but the SCSI code
seems sane so it cannot be that bad. :)  It doesn't seem that easy to
split, too.

Adding doc comments to the header file would be already enough IMO.

Paolo
