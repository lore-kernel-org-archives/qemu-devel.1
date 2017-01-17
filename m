Received: from eggs.gnu.org ([2001:4830:134:3::10]:38946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTXb3-00045D-3s
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cTXb0-0005Ui-0e
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:31:01 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:32953)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cTXaz-0005Tz-OT
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 12:30:57 -0500
Received: by mail-lf0-x242.google.com with SMTP id x1so11889608lff.0
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 09:30:56 -0800 (PST)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-12-git-send-email-clg@kaod.org>
	<b5660d74-0c16-871b-bec0-31a5a6e19f04@gmail.com>
	<9b1c1700-04cc-9b1e-6fdc-5ac84e5cd42e@kaod.org>
	<e6c78999-f851-eb32-6244-80e85e0b5190@gmail.com>
	<64b13418-337d-d3a6-2c65-0add542c9ba8@kaod.org>
	<f36efc32-d25b-0948-6302-0b84ccc3bdda@gmail.com>
	<1585f3eb-c387-d3c5-c11a-0426bd236a17@kaod.org>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <d3b6b42e-6230-b771-31e3-7f8a040ffab4@gmail.com>
Date: Tue, 17 Jan 2017 18:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <1585f3eb-c387-d3c5-c11a-0426bd236a17@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/11] aspeed/smc: handle dummy bytes
 when doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



W dniu 17.01.2017 o 09:37, Cédric Le Goater pisze:
> On 01/16/2017 07:58 PM, mar.krzeminski wrote:
>>
>> W dniu 16.01.2017 o 09:18, Cédric Le Goater pisze:
>>>> I did not notice that this function is also called in writes, isn't it?
>>>> If yes, dummy cycles are used only during reads so probably CTRL_FREADMODE
>>>> needs to be tested.
>>> yes. I can take care of that in a follow up patchset for
>>> dummy support.
>>>    Dummies in user mode is a bit painful to implement, as I had
>>> to snoop into the command flow to catch the fast read op.
>>> Not sure this is the right approach so I kept it for later.
>> Definitelly wrong, controller should not be aware of tha, fix is still on me :(
> ok. np. I will send the support for command mode though,
> as this is a must have for booting.
>
>>>
>>> Did you have time to take look at the other patches adding
>>> Command mode and extending the tests ? I should have addressed
>>> your comments there.
>> Yes, there is one more thing that could be important. It popped out in Sabrelite
>> SPI model. The question is does SCM support different CS active (so device
>> is active at CS high). Your code assume that SMC will always use CS LOW to activate
>> device. If this is not true you might be interested in update this too.
> Aspeed SoC does not let you configure the chip select polarity
> (nor the clock phase ) So it is active low only.
Thanks.
>
> Thanks,
>
> C.
>
>
