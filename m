Received: from eggs.gnu.org ([2001:4830:134:3::10]:36674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gHrW9-0003Uv-0v
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gHrW5-0003QQ-3K
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:30:44 -0400
Received: from ssl.serverraum.org ([2a01:4f8:151:8464::1:2]:57217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gHrW3-0003Mm-Bg
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:30:40 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 31 Oct 2018 15:30:36 +0100
From: Michael Walle <michael@walle.cc>
In-Reply-To: <34069906-b8f8-05da-477e-b2b81fc0fd58@redhat.com>
References: <20180718104836.18488-1-michael@walle.cc>
	<20180718104836.18488-2-michael@walle.cc>
	<34069906-b8f8-05da-477e-b2b81fc0fd58@redhat.com>
Message-ID: <dcf671031ff70a7a18b65f5f7dd79f64@walle.cc>
Subject: Re: [Qemu-devel] [PATCH 2/3] qtest: new functions for pulsed IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

Am 2018-10-31 11:19, schrieb Paolo Bonzini:
> On 18/07/2018 12:48, Michael Walle wrote:
>>  /**
>> + * get_irq_latched:
>> + * @num: Interrupt to observe.
>> + *
>> + * Returns: The latched level of the @num interrupt.
>> + */
>> +static inline bool get_irq_latched(int num)
>> +{
>> +    return qtest_get_irq_latched(global_qtest, num);
>> +}
>> +
>> +/**
>> + * clear_irq_latch:
>> + * @num: Interrupt to operate on.
>> + *
>> + * Clears the latch of the @num interrupt.
>> + */
>> +static inline void clear_irq_latch(int num)
>> +{
>> +    return qtest_clear_irq_latch(global_qtest, num);
>> +}
>> +
>> +/**
>>   * irq_intercept_in:
>>   * @string: QOM path of a device.
>>   *
>> 
> 
> Just one thing, I think an atomic test-and-clear is a better API.  I
> understand that what you have works, because
> get_irq_latched+clear_irq_latch don't have any intervening access to 
> the
> qtest socket.

Ok thanks, like get_and_clear_irq_latched()? Do you think of we still 
need the get_irq_latched() to get the state without actually clearing 
it? I mean my simple test case won't need it, but there might be some 
cases where you may want peek at the state.

-michael
