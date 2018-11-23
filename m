Received: from eggs.gnu.org ([2001:4830:134:3::10]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ7xp-0007cs-KN
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ7uO-0000PQ-0W
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:38:00 -0500
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:27968)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gQ7uN-00008P-6C
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 04:37:55 -0500
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
	<20181119120820.29878-23-maozhongyi@cmss.chinamobile.com>
	<20181119233139.GO3807@habkost.net>
	<bb601691-a96d-8968-bb5b-0b15757285f6@cmss.chinamobile.com>
	<CAFEAcA_tmLbierkqRP6E3QDV89aAOASRdsA5-rt3TyeWE0tE0g@mail.gmail.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <73aa2cb6-eb51-c470-5b14-bbf10c3ed0e5@cmss.chinamobile.com>
Date: Fri, 23 Nov 2018 17:37:36 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_tmLbierkqRP6E3QDV89aAOASRdsA5-rt3TyeWE0tE0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] core/sysbus: remove the
 SysBusDeviceClass::initpath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@wdc.com>, Zhang Shengju <zhangshengju@cmss.chinamobile.com>



On 11/23/18 5:02 PM, Peter Maydell wrote:
> On 23 November 2018 at 03:10, maozy <maozhongyi@cmss.chinamobile.com> wrote:
>> In order to void the subclasses whose parent_realize field is
>> set to NULL, the k->realize function must be retained even
>> though it doesn't do anything practical. Just like this:
>>
>>
>> -/* TODO remove once all sysbus devices have been converted to realize*/
>>   static void sysbus_realize(DeviceState *dev, Error **errp)
>>   {
>> -    SysBusDevice *sd = SYS_BUS_DEVICE(dev);
>> -    SysBusDeviceClass *sbc = SYS_BUS_DEVICE_GET_CLASS(sd);
>> -
>> -    if (!sbc->init) {
>> -        return;
>> -    }
>> -    if (sbc->init(sd) < 0) {
>> -        error_setg(errp, "Device initialization failed");
>> -    }
>>   }
>>
>> it doesn't look elegant, but I didn't think of a better way, if you
>> can give me some hints, I really appreciate it. :)
> 
> If we do take this approach, we should have a comment which
> says why we have an empty realize function, so that we don't
> in future forget and delete the apparently unnecessary code...
> 

OK, I got you, will do it.

Thanks,
Mao

> thanks
> -- PMM
> 
