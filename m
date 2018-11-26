Received: from eggs.gnu.org ([2001:4830:134:3::10]:48070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRHcM-0005ML-Oe
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1gRHcJ-000622-Lo
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:12:06 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:37276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1gRHcJ-00061I-Gv
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 09:12:03 -0500
Received: by mail-ot1-x335.google.com with SMTP id 40so16666786oth.4
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 06:12:03 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <20181115192446.17187-1-minyard@acm.org>
	<d23cb41c-b6a5-9573-32af-07a963f8f827@redhat.com>
From: Corey Minyard <minyard@acm.org>
Message-ID: <eaf8d37a-27a8-0c30-2ce8-31f651a5fdc7@acm.org>
Date: Mon, 26 Nov 2018 08:11:59 -0600
MIME-Version: 1.0
In-Reply-To: <d23cb41c-b6a5-9573-32af-07a963f8f827@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH v2 00/12] RFC: Fix/add vmstate handling in
 some I2C code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 11/15/18 5:01 PM, Philippe Mathieu-Daudé wrote:
> Hi Corey,
>
> On 15/11/18 20:24, minyard@acm.org wrote:
>> These changes allow SMBus access while doing a state transfer.
>> Seems like a good idea to me in general.
>>
>>
>>
>> I'm primarily submitting this to make sure I'm doing the backwards
>> compatability with .needed correctly.  I'm adding a new field in
>> the machine class and setting it in the initialization code for
>> older versions.  David, is this what you wanted?  It will have to
>> be adjusted for the proper version if/when it really goes in, of
>> course.  You can see those in the following commits:
>>    boards.h: Ignore migration for SMBus devices on
>>    i2c:pm_smbus: Fix state transfer
>>    i2c: Add vmstate handling to the smbus eeprom
>> I thought about adding a field to the pm_smbus code to only transfer
>> if it was accessed, but I'm assuming that most modern OSes will
>> at least initialized the device based on its presence on the PCI
>> bus.  So that didn't seem like it would add any value.
>>
>> I'm also submitting to see if all the fixes and cleanups look ok.
>> That's the first 5 commits.
>
> $ git diff origin/master --summary
>  delete mode 100644 hw/i2c/smbus.c
>  create mode 100644 hw/i2c/smbus_master.c
>  create mode 100644 hw/i2c/smbus_slave.c
>  create mode 100644 include/hw/i2c/smbus_eeprom.h
>  rename include/hw/i2c/{smbus.h => smbus_master.h} (56%)
>  create mode 100644 include/hw/i2c/smbus_slave.h
>
> Can you add the following files in the MAINTAINERS file:
> - hw/i2c/smbus_master.c
> - hw/i2c/smbus_slave.c
> - include/hw/i2c/smbus_eeprom.h
> - include/hw/i2c/smbus_master.h
> - include/hw/i2c/smbus_slave.h

I'm almost ready to re-submit this series, but I'd like to do 3
things:

  * Add the proper person as the maintainer.  I can be the
    maintainer, but I don't want to presume that's what you
    meant.  No general I2C code has a maintainer at the moment.
  * I'd like to get David's comments on the .needed addition, as
    I mention above.
  * I need to figure out why piix4 smbus does not work after a
    migration.  I'll work on that today.

Thanks,

-corey

>
> Thanks,
>
> Phil.
