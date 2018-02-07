Received: from eggs.gnu.org ([2001:4830:134:3::10]:40453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ejNqr-0004K6-1J
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:25:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ejNql-0003Jg-Mt
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:25:20 -0500
Received: from mail-db5eur03on0718.outbound.protection.outlook.com
	([2a01:111:f400:fe0a::718]:61296
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1ejNqk-0003IA-Mo
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:25:15 -0500
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-26-rkagan@virtuozzo.com>
	<61ab4454-9aa3-7291-8b54-bcaee1f74bf0@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <901f124d-b256-158e-4870-2bac25fbce71@openvz.org>
Date: Wed, 7 Feb 2018 14:25:05 +0300
MIME-Version: 1.0
In-Reply-To: <61ab4454-9aa3-7291-8b54-bcaee1f74bf0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC PATCH 25/34] scsi: add Hyper-V/VMBus SCSI
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On 02/07/2018 02:11 PM, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
>> +    blk_io_plug(d->conf.blk);
>> +    if (scsi_req_enqueue(sreq)) {
>> +        scsi_req_continue(sreq);
>> +    }
>> +    blk_io_unplug(d->conf.blk);
> Is plug/unplug really useful?
>
> Paolo
good point. here - no. plug/unplug should be moved to upper
layer, where we process all requests. Plug/Unplug should
cover all currently available bits.

Den
